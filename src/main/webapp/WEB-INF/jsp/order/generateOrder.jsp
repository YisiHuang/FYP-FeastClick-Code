<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <title>Form Order</title>
    <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/style.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/js/-jquery-1.8.3.min.js"></script>
    <link href="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/css/nav2.css" type="text/css" rel="stylesheet"><!--藏品分类 -->
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
                    <td><img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/pa30.png" width="615" height="19"></td>
                </tr>
                </tbody></table>
            <div class="qing chm">
                <div class="lf" style="width:295px; text-align:right;">Shop Cart</div>
                <div class="lf" style="width:386px; text-align:right;">Check Order Information</div>
                <div class="lf" style="width:323px; text-align:right;">Payment Success</div>
            </div>
        </div>
    </div>
    <!--核对信息 -->
    <div class="qing juzhong">

        <div class="cenbg">
            <div class="qing" style="position: relative;border-bottom: 1px solid #e3e3e3;padding-bottom: 8px;">
                <div class="xxti layui-inline" style="position: relative;"><font color="red"> * </font><span>Name: </span>
                    <input type="text" class="layui-input-inline" name="realName" id="realName" lay-verify="required" style="position: absolute;top:6px;left: 124px;font-size: 16px;" placeholder="Please input name">
                </div>
                <div class="xxti layui-inline" style="position: relative;position:absolute;left: 600px;top: 0px;"><font color="red"> * </font><span>Phone Number: </span>
                    <input type="text" class="layui-input-inline" name="phone" id="phone" lay-verify="required|phone" style="position: absolute;top:6px;left: 124px;font-size: 16px;" placeholder="Please input phone number" value="${sessionScope.userLogin.phone}">
                </div>
                <div class="layui-form-item">
                    <div class="xxti layui-inline" style="position: relative;"><span>Desk Number: </span>
                        <select class="layui-input-inline" name="address" id="address" lay-verify="required" style="position: absolute;top:6px;left: 124px;font-size: 16px;"></select>
                    </div>
                </div>
            </div>
            <!--支付方式 -->
            <div class="qing fuk">
                <div class="fu-ti"><div class="xxti">Payment Way</div></div>
                <div class="lf"><!--选中状态 class为paynn -->
                    <input type="hidden" name="pay_method" value="1" id="pay_method">
                    <a href="javascript:void(0)" id="pay_method_1" class="pay paynn">
                        <img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/payment1.jpg" width="160" height="60">
                    </a>
                    <a href="javascript:void(0)" id="pay_method_2" class="pay">
                        <img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/payment2.png" width="160" height="60">
                    </a>
                    <a href="javascript:void(0)" id="pay_method_3" class="pay">
                        <img src="${pageContext.request.contextPath}/static/plugins/Ruidan_Page/images/payment3.png" width="160" height="60">
                    </a>
                </div>
            </div>
            <!--配送方式 -->
            <div class="qing dizk" style="position:relative;">
                <div class="xxti lf"><span>Coupon</span>
                    <select class="layui-input-inline" name="ticketId" id="ticketId" style="position: absolute;top: 26px;left: 124px;font-size: 16px;" lay-filter="ticketId">
                        <option value="" selected>Unuse</option>
                    </select>
                </div>
            </div>
            <!--商品及优惠 -->
            <div class="qing" id="view"></div>
        </div>
    </div>
</form>



<div class="qing banq" style="margin-bottom:20px;">Copyright FeastClick By <font color="#1aa094"><b>Yisi</b></font>, All Rights Reserved</div>
</body>

