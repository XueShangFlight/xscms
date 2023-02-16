<?php

namespace app\admin\controller;

use app\admin\model\Admin;
use app\admin\model\User;
use app\common\controller\Backend;
use app\common\model\Attachment;
use fast\Date;
use think\Db;

/**
 * 控制台
 *
 * @icon   fa fa-dashboard
 * @remark 用于展示当前系统中的统计数据、统计报表及重要实时数据
 */
class Dashboard extends Backend
{

    /**
     * 查看
     */
    public function index()
    {
        try {
            \think\Db::execute("SET @@sql_mode='';");
        } catch (\Exception $e) {

        }
        $column = [];
        $starttime = Date::unixtime('day', -6);
        $endtime = Date::unixtime('day', 0, 'end');
        $joinlist = Db("user")->where('jointime', 'between time', [$starttime, $endtime])
            ->field('jointime, status, COUNT(*) AS nums, DATE_FORMAT(FROM_UNIXTIME(jointime), "%Y-%m-%d") AS join_date')
            ->group('join_date')
            ->select();
        for ($time = $starttime; $time <= $endtime;) {
            $column[] = date("Y-m-d", $time);
            $time += 86400;
        }
        $userlist = array_fill_keys($column, 0);
        foreach ($joinlist as $k => $v) {
            $userlist[$v['join_date']] = $v['nums'];
        }

        $dbTableList = Db::query("SHOW TABLE STATUS");

        //系统信息
        $sysinfo = [];
        $sysinfo['os']           = PHP_OS;
        $sysinfo['web_server']   = isset($_SERVER['SERVER_SOFTWARE']) ? htmlspecialchars($_SERVER['SERVER_SOFTWARE']) : '';
        $sysinfo['php_ver']      = PHP_VERSION;
        $sysinfo['mysql_ver']    = $this->mysql_version();
        $sysinfo['zlib']         = function_exists('gzclose') ? '是' : '否';
        $sysinfo['timezone']     = function_exists("date_default_timezone_get") ? date_default_timezone_get() : '无法检测';
        $sysinfo['max_filesize'] = ini_get('upload_max_filesize');
        $sysinfo['post_maxsize'] = ini_get('post_max_size');
        $gd = gd_info();
        $sysinfo['gd']           = isset($gd['GD Version']) ? $gd['GD Version'] : '未开启GD库';
        $sysinfo['memory_limit'] = ini_get('memory_limit');
        $sysinfo['max_time']     = @ini_get("max_execution_time") . 's';
        $sysinfo['admin_ver']    = config('admin_version');
        $sysinfo['language']     = 'ZH-CN';
        $sysinfo['coding']       = 'UTF-8';
        $disk_size = '未知';
        if (!$disk_size = cache('system_disk_size'.date('Ymd'))) {
            if (function_exists('disk_free_space')) {
                $disk_size = floor(disk_free_space('./') / (1024 * 1024));
                if ($disk_size > 1024) {
                    $disk_size = round(floor($disk_size) / (1024), 2) . 'G';
                } else {
                    $disk_size = round($disk_size, 2) . 'M';
                }
            }
            cache('system_disk_size'.date('Ymd'), $disk_size);
        }
        $sysinfo['disk_size'] = $disk_size;
        $sysinfo['isredis']    = ( !extension_loaded('redis') )    ? 0 : 1;
        $sysinfo['ismemcache'] = ( !extension_loaded('memcache') ) ? 0 : 1;

        $this->view->assign([
            'sysinfo'         => $sysinfo,
            'totaluser'       => User::count(),
            'totaladdon'      => count(get_addon_list()),
            'totaladmin'      => Admin::count(),
            'totalcategory'   => \app\common\model\Category::count(),
            'todayusersignup' => User::whereTime('jointime', 'today')->count(),
            'todayuserlogin'  => User::whereTime('logintime', 'today')->count(),
            'sevendau'        => User::whereTime('jointime|logintime|prevtime', '-7 days')->count(),
            'thirtydau'       => User::whereTime('jointime|logintime|prevtime', '-30 days')->count(),
            'threednu'        => User::whereTime('jointime', '-3 days')->count(),
            'sevendnu'        => User::whereTime('jointime', '-7 days')->count(),
            'dbtablenums'     => count($dbTableList),
            'dbsize'          => array_sum(array_map(function ($item) {
                return $item['Data_length'] + $item['Index_length'];
            }, $dbTableList)),
            'attachmentnums'  => Attachment::count(),
            'attachmentsize'  => Attachment::sum('filesize'),
            'picturenums'     => Attachment::where('mimetype', 'like', 'image/%')->count(),
            'picturesize'     => Attachment::where('mimetype', 'like', 'image/%')->sum('filesize'),
        ]);

        $this->assignconfig('column', array_keys($userlist));
        $this->assignconfig('userdata', array_values($userlist));

        return $this->view->fetch();
    }

    private function mysql_version()
    {
        if (!$ver = cache('sql_ver')) {
            $version = Db::query("select version() as ver");
            cache('sql_ver', $version[0]['ver']);
            return $version[0]['ver'];
        } else {
            return $ver;
        }
    }
}
