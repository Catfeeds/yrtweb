<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>用户地址</title>
<c:set var="currentPage" value="ADDRESS"/>
</head>
<body>
	<div class="warp">
		<div class="add_address">
            <div class="closeBtn_1"></div>
            <p class="title">新增收货地址</p>
            <form action="${ctx}/shop/saveAddress" method="post" id="addressForm">
            <input type="hidden" name="address_id" id="address_id" value="${userAddress.address_id}"/>	
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
                        <textarea id="s_address" name="user_address">${userAddress.user_address}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="f">
                        <span>邮政编码</span>
                    </td>
                    <td>
                        <input type="text" id="s_postcode" name="user_postcode" value="${userAddress.user_postcode}" class="text_small" />
                    </td>
                </tr>
                <tr>
                    <td class="f">
                        <span>收货人</span>
                    </td>
                    <td>
                        <input type="text" id="s_name" name="user_name" value="${userAddress.user_name}" class="text_small" placeholder="请填写真实姓名" />
                    </td>
                </tr>
                <tr>
                    <td class="f">
                        <span>手机</span>
                    </td>
                    <td>
                        <input type="text" id="s_phone" name="user_phone" value="${userAddress.user_phone}" class="text_small" />
                    </td>
                </tr>
                <tr>
                    <td class="f"></td>
                    <td>
                    	<c:choose>
                    		<c:when test="${!empty userAddress.user_default || userAddress.user_default eq 1}">
		                        <input type="checkbox" id="s_default" name="user_default" value="${userAddress.user_default}" class="ml15" checked="checked"/><span>&emsp;设置为默认收货地址</span>
                    		</c:when>
                    		<c:otherwise>
                    			<input type="checkbox" id="s_default" name="user_default" value="1" class="ml15"/><span>&emsp;设置为默认收货地址</span>
                    		</c:otherwise>
                    	</c:choose>
                    </td>
                </tr>
                <tr>
                    <td class="f"></td>
                    <td>
                        <input type="button" name="name" value="保存收货地址" class="canyuBtn ml15" onclick="saveAddress();"/>
                    </td>
                </tr>
            </table>
            </form>
        </div>
		<!-- 头部 -->
		<%@include file="../../common/header.jsp" %>
		<!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>  
		<div class="wrapper" style="margin-top: 30px;">
			 <!--页面主体-->
	            <div class="container ms">
	                <div class="middle">
	                	<%@include file="../left.jsp" %>
	                	<div class="content ms">
	                		<div class="content_top">
	                            <div class="title ms">
	                                <span class="text-white f14">当前位置：我的夺宝&ensp;>&ensp;收货地址</span>
	                            </div>
	                            <div class="site">
	                                <p class="text-white f12">我的收货地址<span class="f12 text-gray-s_999">（最多可保存5个收货地址）</span></p>
	                                <c:if test="${!empty listAddress}">
	                                <table class="site_info">
	                                    <tr>
	                                        <th>收货人</th>
	                                        <th>详细地址</th>
	                                        <th>电话/手机</th>
	                                        <th>操作</th>
	                                    </tr>
	                                	<c:forEach items="${listAddress}" var="d">
	                                    <tr>
	                                        <td>${d.user_name}</td>
	                                        <td>${d.user_address}</td>
	                                        <td>${d.user_phone}</td>
	                                        <td>
	                                            <a href="javascript:void(0);" class="text-info" onclick="updateAddress('${d.address_id}');">修改</a><span>&ensp;|&ensp;</span>
	                                            <a href="${ctx}/shop/delAddress/${d.address_id}" class="text-info">删除</a>&ensp;
	                                            <c:choose>
		                                            <c:when test="${d.user_default eq '0' || empty d.user_default}">
		                                           		<a href="#" title="设为默认地址" class="setadd" style="visibility:visible;" onclick="setDefault('${d.address_id}')">默</a>
		                                        	</c:when>
		                                        	<c:otherwise>
		                                           		<a href="#" title="设为默认地址" class="setadd" style="visibility:hidden;">默</a>
		                                        	</c:otherwise>
	                                        	</c:choose>
	                                        </td>
	                                    </tr>
	                                    </c:forEach>
	                                </table>
	                                </c:if>
	                            </div>
	                            <div class="btn_div">
	                                <input type="button" name="name" value="添加收货地址" class="canyuBtn ad_arr" />
	                            </div>
	                		</div>
	                    </div>
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
            $(".add_address").center().fadeIn();
        });
        $(".closeBtn_1").click(function () {
            $(".masker").fadeOut();
            $(".add_address").fadeOut();
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
       					window.location = base + "/shop/addressList";
       				}
       			}
       		});
       	}
        
      //保存用户地址
        function updateAddress(id){
       		$.ajaxSec({
       			type:"POST",
       			url:base+"/shop/getAddress",
       			data:{id:id},
       			dataType:"JSON",
       			success:function(data){
       				if(data.state=="error"){
       					layer.msg(data.message.error[0],{icon: 2});
       				}else{
	       				$("#address_id").val(data.data.address.address_id);
	       				/* $("#s_province").val(data.data.address.user_province);
	       				$("#s_city").val(data.data.address.user_city);
	       				$("#s_area").val(data.data.address.user_area); */
	       				$("#s_postcode").val(data.data.address.user_postcode);
	       			 	new PCAS('user_province', 'user_city', 'user_area', 
	       			 		data.data.address.user_province, data.data.address.user_city, data.data.address.user_area);
	       				$("#s_address").val(data.data.address.user_address);
	       				$("#s_name").val(data.data.address.user_name);
	       				$("#s_phone").val(data.data.address.user_phone);
	       				$("#s_default").val(data.data.address.user_default);
	       				if(data.data.address.user_default == 1){
	       					$("#s_default").attr("checked","checked");
	       				}
       					var h = $(document).height();
	       	            $(".masker").css("height", h).show();
	       	            $(".add_address").center().fadeIn();
       				}
       			}
       		});
       	}
      
      //保存用户地址
        function setDefault(id){
        	$.ajaxSec({
       			type:"POST",
       			url:base+"/shop/setDeaultAddress",
       			data:{id:id},
       			dataType:"JSON",
       			success:function(data){
       				if(data.state=="error"){
       					layer.msg(data.message.error[0],{icon: 2});
       				}else{
       					layer.msg("保存成功",{icon: 1});
       					window.location = base + "/shop/addressList";
       				}
       			}
       		});
       	}
      
    </script>
</html>