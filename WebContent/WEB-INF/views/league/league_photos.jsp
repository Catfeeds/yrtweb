<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--联赛首页 -->
<c:choose>
	<c:when test="${!empty photos.items }">
			<ul class="amazingslider-slides" style="display:none;">
				<c:forEach items="${photos.items }" var="item">
	               <li>
	                   <img src="${filePath}/${item.f_src}" alt="${item.title}" title="${item.title}"/>
	               </li>
	            </c:forEach>
            </ul>
            <ul class="amazingslider-thumbnails" style="display:none;">
	            <c:forEach items="${photos.items }" var="item">
	       			<li>12
	       				<img src="${filePath}/${item.f_src}" alt="${item.title}" title="${item.title}"/>
	       			</li>
				</c:forEach>
            </ul>		
	</c:when>
	<c:otherwise>
		<p style="text-align: center;color: red;">暂无数据...</p>
	</c:otherwise>
</c:choose>
    <script src="${ctx}/resources/sliderengine/initslider-1.js"></script>