<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="../common/common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>宇任拓_宇币_夺宝</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
    <meta name="keywords" content="足球，宇币，夺宝">
    <meta name="description" content="宇币夺宝是线上线下真实版O2O足球经理，自主联赛系统的新玩法，通过联赛球员竞拍、转会和充值方式等方式获取宇币参与到平台足球装备夺宝中。">
    <link href="${ctx}/resources/css/seize.css" rel="stylesheet" />
</head>
<c:set var="currentPage" value="PRODUCT"/>
<body>
    <div class="warp">
        <!--头部-->
		<%@include file="../common/header.jsp" %>
		<!--导航 start-->
	    <%@ include file="../common/naver.jsp" %> 
	      
        <div class="wrapper" style="margin-top: 30px;">
            <div class="duo_home">
                <div class="duo_zuo">
                    <div class="duo_zuo_title">
                        <span>最新上架</span>
                        <a href="${ctx}/shop/products">点击查看更多 ></a>
                        <div class="clearfix"></div>
                    </div>
                    <!--商品区域-->
                    <div class="spqy">
                    	<c:if test="${empty user_products}">
                    	<p align="center" class="text-white f16">商品正在进驻，请稍后...</p>
                    	</c:if>
                    	<c:if test="${!empty user_products}">
                    	<c:forEach items="${user_products}" var="pro" begin="0">
                        <div class="sqzhanshi">
                            <div class="biaoqian">
                                <span><fmt:formatNumber value="${pro.data_single_price}" pattern="##0"/>宇币</span>
                            </div>
                            <img src="${el:headPath()}${pro.product_header}" alt="" class="img" style="cursor: pointer;" onclick="location.href='${ctx}/shop/product/${pro.data_id}'" />
                            <div class="duo_jj">
                                <p class="jj" style="cursor: pointer;" onclick="location.href='${ctx}/shop/product/${pro.data_id}'">
                                     <span>${pro.product_title}</span></p>
                                <p class="jj_2 song">总需：${pro.data_total_count}&ensp;人次</p>
                                <div class="setbacks_bg">
                                    <div class="setbacks" style="width: ${(pro.data_count/pro.data_total_count)*100}%;"></div>
                                </div>
                                <div class="mt25">
                                    <dl class="pull-left">
                                        <dt><span class="jj_2">${pro.data_count}</span></dt>
                                        <dd><span class="jj_2 song">已参与人次</span></dd>
                                    </dl>
                                    <dl class="pull-right">
                                        <dt><span class="jj_2">${pro.data_total_count-pro.data_count}</span></dt>
                                        <dd><span class="jj_2 song">剩余人次</span></dd>
                                    </dl>
                                    <div class="clearfix"></div>
                                </div>
                                <c:if test="${pro.product_hot eq '1'}">
                                <span class="top_hot"></span>
                                </c:if>
                                <input type="button" value="立即夺宝" class="gou_btn" onclick="toBuy('${pro.data_id}');" />
                            </div>
                        </div>
                        </c:forEach>
                        </c:if>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="duo_you">
                    <div class="duo_zuo_title">
                        <span class="f16">宇拓夺宝</span>
                    </div>

                    <div class="duo_list" id="the_roll">
                    	<c:if test="${!empty win_users}">
                    	<div id="the_roll_1">
                    	<c:forEach items="${win_users}" var="user" begin="0">
                        <table>
                            <tr>
                                <td rowspan="3" style="width: 62px;" valign="top">
                                    <img src="${el:headPath()}${user.head_icon}" alt="" class="" style="width: 52px;height: 52px;cursor: pointer;" onclick="location.href='${ctx}/center/${user.data_win_user}'" />
                                </td>
                                <td>
                                    <span class="id" onclick="location.href='${ctx}/center/${user.data_win_user}'">${user.usernick}</span><span class="the_date"><fmt:formatDate value="${user.data_finish_time}" type="both" pattern="yyyy-MM-dd" /></span>
                                </td>
                            </tr>
                            <tr>
                                <td><span class="renci">${user.order_count}人次</span><span class="jj_3">夺得<a id="jj_3" href="${ctx}/shop/product/${user.data_id}" target="_blank" style="color: white;text-decoration:none; ">${user.product_title}</a></span></td>
                            </tr>
                            <tr>
                                <td><span class="jj_3">总需：${user.data_total_count}人次</span></td>
                            </tr>
                        </table>
                        </c:forEach>
                        </div>
                        <div id="the_roll_2"></div>
                    	</c:if>
                        <!-- <div class="diangengduo">点击查看更多</div> -->
                    </div>
                    <!--消费排行榜-->
                    <div class="duo_zuo_title mt10">
                        <span class="f16">消费榜</span>
                    </div>
                    <div class="phb">
                      	<c:if test="${!empty consumers}">
                      	<c:forEach items="${consumers}" var="user" varStatus="status">
                      	<c:if test="${status.index <= 3}">
                      	<dl class="t-${status.index+1}">
                      	</c:if>
                      	<c:if test="${status.index > 3}">
                      	<dl class="t-4">
                      	</c:if>
                            <dt><span class="blue" onclick="location.href='${ctx}/center/${user.user_id}'" style="cursor: pointer;">${user.usernick}</span></dt>
                            <dd><span class="xf">消费宇币：<span class="text-santand"><fmt:formatNumber value="${user.price}" pattern="##0"/>YB</span></span></dd>
                        </dl>
                      	</c:forEach>
                      	</c:if>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <script src="${ctx}/resources/js/own/shop.js"></script> 
    <%@ include file="../common/footer.jsp" %>
    <script type="text/javascript">
    $(document).ready(function () {
        $(".id").each(function () {
            var maxwidth = 7;
            if ($(this).text().length > maxwidth) {
                $(this).text($(this).text().substring(0, maxwidth));
                $(this).html($(this).html() + '...');
            }
        });
        $("#jj_3").each(function () {
            var maxwidth = 13;
            if ($(this).text().length > maxwidth) {
                $(this).text($(this).text().substring(0, maxwidth));
                $(this).html($(this).html() + '...');
            }
        });
    });
    
  //滚动
    var speed = 50;
    if ($("#the_roll_1 table").length < 8) {
        the_roll_1.innerHTML = the_roll_1.innerHTML;
        clearInterval(MyMar);
    } else {
        the_roll_2.innerHTML = the_roll_1.innerHTML;
        function Marquee() {
            if (the_roll_2.offsetHeight - the_roll.scrollTop <= 0)
                the_roll.scrollTop -= the_roll_1.offsetHeight;
            else {

                the_roll.scrollTop++;
            }
        }
        var MyMar = setInterval(Marquee, speed);
        the_roll.onmouseover = function () { clearInterval(MyMar); }
        the_roll.onmouseout = function () { MyMar = setInterval(Marquee, speed); }
    }

    </script>

</body>
</html>
