<?php
namespace page;

class HomePage {

	public $_total;								//总记录
	public $pagesize;						    //每页显示多少条
	public $limit;								//limit
	public $_page;								//当前页码
	public $_pagenum;							//总页码
	public $_url;								//地址
	public $_bothnum;							//两边保持数字分页的量
	public function __construct($_total, $pagesize){
		$this->_total   = $_total ? $_total : 1;
		$this->pagesize = $pagesize;
		$this->_pagenum = ceil($this->_total / $this->pagesize);
		$this->_page    = $this->setPage();
		$this->limit    = ($this->_page-1)*$this->pagesize.",$this->pagesize";
		$this->_url     = $this->setUrl();
		$this->_bothnum = 4;
	}

	public function getLimit() 
	{
		return $this->limit;
	}

	public function getPage() 
	{
		return $this->_page;
	}

	private function setPage() 
	{
	   $page = input('param.page',0,'intval');
	   if ( $page < 1 ) $page = 1;
	   if ( $page > $this->_pagenum ) $page = $this->_pagenum;
	   return $page;
	}	

	private function setUrl() 
	{
		return request()->module().'/'.request()->controller().'/'.request()->action();
	}
	
	private function url($page)
	{
	  	$parameter = input('param.');
		$parameterurl = $this->setUrl();
		foreach($parameter as $key=>$val){
		  if($key!='page' && $key!='frist'){
			$parameterurl .= '&'.$key.'='.$val;
		  }
		}
		return $parameterurl.'&page='.$page;
	}

	private function pageList() 
	{
		$_pagelist = '';
		for ($i=$this->_bothnum;$i>=1;$i--) {
			$_page = $this->_page-$i;
			if ($_page < 1) continue;
			$_pagelist .= '<li><a href="'.url($this->_url,$this->url($_page)).'">'.$_page.'</a></li>';
		}
		$_pagelist .= '<li class="active"><a href="javascript:void(0)">'.$this->_page.'</a></li>';
		for ($i=1;$i<=$this->_bothnum;$i++) {
			$_page = $this->_page+$i;
			if ($_page > $this->_pagenum) break;
			$_pagelist .= '<li><a href="'.url($this->_url,$this->url($_page)).'">'.$_page.'</a></li>';
		}
		return $_pagelist;
	}

	private function first() 
	{
		if ($this->_page > $this->_bothnum+1) {
			return '<li><a href="'.url($this->_url,$this->url(1)).'">1</a></li><li><a href="javascript:void(0)">...</a></li>';
		}
	}

	private function prev() 
	{
		if ($this->_page == 1) {
			return '<li class="disabled"><a href="javascript:void(0)"><span aria-hidden="true">上一页</span></a></li>';
		}
		return '<li><a href="'.url($this->_url,$this->url($this->_page-1)).'"><span aria-hidden="true">上一页</span></a></li>';
	}

	private function next() 
	{
		if ($this->_page == $this->_pagenum) {
			return '<li class="disabled"><a href="javascript:void(0)"><span aria-hidden="true">下一页</span></a></li>';
		}
		return ' <li><a href="'.url($this->_url,$this->url($this->_page+1)).'"><span aria-hidden="true">下一页</span></a></li> ';
	}

	private function last() 
	{
		if ($this->_pagenum - $this->_page > $this->_bothnum) {
			return ' <li><a href="javascript:void(0)">...</a></li><li><a href="'.url($this->_url,$this->url($this->_pagenum)).'">'.$this->_pagenum.'</a></li>';
		}
	}

	public function showpage() 
	{
		$_page = '';
		$_page .= $this->prev();
		$_page .= $this->first();
		$_page .= $this->pageList();
		$_page .= $this->last();
		$_page .= $this->next();
		$_page = '<ul class="pagination pagination-sm">'.$_page.'</ul>';
		return ($this->_pagenum != 1) ? '<div class="mypage">'.$_page.'</div>' : '';
	}
}
?>