<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<table class="the_inv">
	<tr>
	    <th style="width: 120px;"><span>赛事</span></th>
	    <th style="width: 100px;"><span>轮次</span></th>
	    <th style="width: 100px;"><span>生成日期</span></th>
	    <th style="width: 160px;"><span>操作</span></th>
    </tr>
    <c:choose>
    	<c:when test="${empty rf.items}">
    		<tr>
    			<td colspan="4">暂无数据...</td>
    		</tr>
    	</c:when>
    	<c:otherwise>
   			<c:forEach items="${rf.items}" var="item">
			    <tr>
			        <td>
			            <span class="f14">${item.league_name}</span>
			        </td>
			        <td>
			            <span class="f14">第${item.rounds}轮</span>
			        </td>
			        <td>
			            <span class="f14">
			            	<fmt:formatDate value="${item.create_time}" pattern="yyyy-MM-dd"/>
			            </span> 
			        </td>
			        <td>
			        	<c:choose>
			        		<c:when test="${item.status eq 0 }">
					            <input type="button" name="name" value="前往确认" class="argee_btn" onclick="window.location='${ctx}/team/wagePayroll?teaminfo_id=${item.teaminfo_id}&event_id=${item.event_id}'"/>
			        		</c:when>
			        		<c:otherwise>
					            <input type="button" name="name" value="查看详情" class="refuse_btn ml10" onclick="window.location='${ctx}/team/wagePayroll?teaminfo_id=${item.teaminfo_id}&event_id=${item.event_id}'"/>
			        		</c:otherwise>
			        	</c:choose>
			        </td>
			    </tr>
		    </c:forEach>
    	</c:otherwise>
    </c:choose>
</table>
<ul class="pagination" style="float:right;margin-top:15px;margin-right: 40px;">
   	<c:choose>
   		<c:when test="${rf.pageCount!=0}">
   			<c:choose>
				<c:when test="${rf.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="loadAllTeamMsg(1)">首页</a></li>
					<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadAllTeamMsg(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
					<li class="active"><a>${rf.currentPage}</a></li> 
				</c:when>
				<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadAllTeamMsg(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadAllTeamMsg(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="loadAllTeamMsg(${rf.pageCount})">末页</a></li> </c:when>
			</c:choose>
   		</c:when>
   	</c:choose>
</ul>	
<div class="clearit"></div>