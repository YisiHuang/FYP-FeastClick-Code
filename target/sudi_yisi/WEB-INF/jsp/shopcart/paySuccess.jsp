<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
        <title>Pay Success</title>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/style.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/-jquery-1.8.3.min.js"></script>
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/nav2.css" type="text/css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/amazeui.min.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/amazeui.min.js"></script>
        <style>
            .one_qcode{
                position:absolute;
                top:190px;
                width:200px;
                height:180px;
                background:#fff;
                text-align:center;
                color:#000;
                z-index:200;
            }
            .one_qcode img{
                margin:0 auto;
            }
        </style>
    </head>
    <body>
        <form id="myform" action="" method="post">
            <div class="qing tibg">
                <div class="juzhong gwc-tk">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody><tr>
                            <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa1.png" width="273" height="19"></td>
                            <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa2.png" width="362" height="19"></td>
                            <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa3.png" width="615" height="19"></td>
                        </tr>
                        </tbody></table>
                    <div class="qing chm">
                        <div class="lf" style="width:295px; text-align:right;">Shop Cart</div>
                        <div class="lf" style="width:386px; text-align:right;">Check Order Information</div>
                        <div class="lf" style="width:323px; text-align:right;">Pay Success</div>
                    </div>
                </div>
            </div>
            <!--核对信息 -->
            <div class="qing juzhong">
                <div class="cenbg">
                    <div class="qing" style="width: 500px;margin: 50px auto;">
                        <img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/zfcg.png" width="100" style=" float:left;">
                        <div style="float:left; margin-left:30px;">
                            <h1 style="font-size:20px;">Payment successful!</h1>
                            <p style="font-size:14px;color: #333333;">You have earned a total of
                                <font color="#e01222">【<span id="rewardScore">0</span> points for this payment】</font>
                            </p>
                            <a href="javascript:void(0)" id="continue"><input type="button" value="Continue Order" class="jie2" style="line-height:35px; margin-right:20px; border-radius:5px; height:35px; margin-top:10px; background:#666"></a>
                            <a href="javascript:void(0)" id="userInfo"><input type="button" value="Personal Center" class="jie2"  style="line-height:35px; margin-right:20px; border-radius:5px; height:35px; margin-top:10px;"></a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="qing banq" style="margin-bottom:20px;">Copyright FeastClick By <font color="#1aa094"><b>Yisi</b></font>, All Rights Reserved</div>
    </body>


    <script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/static/plugins/layui/js/lay-config.js?v=2.0.0" charset="utf-8"></script>
    <script>
        //获取奖励积分参数
        var rewardScore = window.location.href.split("?")[1].split("=")[1];
        $("#rewardScore").text(rewardScore);

        layui.use(['form', 'jquery', 'layer', 'laytpl', 'miniTab'], function () {
            var $ = layui.jquery,
                miniTab = layui.miniTab,
                layer = layui.layer;

            /**
             * 监听按钮点击事件，跳转新的Tab页面
             */
            $("#continue").click(function () {
                // 打开新的iframe窗口
                miniTab.openNewTabByIframe({
                    href:"${pageContext.request.contextPath}/reception/foodCenter.html",
                    title:"Order Menu",
                });
            });
            $("#userInfo").click(function () {
                // 打开新的iframe窗口
                miniTab.openNewTabByIframe({
                    href:"${pageContext.request.contextPath}/userInfo.html",
                    title:"Personal Account",
                });
            });

        });
    </script>
</html>
