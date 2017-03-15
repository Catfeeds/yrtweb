<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:choose>
	<c:when test="${page.currentPage!=1}">
		<a href="javascript:load_team_recommend('${page.currentPage-1}');" class="a_left"></a>
	</c:when>
	<c:otherwise>
	<a href="javascript:void(0);" class="a_left"></a>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${page.currentPage!=page.pageCount&&page.pageCount!=0}">
		<a href="javascript:load_team_recommend('${page.currentPage+1}');" class="a_right"></a>
	</c:when>
	<c:otherwise>
	<a href="javascript:void(0);" class="a_right"></a>
	</c:otherwise>
</c:choose>
<div class="team_head frame" id="theclub">
    <ul class="clearfix">
        <li>
        	<c:forEach items="${page.items}" var="team" varStatus="status">
            <img src="${el:headPath()}${team.logo}" onclick="window.open('${ctx}/team/detail/${team.user_id}.html')" alt="" title="${team.name}">
            </c:forEach>
            <div class="clearit"></div>
        </li>
    </ul>
</div>