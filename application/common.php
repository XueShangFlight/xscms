<?php

// 公共助手函数

use Symfony\Component\VarExporter\VarExporter;
use think\Db;
use think\exception\HttpResponseException;
use think\Response;

if (!function_exists('__')) {

    /**
     * 获取语言变量值
     * @param string $name 语言变量名
     * @param array  $vars 动态变量值
     * @param string $lang 语言
     * @return mixed
     */
    function __($name, $vars = [], $lang = '')
    {
        if (is_numeric($name) || !$name) {
            return $name;
        }
        if (!is_array($vars)) {
            $vars = func_get_args();
            array_shift($vars);
            $lang = '';
        }
        return \think\Lang::get($name, $vars, $lang);
    }
}

if (!function_exists('format_bytes')) {

    /**
     * 将字节转换为可读文本
     * @param int    $size      大小
     * @param string $delimiter 分隔符
     * @param int    $precision 小数位数
     * @return string
     */
    function format_bytes($size, $delimiter = '', $precision = 2)
    {
        $units = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
        for ($i = 0; $size >= 1024 && $i < 6; $i++) {
            $size /= 1024;
        }
        return round($size, $precision) . $delimiter . $units[$i];
    }
}

if (!function_exists('datetime')) {

    /**
     * 将时间戳转换为日期时间
     * @param int    $time   时间戳
     * @param string $format 日期时间格式
     * @return string
     */
    function datetime($time, $format = 'Y-m-d H:i:s')
    {
        $time = is_numeric($time) ? $time : strtotime($time);
        return date($format, $time);
    }
}

if (!function_exists('human_date')) {

    /**
     * 获取语义化时间
     * @param int $time  时间
     * @param int $local 本地时间
     * @return string
     */
    function human_date($time, $local = null)
    {
        return \fast\Date::human($time, $local);
    }
}

if (!function_exists('cdnurl')) {

    /**
     * 获取上传资源的CDN的地址
     * @param string  $url    资源相对地址
     * @param boolean $domain 是否显示域名 或者直接传入域名
     * @return string
     */
    function cdnurl($url, $domain = false)
    {
        $regex = "/^((?:[a-z]+:)?\/\/|data:image\/)(.*)/i";
        $cdnurl = \think\Config::get('upload.cdnurl');
        $url = preg_match($regex, $url) || ($cdnurl && stripos($url, $cdnurl) === 0) ? $url : $cdnurl . $url;
        if ($domain && !preg_match($regex, $url)) {
            $domain = is_bool($domain) ? request()->domain() : $domain;
            $url = $domain . $url;
        }
        return $url;
    }
}


if (!function_exists('is_really_writable')) {

    /**
     * 判断文件或文件夹是否可写
     * @param string $file 文件或目录
     * @return    bool
     */
    function is_really_writable($file)
    {
        if (DIRECTORY_SEPARATOR === '/') {
            return is_writable($file);
        }
        if (is_dir($file)) {
            $file = rtrim($file, '/') . '/' . md5(mt_rand());
            if (($fp = @fopen($file, 'ab')) === false) {
                return false;
            }
            fclose($fp);
            @chmod($file, 0777);
            @unlink($file);
            return true;
        } elseif (!is_file($file) or ($fp = @fopen($file, 'ab')) === false) {
            return false;
        }
        fclose($fp);
        return true;
    }
}

if (!function_exists('rmdirs')) {

    /**
     * 删除文件夹
     * @param string $dirname  目录
     * @param bool   $withself 是否删除自身
     * @return boolean
     */
    function rmdirs($dirname, $withself = true)
    {
        if (!is_dir($dirname)) {
            return false;
        }
        $files = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($dirname, RecursiveDirectoryIterator::SKIP_DOTS),
            RecursiveIteratorIterator::CHILD_FIRST
        );

        foreach ($files as $fileinfo) {
            $todo = ($fileinfo->isDir() ? 'rmdir' : 'unlink');
            $todo($fileinfo->getRealPath());
        }
        if ($withself) {
            @rmdir($dirname);
        }
        return true;
    }
}

