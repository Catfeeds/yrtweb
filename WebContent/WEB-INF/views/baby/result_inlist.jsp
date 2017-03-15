<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="filePath" value="${ctx}/upload" />
<c:set var="nowDate" value="<%=System.currentTimeMillis()%>"></c:set> 
<ul class="dy_ul">
	<c:forEach items="${rf.items}" var="babyIn" varStatus="i"> 
	     <li>
	         <div class="dy_list">
	             <img src="${el:headPath()}${babyIn.logo}" class="pull-left mt15 ml15" />
	             <dl class="j_name">
	                 <dt><span class="text-white">${babyIn.name}</span></dt>
	             </dl>
	             	<a href="javascript:void(0);" onclick="quitTeamIn('${babyIn.id}');">【退出】</a>
	             <div class="clearit"></div>
	             <span class="shengyu ms">
	             	（剩余时间：${babyIn.over_time}天）
	             </span>
	         </div>
	     </li>
	</c:forEach>	
	<div class="clearit"></div>
</ul>
<div class="clearit"></div>
<ul class="pagination" style="float:right;margin-top:15px;margin-right: 36px;">
   	<c:choose>
   		<c:when test="${rf.pageCount!=0}">
   			<c:choose>
				<c:when test="${rf.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="InList(1)">首页</a></li>
					<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="InList(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
					<li class="active"><a>${rf.currentPage}</a></li> 
				</c:when>
				<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="InList(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="InList(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="InList(${rf.pageCount})">末页</a></li> </c:when>
			</c:choose>
   		</c:when>
   	</c:choose>
</ul>	
<div class="clearit"></div>