<script id="demo" type="text/html">
    <div class="qing">
        <div class="xxti lf">Dish List</div>
        <a href="${pageContext.request.contextPath}/reception/shopcart.html" class="rf hui">Back to Cart<span> &gt;</span></a>
    </div>
    <div class="qing xcp">
        {{# var totalCount = 0;
        var totalPrice = 0;}}
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            {{# layui.each(d.list, function(index, item){ }}
            {{# var foodImage = "${pageContext.request.contextPath}/upload/" + item.foodImage; }}
            <tr>
                <td width="75"><img src={{ foodImage }} width="59" height="45"></td>
                <td width=""><a href="javascript:void(0)" class="dj-m1" style="font-size: 14px;color: #333333;margin-left: 16px;">{{ item.skuName }}</a></td>
                <td width="150" align="center"><div class="xsl">{{ item.skuPrice }}EUR&nbsp;&nbsp;×&nbsp;&nbsp;{{ item.numCount }}</div></td>
                <td width="150" align="center"><div class="xslj">{{ item.skuPrice*item.numCount }}EUR</div></td>
            </tr>
            {{# totalCount += item.numCount;
            totalPrice += item.skuPrice*item.numCount; }}
            {{# }) }}
            </tbody>
        </table>
    </div>
    <div class="qing fuyk0">
        <div class="rf fuyk">
            <div class="fu-you2 rf">{{ totalCount }}</div>
            <div class="fu-yu2 rf">Dish Count: </div>
        </div>
        <div class="rf fuyk">
            <div class="fu-you2 rf" id="totalPrice">{{ totalPrice.toFixed(2) }}EUR</div>
            <div class="fu-yu2 rf">Total Payment: </div>
        </div>
        <div class="rf fuyk">
            <div class="fu-you2 rf" id="cheap">0.00EUR</div>
            <div class="fu-yu2 rf">Discount Amount: </div>
        </div>
        <div class="rf fuyk">
            <div class="fu-you3 rf"><sapn id="actualPrice">{{ totalPrice.toFixed(2) }}EUR</sapn></div>
            <div class="fu-yu2 fu-yu3 rf">Payment：</div>
        </div>
    </div>
    <div class="qing rf"><a href="javascript:void(0)" id="commit"><input type="button" value="Payment" class="jie2"></a></div>
</script>

<script src="${pageContext.request.contextPath}/static/plugins/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'jquery', 'layer', 'laytpl'], function () {
        var $ = layui.jquery,
            layer = layui.layer,
            form = layui.form,
            laytpl = layui.laytpl;

        /**
         * 请求后端访问当前用户购物车中的菜品条目
         */
        $.post("${pageContext.request.contextPath}/reception/shopcart/findByUserId", function (result) {
            /**
             * 渲染模版
             * @type {{title: string, list: *}}
             */
            var templetData = { //数据
                "title":"Layui常用模块"
                ,"list":result.shopcart
            }
            var getTpl = demo.innerHTML;
            var view = document.getElementById('view');
            laytpl(getTpl).render(templetData, function(html){
                view.innerHTML = html;
            });

            /**
             * 监听订单提交按钮的点击事件
             */
            $("#commit").click(function () {
                if ($("#realName").val() == ''){
                    alert("Please input name");
                }else {
                    //发送post请求生成订单
                    var realName = $("#realName").val();
                    var phone = $("#phone").val();
                    var addressId = $("#address").val();
                    var ticketId = $("#ticketId").val();
                    var orderData = {
                        realName: realName,
                        phone: phone,
                        addressId: addressId,
                        ticketId: ticketId,
                    }
                    $.get("${pageContext.request.contextPath}/reception/order/generateOrder", orderData, function (orderResult) {
                        console.log(orderResult);
                        if(orderResult.flag){
                            //跳转到支付成功页面
                            location.href = "${pageContext.request.contextPath}/reception/paySuccess.html?rewardScore=" + orderResult.rewardScore;
                            layer.msg(orderResult.message + ", Congratulations on earning bonus points: " + orderResult.rewardScore);
                        }else {
                            layer.msg(orderResult.message);
                        }

                    }, "json");
                }
            });
        }, "json");

        /**
         * 请求后端获取用户的地址信息
         */
        $.post("${pageContext.request.contextPath}/address/listByUser", function (addressResult) {
            if (addressResult.flag){
                $.each(addressResult.addressList, function (index, address) {
                    //向下拉框中追加元素
                    if (address.defaulted == 1){
                        $("#address").append(new Option(address.address, address.addressId, true, true));
                    }else {
                        $("#address").append(new Option(address.address, address.addressId));
                    }
                });
                form.render("select");
            }
        }, "json");

        /**
         * 请求后端获取用户未使用的优惠券列表
         */
        $.post("${pageContext.request.contextPath}/reception/ticket/findByUserUnuse", function (ticketResult) {
            if (ticketResult.flag){
                var totalPrice = $("#totalPrice").text().split("EUR")[0];
                $.each(ticketResult.ticketList, function (index, ticket) {
                    //向下拉框中追加元素
                    var str = ticket.ticketName+"————Over"+ticket.requirement+"minus"+ticket.cheap+"EUR";
                    if (ticket.requirement <= totalPrice){
                        $("#ticketId").append(new Option(str, ticket.ticketId, true, false));
                    }
                });
                form.render("select");
            }
        }, "json");

        /**
         * 点着玩的支付方式
         */
        $(".pay").click(function () {
            $(".pay").removeClass("paynn");
            $(this).attr("class", "pay paynn");
        });

        /**
         * 监听优惠券选择的改变事件
         */
        $("#ticketId").change(function () {
            var ticketId = $(this).val();
            $.post("${pageContext.request.contextPath}/reception/ticket/findTicketById", {ticketId: ticketId}, function (result3) {
                result3 = JSON.parse(result3);
                var cheap = (parseFloat(result3.ticket.cheap)).toFixed(2);
                $("#cheap").text(cheap + "EUR");
                $("#actualPrice").text((parseFloat($("#totalPrice").text().split("EUR")[0]) - parseFloat($("#cheap").text().split("EUR")[0])).toFixed(2));
            });
        });
    });
</script>
</html>