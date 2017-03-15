<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:if test="${sf.havePrePage eq true}">
	<a href="javascript:void(0);" class="a_left" onclick="gUserSearch(${sf.currentPage-1})"></a>
</c:if>
<c:if test="${sf.haveNextPage eq true}">
	<a href="javascript:void(0);" class="a_right" onclick="gUserSearch(${sf.currentPage+1})"></a>
</c:if>
<div class="player_head">
    <ul>
    	<c:forEach items="${sf.items}" var="player">
        	<li><img src="${el:headPath()}${player.head_icon}" alt="" title="${player.usernick}" onclick="window.location='/center/${player.user_id}'"/></li>
        </c:forEach>
        <div class="clearit"></div>
    </ul>
</div>