<?php

namespace app\index\controller;

use app\admin\controller\Files;
use app\common\controller\Frontend;
use think\Config;
use think\Db;

class Index extends Frontend
{

    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';
    protected $layout = '';

    public function index()
    {
        $info = Db::name('pages')->field('id,name,content')->where('id',2)->find();

        return $this->view->fetch('',['info'=>$info]);
    }

    public function news()
    {
        $adv = 0;
        return $this->getNews(1,$adv,'新闻资讯','news',10,'news');
    }

    protected function getNews($type=0,$adv=0,$title='',$mark='news',$limit=8,$template='news')
    {
        $arttype    = input('arttype',0,'intval');
        $ishot 	    = input('ishot', 0, 'intval');
        $isrec 	    = input('isrec', 0, 'intval');
        $kwd   	    = input('kwd','','hhxss');
        $ord        = input('ord',1,'intval');
        $where 	  = "switch=1 AND type={$type}";
        if ($arttype)   $where .= " AND arctype_id={$arttype}";
        if ($ishot)     $where .= " AND ishot={$ishot}";
        if ($isrec)     $where .= " AND isrec={$isrec}";
        if ($kwd)       $where .= " AND ( name LIKE '%" . $kwd . "%' OR intro LIKE '%" . $kwd . "%')";

        $order = "istop DESC,weigh DESC,createtime DESC";
        if($ord==2) $order = 'createtime DESC';
        if($ord==3) $order = 'hit DESC';

        $count 	  = Db::name('article')->where($where)->count();
        $page  	  = new \page\HomePage($count, $limit);
        $data  	  = Db::name('article')->field('id,name,arctype_id,createtime,intro,image,ishot,hit')->where($where)->order($order)->limit($page->limit)->select();
        foreach ($data as $key=>$val){
            $data[$key]['url'] = url('index/index/article','id='.$val['id']);
        }
        if($kwd) $title = '搜索 “<font color="red">'.$kwd.'</font>” 的结果：';
        //显示分页
        $pageshow = ($count > $limit) ? $page->showpage() : '';

        $arttypes = Db::name('arttype')->field('id,name')->where(['switch'=>1,'type'=>$type])->select();
        if(!$arttypes) $arttypes = [];
        array_unshift($arttypes,['id'=>0,'topic'=>'全部']);
        $banner = '';
        if($adv) $banner = getadv($adv);

        return $this->view->fetch($template,['kwd' => $kwd, 'mark' => $mark, 'pageshow' => $pageshow, 'data' => $data, 'title' => $title, 'arttype' => $arttype,'arttypes'=>$arttypes,'banner'=>$banner,'limit'=>$limit,'type'=>$type,'ord'=>$ord]);
    }

    public function article()
    {
        $id     = input('id',0,'intval');
        $tables = 'article';
        if (!$id) $this->error('页面不存在');
        $data   = Db::name($tables)->field('*')->where('id',$id)->find();
        if ( !$data ) $this->error('页面不存在');
        if ( !$data['switch'] ) $this->error('文章已被删除');
        Db::name($tables)->where('Id',$id)->setInc('hit');
        if ($data['linkurl'] !='' ) header("Location:".$data['linkurl']);
        $data['content'] = html_entity_decode($data['content']);
        $tpage = $this->getpage(['type'=>$data['type'],'id'=>$id]);

        $this->assign('title',  ($data['title']!='')   ? $data['title']   : $data['name']);
        $this->assign('description',($data['description']!='') ? $data['description'] : Config::get("site.description"));
        $this->assign('keywords',($data['keyword']!='') ? $data['keyword'] : Config::get("site.keywords"));

        return $this->view->fetch('',['data'=>$data,'tpage'=>$tpage,'mark'=>'article']);
    }

    public function pages()
    {
        $id = input('id',0,'intval');
        if(!$id) $this->error('抱歉，数据不存在');
        $data = Db::name('pages')->field('*')->where('id',$id)->find();
        if(!$data['switch']) $this->error('数据已删除');
        $data['content'] = html_entity_decode($data['content']);
        $mark = 'pages';
        $mtitle = '关于我们';
        $banner = getadv(3);

        $this->assign('title', ($data['title'] != '') 	  ? $data['title']   : $data['name']);
        $this->assign('description',($data['description']!='') ? $data['description'] : Config::get("site.description"));
        $this->assign('keywords',($data['keywords']!='') ? $data['keywords'] : Config::get("site.keywords"));

        return $this->fetch('', ['data'=>$data,'mark' => $mark,'mtitle'=>$mtitle,'banner'=>$banner]);
    }
}
