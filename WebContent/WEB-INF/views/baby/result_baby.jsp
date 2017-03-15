<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<ul class="ml10 mt20">
	<c:forEach items="${rf.items}" var="baby" varStatus="i"> 
		<li>
		    <div class="babyList">
		    	<c:if test="${baby.status eq 1}">
		    		<img src="${ctx}/resources/images/rzld.png" class="rzld">
				</c:if>
				<a href="javascript:void(window.open('/baby/base/baby/${baby.id}'))">
					<img src="${filePath}/${baby.f_src}"/>
				</a>
				<p class="baby_name">
					<a href="#" class="text-white">${baby.usernick}</a>
				</p>
			</div>
		</li>
	</c:forEach>	
</ul>
<div class="clearit"></div>
<ul class="pagination" style="float: right">
   	<c:choose>
   		<c:when test="${rf.pageCount!=0}">
   			<c:choose>
				<c:when test="${rf.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="searchGirl(1)">首页</a></li>
					<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="searchGirl(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
					<li class="active"><a>${rf.currentPage}</a></li> 
				</c:when>
				<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="searchGirl(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="searchGirl(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="searchGirl(${rf.pageCount})">末页</a></li> </c:when>
			</c:choose>
   		</c:when>
   	</c:choose>
</ul>	
<div class="clearit"></div>
