<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 联赛新闻 -->
<c:choose>
	<c:when test="${!empty news.items }">
		<c:forEach items="${news.items}" var="item">
			<c:choose>
				<c:when test="${item.is_special eq 1 }">
					<dt>
						<a href="${ctx}/news/${item.id}" title="${item.title}">
			            	<c:choose>
				            	<c:when test="${!empty item.title&&fn:length(item.title)>21}">
				            	${fn:substring(item.title, 0, 20)}...
				            	</c:when>
				            	<c:otherwise>
				            	${empty item.title?'':item.title}
				            	</c:otherwise>
				            </c:choose>
						</a>
					</dt>
				</c:when>
				<c:otherwise>
				<dd>
					<a href="${ctx}/news/${item.id}" title="${item.title}">
		            	<c:choose>
			            	<c:when test="${!empty item.title&&fn:length(item.title)>21}">
			            	${fn:substring(item.title, 0, 20)}...
			            	</c:when>
			            	<c:otherwise>
			            	${empty item.title?'':item.title}
			            	</c:otherwise>
			            </c:choose>
					</a>
				</dd>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<dd>暂无新闻...</dd>
	</c:otherwise>
</c:choose>