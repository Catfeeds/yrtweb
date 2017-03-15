<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
	<table>
	   <tr>
	       <th class="w"><span class="text-white ms f20">助威</span></th>
	       <th><span class="text-gray">俱乐部</span></th>
	       <th><span class="text-gray">助威地点及时间</span></th>
	       <th><span class="text-gray">联系人及联系方式</span></th>
	       <th><span class="text-gray">备注</span></th>
	       <th><span class="text-gray">操作</span></th>
	   </tr>
	   <c:forEach items="${rf.items}" var="cheer" varStatus="i"> 
	   <tr>
	       <td></td>
	       <td>
	           <img src="${el:headPath()}${cheer.logo}" class="pull-left" />
	           <dl class="j_name">
	               <dt><span class="text-white">${cheer.team_name}</span></dt>
	           </dl>
	       </td>
	       <td class="c">
	           <dl>
	               <dt><span>${cheer.cheer_address}</span></dt>
	               <dd><span><fmt:formatDate value="${cheer.cheer_time}" pattern="yyyy-MM-dd HH:mm:ss" /></span></dd>
	           </dl>
	       </td>
	       <td class="c">
	           <dl>
	               <dt><span>${cheer.contact_person}</span></dt>
	               <dd><span>${cheer.contact_phone}</span></dd>
	           </dl>
	       </td>
	       <td class="c">
	           <span>${cheer.remark}</span>
	       </td>
	       <td class="c">
	       		<c:choose>
	       			<c:when test="${cheer.status eq 1}">
	       				已同意
	       			</c:when>
	       			<c:when test="${cheer.status eq 2}">
	       				已拒绝
	       			</c:when>
	       			<c:otherwise>
			           <input type="button" name="name" value="同意" class="invi_btn" onclick="checkCheer('${cheer.id}','1');"/>
			           <input type="button" name="name" value="拒绝" class="cheer_btn" onclick="checkCheer('${cheer.id}','2');"/>
	       			</c:otherwise>
	       		</c:choose>	
	       </td>
	   </tr>
	   </c:forEach>	
	</table>
<ul class="pagination" style="float:right;margin-top:15px;margin-right: 36px;">
   	<c:choose>
   		<c:when test="${rf.pageCount!=0}">
   			<c:choose>
				<c:when test="${rf.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="searchCheer(1)">首页</a></li>
					<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="searchCheer(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
					<li class="active"><a>${rf.currentPage}</a></li> 
				</c:when>
				<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="searchCheer(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="searchCheer(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="searchCheer(${rf.pageCount})">末页</a></li> </c:when>
			</c:choose>
   		</c:when>
   	</c:choose>
</ul>	
<div class="clearit"></div>
