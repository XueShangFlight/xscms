<?php
namespace app\admin\controller;

use app\common\controller\Backend;
use think\Config;
use think\Db;
use OSS\OssClient;
use OSS\Core\OssException;

class Oss extends Backend
{
	
	protected $psize;
	protected $conf;

    public function _initialize()
    {
        parent::_initialize();
        $conf['AccessKeyId'] = Config::get('site.AccessKeyId');
        $conf['AccessKeySecret'] = Config::get('site.AccessKeySecret');
        $conf['endpoint'] = Config::get('site.endpoint');
        $conf['Bucket'] = Config::get('site.Bucket');
        $conf['switch'] = Config::get('site.switch');
        $conf['isdel'] = Config::get('site.isdel');
        $this->conf = $conf;
        if(!$this->conf['AccessKeyId'] || !$this->conf['AccessKeyId']) return ['success'=>0,'msg'=>'请先设置oss配置信息'];
        if ( $this->conf['Bucket'] == '' ) return ['success'=>0,'msg'=>'请输入存储空间名称'];
        if ( !$this->conf['switch']) return ['success'=>0,'msg'=>'请先启用阿里OSS存储'];
    }
	
	private function ossheader()
	{
		try{
			if ( $this->conf['AccessKeyId'] == '' || $this->conf['AccessKeySecret'] == '' || $this->conf['endpoint'] == '' ) return false;
			$oss = new OssClient($this->conf['AccessKeyId'], $this->conf['AccessKeySecret'], $this->conf['endpoint']);
			return $oss;	
		} catch(OssException $e) {
			return false;
		}
	}
	
	public function uploads($file='')
	{
		$root  = ROOT_PATH.'public';
		if ( $file == '' ) return ['success'=>0,'msg'=>'文件为空'];
		$upfile  = $root.$file;
		try{
			$oss = self::ossheader();
			if(!$oss) return ['success'=>0,'msg'=>'OSS配置有误'];
            if(strpos($file,'/uploads') === 0) $file = str_replace('/uploads','uploads',$file);
			$res = $oss->uploadFile($this->conf['Bucket'], $file, $upfile);
			if ( $this->conf['isdel'] ) @unlink($upfile);
			$ossfile = $res['oss-request-url'];
			$ossfile = str_replace('http://','https://',$ossfile);
			return ['success'=>1,'msg'=>'','file'=>$ossfile];		
		} catch(OssException $e) {
			return ['success'=>0,'msg'=>$e->getMessage()];
		}
	}
	
	public function createbucket()
	{
		try {
			$oss = self::ossheader();
   			$res = $oss->createBucket($this->conf['Bucket'], OssClient::OSS_ACL_TYPE_PUBLIC_READ);
			return ['success'=>1,'msg'=>'存储空间创建成功'];
		} catch (OssException $e) {
			return ['success'=>0,'msg'=>$e->getMessage()];
		}
	}
	
	public function ckbucket()
	{
		try {
			$oss = self::ossheader();
			if ( !$oss ) return ['success'=>0,'msg'=>'资料不全'];
			$res = $oss->doesBucketExist($this->conf['Bucket']);
			if ( $res === true ) {
				return ['success'=>1,'msg'=>'存储空间检测：'.$this->conf['Bucket'].'存储空间可用'];
			} else {
				return ['success'=>0,'msg'=>'存储空间检测：'.$this->conf['Bucket'].'存储空间不存在'];
			}
		} catch (OssException $e) {
			return ['success'=>0,'msg'=>$e->getMessage()];
		}
	}
	
	public function filelist($dir='')
	{
		$basediv  = self::basediv();
		$baseurl  = $basediv['success'] ? $basediv['info']['oss-request-url'] : '';
		try {
			$oss  = self::ossheader();
			$opt  = ['delimiter'=>'','marker'=>'','prefix'=>$dir,'max-keys'=>1000];
   			$res  = $oss->listObjects($this->conf['Bucket'],$opt);
			$res  = $res->getobjectList();
			$list = [];
			$size = 0;
			if ( $res ) {
				foreach( $res as $rv ) {
					$file = $rv->getkey();
					$fobj = explode('.',$file);
					$ext  = $fobj[count($fobj)-1];
					$size += $rv->getsize();
					$list[] = ['file'=>$file,'url'=>$baseurl.'/'.$file,'ext'=>$ext,'size'=>$rv->getsize(),'type'=>$rv->gettype(),'date'=>$rv->getlastModified(),'tag'=>$rv->geteTag()];
					
				}
			}
			return ['success'=>1,'msg'=>'','list'=>$list,'size'=>$size];
		} catch (OssException $e) {
			return ['success'=>0,'msg'=>$e->getMessage()];
		}
	}

	public function prefix($dir='')
	{
		try {
			$oss  = self::ossheader();
			$opt  = ['delimiter'=>'/','marker'=>'','prefix'=>$dir,'max-keys'=>1000];
   			$res  = $oss->listObjects($this->conf['Bucket'],$opt);
			$res  = $res->getPrefixList();
			$list = [];
			if ( $res ) {
				foreach( $res as $rv ) {
					$list[] = str_replace('/','',$rv->getPrefix());
				}
			}
			return ['success'=>1,'msg'=>'','list'=>$list];
		} catch (OssException $e) {
			return ['success'=>0,'msg'=>$e->getMessage()];
		}
	}
	
	public function basediv()
	{
		if ( cache('?basediv_oss_bucket'.$this->conf['Bucket']) ) return cache('basediv_oss_bucket'.$this->conf['Bucket']);
		try {
			$oss  = self::ossheader();
   			$info = $oss->getBucketMeta($this->conf['Bucket']);
			$res  =  ['success'=>1,'msg'=>'','info'=>$info];
			cache('basediv_oss_bucket'.$this->conf['Bucket'],$res);
			return $res;
		} catch (OssException $e) {
			return ['success'=>0,'msg'=>$e->getMessage()];
		}	
	}
	
	public function delfile($del=[])
	{
		try {
			$oss  = self::ossheader();
			$res  = $oss->deleteObjects($this->conf['Bucket'], $del);
			return ['success'=>1,'msg'=>''];
		} catch (OssException $e) {
			return ['success'=>0,'msg'=>$e->getMessage()];
		}
	}
	
	
	
}