<?php

/**
 * @param string $content
 * @return array|bool|false|mixed|string
 * 编辑器内容转义
 */
function dwcontent( $content = '' )
{
    if ( $content == '' ) return '';
    $content = str_replace("/uploads/editor",cdnurl('/uploads/editor',true),$content);
    $towxml  = new \html2wxml\ToWXML();
    $content = $towxml->towxml($content, array(
        'type'      => 'html',
        'highlight' => true,
        'linenums'  => true,
        'imghost'   => null,
        'encode'    => false,
        'highlight_languages' => array( 'html', 'js', 'php', 'css' )
    ));
    return $content;
}

/**
 * 获取微信配置
 * @return mixed
 */
function getWxConf()
{
    $data['xcx_wxmacid']    = config('xcx_wxmacid');
    $data['xcx_wxkey']      = config('xcx_wxkey');
    $data['wxname']         = config('wxname');
    $data['wxappid']        = config('wxappid');
    $data['wxsecret']       = config('wxsecret');
    $data['companyurl']     = config('companyurl');
    return $data;
}