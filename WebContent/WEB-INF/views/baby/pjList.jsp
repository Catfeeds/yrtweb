<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝贝评价列表</title>
</head>
<body>
<c:choose>
	<c:when test="${empty rf.items }">
		<div class="baby_pl">
		 <p>暂无评价！</p>
		 <div class="clearit"></div>
		</div>
	</c:when>
	<c:otherwise>
		<c:forEach items="${rf.items}" var="item">
			<div class="baby_pl">
			    <div class="baby_a">
			        <img src="${el:headPath()}${item.head_icon}" />
			        <span class="text-white mt10">${item.usernick}</span>
			    </div>
			    <div class="baby_p">
			        <dl>
			            <dt><span class="text-white">${item.content}</span></dt>
			            <dd class="mt10">
				            <span class="text-gray">
				            	<fmt:formatDate value="${item.create_time}" pattern="yyyy年MM月dd日 HH:mm"/>
				            </span>
			            </dd>
			        </dl>
			    </div>
			    <div class="clearit"></div>
			</div>
		</c:forEach>
		<!-- 分页start -->
		 <ul class="pagination" style="float:right;margin-top:15px;">
	    	<c:choose>
	    		<c:when test="${rf.pageCount!=0}">
	    			<c:choose>
						<c:when test="${rf.currentPage!=1}"> 
							<li data-command="prev"><a href="javascript:void(0)" onclick="loadListPage(1)">首页</a></li>
							<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadListPage(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
							<li class="active"><a>${rf.currentPage}</a></li> 
						</c:when>
						<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
					</c:choose>
					<c:choose>
					<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadListPage(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
					<c:choose>
					<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
					</c:choose>
					<c:choose>
					<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadListPage(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
					</c:choose>
					<li data-command="next"><a href="javascript:void(0)" onclick="loadListPage(${rf.pageCount})">末页</a></li> </c:when>
					</c:choose>
	    		</c:when>
	    	</c:choose>
	    </ul>	
		<div class="clearit"></div>
	    <!-- 分页end -->
	</c:otherwise>
</c:choose>
</body>
</html>