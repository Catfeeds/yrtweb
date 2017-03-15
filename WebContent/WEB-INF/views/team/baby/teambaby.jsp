<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<c:if test="${empty rf.items}"><li class="f">暂无宝贝</li></c:if>
<c:forEach items="${rf.items}" var="babyTeam">
	<!-- <li class="f">
	    <img src="${filePath}/${babyTeam.head_icon}" class="pull-left"  onclick="javascript:window.location='${ctx}/baby/base/user/${babyTeam.user_id}'" />
	    <ul class="pull-left mt10 ml5">
	        <li>
	            <span class="pull-left ml10 ms f16">${babyTeam.usernick}</span>
	            <%-- <span class="pull-right ms f16"><fmt:formatNumber value="${(nowDate.time-babyTeam.borndate.time)/1000/60/60/24/365}" pattern="#0"/>岁</span> --%>
	            <div class="clearit"></div>
	        </li>
	        <li class="mt10">1111111三围：${babyTeam.chest}/${babyTeam.waist}/${babyTeam.hip}</li>
	        <c:if test="${session_user_id eq user_id}">
		        <li class="mt5">
	                <input type="button" name="name" value="解除代言" class="buy_act ml5" onclick="delBaby('${babyTeam.user_id}')"/>
	                <input type="button" name="name" value="邀请助威" class="buy_act ml5 zw" onclick="openGameBaby('${babyTeam.user_id}')"/>
	            </li>
	        </c:if>  
	          
	    </ul>
	    </li> -->
	    <li class="f">
             <dl>
                <dt><img src="${el:headPath()}${babyTeam.head_icon}" onclick="javascript:window.location='${ctx}/baby/base/user/${babyTeam.user_id}'"/></dt>
                <dd class="mt5">
                   <input type="button" name="name" value="助威" class="zw" onclick="openGameBaby('${babyTeam.user_id}')"/>
                   <%-- <input type="button" name="name" value="移除" class="yc" onclick="delBaby('${babyTeam.user_id}')"/> --%>
                </dd>
             </dl>
        </li>
</c:forEach>
<div class="clearit"></div>