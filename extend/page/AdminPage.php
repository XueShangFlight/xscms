<?php
namespace page;

class AdminPage {
	public $_total;								//总记录
	public $pagesize;						    //每页显示多少条
	public $limit;								//limit
	public $_page;								//当前页码
	public $_pagenum;							//总页码
	public $_url;								//地址
	public $_bothnum;							//两边保持数字分页的量

	public function __construct($_total, $pagesize)
	{
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
	    $page = input('page',1,'intval');
	    if ( $page < 1 ) $page = 1;
	    if ( $page > $this->_pagenum ) $page = $this->_pagenum;
	    return $page;
	}	

	private function setUrl()
	{
		return request()->action();
	}

	private function url($page)
	{
	  	$parameter	  = input('param.');
		$parameterurl = $this->setUrl();
		foreach( $parameter as $key=>$val ){
		  if( $key!='page' && $key!='frist' )  $parameterurl .= '&'.$key.'='.$val;
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
		if ($this->_page > $this->_bothnum+1) return '<li><a href="'.$this->_url.'">1</a></li><li><a href="javascript:void(0)">...</a></li>';
	}

	private function prev() 
	{
		if ( $this->_page == 1 ) return '<li class="disabled"><a href="javascript:void(0)" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>';
		return '<li><a href="'.url($this->_url,$this->url($this->_page-1)).'" data-toggle="tooltip" data-placement="top" title="上一页" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>';
	}

	private function next() 
	{
		if ($this->_page == $this->_pagenum) {
			return '<li class="disabled"><a href="javascript:void(0)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
		}
		return ' <li><a href="'.url($this->_url,$this->url($this->_page+1)).'" data-toggle="tooltip" data-placement="top" title="下一页" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li> ';
	}

	private function last() 
	{
		if ($this->_pagenum - $this->_page > $this->_bothnum) {
			return ' <li><a href="javascript:void(0)">...</a></li><li><a href="'.url($this->_url,$this->url($this->_pagenum)).'">'.$this->_pagenum.'</a></li>';
		}
	}

	private function jump()
	{
		return '';
	    $val = ($this->_page < $this->_pagenum) ? $this->_page+1 : $this->_page;	
	    return '<div class="input-group input-group-sm pull-left" style="width:100px;"><input type="hidden" value="'.url($this->_url,$this->url(0)).'" name="jump_url" class="jump_url" /><input type="text" value="'.$val.'" max="'.$this->_pagenum.'" onKeyUp="if(this.value>'.$this->_pagenum.'){this.value='.$this->_pagenum.'}" name="page" class="form-control page_num"><span class="input-group-addon jump_go" data-toggle="tooltip" data-placement="top" title="点击跳转到页码"><span class="glyphicon glyphicon-share-alt"></span></span></div>';
	}

	public function showpage() 
	{
		$_page = '';
		if($this->_pagenum>0) $_page .= "<li class='active'><a href=\"javascript:void(0)\">".$this->_total."条 / ".$this->_pagenum."页</a><li>";
		$_page .= $this->prev();
		$_page .= $this->first();
		$_page .= $this->pageList();
		$_page .= $this->last();
		$_page .= $this->next();
		$_page = '<nav class="pull-left"><ul class="pagination pagination-sm">'.$_page.'</ul></nav>';
		return ($this->_pagenum>1) ? '<div class="mypage">'.$_page.$this->jump().'</div>' : '<div class="mypage">'.$_page.'</div>';
	}
	
}
