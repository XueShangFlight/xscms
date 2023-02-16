<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class Article extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'article';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [

    ];
    

    

    public function setCreatetimeAttr($value,$data)
    {
        return strtotime($value);
    }

    public function getCreatetimeAttr($value,$data)
    {
        return date('Y-m-d H:i:s',$value);
    }



    public function arttype()
    {
        return $this->belongsTo('Arttype', 'arctype_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
