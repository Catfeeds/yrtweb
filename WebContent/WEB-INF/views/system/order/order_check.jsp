<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>幸运记录</title>
<c:set var="currentPage" value="LUCK"/>
</head>
<body>
	<div class="warp">
		<!-- 头部 -->
		<div class="add_address" id="add_address_1">
			<form action="${ctx}/shop/saveAddress" method="post" id="addressForm">
			<input type="hidden" name="address_id" value="${userAddress.address_id}"/>	
            <div class="closeBtn_1"></div>
            <p class="title">新增收货地址</p>
            <table class="ad">
                <tr>
                    <td class="f">
                        <span>所在区域</span>
                    </td>
                    <td valign="top">
                        <select id="s_province" name="user_province"></select>&nbsp;&nbsp;
                        <select id="s_city" name="user_city"></select>&nbsp;&nbsp;
                        <select id="s_area" name="user_area"></select>
                    </td>
                </tr>
                <tr>
                    <td class="f" valign="top">
                        <span>详细地址</span>
                    </td>
                    <td>
                        <textarea name="user_address" placeholder="不用填写省、市、县">${userAddress.user_address}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="f">
                        <span>邮政编码</span>
                    </td>
                    <td>
                        <input type="text" name="user_postcode" value="${userAddress.user_postcode}" class="text_small" />
                    </td>
                </tr>
                <tr>
                    <td class="f">
                        <span>收货人</span>
                    </td>
                    <td>
                        <input type="text" name="user_name" value="${userAddress.user_name}" class="text_small" placeholder="请填写真实姓名" />
                    </td>
                </tr>
                <tr>
                    <td class="f">
                        <span>手机</span>
                    </td>
                    <td>
                        <input type="text" name="user_phone" value="${userAddress.user_phone}" class="text_small" />
                    </td>
                </tr>
                <!-- <tr>
                    <td class="f" valign="top">
                        <span>用户留言</span>
                    </td>
                    <td>
                        <textarea name="order_user_offer" placeholder="客官请提出您对奖品的大小、颜色等要求我们尽量满足....."></textarea>
                    </td>
                </tr> -->
                <tr>
                    <td class="f"></td>
                    <td>
                        <input type="checkbox" name="user_default" value="1" class="ml15" checked="checked"/><span>&emsp;设置为默认收货地址</span>
                    </td>
                </tr>
                <tr>
                    <td class="f"></td>
                    <td>
                        <input type="button" name="name" value="保存收货地址" class="canyuBtn ml15" onclick="saveAddress();" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="add_address" id="add_address_2">
            <div class="closeBtn_1"></div>
            <table class="ad">
                <tr>
                    <td class="f" valign="top">
                        <span>用户留言</span>
                    </td>
                    <td>
                        <textarea id="user_offer" name="user_offer" placeholder="亲，恭喜您获得宇币夺宝奖品，请根据产品实际情况留言对应尺码，颜色等，期待您下次继续参与夺宝....."></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="f"></td>
                    <td>
                        <input type="button" name="name" value="提交" class="canyuBtn ml15" onclick="co();"/>
                    </td>
                </tr>
            </table>
        </div>
        <div class="masker"></div>
		<%@include file="../../common/header.jsp" %>
		<!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>  
		<div class="wrapper" style="margin-top: 30px;">
			 <!--页面主体-->
	            <div class="container ms">
	                <div class="middle">
	                	<%@include file="../left.jsp" %> 
	                	<form action="${ctx}/shop/check" method="post" id="orderForm">
	                	<input type="hidden" name="order_sn" value="${o.order_sn}"/>
	                	<input type="hidden" name="order_user_offer" id="order_user_offer" value=""/> 
	                	<in>
	                	<div class="content ms">
               				<div class="content_top">
	                            <div class="title ms">
	                                <span class="text-white f14">当前位置：我的夺宝&ensp;>&ensp;幸运记录&ensp;>&ensp;查看领取</span>
	                            </div>
	                            <div id="order_area">
	                           		<table class="sp_info">
										<tr>
									        <th>商品信息</th>
									        <th>期号</th>
									        <th>夺宝状态</th>
									        <th>操作</th>
									    </tr>
									    <tr>
									        <td>
									            <img src="${o.product_title}" alt="${o.product_title}" />
									            <dl>
									                <dt><span class="f14">${o.product_title}</span></dt>
									                <dd><span class="f12">总需：${o.data_total_count}人次</span></dd>
									                <dd><span class="f12">幸运代码：</span><span class="id_num">${o.data_win_num}</span></dd>
									                <dd><span class="f12">揭晓时间：<fmt:formatDate value="${o.data_finish_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span></dd>
									            </dl>
									        </td>
									        <td align="center">
									            <span class="block">${o.data_sn}</span>
									        </td>
										    <td align="center">
										        <span class="text-santand f12">已中奖</span>
										    </td>
									        <td align="center">
									            <dl class="ctrlos">
									                <dt><span>我参与了${o.order_count}人次</span></dt>
									            </dl>
									        </td>
									    </tr>
									</table>
									<div align="center">
										<c:choose>
											<c:when test="${empty userAddress}">
				                                <input type="button" name="name" value="添加收货地址" class="canyuBtn ad_arr" />
											</c:when>
											<c:otherwise>
												<div class="shdz">
		                                            <p class="">我的收货地址</p>
		                                            <table class="sh_tab">
		                                                <tr>
		                                                    <th>收货人</th>
		                                                    <th>详细地址</th>
		                                                    <th>电话/手机</th>
		                                                    <th>操作</th>
		                                                </tr>
		                                                <tr>
		                                                    <td>${userAddress.user_name}</td>
		                                                    <td>${userAddress.user_address}</td>
		                                                    <td>${userAddress.user_phone}</td>
		                                                    <td>
		                                                        <a href="#" class="text-info" id="edit_btn">修改</a>
		                                                    </td>
		                                                </tr>
		                                                <tr>
		                                                    <td colspan="4">
		                                                        <input type="button" name="name" value="确认" class="canyuBtn user_offer" />
		                                                    </td>
		                                                </tr>
		                                            </table>
		                                        </div>
											</c:otherwise>
										</c:choose>
		                            </div> 		
	                            </div>
                        	</div>
	                    </div>
	                    </form>
	                </div>
                </div>	
		</div>
