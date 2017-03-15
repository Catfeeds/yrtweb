<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<c:choose>
		<c:when test="${!empty rf.items}">
			<c:forEach items="${rf.items}" var="data">
				<tr>
					<td>${data.name}</td>
					<td>${data.days}</td>
					<td>${data.contact_person}</td>
					<td>${data.contact_phone}</td>
					<td>
						<fmt:formatDate value="${data.create_time}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>${data.remark}</td>
					<td>
						<span>同意</span>
						<span>拒绝</span>
					</td>
				</tr>
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
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="7">
					<font style="color:red;">暂无受邀信息...</font>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
</html>