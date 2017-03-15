<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 经纪人已签约球员列表 -->
<table class="signend">
	<c:choose>
		<c:when test="${empty rf.items}">
			<tr>
				<td colspan="2"><font style="color:red;">暂无签约球员</font></td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${rf.items}" var="user" varStatus="num">
			    <tr>
			        <td class="w">
			            <span class="f12">${user.usernick}</span>
			            <c:if test="${num.index eq 0 and rf.currentPage eq 1}">
				            <span class="text-red">new</span>
			            </c:if>
			        </td>
			        <td>
			        	<c:if test="${user.status eq 1 and user.applying!=2 }">
				            <input type="button" name="name" value="申请解约" class="jybtn" onclick="breakPlayer('${user.id}')"/>
			        	</c:if>
			        	<c:if test="${user.applying eq 2 }">
				            <input type="button" name="name" value="申请当中" style=" background: #969494 none repeat scroll 0 0;border: medium none;border-radius: 6px;color: #fff;padding: 6px 15px;"/>
			        	</c:if>
		        		<c:if test="${!empty user.teaminfo_id}">
				            <input type="button" name="name" value="退队" class="jybtn" onclick="outTeam('${user.id}','${user.teaminfo_id}')"/>
		        		</c:if>
			        </td>
			    </tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
<!-- 分页start -->
	<div class="navpage" style="float:right;margin-right: 60px;">
		<c:choose>
		<c:when test="${rf.pageCount!=0}">
		<c:choose>
		<c:when test="${rf.currentPage!=1}"> <a href="javascript:void(0)" onclick="loadAgentPlayers(1)">&laquo;</a> <a href="javascript:void(0)" onclick="loadAgentPlayers(${rf.currentPage-1})">${rf.currentPage-1}</a> <b>${rf.currentPage}</b> </c:when>
		<c:when test="${rf.currentPage==1}"> <b>1</b> </c:when>
		</c:choose>
		<c:choose>
		<c:when test="${rf.currentPage!=rf.pageCount}"> <a href="javascript:void(0)" onclick="loadAgentPlayers(${rf.currentPage+1})">${rf.currentPage+1}</a>
		<c:choose>
		<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <i>...</i> </c:when>
		</c:choose>
		<c:choose>
		<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <a href="javascript:void(0)"  onclick="loadAgentPlayers(${rf.pageCount})">${rf.pageCount}</a> </c:when>
		</c:choose>
		<a href="javascript:void(0)" onclick="loadAgentPlayers(${rf.pageCount})">&raquo;</a> </c:when>
		</c:choose>
		</c:when>
		</c:choose>
	</div> 
    <!-- 分页end -->
<div class="clearfix"></div>