if (!function_exists('copydirs')) {

    /**
     * 复制文件夹
     * @param string $source 源文件夹
     * @param string $dest   目标文件夹
     */
    function copydirs($source, $dest)
    {
        if (!is_dir($dest)) {
            mkdir($dest, 0755, true);
        }
        foreach (
            $iterator = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($source, RecursiveDirectoryIterator::SKIP_DOTS),
                RecursiveIteratorIterator::SELF_FIRST
            ) as $item
        ) {
            if ($item->isDir()) {
                $sontDir = $dest . DS . $iterator->getSubPathName();
                if (!is_dir($sontDir)) {
                    mkdir($sontDir, 0755, true);
                }
            } else {
                copy($item, $dest . DS . $iterator->getSubPathName());
            }
        }
    }
}

if (!function_exists('mb_ucfirst')) {
    function mb_ucfirst($string)
    {
        return mb_strtoupper(mb_substr($string, 0, 1)) . mb_strtolower(mb_substr($string, 1));
    }
}

if (!function_exists('addtion')) {

    /**
     * 附加关联字段数据
     * @param array $items  数据列表
     * @param mixed $fields 渲染的来源字段
     * @return array
     */
    function addtion($items, $fields)
    {
        if (!$items || !$fields) {
            return $items;
        }
        $fieldsArr = [];
        if (!is_array($fields)) {
            $arr = explode(',', $fields);
            foreach ($arr as $k => $v) {
                $fieldsArr[$v] = ['field' => $v];
            }
        } else {
            foreach ($fields as $k => $v) {
                if (is_array($v)) {
                    $v['field'] = isset($v['field']) ? $v['field'] : $k;
                } else {
                    $v = ['field' => $v];
                }
                $fieldsArr[$v['field']] = $v;
            }
        }
        foreach ($fieldsArr as $k => &$v) {
            $v = is_array($v) ? $v : ['field' => $v];
            $v['display'] = isset($v['display']) ? $v['display'] : str_replace(['_ids', '_id'], ['_names', '_name'], $v['field']);
            $v['primary'] = isset($v['primary']) ? $v['primary'] : '';
            $v['column'] = isset($v['column']) ? $v['column'] : 'name';
            $v['model'] = isset($v['model']) ? $v['model'] : '';
            $v['table'] = isset($v['table']) ? $v['table'] : '';
            $v['name'] = isset($v['name']) ? $v['name'] : str_replace(['_ids', '_id'], '', $v['field']);
        }
        unset($v);
        $ids = [];
        $fields = array_keys($fieldsArr);
        foreach ($items as $k => $v) {
            foreach ($fields as $m => $n) {
                if (isset($v[$n])) {
                    $ids[$n] = array_merge(isset($ids[$n]) && is_array($ids[$n]) ? $ids[$n] : [], explode(',', $v[$n]));
                }
            }
        }
        $result = [];
        foreach ($fieldsArr as $k => $v) {
            if ($v['model']) {
                $model = new $v['model'];
            } else {
                $model = $v['name'] ? \think\Db::name($v['name']) : \think\Db::table($v['table']);
            }
            $primary = $v['primary'] ? $v['primary'] : $model->getPk();
            $result[$v['field']] = isset($ids[$v['field']]) ? $model->where($primary, 'in', $ids[$v['field']])->column("{$primary},{$v['column']}") : [];
        }

        foreach ($items as $k => &$v) {
            foreach ($fields as $m => $n) {
                if (isset($v[$n])) {
                    $curr = array_flip(explode(',', $v[$n]));

                    $v[$fieldsArr[$n]['display']] = implode(',', array_intersect_key($result[$n], $curr));
                }
            }
        }
        return $items;
    }
}

