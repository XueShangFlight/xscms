<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\library\Ems;
use app\common\library\Sms;
use fast\Random;
use think\Config;
use think\Db;
use think\Validate;
use wxmini\WXBizDataCrypt;

/**
 * 会员接口
 */
class User extends Api
{
    protected $noNeedLogin = ['login', 'mobilelogin', 'register', 'resetpwd', 'changeemail', 'changemobile', 'third','wxlogin'];
    protected $noNeedRight = '*';

    protected $statusArr = ['未审核','审核中','已通过','未通过'];

    public function _initialize()
    {
        parent::_initialize();

        if (!Config::get('fastadmin.usercenter')) {
            $this->error(__('User center already closed'));
        }

    }

    /**
     * 会员中心
     */
    public function index()
    {
        $letter = Letters::where(['user_id'=>$this->auth->id,'isread'=>0])->count();
        $myWorks = Workspersonal::where(['user_id'=>$this->auth->id,'status'=>2,'switch'=>1])->column('id');
        $zanCount = Collect::where(['cate'=>2,'type'=>1])->where('typeid','in',$myWorks)->count();
        if($zanCount > 1000){
            if($zanCount%1000 == 0){
                $zanCount = (int)$zanCount/1000 . 'k';
            }else{
                $zanCount =  sprintf("%.1f",$zanCount/1000).'k';
            }
        }
        $this->success('获取成功', ['letter' => $letter,'zanCount'=>$zanCount]);
    }

