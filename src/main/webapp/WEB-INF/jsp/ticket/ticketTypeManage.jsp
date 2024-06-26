<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>Coupon Category Management</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/css/foodManage.css">
    </head>
    <script>
        var flag;//控制行工具栏显示的标识符
    </script>
    <body>
        <div class="layuimini-container">
            <div class="layuimini-main">

                <%-- 头部条件搜索区域 --%>
                <fieldset class="table-search-fieldset">
                    <legend>Search Information</legend>
                    <div style="margin: 10px 10px 10px 10px">
                        <form class="layui-form layui-form-pane" action="" id="searchForm">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">Coupon Number</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="ticketTypeId" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">Coupon Name</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="ticketName" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">Requirements</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="requirement" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">Offer Amount</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="cheap" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">Days in Force</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="liveTime" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn">
                                        <i class="layui-icon layui-icon-search"></i>Search
                                    </button>
                                    <button type="reset" class="layui-btn layui-btn-primary" lay-submit lay-filter="data-reset-btn" id="data-reset-btn">
                                        <i class="layui-icon layui-icon-refresh"></i>Reset
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </fieldset>

                <%-- 表格头部工具栏 --%>
                <script type="text/html" id="toolbarDemo">
                    <div class="layui-btn-container">
                        <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add">
                            <i class="layui-icon layui-icon-add-1"></i>Add
                        </button>
                    </div>
                </script>

                <%-- 表格区域 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

                <%-- 表格行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit" id="edit">
                        <i class="layui-icon layui-icon-edit"></i>Edit
                    </a>
                    {{# if(!flag){ }}
                    <a class="layui-btn layui-btn-xs layui-btn data-count-delete" lay-event="onShelf" id="onShelf">
                        <i class="layui-icon layui-icon-play"></i>On Shelf
                    </a>
                    {{# } else{}}
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="offShelf" id="offShelf">
                        <i class="layui-icon layui-icon-pause"></i>Off Shelf
                    </a>
                    {{# } }}
                </script>

                <%-- 添加或修改弹出框 --%>
                <div class="layui-container" style="display: none;padding: 5px;width: 100%;" id="addOrUpdateForm">
                    <form class="layui-form" style="width: 90%" id="dataForm" lay-filter="dataForm">
                        <%--表单隐藏域--%>
                        <input type="hidden" name="ticketTypeId" id="ticketTypeId">
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Coupon Name</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="ticketName" placeholder="Please enter the coupon name." lay-verify="required" autocomplete="off" class="layui-input" id="ticketName">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Threshold</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="requirement" placeholder="Please enter the threshold of use" lay-verify="required" autocomplete="off" class="layui-input" id="requirement">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Offer Amount</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="cheap" placeholder="Please enter the discount amount" lay-verify="required" autocomplete="off" class="layui-input" id="cheap">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Quantity Provided</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="ticketNum" placeholder="Please enter the quantity provided" lay-verify="required" autocomplete="off" class="layui-input" id="ticketNum">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Days in Effect</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="liveTime" placeholder="Please enter the number of days in effect" lay-verify="required" autocomplete="off" class="layui-input" id="liveTime">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Points Required</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="needScore" placeholder="Please enter the required points" lay-verify="required" autocomplete="off" class="layui-input" id="needScore">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item layui-row layui-col-md12">
                            <div class="layui-input-block" style="text-align: center">
                                <button type="button" class="layui-btn layui-btn-checked" lay-submit lay-filter="doSubmit">
                                    <span class="layui-icon layui-icon-add-1"></span>Submit
                                </button>
                                <button type="reset" class="layui-btn layui-btn-primary" lay-reset lay-filter="doReset" id="doReset">
                                    <span class="layui-icon layui-icon-refresh"></span>Reset
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>

    </body>

    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table', 'jquery', 'layer'], function () {
            var $ = layui.jquery,
                form = layui.form,
                table = layui.table,
                layer = layui.layer;

            var url;//提交的请求地址
            var index;//打开窗口的索引

            /**
             * 数据表单初始化
             */
            var tableIns = table.render({
                elem: '#currentTableId',
                url: '${pageContext.request.contextPath}/backstage/ticketType/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: 'Hint',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'ticketTypeId', width: 154, title: 'Coupon Category Number', align: "center", sort: true},
                    {field: 'ticketName', minWidth: 180, title: 'Coupon Name', align: "center"},
                    {field: 'requirement', width: 86, title: 'Coupon Threshold', align: "center"},
                    {field: 'cheap', width: 86, title: 'Offer Amount', align: "center"},
                    {field: 'ticketNum', width: 100, title: 'Quantity Provided', align: "center"},
                    {field: 'lastModifyBy', width: 100, title: 'Last Modified By', align: "center"},
                    {field: 'lastModifyTime', minWidth: 160, title: 'Last Modified Time', align: "center",
                        templet:"<div>{{layui.util.toDateString(d.lastModifyTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                    },
                    {field: 'ticketTypeStatus', width: 84, title: 'Status', sort: true, align: "center",
                        templet: function (d) {
                            console.log(d);
                            if (d.ticketTypeStatus == 1){
                                flag = true;
                                return "<font color='blue'>On Shelf</font>";
                            }else if (d.ticketTypeStatus == 2) {
                                flag = false;
                                return "<font color='red'>Off Shelf</font>";
                            }
                        }
                    },
                    {title: 'Operation', width: 240, toolbar: '#currentTableBar', align: "center"}
                ]],
                limits: [10, 15, 20, 25, 50, 100],
                limit: 10,
                page: true,
                skin: 'line',
                //当最后一页的数据被删完后，可以自动返回到上一页
                done: function(res, curr, count){
                    //判断当前页码是否大于1并且当前页的数据量是否为0
                    if (curr>1 && res.data.length==0){
                        var pageValue = curr - 1;
                        //刷新数据表格的数据
                        tableIns.reload({
                            page: {curr: pageValue}
                        })
                    }
                }
            });

            /**
             * 监听搜索操作
             */
            form.on('submit(data-search-btn)', function (data) {
                console.log(data);
                //执行搜索重载
                tableIns.reload({
                    where: data.field,
                    page: {
                        curr: 1
                    }
                });
                return false;
            });

            /**
             * 编写表单提交的监听事件,doSubmit是提交按钮的lay-filter的值
             */
            form.on("submit(doSubmit)", function(data){
                //使用ajax的post请求去传递数据
                $.post(url, data.field, function(result){
                    if (result.flag){
                        //刷新数据表格
                        tableIns.reload();
                        //关闭当前窗口
                        layer.close(index);
                    }
                    //弹出提示信息
                    layer.msg(result.message);
                }, "json");
                //禁止页面刷新
                return false;
            });

            /**
             * toolbar监听头部工具栏事件
             */
            table.on('toolbar(currentTableFilter)', function (obj) {
                if (obj.event === 'add') {  // 监听添加操作
                    index = layer.open({
                        title: 'Add Coupon Category',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['60%', '45%'],
                        offset: ['100px', '240px'],
                        content: $("#addOrUpdateForm"),
                        success: function () {
                            //清空表单数据
                            $("#dataForm")[0].reset();
                            //添加的提交请求路径赋值
                            url = "${pageContext.request.contextPath}/backstage/ticketType/add";
                        }
                    });
                }
            });

            /**
             * 监听表单行工具栏事件
             */
            table.on('tool(currentTableFilter)', function (obj) {
                var data = obj.data;
                console.log(data);
                if (obj.event === 'edit') {
                    index = layer.open({
                        title: 'Edit Coupon Category',
                        type: 1,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['60%', '45%'],
                        offset: ['100px', '240px'],
                        content: $("#addOrUpdateForm"),
                        success: function(){
                            //表单数据回显，参数1表示lay-filter的值，参数2表示回显的数据
                            form.val("dataForm", data);
                            //重新渲染表单
                            form.render();
                            //添加的提交请求
                            url = "${pageContext.request.contextPath}/backstage/ticketType/modify";
                        }
                    });
                }else if (obj.event === "offShelf") {
                    var str = 'Sure you want to do a downvote on coupon category <font color="red">【' +data.ticketName+ '】</font>?\nThe take down action will prevent the user from claiming the voucher';
                    layer.confirm(str, {icon: 3, title:'Alert', btn: ['Sure', 'Close']}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/ticketType/offShelf", {ticketTypeId: data.ticketTypeId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }else if (obj.event === 'onShelf') {
                    var str = 'Are you sure you want to do a shelf operation on category <font color="red">【' +data.ticketName+ '】</font>?';
                    layer.confirm(str, {icon: 3, title:'Alert', btn: ['Sure', 'Close']}, function(index){
                        $.post("${pageContext.request.contextPath}/backstage/ticketType/onShelf", {ticketTypeId: data.ticketTypeId}, function (result) {
                            if (result.flag){
                                //重新加载
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }
            });


        });
    </script>

</html>
