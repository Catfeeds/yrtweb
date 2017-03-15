<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="temp_nav">
		<div class="big_menu">
                            我的夺宝
        </div>
        <ul class="duo_bao">
            <li><a href="${ctx}/shop/orderList" <c:if test="${currentPage eq 'TREASURE'}"> class="active"</c:if>>夺宝记录</a></li>
            <li><a href="${ctx}/shop/luckList" <c:if test="${currentPage eq 'LUCK'}"> class="active"</c:if>>幸运记录</a><img alt="" src="${ctx}/resources/images/tx-tx.png" class="the-tx"></li>
            <li style="background: none;"><a href="${ctx}/shop/addressList" <c:if test="${currentPage eq 'ADDRESS'}"> class="active"</c:if>>收货地址</a></li>
        <!-- </ul>
        <div style="width:100%;border-top:3px solid #aaa;margin-top: 5px; "></div>
        <div class="big_menu mt20">用户设置</div>
        <ul> -->
	         <%-- <li <c:if test="${currentPage eq 'BASEINFO'}"> class="active"</c:if>><a href="${ctx}/system/baseInfo">基本信息</a></li> --%>
         </ul>
         <div class="big_menu mt20" >
                            用户设置
        </div>
        <ul class="duo_bao">
            <li><a href="${ctx}/system/settingSms" <c:if test="${currentPage eq 'SMS'}"> class="active"</c:if>>短信设置</a></li>
	         <li><a href="${ctx}/system/modifyPassword" <c:if test="${currentPage eq 'MODIFYPASSWORD'}"> class="active"</c:if>>修改密码</a></li>
	         <c:choose>
	         	<c:when test="${!empty user.phone }">
			         <li><a href="${ctx}/system/phonePage" <c:if test="${currentPage eq 'MODIFYBINDPHONE'}"> class="active"</c:if>>修改手机</a></li>
	         	</c:when>
	         	<c:otherwise>
			         <li><a href="${ctx}/system/phonePage" <c:if test="${currentPage eq 'BINDPHONE'}"> class="active"</c:if>>绑定手机</a></li>
	         	</c:otherwise>
	         </c:choose>
	         <c:choose>
	         	<c:when test="${!empty user.email }">
			         <li><a href="${ctx}/system/emailPage" <c:if test="${currentPage eq 'MODIFYBINDEMAIL'}"> class="active"</c:if>>修改邮箱</a></li>
	         	</c:when>
	         	<c:otherwise>
			         <li><a href="${ctx}/system/emailPage" <c:if test="${currentPage eq 'BINDEMAIL'}"> class="active"</c:if>>绑定邮箱</a></li>
	         	</c:otherwise>
	         </c:choose>
	         <li><a href="${ctx}/account/recharge" <c:if test="${currentPage eq 'RECHARGE'}"> class="active"</c:if>>充值中心</a></li>
	         <li><a href="${ctx}/account/payRecord" <c:if test="${currentPage eq 'PAYRECORD'}"> class="active"</c:if>>充值记录</a></li>
	         <li><a href="${ctx}/account/costRecord" <c:if test="${currentPage eq 'COSTRECORD'}"> class="active"</c:if>>消费记录</a></li>
	         <li><a href="${ctx}/certificat/IDinfo" <c:if test="${currentPage eq 'CERIDCARD'}"> class="active"</c:if>>实名认证</a></li>
	         <%-- <li><a href="${ctx}/centerold/toDress" <c:if test="${currentPage eq 'MYTEMPLATE'}"> class="active"</c:if>>装扮</a></li> --%>
	     </ul>    
 </div>