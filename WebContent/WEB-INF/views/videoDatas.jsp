<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<ul>
	<c:forEach items="${rf.items}" var="item">
		<li onmouseover="showBtn(this)" onmouseout="hideBtn()">
			<div class="videos_img" onclick="show_video('${item.src}','${item.create_time}','${item.id}','${item.roleType}')">
				<a id="video_play" class="video_play"></a>
				<div class="video_icon">
					
						<a class="videoIcon1"></a> 
					
					<span class="text-white f12 ml100">
						<!-- 视频时长 -->
					</span>
					
						<a class="videoIcon2"></a> 
					
					<span class="text-white f12 ml20">${item.click_count}</span>
				</div>
				<img src="${filePath}/${item.src.substring(0,fn:indexOf(item.src,'.'))}.jpg" />
				<p class="text-white mt5"><%-- ${item.title} --%></p>
				<p class="text-white mt5">
					<fmt:formatDate value="${item.create_time}" pattern="yyyy-MM-dd"/>
				</p>
			</div>
		</li>
	</c:forEach>
</ul>
<div class="clearfix"></div>
<ul class="pagination" style="float:right;margin-right: 30px;">
	<c:choose>
		<c:when test="${rf.pageCount!=0}">
			<c:choose>
			<c:when test="${rf.currentPage!=1}"> 
			<li data-command="prev"><a href="javascript:void(0)" onclick="loadVideoDatas(1)">首页</a></li>
			<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadVideoDatas(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
			<li class="active"><a>${rf.currentPage}</a></li> 
			</c:when>
			<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadVideoDatas(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadVideoDatas(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="loadVideoDatas(${rf.pageCount})">末页</a></li> </c:when>
			</c:choose>
		</c:when>
	</c:choose>
</ul>