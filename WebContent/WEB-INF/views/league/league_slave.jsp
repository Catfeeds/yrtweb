<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 球员身价列表 -->
<!-- <ul> -->
   <c:choose>
   		<c:when test="${!empty pages.items }">
   			<c:forEach items="${pages.items}" var="item" varStatus="num">
   				<li>
			       <div class="player_display">
			       		<c:if test="${num.index eq 0 }"></c:if>
			       		<c:choose>
			       			<c:when test="${num.index eq 0 }">
					           <div class="ranking_1">
			       			</c:when>
			       			<c:when test="${num.index eq 1 }">
					           <div class="ranking_2">
			       			</c:when>
			       			<c:when test="${num.index eq 2 }">
					           <div class="ranking_3">
			       			</c:when>
			       			<c:otherwise>
			       				<div class="ranking_4">
			       			</c:otherwise>
			       		</c:choose>
					              <span>${num.index+1 }</span>
					           </div>
			           <div class="shenjia_title">
			               <span class="ms f14 text-white">${item.username }</span>
			               <span class="f12 text-white ml10">身价${item.price}宇币</span>
			           </div>
			           <img src="${el:headPath()}${item.head_icon}" style="cursor: pointer;" onclick="javscript:window.location='${ctx}/center/${item.user_id}'"/>
			       </div>
			   </li>
   			</c:forEach>
   		</c:when>
   		<c:otherwise>
   			<p style="color: red;text-align: center;">暂无球员身价信息</p>
   		</c:otherwise>
   </c:choose>	
<!-- </ul> -->