<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/common.jsp" %>
<c:choose>
	<c:when test="${!empty rf.items}">
		<table style="float: left; width: 100%;margin-top: 20px;">
		     <tr>
		         <th class="w120"><span>头像</span></th>
		         <th><span>名字</span></th>
		         <th><span>常驻城市</span></th>
		         <th><span>所属俱乐部</span></th>
		     </tr>
		     <c:forEach items="${rf.items}" var="coach">
		     	 <tr>
			         <td>
			             <img src="${el:headPath()}${coach.head_icon}" class="ml35" width="40" height="40"/>
			         </td>
			         <td>
			             <span><a class="no" target="_blank" href="${ctx}/center/${coach.user_id}">${coach.usernick }</a></span>
			         </td>
			         <td>
			             <span>${coach.province}${coach.city}</span>
			         </td>
			         <td>
			             <span>${coach.in_team}</span>
			         </td>
			     </tr>
		     </c:forEach>
	   </table>    
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
		<table style="float: left; width: 100%;margin-top: 20px;">
			     <tr>
			         <th class="w120"><span>头像</span></th>
			         <th><span>名字</span></th>
			         <th><span>常驻城市</span></th>
			         <th><span>所属俱乐部</span></th>
			     </tr>
			     <tr>
			     	<td colspan="4"><font color="red">暂无数据</font></td>
			     </tr>
	    </table>
	</c:otherwise>	
</c:choose>
