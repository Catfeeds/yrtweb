<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<table class="be">
    <tr>
        <th><span>头像</span></th>
        <th><span>昵称</span></th>
        <th><span>屏蔽时间</span></th>
        <th><span>操作</span></th>
    </tr>
    <c:forEach items="${rf.items}" var="bplayer" varStatus="i"> 
    	
	    <tr>
	        <td>
	            <img src="${el:headPath()}${bplayer.head_icon}" class="black_header" style="width: 60px;" />
	        </td>
	        <td>
	            <span>${bplayer.usernick}</span>
	        </td>
	        <td>
	            <span><fmt:formatDate value="${bplayer.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></span>
	        </td>
	        <td>
	        	<c:if test="${!empty session_user_id && !empty user_id}">
		        	<c:if test="${session_user_id eq user_id}">
		            	<input type="button" name="name" value="移除" class="agree_btn" onclick="kickBlack('${bplayer.user_id}');"/>
		            </c:if>
	            </c:if>
	        </td>
	    </tr>
    </c:forEach>
</table>
<div class="pull-right">
<ul class="pagination" style="margin-top:15px;margin-right: 40px;">
    	<c:choose>
    		<c:when test="${rf.pageCount!=0}">
    			<c:choose>
					<c:when test="${rf.currentPage!=1}"> 
						<li data-command="prev"><a href="javascript:void(0)" onclick="loadBlackList(1)">首页</a></li>
						<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadBlackList(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
						<li class="active"><a>${rf.currentPage}</a></li> 
					</c:when>
					<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
				</c:choose>
				<c:choose>
				<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadBlackList(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
				<c:choose>
				<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
				</c:choose>
				<c:choose>
				<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadBlackList(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
				</c:choose>
				<li data-command="next"><a href="javascript:void(0)" onclick="loadBlackList(${rf.pageCount})">末页</a></li> </c:when>
				</c:choose>
    		</c:when>
    	</c:choose>
    </ul>
</div>    	
<div class="clearit"></div>
