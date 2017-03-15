<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<input type="hidden" id="news_type" value="${type}"/>
<ul class="n_list">
<c:forEach items="${page.items}" var="news" varStatus="status">
    <li>
        <a href="${ctx}/news/${news.id}">
            <span class="pull-left">
            <c:choose>
            	<c:when test="${news.type=='1'}">
            	[新闻]
            	</c:when>
            	<c:otherwise>
            	[公告]
            	</c:otherwise>
            </c:choose>
			<span class="text-white">${news.title}</span></span>
            <span class="pull-right"><fmt:formatDate value="${news.create_time}" type="both" pattern="yyyy-MM-dd" /></span>
            <div class="clearit"></div>
        </a>
    </li>
</c:forEach>
</ul>
<c:choose>
	<c:when test="${page.pageCount!=0}">
	<ul class="pagination" style="float:right;margin-right: 30px;">
		<c:choose>
			<c:when test="${page.currentPage!=1}">
			<li data-command="prev" onclick="load_news_list('','#news_list','','${page.currentPage-1}')"><a>上一页</a></li>
	        <li data-page-num="${page.currentPage-1}" onclick="load_news_list('','#news_list','','${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
			</c:when>
			<c:when test="${page.currentPage==1}">
			<li data-command="prev"><a>上一页</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
	        </c:when>
		</c:choose>
		<c:choose>
			<c:when test="${page.currentPage!=page.pageCount}">
			<li data-page-num="${page.currentPage+1}" onclick="load_news_list('','#news_list','','${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
			<c:choose>
	            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
            </c:choose>
            <c:choose>
	            <c:when test="${(page.currentPage+1)!=page.pageCount}">
	            <li data-page-num="${page.pageCount}" onclick="load_news_list('','#news_list','','${page.pageCount}')"><a>${page.pageCount}</a></li>
	            </c:when>
	        </c:choose>
	        <li data-command="next" onclick="load_news_list('','#news_list','','${page.currentPage+1}')"><a>下一页</a></li>
			</c:when>
			<c:otherwise>
	    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
	    	</c:otherwise>
		</c:choose>
	</ul>
	</c:when>
</c:choose>
<div class="clearit"></div>
