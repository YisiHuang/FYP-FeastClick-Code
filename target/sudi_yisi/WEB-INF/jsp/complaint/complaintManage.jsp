<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <title>Complaint Centre</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui/css/public.css" media="all">
        <%-- 添加layui-dtree的css样式 --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/dtree.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/layui_ext/dtree/font/dtreefont.css">
    </head>
    <body>
        <div class="layuimini-container">
            <div class="layuimini-main">

                <%-- 头部条件搜索区域 --%>
                <fieldset class="table-search-fieldset">
                    <legend> Search Information</legend>
                    <div style="margin: 10px 10px 10px 10px">
                        <form class="layui-form layui-form-pane" action="" id="searchForm">
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">Complaint Number</label>
                                    <div class="layui-input-inline">
                                        <input type="text" name="ticketTypeId" autocomplete="off" class="layui-input" onkeyup="value=value.replace(/[^0-9]/g,'')">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">Type of complaint</label>
                                    <div class="layui-input-inline">
                                        <select type="text" name="complaintType">
                                            <option value="0">Please Select</option>
                                            <option value="1">Distributor Complaints</option>
                                            <option value="2">Food Complaints</option>
                                            <option value="3">Other</option>
                                        </select>
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

                <%-- 表格区域 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

                <%-- 表格行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit" id="edit">
                        <i class="layui-icon layui-icon-edit"></i>Edit
                    </a>
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
                                    <input type="text" name="ticketName" placeholder="Please enter the name of the coupon" lay-verify="required" autocomplete="off" class="layui-input" id="ticketName">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font> Usage Threshold </label>
                                <div class="layui-input-inline">
                                    <input type="text" name="requirement" placeholder="Please enter the threshold of use" lay-verify="required" autocomplete="off" class="layui-input" id="requirement">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Discount Amount</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="cheap" placeholder="Please enter the discount amount" lay-verify="required" autocomplete="off" class="layui-input" id="cheap">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Quantity provided</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="ticketNum" placeholder="Please enter the quantity provided" lay-verify="required" autocomplete="off" class="layui-input" id="ticketNum">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Number of days in effect</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="liveTime" placeholder="Please enter the number of days in effect" lay-verify="required" autocomplete="off" class="layui-input" id="liveTime">
                                </div>
                            </div>
                            <div class="layui-inline layui-col-md6 my-inline">
                                <label class="layui-form-label"><font color="red"> * </font>Points required</label>
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
                url: '${pageContext.request.contextPath}/reception/complaint/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: 'Hint',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50, align: "center"},
                    {field: 'complaintId', width: 114, title: 'Complaint Number', align: "center", sort: true},
                    {field: 'orderId', width: 190, title: 'Order Number', align: "center"},
                    {field: 'username', width: 90, title: 'Complainant', align: "center"},
                    {field: 'complaintType', width: 114, title: 'Type of complaint', align: "center", sort: true,
                        templet: function (d) {
                            if (d.complaintType == 1){
                                return "<font color='#4662d9'>Distributor Complaints</font>";
                            }else if (d.complaintType == 2){
                                return "<font color='#ff4500'>Food Complaints</font>";
                            }else if (d.complaintType == 3){
                                return "<font color='#999999'>Other</font>";
                            }
                        }
                    },
                    {field: 'target', width: 120, title: 'Target of Complaint', align: "center"},
                    {field: 'complaintContent', minWidth: 200, title: 'Complaint Content', align: "center"},
                    {field: 'complaintTime', minWidth: 160, title: 'Complaint Time', align: "center", sort: true,
                        templet:"<div>{{layui.util.toDateString(d.complaintTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                    }
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
        });
    </script>

</html>