if (!function_exists('var_export_short')) {

    /**
     * 使用短标签打印或返回数组结构
     * @param mixed   $data
     * @param boolean $return 是否返回数据
     * @return string
     */
    function var_export_short($data, $return = true)
    {
        return var_export($data, $return);
        $replaced = [];
        $count = 0;

        //判断是否是对象
        if (is_resource($data) || is_object($data)) {
            return var_export($data, $return);
        }

        //判断是否有特殊的键名
        $specialKey = false;
        array_walk_recursive($data, function (&$value, &$key) use (&$specialKey) {
            if (is_string($key) && (stripos($key, "\n") !== false || stripos($key, "array (") !== false)) {
                $specialKey = true;
            }
        });
        if ($specialKey) {
            return var_export($data, $return);
        }
        array_walk_recursive($data, function (&$value, &$key) use (&$replaced, &$count, &$stringcheck) {
            if (is_object($value) || is_resource($value)) {
                $replaced[$count] = var_export($value, true);
                $value = "##<{$count}>##";
            } else {
                if (is_string($value) && (stripos($value, "\n") !== false || stripos($value, "array (") !== false)) {
                    $index = array_search($value, $replaced);
                    if ($index === false) {
                        $replaced[$count] = var_export($value, true);
                        $value = "##<{$count}>##";
                    } else {
                        $value = "##<{$index}>##";
                    }
                }
            }
            $count++;
        });

        $dump = var_export($data, true);

        $dump = preg_replace('#(?:\A|\n)([ ]*)array \(#i', '[', $dump); // Starts
        $dump = preg_replace('#\n([ ]*)\),#', "\n$1],", $dump); // Ends
        $dump = preg_replace('#=> \[\n\s+\],\n#', "=> [],\n", $dump); // Empties
        $dump = preg_replace('#\)$#', "]", $dump); //End

        if ($replaced) {
            $dump = preg_replace_callback("/'##<(\d+)>##'/", function ($matches) use ($replaced) {
                return isset($replaced[$matches[1]]) ? $replaced[$matches[1]] : "''";
            }, $dump);
        }

        if ($return === true) {
            return $dump;
        } else {
            echo $dump;
        }
    }
}

if (!function_exists('letter_avatar')) {
    /**
     * 首字母头像
     * @param $text
     * @return string
     */
    function letter_avatar($text)
    {
        $total = unpack('L', hash('adler32', $text, true))[1];
        $hue = $total % 360;
        list($r, $g, $b) = hsv2rgb($hue / 360, 0.3, 0.9);

        $bg = "rgb({$r},{$g},{$b})";
        $color = "#ffffff";
        $first = mb_strtoupper(mb_substr($text, 0, 1));
        $src = base64_encode('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="100" width="100"><rect fill="' . $bg . '" x="0" y="0" width="100" height="100"></rect><text x="50" y="50" font-size="50" text-copy="fast" fill="' . $color . '" text-anchor="middle" text-rights="admin" dominant-baseline="central">' . $first . '</text></svg>');
        $value = 'data:image/svg+xml;base64,' . $src;
        return $value;
    }
}

if (!function_exists('hsv2rgb')) {
    function hsv2rgb($h, $s, $v)
    {
        $r = $g = $b = 0;

        $i = floor($h * 6);
        $f = $h * 6 - $i;
        $p = $v * (1 - $s);
        $q = $v * (1 - $f * $s);
        $t = $v * (1 - (1 - $f) * $s);

        switch ($i % 6) {
            case 0:
                $r = $v;
                $g = $t;
                $b = $p;
                break;
            case 1:
                $r = $q;
                $g = $v;
                $b = $p;
                break;
            case 2:
                $r = $p;
                $g = $v;
                $b = $t;
                break;
            case 3:
                $r = $p;
                $g = $q;
                $b = $v;
                break;
            case 4:
                $r = $t;
                $g = $p;
                $b = $v;
                break;
            case 5:
                $r = $v;
                $g = $p;
                $b = $q;
                break;
        }

        return [
            floor($r * 255),
            floor($g * 255),
            floor($b * 255)
        ];
    }
}

if (!function_exists('check_nav_active')) {
    /**
     * 检测会员中心导航是否高亮
     */
    function check_nav_active($url, $classname = 'active')
    {
        $auth = \app\common\library\Auth::instance();
        $requestUrl = $auth->getRequestUri();
        $url = ltrim($url, '/');
        return $requestUrl === str_replace(".", "/", $url) ? $classname : '';
    }
}

