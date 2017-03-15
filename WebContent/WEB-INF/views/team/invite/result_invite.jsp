<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
 	<table class="the_inv">
		<tr>
			<th></th>
			<th><span>俱乐部名称</span></th>
			<th><span>时间</span></th>
			<th><span>地点</span></th>
			<th><span>赛制</span> </th>
			<th><span>挑战宣言</span> </th>
			<th><span>操作</span></th>
		</tr>
		<c:forEach items="${listInvite.items}" var="invite" varStatus="i">
				<tr>
					<td>
                        <img src="${el:headPath()}${invite.t_logo}">
                    </td>
					<td><span class="f14">${invite.t_name}</span></td>
					<td><span><fmt:formatDate value="${invite.invite_time}" pattern="yyyy-MM-dd" /></span></td>
					<td><span class="f14">${invite.position}</span></td>
					<td><span class="f14">${invite.ball_format}人制</span></td>
					<td><span class="f14">${invite.declar}</span></td>
					<td>
						<c:choose>
							<c:when test="${invite.status eq 1}">
								<span class="f14 text-gray-s_666">约战成功</span>
							</c:when>	
							<c:when test="${invite.status eq 0}">
								 <span class="f14 text-gray-s_666">已拒绝</span>
							</c:when>
							<c:otherwise>
								<input type="button" name="name" value="接受" class="argee_btn" onclick="checkInvite('${invite.teaminfo_id}',1,'${invite.id}')"/>
								<input type="button" name="name" value="拒绝" class="refuse_btn" onclick="checkInvite('${invite.teaminfo_id}',0,'${invite.id}')"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
		</c:forEach>
	</table>
</div>
<ul class="pagination" style="float:right;margin-top:15px;margin-right: 40px;">
   	<c:choose>
   		<c:when test="${listInvite.pageCount!=0}">
   			<c:choose>
				<c:when test="${listInvite.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="loadInviteList(1)">首页</a></li>
					<li data-page-num="${listInvite.currentPage-1}"> <a href="javascript:void(0)" onclick="loadInviteList(${listInvite.currentPage-1})">${listInvite.currentPage-1}</a></li>
					<li class="active"><a>${listInvite.currentPage}</a></li> 
				</c:when>
				<c:when test="${listInvite.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${listInvite.currentPage!=listInvite.pageCount}"> <li data-page-num="${listInvite.currentPage+1}"><a href="javascript:void(0)" onclick="loadInviteList(${listInvite.currentPage+1})">${listInvite.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(listInvite.currentPage+2)<listInvite.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(listInvite.currentPage+1)!=listInvite.pageCount}"> <li data-page-num="${listInvite.pageCount}"><a href="javascript:void(0)"  onclick="loadInviteList(${listInvite.pageCount})">${listInvite.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="loadInviteList(${listInvite.pageCount})">末页</a></li> </c:when>
			</c:choose>
   		</c:when>
   	</c:choose>
</ul>	
<div class="clearit"></div>
<script type="text/javascript">
        $(function () {
            $(".be tr:odd").not("th").css({ "background": "#3d3d3d" });
        });
</script>