<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination pagination-centered">
 <c:choose>
 	<c:when test="${page.pageCount!=0}">
 	<ul class="pagination" style="float: left;">
 		<c:choose>
	        <c:when test="${page.currentPage!=1}">
	        <li><a style="cursor: pointer;" onclick="ListPage.paginate(1)">Prev</a></li>
	        <li><a style="cursor: pointer;" onclick="ListPage.paginate(${page.currentPage-1})">${page.currentPage-1}</a></li>
	        <li class="active">
			  <a>${page.currentPage}</a>
			</li>
	        </c:when>
	        <c:when test="${page.currentPage==1}">
	        <li class="disabled"><a>Prev</a></li>
	        <li class="active">
			  <a>1</a>
			</li>
	        </c:when>
	    </c:choose>
	    <c:choose>
	    	<c:when test="${page.currentPage!=page.pageCount}">
	    	<li><a style="cursor: pointer;" onclick="ListPage.paginate(${page.currentPage+1})">${page.currentPage+1}</a></li>
	    	<c:choose>
	            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
            </c:choose>
	        <c:choose>
	            <c:when test="${(page.currentPage+1)!=page.pageCount}"><li><a style="cursor: pointer;" onclick="ListPage.paginate(${page.pageCount})">${page.pageCount}</a></li></c:when>
	        </c:choose>
			<li><a style="cursor: pointer;" onclick="ListPage.paginate(${page.currentPage+1})">Next</a></li>
	    	</c:when>
	    	<c:otherwise>
	    	<li class="disabled"><a>Next</a></li>
	    	</c:otherwise>
	    </c:choose>
	  </ul>
 	</c:when>
  </c:choose>
  <span style="float: left;margin-top: 26px;margin-left: 26px;">共 ${page.totalCount} 条</span>
</div> 