if (!function_exists('check_cors_request')) {
    /**
     * 跨域检测
     */
    function check_cors_request()
    {
        if (isset($_SERVER['HTTP_ORIGIN']) && $_SERVER['HTTP_ORIGIN']) {
            $info = parse_url($_SERVER['HTTP_ORIGIN']);
            $domainArr = explode(',', config('fastadmin.cors_request_domain'));
            $domainArr[] = request()->host(true);
            if (in_array("*", $domainArr) || in_array($_SERVER['HTTP_ORIGIN'], $domainArr) || (isset($info['host']) && in_array($info['host'], $domainArr))) {
                header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
            } else {
                $response = Response::create('跨域检测无效', 'html', 403);
                throw new HttpResponseException($response);
            }

            header('Access-Control-Allow-Credentials: true');
            header('Access-Control-Max-Age: 86400');

            if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
                if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'])) {
                    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
                }
                if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS'])) {
                    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
                }
                $response = Response::create('', 'html');
                throw new HttpResponseException($response);
            }
        }
    }
}

if (!function_exists('xss_clean')) {
    /**
     * 清理XSS
     */
    function xss_clean($content, $is_image = false)
    {
        return \app\common\library\Security::instance()->xss_clean($content, $is_image);
    }
}

if (!function_exists('check_ip_allowed')) {
    /**
     * 检测IP是否允许
     * @param string $ip IP地址
     */
    function check_ip_allowed($ip = null)
    {
        $ip = is_null($ip) ? request()->ip() : $ip;
        $forbiddenipArr = config('site.forbiddenip');
        $forbiddenipArr = !$forbiddenipArr ? [] : $forbiddenipArr;
        $forbiddenipArr = is_array($forbiddenipArr) ? $forbiddenipArr : array_filter(explode("\n", str_replace("\r\n", "\n", $forbiddenipArr)));
        if ($forbiddenipArr && \Symfony\Component\HttpFoundation\IpUtils::checkIp($ip, $forbiddenipArr)) {
            $response = Response::create('请求无权访问', 'html', 403);
            throw new HttpResponseException($response);
        }
    }
}

if (!function_exists('writelog')) {

    /**
     * @param string $name
     * @param string $content
     * @return bool
     * 写入日志
     */
    function writelog($name = "", $content = "")
    {
        try {
            if (!$content || !$name)   return false;
            if (is_array($content) || is_object($content)) $content = json_encode($content,JSON_UNESCAPED_UNICODE);
            if (is_int($content))      $content = strval($content);
            if (is_numeric($content))  $content = number_format($content,0,'','');
            $base = ROOT_PATH . '/runtime/';
            if (!is_dir($base . 'logs')) mkdir($base . 'logs', 0777, true);
            $dir  = $base . 'logs' . DIRECTORY_SEPARATOR . $name;
            if (!is_dir($dir)) {
                if (!mkdir($dir, 0777, true)) return false;
            }
            $fname  = $dir . DIRECTORY_SEPARATOR . date("YmdH", time()) . '.log';
            $msg    = "[" . date('Y-m-d H:i:s') . "] ";
            $msg   .= $content;
            $msg   .= PHP_EOL;
            error_log($msg, 3, $fname);
            return true;
        } catch ( \Exception $e ) {
            writelog('errorlogs',strip_tags($e));
            return false;
        }
    }
}
if (!function_exists('root')) {

    /**
     * @return string
     * 获取root目录
     */
    function root()
    {
        $root = $phpfile = '';
        $iscgi = (0 === strpos(PHP_SAPI, 'cgi') || false !== strpos(PHP_SAPI, 'fcgi')) ? 1 : 0;
        if ($iscgi) {
            if (isset($_SERVER['PHP_SELF']) && isset($_SERVER['HTTP_HOST'])) {
                $temp = explode('.php', $_SERVER['PHP_SELF']);
                $phpfile = rtrim(str_replace($_SERVER['HTTP_HOST'], '', $temp[0] . '.php'), '/');
            } else {
                $phpfile = '';
            }
        } else {
            $phpfile = (isset($_SERVER['SCRIPT_NAME'])) ? rtrim($_SERVER['SCRIPT_NAME'], '/') : '';
        }
        $root = rtrim(dirname($phpfile), '/');
        $root = (($root == '/' || $root == '\\') ? '' : $root);
        return $root;
    }
}

