<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<table class="player">
	 <tr>
	   <th><span>名次</span></th>
	    <th><span>球员</span></th>
	    <th><span>交易方式</span></th>
	    <th><span>当前身价（宇币）</span></th>
	</tr>
	<c:choose>
		<c:when test="${!empty rf.items}">
			<c:forEach items="${rf.items}" var="item" varStatus="i">
				<tr>
				    <td><span class="text-red">${i.index+1}</span></td>
				    <td>
				        <img src="${el:headPath()}${item.head_icon}" class="pull-left" />
				        <dl>
				            <dt class="mt5">
				            	<a href="${ctx}/center/${item.user_id}" target="blank"><span class="text-orange">${item.username}</span></a>
				            </dt>
				            <dd>
				            	<span class="text-orange f14">
				            		<yt:id2NameDB beanId="teamInfoService" id="${item.teaminfo_id}"></yt:id2NameDB>
				            	</span>
				            </dd>
				        </dl>
				    </td>
				    <td><span><yt:dict2Name nodeKey="buy_type" key="${item.buy_type}"></yt:dict2Name></span></td>
				    <td><span class="text-orange">${item.price}</span></td>
				</tr>
			</c:forEach>
		</c:when>    
	     <c:otherwise>
			<tr>
				<tr><td colspan='4'>该分组下还没有联赛积分记录</td></tr>
			</tr>
	</c:otherwise>
	</c:choose>
</table> 
<ul class="pagination" style="float:right;margin-top:60px;">
   	<li><label class="index">第${rf.currentPage}页/共${rf.pageCount}页</label> </li>
   	<li><label class="sum">共计${rf.totalCount}条</label> </li>
	<li><a href="javascript:void(0)" onclick="loadLeaguePrice(0);">首页</a></li>
		<c:choose>
			<c:when test="${rf.currentPage-1>0}">
				<li><a href="javascript:void(0)" onclick="loadLeaguePrice(${rf.currentPage-1});">上一页</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:void(0)">上一页</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${rf.currentPage+1>rf.pageCount}">
				<li><a href="javascript:void(0)">下一页</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:void(0)" onclick="loadLeaguePrice(${rf.currentPage+1});">下一页</a></li>
			</c:otherwise>
		</c:choose>	
	<li><a href="javascript:void(0)" onclick="loadLeaguePrice(${rf.pageCount});">最后一页</a></li>
</ul>
<div class="clearit"></div>
