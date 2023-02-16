define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {
    var type = Config.type;
    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'pages/index' + location.search,
                    add_url: 'pages/add/type/'+type,
                    edit_url: 'pages/edit/type/'+type,
                    del_url: 'pages/del/type/'+type,
                    multi_url: 'pages/multi/type/'+type,
                    import_url: 'pages/import/type/'+type,
                    table: 'pages',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id'),width:50},
                        {field: 'name', title: __('Name'), operate: 'LIKE',width:200},
                        {field: 'ftitle', title: __('Ftitle'), operate: 'LIKE',visible:false},
                        {field: 'domain', title: __('Domain'), operate: 'LIKE',visible:false},
                        {field: 'image',width:100, title: __('Image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'intro', title: __('Intro'), operate: 'LIKE',align:'left',
                            formatter : function(value, row, index, field){
                                return "<span style='display: block;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;' title='" + row.intro + "'>" + value + "</span>";
                            },
                            cellStyle : function(value, row, index, field){
                                return {
                                    css: {
                                        "white-space": "nowrap",
                                        "text-overflow": "ellipsis",
                                        "overflow": "hidden",
                                        "max-width":"400px"
                                    }
                                };
                            }
                        },
                        {field: 'linkurl', title: __('Linkurl'), operate: 'LIKE', formatter: Table.api.formatter.url,visible:false},
                        {field: 'title', title: __('Title'), operate: 'LIKE',visible:false},
                        {field: 'keyword', title: __('Keyword'), operate: 'LIKE',visible:false},
                        {field: 'description', title: __('Description'), operate: 'LIKE',visible:false},
                        {field: 'switch',width:100, title: __('Switch'), searchList: {"1":__('Yes'),"0":__('No')}, table: table, formatter: Table.api.formatter.toggle},
                        {field: 'weigh', title: __('Weigh'),sortable:true,width: 65},
                        {field: 'createtime',width:150, title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime,visible:false},
                        {field: 'operate',width:150, title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ],
                queryParams: function (params) {
                    // 自定义搜索条件
                    var filter = params.filter ? JSON.parse(params.filter) : {};
                    var op = params.op ? JSON.parse(params.op) : {};
                    if(type > 0){
                        //filter.后跟的是在ajax里使用的名称只需修改这两行
                        filter.type = type;
                        //op后跟的也是ajax里使用的名称，后面是条件
                        op.type = '=';

                        params.filter = JSON.stringify(filter);
                        params.op = JSON.stringify(op);
                        //funcUrlDel('ids');
                    }
                    return params;
                },
                onLoadSuccess:function(){
                    // 这里就是数据渲染结束后的回调函数
                    $(".btn-add").data("area", ['90%','80%']);
                    $(".btn-edit").data("area", ['90%','80%']);
                    $(".btn-editone").data("area", ['90%','80%']);
                }
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        recyclebin: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    'dragsort_url': ''
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: 'pages/recyclebin' + location.search,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'title', title: __('Title'), align: 'left'},
                        {
                            field: 'deletetime',
                            title: __('Deletetime'),
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime
                        },
                        {
                            field: 'operate',
                            width: '130px',
                            title: __('Operate'),
                            table: table,
                            events: Table.api.events.operate,
                            buttons: [
                                {
                                    name: 'Restore',
                                    text: __('Restore'),
                                    classname: 'btn btn-xs btn-info btn-ajax btn-restoreit',
                                    icon: 'fa fa-rotate-left',
                                    url: 'pages/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'pages/destroy',
                                    refresh: true
                                }
                            ],
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },

        add: function () {
            var type = Fast.api.query('type');
            $('#c-type').val(type);
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});