if(!function_exists('getadv')){

    /**
     * @param int $advtype_id 广告类别
     * @param bool $all 是否查询多条
     * @return array|bool|false|PDOStatement|string|\think\Collection|\think\Model|null
     * 获取广告
     */
    function getadv($advtype_id=0,$all=false)
    {
        if ( $all ) {
            $data = Db::name('advdata')->field('name,linkurl,pic')->where(['switch'=>1,'advtype_id'=>$advtype_id])->order('weigh DESC')->select();
        } else {
            $data = Db::name('advdata')->field('name,linkurl,pic')->where(['switch'=>1,'advtype_id'=>$advtype_id])->order('weigh DESC')->find();
        }
        return $data;
    }
}

if(!function_exists('hhxss')){

    /**
     * @param string $val
     * @return string
     * 过滤xss
     */
    function hhxss( $val= '' )
    {
        if ( $val == '' ) return '';
        try {
            $val 	 = preg_replace('/([\x00-\x08,\x0b-\x0c,\x0e-\x19])/', '', $val);
            $search  = 'abcdefghijklmnopqrstuvwxyz';
            $search .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            $search .= '1234567890!@#$%^&*()';
            $search .= '~`";:?+/={}[]-_|\'\\';
            for ($i = 0; $i < strlen($search); $i++) {
                $val = preg_replace('/(&#[xX]0{0,8}'.dechex(ord($search[$i])).';?)/i', $search[$i], $val);
                $val = preg_replace('/(&#0{0,8}'.ord($search[$i]).';?)/', $search[$i], $val);
            }
            $ra1 = ['javascript', 'vbscript', 'expression', 'applet','src','img','script', 'meta', 'xml', 'blink', 'link', 'style', 'script', 'embed', 'object', 'iframe', 'frame', 'frameset', 'ilayer', 'layer', 'bgsound', 'title', 'base','video'];
            $ra3 = ['or','select','insert','and','update','delete','outfile','load_file','sp_','create','exec','xp_','drop','group','sleep','from','union','master','truncate','cr','lf','count','from','declare','alt','lgt','alert','limit'];
            $ra2 = ['onabort', 'onactivate', 'onafterprint', 'onafterupdate', 'onbeforeactivate', 'onbeforecopy', 'onbeforecut', 'onbeforedeactivate', 'onbeforeeditfocus', 'onbeforepaste', 'onbeforeprint', 'onbeforeunload', 'onbeforeupdate', 'onblur', 'onbounce', 'oncellchange', 'onchange', 'onclick', 'oncontextmenu', 'oncontrolselect', 'oncopy', 'oncut', 'ondataavailable', 'ondatasetchanged', 'ondatasetcomplete', 'ondblclick', 'ondeactivate', 'ondrag', 'ondragend', 'ondragenter', 'ondragleave', 'ondragover', 'ondragstart', 'ondrop', 'onerror', 'onerrorupdate', 'onfilterchange', 'onfinish', 'onfocus', 'onfocusin', 'onfocusout', 'onhelp', 'onkeydown', 'onkeypress', 'onkeyup', 'onlayoutcomplete', 'onload', 'onlosecapture', 'onmousedown', 'onmouseenter', 'onmouseleave', 'onmousemove', 'onmouseout', 'onmouseover', 'onmouseup', 'onmousewheel', 'onmove', 'onmoveend', 'onmovestart', 'onpaste', 'onpropertychange', 'onreadystatechange', 'onreset', 'onresize', 'onresizeend', 'onresizestart', 'onrowenter', 'onrowexit', 'onrowsdelete', 'onrowsinserted', 'onscroll', 'onselect', 'onselectionchange', 'onselectstart', 'onstart', 'onstop', 'onsubmit', 'onunload'];
            $ra    = array_merge($ra1, $ra2,$ra3);
            $found = true;
            while ($found == true) {
                $val_before = $val;
                for ($i = 0; $i < sizeof($ra); $i++) {
                    $pattern = '/';
                    for ($j = 0; $j < strlen($ra[$i]); $j++) {
                        if ($j > 0) {
                            $pattern .= '(';
                            $pattern .= '(&#[xX]0{0,8}([9ab]);)';
                            $pattern .= '|';
                            $pattern .= '|(&#0{0,8}([9|10|13]);)';
                            $pattern .= ')*';
                        }
                        $pattern .= $ra[$i][$j];
                    }
                    $pattern .= '/i';
                    $replacement = substr($ra[$i], 0, 1).' '.substr($ra[$i], 1);
                    $val = preg_replace($pattern, $replacement, $val);
                    if ($val_before == $val)   $found = false;
                }
            }
            $val = str_ireplace(['(',')','{','}','[',']','/','"',';','*',"\\","'"],'',$val);
            return trim(addslashes(htmlspecialchars($val)));
        } catch( \Exception $e) {
            writelog('errorlogs',strip_tags($e));
            return '';
        }
    }
}

