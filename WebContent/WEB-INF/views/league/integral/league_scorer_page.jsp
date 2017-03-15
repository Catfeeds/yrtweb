<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<table class="race_card">
    <tr>
        <th><span class="f12">排名</span></th>
        <th class="w190"><span class="f12">球员</span></th>
        <th class="w305"><span class="f12">俱乐部</span></th>
        <th><span class="f12">进球</span></th>
        <th><span class="f12">射门</span></th>
        <th><span class="f12">射正</span></th>
    </tr>
    <c:choose>
    	<c:when test="${!empty page.items}">
    	<c:forEach items="${page.items}" var="item" varStatus="num">
    	<tr>
	        <td>
	        	<c:choose>
	        	<c:when test="${num.index eq 0 && page.currentPage eq 1}">
	        	<div class="f_${num.index+1}">
	        	</c:when>
	        	<c:when test="${num.index eq 1 && page.currentPage eq 1}">
	        	<div class="s_${num.index+1}">
	        	</c:when>
	        	<c:when test="${num.index eq 2 && page.currentPage eq 1}">
	        	<div class="t_${num.index+1}">
	        	</c:when>
	        	<c:otherwise>
	        	 <div class="f_4">
	        	</c:otherwise>
	        	</c:choose>
	                <span class="seq">
	                    ${(page.currentPage-1)*10+num.index+1}
	                </span>
	            </div>
	        </td>
	        <td>
	            <img src="${el:headPath()}${item.head_icon}" alt="头像" class="portrait" />
	            <span class="z_name">
	                ${empty item.username?item.usernick:item.username}
	            </span>
	
	        </td>
	        <td>
	            <img src="${el:headPath()}${item.logo}" alt="头像" class="team_name" />
	            <span class="z_name">
	                ${item.tname}
	            </span>
	
	        </td>
	        <td>
	            <span class="f14 ms">${empty item.goal?0:item.goal}</span>
	        </td>
	        <td>
	            <span class="f14 ms">${empty item.shemen_num?0:item.shemen_num}</span>
	        </td>
	        <td>
	            <span class="f14 ms">${empty item.shezheng_num?0:item.shezheng_num}</span>
	        </td>
	    </tr>
    	</c:forEach>
    	</c:when>
    </c:choose>
</table>
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
		<li data-command="prev" onclick="load_scorer(null,'${params.group_id}','1')"><a>首页</a></li>
		<c:choose>
			<c:when test="${page.currentPage!=1}">
			<li data-command="prev" onclick="load_scorer(null,'${params.group_id}','${page.currentPage-1}')"><a><</a></li>
	        <li data-page-num="${page.currentPage-1}" onclick="load_scorer(null,'${params.group_id}','${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
			</c:when>
			<c:when test="${page.currentPage==1}">
			<li data-command="prev"><a><</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
	        </c:when>
		</c:choose>
		<c:choose>
			<c:when test="${page.currentPage!=page.pageCount}">
			<li data-page-num="${page.currentPage+1}" onclick="load_scorer(null,'${params.group_id}','${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
			<c:choose>
	            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
            </c:choose>
            <c:choose>
	            <c:when test="${(page.currentPage+1)!=page.pageCount}">
	            <li data-page-num="${page.pageCount}" onclick="load_scorer(null,'${params.group_id}','${page.pageCount}')"><a>${page.pageCount}</a></li>
	            </c:when>
	        </c:choose>
	        <li data-command="next" onclick="load_scorer(null,'${params.group_id}','${page.currentPage+1}')"><a>></a></li>
			</c:when>
			<c:otherwise>
	    	<li class="disabled"><li data-command="next"><a>></a></li></li>
	    	</c:otherwise>
		</c:choose>
		<li data-command="next" onclick="load_scorer(null,'${params.group_id}','${page.pageCount}')"><a>末页</a></li>
	</ul>
	</c:when>
</c:choose>
<div class="clearit"></div>