    /**
     * 会员登录
     *
     * @ApiMethod (POST)
     * @param string $account  账号
     * @param string $password 密码
     */
    public function login()
    {
        $this->auth->direct(1);
        echo $this->auth->getToken();die;
        $account = $this->request->post('account');
        $password = $this->request->post('password');
        if (!$account || !$password) {
            $this->error(__('Invalid parameters'));
        }
        $ret = $this->auth->login($account, $password);
        if ($ret) {
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 手机验证码登录
     *
     * @ApiMethod (POST)
     * @param string $mobile  手机号
     * @param string $captcha 验证码
     */
    public function mobilelogin()
    {
        $mobile = $this->request->post('mobile');
        $captcha = $this->request->post('captcha');
        if (!$mobile || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if (!Validate::regex($mobile, "^1\d{10}$")) {
            $this->error(__('Mobile is incorrect'));
        }
        if (!Sms::check($mobile, $captcha, 'mobilelogin')) {
            $this->error(__('Captcha is incorrect'));
        }
        $user = \app\common\model\User::getByMobile($mobile);
        if ($user) {
            if ($user->status != 'normal') {
                $this->error(__('Account is locked'));
            }
            //如果已经有账号则直接登录
            $ret = $this->auth->direct($user->id);
        } else {
            $ret = $this->auth->register($mobile, Random::alnum(), '', $mobile, []);
        }
        if ($ret) {
            Sms::flush($mobile, 'mobilelogin');
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 注册会员
     *
     * @ApiMethod (POST)
     * @param string $username 用户名
     * @param string $password 密码
     * @param string $email    邮箱
     * @param string $mobile   手机号
     * @param string $code     验证码
     */
    public function register()
    {
        $username = $this->request->post('username');
        $password = $this->request->post('password');
        $email = $this->request->post('email');
        $mobile = $this->request->post('mobile');
        $code = $this->request->post('code');
        if (!$username || !$password) {
            $this->error(__('Invalid parameters'));
        }
        if ($email && !Validate::is($email, "email")) {
            $this->error(__('Email is incorrect'));
        }
        if ($mobile && !Validate::regex($mobile, "^1\d{10}$")) {
            $this->error(__('Mobile is incorrect'));
        }
        $ret = Sms::check($mobile, $code, 'register');
        if (!$ret) {
            $this->error(__('Captcha is incorrect'));
        }
        $ret = $this->auth->register($username, $password, $email, $mobile, []);
        if ($ret) {
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success(__('Sign up successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 退出登录
     * @ApiMethod (POST)
     */
    public function logout()
    {
        if (!$this->request->isPost()) {
            $this->error(__('Invalid parameters'));
        }
        $this->auth->logout();
        $this->success(__('Logout successful'));
    }

    /**
     * 修改会员个人信息
     *
     * @ApiMethod (POST)
     * @param string $avatar   头像地址
     * @param string $username 用户名
     * @param string $nickname 昵称
     * @param string $bio      个人简介
     */
    public function profile()
    {
        $user = $this->auth->getUser();
        $username = $this->request->post('username');
        $nickname = $this->request->post('nickname');
        $bio = $this->request->post('bio');
        $avatar = $this->request->post('avatar', '', 'trim,strip_tags,htmlspecialchars');
        if ($username) {
            $exists = \app\common\model\User::where('username', $username)->where('id', '<>', $this->auth->id)->find();
            if ($exists) {
                $this->error(__('Username already exists'));
            }
            $user->username = $username;
        }
        if ($nickname) {
            $exists = \app\common\model\User::where('nickname', $nickname)->where('id', '<>', $this->auth->id)->find();
            if ($exists) {
                $this->error(__('Nickname already exists'));
            }
            $user->nickname = $nickname;
        }
        $user->bio = $bio;
        $user->avatar = $avatar;
        $user->save();
        $this->success();
    }

    /**
     * 修改邮箱
     *
     * @ApiMethod (POST)
     * @param string $email   邮箱
     * @param string $captcha 验证码
     */
    public function changeemail()
    {
        $user = $this->auth->getUser();
        $email = $this->request->post('email');
        $captcha = $this->request->post('captcha');
        if (!$email || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if (!Validate::is($email, "email")) {
            $this->error(__('Email is incorrect'));
        }
        if (\app\common\model\User::where('email', $email)->where('id', '<>', $user->id)->find()) {
            $this->error(__('Email already exists'));
        }
        $result = Ems::check($email, $captcha, 'changeemail');
        if (!$result) {
            $this->error(__('Captcha is incorrect'));
        }
        $verification = $user->verification;
        $verification->email = 1;
        $user->verification = $verification;
        $user->email = $email;
        $user->save();

        Ems::flush($email, 'changeemail');
        $this->success();
    }

    /**
     * 修改手机号
     *
     * @ApiMethod (POST)
     * @param string $mobile  手机号
     * @param string $captcha 验证码
     */
    public function changemobile()
    {
        $user = $this->auth->getUser();
        $mobile = $this->request->post('mobile');
        $captcha = $this->request->post('captcha');
        if (!$mobile || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if (!Validate::regex($mobile, "^1\d{10}$")) {
            $this->error(__('Mobile is incorrect'));
        }
        if (\app\common\model\User::where('mobile', $mobile)->where('id', '<>', $user->id)->find()) {
            $this->error(__('Mobile already exists'));
        }
        $result = Sms::check($mobile, $captcha, 'changemobile');
        if (!$result) {
            $this->error(__('Captcha is incorrect'));
        }
        $verification = $user->verification;
        $verification->mobile = 1;
        $user->verification = $verification;
        $user->mobile = $mobile;
        $user->save();

        Sms::flush($mobile, 'changemobile');
        $this->success();
    }

    /**
     * 第三方登录
     *
     * @ApiMethod (POST)
     * @param string $platform 平台名称
     * @param string $code     Code码
     */
    public function third()
    {
        $url = url('user/index');
        $platform = $this->request->post("platform");
        $code = $this->request->post("code");
        $config = get_addon_config('third');
        if (!$config || !isset($config[$platform])) {
            $this->error(__('Invalid parameters'));
        }
        $app = new \addons\third\library\Application($config);
        //通过code换access_token和绑定会员
        $result = $app->{$platform}->getUserInfo(['code' => $code]);
        if ($result) {
            $loginret = \addons\third\library\Service::connect($platform, $result);
            if ($loginret) {
                $data = [
                    'userinfo'  => $this->auth->getUserinfo(),
                    'thirdinfo' => $result
                ];
                $this->success(__('Logged in successful'), $data);
            }
        }
        $this->error(__('Operation failed'), $url);
    }

    /**
     * 重置密码
     *
     * @ApiMethod (POST)
     * @param string $mobile      手机号
     * @param string $newpassword 新密码
     * @param string $captcha     验证码
     */
    public function resetpwd()
    {
        $type = $this->request->post("type");
        $mobile = $this->request->post("mobile");
        $email = $this->request->post("email");
        $newpassword = $this->request->post("newpassword");
        $captcha = $this->request->post("captcha");
        if (!$newpassword || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if ($type == 'mobile') {
            if (!Validate::regex($mobile, "^1\d{10}$")) {
                $this->error(__('Mobile is incorrect'));
            }
            $user = \app\common\model\User::getByMobile($mobile);
            if (!$user) {
                $this->error(__('User not found'));
            }
            $ret = Sms::check($mobile, $captcha, 'resetpwd');
            if (!$ret) {
                $this->error(__('Captcha is incorrect'));
            }
            Sms::flush($mobile, 'resetpwd');
        } else {
            if (!Validate::is($email, "email")) {
                $this->error(__('Email is incorrect'));
            }
            $user = \app\common\model\User::getByEmail($email);
            if (!$user) {
                $this->error(__('User not found'));
            }
            $ret = Ems::check($email, $captcha, 'resetpwd');
            if (!$ret) {
                $this->error(__('Captcha is incorrect'));
            }
            Ems::flush($email, 'resetpwd');
        }
        //模拟一次登录
        $this->auth->direct($user->id);
        $ret = $this->auth->changepwd($newpassword, '', true);
        if ($ret) {
            $this->success(__('Reset password successful'));
        } else {
            $this->error($this->auth->getError());
        }
    }


    /**
     * @throws \think\exception\DbException
     * 微信登录
     */
    public function wxlogin()
    {
        $encryptedData = input("post.data","");
        $iv	           = input('post.iv','');
        $code          = input('post.code', '');
        if ( $encryptedData == '' ) $this->error('微信数据为空~');
        if ( $iv == '' )   $this->error('解析秘钥为空~');
        if ($code == '')  $this->error('code为空');
        $wxconf = getWxConf();
        $authData  = json_decode(file_get_contents("https://api.weixin.qq.com/sns/jscode2session?appid=" . $wxconf['wxappid'] . "&secret=" . $wxconf['wxsecret'] . "&js_code={$code}&grant_type=authorization_code", true));
        if ( isset($authData->errcode) ) $this->error($authData->errmsg);
        $sessionkey = $authData->session_key;
        $openid  = $authData->openid;
        if ( $sessionkey == '' ) $this->error('sessionkey为空~');
        if ( strlen( $sessionkey ) != 24 ) $this->error('sessionkey无效~');

        $pc = new WXBizDataCrypt($wxconf['wxappid'], $sessionkey);
        $errCode = $pc->decryptData($encryptedData, $iv, $data );

        if ($errCode == 0) {
            $data = json_decode($data,true);
            $watermark = $data['watermark'];
            if($watermark['appid'] != $wxconf['wxappid']){
                $this->error('非官方数据~');
            }
            $wxname = $data['nickName'];
            $sex = $data['gender'];
            $wxface = $data['avatarUrl'];
            $user = \app\common\model\User::get(['openid' => $openid]);
            if($user){
                if ($user->status != 'normal') $this->Error('Account is locked');
                $res = $this->auth->direct($user->id);
                if(!$res) $this->error($this->auth->getError());
            }else{
                $username = $wxname;
                $res =  $this->auth->register($username,123456,'','',['openid'=>$openid,'avatar'=>$wxface,'status'=>'normal','nickname'=>$wxname,'gender'=>$sex,'group_id'=>1]);
                if(!$res) $this->error($this->auth->getError());
            }
            $sdata['token'] = $this->auth->getToken();
            $sdata['user'] = $this->auth->getUser();
            $this->success('登录成功',$sdata);
        } else {
            $this->error($errCode);
        }
    }

    /**
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     * 获取微信电话
     */
    public function wxphone(){
        $user = $this->auth->getUser();
        if(!$user) $this->error('请先登录你的账号');
        $data   	= input('post.data','');
        $iv	    	= input('post.iv','');
        $code	    = input('post.code','');
        if ( $data == '' ) $this->error('解析值为空~');
        if ( $iv == '' )   $this->error('解析秘钥为空~');
        if ( $code == '' ) $this->error('code为空~');
        $wxconf    = getWxConf();
        $userData  = json_decode(file_get_contents("https://api.weixin.qq.com/sns/jscode2session?appid=" . $wxconf['wxappid'] . "&secret=" . $wxconf['wxsecret'] . "&js_code={$code}&grant_type=authorization_code", true));
        if ( isset($userData->errcode) ) $this->error('',0,$userData->errmsg);
        $sessionkey = $userData->session_key;
        if ( $sessionkey == '' ) $this->error('sessionkey为空~');
        if ( strlen( $sessionkey ) != 24 ) $this->error('sessionkey无效~');
        if ( strlen($iv) != 24 ) $this->error('iv无效~');
        $appid   = $wxconf['wxappid'];
        $aeskey  = base64_decode($sessionkey);
        $aesiv   = base64_decode($iv);
        $aesdata = base64_decode($data);
        $res     = openssl_decrypt( $aesdata, "AES-128-CBC", $aeskey, 1, $aesiv);
        $resobj  = json_decode( $res );
        if( $resobj  == NULL ) $this->error('绑定失败,请重新绑定~');
        if( $resobj->watermark->appid != $appid ) $this->error('appid与应用不符~');
        $phone   = $resobj->phoneNumber;
        //保存用户至用户表
        if ( $user && $phone !='' ) {
            if($user->mobile == ''){
                $redata = Db::name('user')->where('Id',$user->id)->update(['mobile'=>$phone]);
                if($redata){
                    $this->success('绑定手机号成功~',['phone'=>$phone]);
                }else{
                    $this->error('绑定手机号失败，请重试~');
                }
            } else{
                $this->error('该账号已绑定手机号，无需重复绑定~');
            }
        }else{
            $this->error('获取电话失败');
            writelog('wxphone',$resobj);
        }

    }
}