if(!function_exists('upic')){
    /**
     * @param string $pic 传入图片
     * @param string $thumb 是否要生成缩略图，是 传数组['宽度'，'高度']
     * @param string $default 传入图片不存在时显示的默认图片
     * @return string
     * 返回图片（全路径）
     */
    function upic($pic='',$thumb='', $default = 'default.png')
    {
        if ( strstr($pic,'http') !='' || strstr($pic,'//') ) return $pic;
        if ( $thumb !='' ) {
            $thumb = explode(',',$thumb);
            $w = isset($thumb[0]) ? $thumb[0] : 100;
            $h = isset($thumb[1]) ? $thumb[1] : 100;
            return thumbpic($pic,$w,$h,$default);
        }
        $path  = root() .'/uploads/';
        $abs   = ROOT_PATH.'public/';
        $default = $path . 'default/' . $default;
        if ($pic == '') return $default;
        return (file_exists($abs . $pic)) ? cdnurl(root() . $pic,true) : cdnurl($default,true);
    }
}

if(!function_exists('thumbpic')){
    /**
     * @param string $pic 传入图片
     * @param int $w 裁剪宽度
     * @param int $h 裁剪高度
     * @param string $default 传入图片不存在时显示的默认图片
     * @param string $dirname 裁剪图片保存位置
     * @param int $type 裁剪区域
     * @return string
     * 生成缩略图，返回裁剪后的图片（全路径）
     */
    function thumbpic($pic='',$w=100,$h=100, $default = 'default.png',$dirname='thumb',$type=3)
    {
        if ( strstr($pic,'http') !='' || strstr($pic,'//') ) return $pic;
        $path  = root() .'/uploads/';
        if ( $pic == '' )  return $path.'default/'.$default;
        $abs   = ROOT_PATH.'public/';

        $fname = pathinfo($pic, PATHINFO_FILENAME);
        $ext = pathinfo($pic, PATHINFO_EXTENSION);
        $thumb = "{$dirname}/{$fname}_{$w}_{$h}.".$ext;

        if (file_exists( $abs.'uploads/'. $thumb))	 return $path.$thumb;
        if (!file_exists($abs. $pic) )   return $path.'default/'.$default;
        if (!is_dir($abs.'uploads/'.$dirname)) mkdir($abs.'uploads/'.$dirname,0777);
        $img = \think\Image::open($abs.$pic);
        $img->thumb($w, $h, $type)->save($abs.'uploads/'. $thumb);
        return cdnurl($path.$thumb,true);
    }
}


if(!function_exists('getdata')){
    /**
     * @param string $table 数据表
     * @param int $id 记录id
     * @param string $field
     * @param bool $default
     * @param bool $cache
     * @return bool|mixed
     * 获取一条数据的一个字段
     */
    function getdata($table = '', $id = 0, $field = 'name', $default = false, $cache = true)
    {
        if ($table == '' || !$id || $field == '') return $default;
        if ($cache && cache($table . '_' . $id . '_' . $field)) return cache($table . '_' . $id . '_' . $field);
        $data   = Db::name($table)->field($field)->where('id', $id)->find();
        $return = ($data) ? $data[$field] : $default;
        if ($cache) cache($table . '_' . $id . '_' . $field, $return, 3600);
        return $return;
    }
}

