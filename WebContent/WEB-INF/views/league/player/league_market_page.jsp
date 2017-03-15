<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<div class="title">
    <span class="pull-left ml20">转会公告</span>
</div>
<c:if test="${!empty page.items}">
<table class="zhb_more">
	<c:forEach items="${page.items}" var="lm">
    <tr>
       <td>
           <span>[${lm.outname}]</span>
           <span>的</span>
           <span>[${empty lm.username?lm.usernick:lm.username}]</span>
           <span>以</span>
           <span>[${lm.price}]</span>
           <span>的转会费，</span>
           <span>转会到</span>
           <span>[${lm.inname}]</span>
       </td>
       <td>
           <span class="text-gray-s_666"><fmt:formatDate value="${lm.buy_time}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
       </td>
   </tr>
   </c:forEach>
</table>
</c:if>
<!-- <ul class="pagination" style="float:right;margin-top:50px;margin-right: 25px;">
    <li data-command="prev"><a>首页</a></li>
    <li data-page-num=""><a><</a></li>
    <li data-page-num="1" class="active"><a>1</a></li>
    <li data-page-num="2"><a>2</a></li>
    <li data-page-num="3"><a>3</a></li>
    <li data-page-num="4"><a>4</a></li>
    <li data-page-num="5"><a>5</a></li>
    <li data-page-num="6"><a>6</a></li>
    <li data-page-num=""><a>></a></li>
    <li data-command="next"><a>末页</a></li>
</ul> -->
<!-- <ul class="pagination" style="float:right;margin-top:50px;margin-right: 25px;">
    <li data-command="prev"><a>首页</a></li>
    <li data-page-num=""><a><</a></li>
    <li data-page-num="1" class="active"><a>1</a></li>
    <li data-page-num="2"><a>2</a></li>
    <li data-page-num="3"><a>3</a></li>
    <li data-page-num="4"><a>4</a></li>
    <li data-page-num="5"><a>5</a></li>
    <li data-page-num="6"><a>6</a></li>
    <li data-page-num=""><a>></a></li>
    <li data-command="next"><a>末页</a></li>
</ul> -->
<c:choose>
	<c:when test="${page.pageCount!=0}">
	<ul class="pagination" style="float:right;margin-top:50px;margin-right: 25px;">
		<li data-command="prev" onclick="load_league_market('${params.s_id}','1')"><a>首页</a></li>
		<c:choose>
			<c:when test="${page.currentPage!=1}">
			<li data-command="prev" onclick="load_league_market('${params.s_id}','${page.currentPage-1}')"><a><</a></li>
	        <li data-page-num="${page.currentPage-1}" onclick="load_league_market('${params.s_id}','${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
			</c:when>
			<c:when test="${page.currentPage==1}">
			<li data-command="prev"><a><</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
	        </c:when>
		</c:choose>
		<c:choose>
			<c:when test="${page.currentPage!=page.pageCount}">
			<li data-page-num="${page.currentPage+1}" onclick="load_league_market('${params.s_id}','${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
			<c:choose>
	            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
            </c:choose>
            <c:choose>
	            <c:when test="${(page.currentPage+1)!=page.pageCount}">
	            <li data-page-num="${page.pageCount}" onclick="load_league_market('${params.s_id}','${page.pageCount}')"><a>${page.pageCount}</a></li>
	            </c:when>
	        </c:choose>
	        <li data-command="next" onclick="load_league_market('${params.s_id}','${page.currentPage+1}')"><a>></a></li>
			</c:when>
			<c:otherwise>
	    	<li class="disabled"><li data-command="next"><a>></a></li></li>
	    	</c:otherwise>
		</c:choose>
		<li data-command="next" onclick="load_league_market('${params.s_id}','${page.pageCount}')"><a>末页</a></li>
	</ul>
	</c:when>
</c:choose>
<div class="clearit"></div>