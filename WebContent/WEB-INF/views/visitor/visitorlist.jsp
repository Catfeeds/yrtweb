<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />

<c:choose>
	<c:when test="${empty visitors.items}">
		<div class="no_data">
			<span class="text-gray-s_999">暂时没有访客记录</span><br />
			<a href="${ctx}/dynamicv1" class="new_btn_l" target="_top">去看动态</a><br />
			<a href="${ctx}/player/searchPlayer" class="new_btn_l">去球员库</a>
     	</div>
	</c:when>
	<c:otherwise>
		<ul>
			<c:forEach items="${visitors.items}" var="visitor" varStatus="visitorIndex"> 
			    <li style="position: relative;">
			        <img src="${el:headPath()}${visitor.icon}" onclick="javascript:window.location='${ctx}/center/${visitor.visitor_id}'" style="cursor:pointer;" class="pull-left"/>
	                 <dl>
	                     <dd><span id="card_id" onmouseover="showUserInfo('${visitor.visitor_id}','#v_player_${visitor.visitor_id}',this)" onmouseout="hideUserInfo('#v_player_${visitor.visitor_id}')" class="f14 ms">${visitor.nick}</span>
	                     <span id="jl">
                            <!--名片-->
                            <div class="card" id="v_player_${visitor.visitor_id}">
                            </div>
                       	 </span>
	                     </dd>
	                     <dd><span><fmt:formatDate value="${visitor.visit_time}" pattern="MM月dd日" /></span></dd>
	                 </dl>
	                 <div class="clearit"></div>
			    </li>
			</c:forEach>
		</ul>
		<div class="track_record">
		 	<c:choose>
		 		<c:when test="${visitors.pageCount!=0}">
		 			 	<c:if test="${visitors.havePrePage eq true}">
			 			 <a href="javascript:void(0)" class="arr_l pu pull-left" onclick="loadVisitor(${visitors.currentPage-1})"></a>
		 			 	</c:if>
		 			 	<c:if test="${visitors.haveNextPage eq true}">
			             <a href="javascript:void(0)" class="arr_r pull-left" onclick="loadVisitor(${visitors.currentPage+1})"></a>
		 			 	</c:if>
		 		</c:when>
		 	</c:choose>
	 		<%-- <ol class="arr_com">
                   <li><span>总浏览量</span></li>
                   <li><span>
                   			<c:if test="${!empty visitCount[1]}">${visitCount[1]}</c:if>
                   		</span>
                   	</li>
               </ol> --%>
		</div>
	</c:otherwise>
</c:choose>