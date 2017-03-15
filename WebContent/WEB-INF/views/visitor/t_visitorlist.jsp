<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<ul class="records">
	<c:choose>
		<c:when test="${!empty visitors}">
			<c:forEach items="${visitors.items}" var="visitor" varStatus="visitorIndex"> 
			    <li>
			        <dl>
			            <dt style="position: relative;">
					        <img onmouseover="showUserInfo('${visitor.visitor_id}','#visitor_playerA_${visitorIndex.index}')" onmouseout="hideUserInfo('#visitor_playerA_${visitorIndex.index}')" src="${el:headPath()}${visitor.icon}" onclick="javascript:window.location='${ctx}/center/${visitor.visitor_id}'" style="cursor:pointer;"/>
				             <span>
			                     <!--名片-->
			                    <div class="card" id="visitor_playerA_${visitorIndex.index}"></div>
			                   </span>
			            </dt>
			            <dd>
			            <span class="ml5"><fmt:formatDate value="${visitor.visit_time}" pattern="MM月dd日" /></span>
			            </dd>
			        </dl>
			    </li>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<li>无好友访客记录</li>
		</c:otherwise>
	</c:choose>
    <div class="clearit"></div>
</ul>
<div style="position: relative;">
   
    <c:choose>
 		<c:when test="${visitors.pageCount!=0}">
		 	<c:if test="${visitors.havePrePage eq true}">
				<a href="javascript:void(0)" class="arr_l mt5 pull-left" onclick="loadVisitor(${visitors.currentPage-1})"></a>
		 	</c:if>
		 	<c:if test="${visitors.haveNextPage eq true}">
            	<a href="javascript:void(0)" class="arr_r mt5 pull-left"  onclick="loadVisitor(${visitors.currentPage+1})"></a>
		 	</c:if>
	 		<c:if test="${visitors.havePrePage eq false && visitors.haveNextPage eq false}">
	 			<a href="javascript:void(0)" class="arr_l mt5 pull-left"></a>
	 		</c:if>
		<!-- <a href="javascript:void(0);" class="arr_more"></a> -->
 		</c:when>
	</c:choose>
	 <dl class="arr_com pull-left">
        <dt>总浏览量</dt>
        <dd><c:if test="${!empty visitCount[1]}">${visitCount[1]}</c:if></dd>
    </dl>
</div>





