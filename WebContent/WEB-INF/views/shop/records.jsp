<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<div class="wrapper">
    <div class="light"><i></i></div>
    <h1 class="title">&emsp;</h1>
    <div class="main">
        <div class="year">
            <%-- <h2><a href="#">${curdate}</a></h2> --%>
            <div class="list">
                <ul>
                	<c:if test="${!empty page.items}">
                   	<c:forEach items="${page.items}" var="rec">
                    <li class="cls">
                        <p class="date" style="font-size: 16px;">${el:long2DateTime(rec.order_pay_num)}</p>
                        <p class="intro"><img src="${el:headPath()}${rec.head_icon}" alt="" onclick="location.href='${ctx}/center/${rec.user_id}'" class="duo_avatar" />&ensp;<span onclick="location.href='${ctx}/center/${rec.user_id}'" style="cursor: pointer;">${rec.usernick}</span><span class="ml10">( IP：117.136.63.120 ) 参与了${rec.order_count}人次</span></p>
                    </li>
                   	</c:forEach>
                   	</c:if>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="clearfix"></div>
<c:if test="${page.totalCount > 20}">
<div class="page_div" style="float: right;margin-right: 35px;">
<c:choose>
<c:when test="${page.pageCount!=0}">
<ul class="pagination">
	<c:choose>
		<c:when test="${page.currentPage!=1}">
		<li data-command="prev" onclick="load_datas('indiana_records','${params.data_id}','${page.currentPage-1}')"><a>上一页</a></li>
        <li data-page-num="${page.currentPage-1}" onclick="load_datas('indiana_records','${params.data_id}','${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
		</c:when>
		<c:when test="${page.currentPage==1}">
		<li data-command="prev"><a>上一页</a></li>
        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
        </c:when>
	</c:choose>
	<c:choose>
		<c:when test="${page.currentPage!=page.pageCount}">
		<li data-page-num="${page.currentPage+1}" onclick="load_datas('indiana_records','${params.data_id}','${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
		<c:choose>
            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
           </c:choose>
           <c:choose>
            <c:when test="${(page.currentPage+1)!=page.pageCount}">
            <li data-page-num="${page.pageCount}" onclick="load_datas('indiana_records','${params.data_id}','${page.pageCount}')"><a>${page.pageCount}</a></li>
            </c:when>
        </c:choose>
        <li data-command="next" onclick="load_datas('indiana_records','${params.data_id}','${page.currentPage+1}')"><a>下一页</a></li>
		</c:when>
		<c:otherwise>
    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
    	</c:otherwise>
	</c:choose>
</ul>
</c:when>
</c:choose>
</div>
<div class="clearfix"></div>
</c:if>