if(!function_exists('cg')){

    /**
     * @param string $str
     * @return string
     * 编辑器内容传值
     */
    function cg($name = 'content', $default = '', $method = 'post')
    {
        if ($method == 'get') {
            return isset($_GET[$name]) ? trim($_GET[$name]) : $default;
        } else if ($method == 'post') {
            return isset($_POST[$name]) ? trim($_POST[$name]) : $default;
        }
    }
}

if(!function_exists('editorFilter')){

    /**
     * @param string $content
     * @return string
     * 过滤XSS攻击
     */
    function editorFilter($content = ''){
        vendor('ezyang.htmlpurifier.library.HTMLPurifier');
        $config = \HTMLPurifier_Config::createDefault();
        $config->set('HTML.SafeEmbed',true);
        $config->set('HTML.SafeObject',true);
        $config->set('HTML.DefinitionID', 'html5-definitions');
        $config->set('HTML.DefinitionRev', 1);
        $config->set('HTML.ForbiddenAttributes', ['width', 'height']);
        if ( $def = $config->maybeGetRawHTMLDefinition() )
        {
            $def->addElement('video', 'Block', 'Optional: (source, Flow) | (Flow, source) | Flow', 'Common', [
                'src' => 'URI',
                'type' => 'Text',
                'poster' => 'URI',
                'preload' => 'Enum#auto,metadata,none',
                'controls' => 'Bool',
            ]);
            $def->addElement('source', 'Block', 'Flow', 'Common', [
                'src' => 'URI',
                'type' => 'Text',
            ]);
        }
        $filter = new \HTMLPurifier($config);
        return $filter->purify($content);
    }
}

if(!function_exists('letters')){
    /**
     * @param array $data
     * @return bool
     * 发送私信
     */
    function letters($data = []){

        $letters['title']       = $data['title']??'系统通知';
        $letters['msg']         = $data['msg']??'';
        $letters['user_id']     = $data['user_id']??0;
        $letters['type']        = $data['type']??1;
        $letters['isread']      = $data['isread']??0;
        $letters['parameter']   = $data['parameter']??'';//附带参数
        $letters['createtime']  = $data['createtime']??time();
        if(!$letters['user_id'] || !$letters['msg']) return false;
        if (  $letters['parameter'] != '' && is_array( $letters['parameter']) )  $letters['parameter'] = json_encode( $letters['parameter']);
        $res = (new \app\admin\model\Letters())::create($letters);
        return $res ? true : false;
    }
}
if(!function_exists('dateFormat')){
    /**
     * @param int $time
     * @param string $format
     * @return false|string
     * 格式化日期
     */
    function dateFormat($time,$format = 'Y-m-d H:i:s'){
        $mtime = $time;
        $ctime = time();
        if($ctime-$mtime<=10){
            return "刚刚";
        }else if($ctime-$mtime<=60){
            return "1分钟前";
        }else if($ctime-$mtime<=3600){
            $m = intval(($ctime-$mtime)/60);
            return "{$m}分钟前";
        }else if($ctime-$mtime<=3600*24){
            $h = intval(($ctime-$mtime)/3600);
            $m = intval(($ctime-$mtime-$h*3600)/60);
            return "{$h}小时{$m}分钟前";
        }else{
            return date($format,$time);
        }
    }
}

if(!function_exists('timeFormat')){

    /**
     * @param $time
     * @param null $local
     * @return string
     * 格式化时间
     */

    function timeFormat($time, $local = null){
        $local = $local ?: time();
        if(($time - $local) <= 0) return false;
        $day = ($time - $local)/(3600*24) ;
        if($day >= 1){
            $title = ceil($day).'天';
        }else{
            $hour = ($time - $local)/3600;
            if($hour >= 1){
                $title = ceil($hour).'小时';
            }else{
                $minute = ($time - $local)/60;
                $title = ceil($minute).'分钟';
                if($minute < 1) $title = '不足1分钟';
            }
        }
        return $title;
    }
}
