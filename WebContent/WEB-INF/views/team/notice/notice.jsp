<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:if test="${empty notices.items}">
	<dd><span>暂无公告</span></dd>
</c:if>
<c:forEach items="${notices.items}" var="notice" varStatus="i">
	<dd>
		<span class="f14"><fmt:formatDate value="${notice.create_time}" pattern="yyyy-MM-dd"/></span>
		<span class="ml10 f14"><a href="javascript:void(0);" onclick="showNotice('${notice.id}');" class="text-white">${notice.name}</a></span>
		<c:choose>
			<c:when test="${i.index == 0}">
				<span class="g_new ml5"></span>
			</c:when>
			<c:when test="${notice.check_count > 10}">
				<span class="g_hot ml5"></span>
			</c:when>
			<c:otherwise>
				<span class="ml5"></span>
			</c:otherwise>
		</c:choose>	
	</dd>
</c:forEach>
