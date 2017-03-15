<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>  
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<ul>
	<c:forEach items="${page.items}" var="news" varStatus="status">
    <li>
        <div>
            <span class="pull-left song">[<yt:dict2Name nodeKey="m_new" key="${news.type}"></yt:dict2Name>]</span>
            <a href="${ctx}/news/${news.id}" class="p_info" title="${news.title}">
            	<c:choose>
	            	<c:when test="${!empty news.title&&fn:length(news.title)>17}">
	            	${fn:substring(news.title, 0, 15)}...
	            	</c:when>
	            	<c:otherwise>
	            	${empty news.title?'':news.title}
	            	</c:otherwise>
	            </c:choose>
			</a>
			<c:if test="${news.hava_iv=='1'}">
            	<%-- <img src="${ctx}/resources/images/newsIcon2.png" class="infoImg1" /> --%>
            	<span class="vv_1"></span>
			</c:if>
            <div class="clearfix"></div>
        </div>
    </li>
    </c:forEach>
</ul>