</div>		
<%@ include file="../../common/footer.jsp" %>
</body>
<script src="${ctx}/resources/js/area.js"></script>
 <script type="text/javascript">
 jQuery.fn.center = function () {
     this.css("position", "absolute");
     this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
     this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
     return this;
 }


 //省市选择
 new PCAS('user_province', 'user_city', 'user_area', '${userAddress.user_province}', '${userAddress.user_city}', '${userAddress.user_area}');

 //弹框
 $(".ad_arr").click(function () {
     var h = $(document).height();
     $(".masker").css("height", h).show();
     $("#add_address_1").center().fadeIn();
 });
 $(".user_offer").click(function () {
     var h = $(document).height();
     $(".masker").css("height", h).show();
     $("#add_address_2").center().fadeIn();
 });
 $("#edit_btn").click(function () {
     var h = $(document).height();
     $(".masker").css("height", h).show();
     $("#add_address_1").center().fadeIn();
 });
 
 $(".closeBtn_1").click(function () {
     $(".masker").fadeOut();
     $("#add_address_1").fadeOut();
     $("#add_address_2").fadeOut();
 });
 
 
 
  
  //保存用户地址
 function saveAddress(){
		var s_province = $("#s_province").val();
		var s_city = $("#s_city").val();
		var s_country
		if(s_province == "" || s_city == ""){
			layer.msg("所属城市不能为空",{icon: 2});
			return;
		}
		$("user_offer").val($("#order_user_offer").val());
		var jsonData = $("#addressForm").serializeObject();
		$.ajaxSec({
			context:$("#addressForm"),
			type:"POST",
			url:base+"/shop/saveAddress",
			data:jsonData,
			dataType:"JSON",
			success:function(data){
				if(data.state=="error"){
					layer.msg(data.message.error[0],{icon: 2});
				}else{
					layer.msg("保存成功",{icon: 1});
					window.location = base + "/shop/toCheck/${o.order_sn}";
				}
			}
		});
	}
 
	 function co(){
		 $("#order_user_offer").val($("#user_offer").val());
		 $("#orderForm").submit();
	 }
  </script>
</html>