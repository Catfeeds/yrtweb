<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:forEach items="${follows.items}" var="follow" varStatus="followIndex"> 
	<c:choose>
	    <c:when test="${follow.type == '0'}">
		    <li>
			     <img src="${filePath}/${follow.icon}" onclick="javascript:window.location='${ctx}/center/${follow.user_id}'" style="cursor:pointer;"/>
			     <span>
				     <c:choose>
				     	<c:when test="${fn:length(follow.nick) > 4}">  
					    	<c:out value="${fn:substring(follow.nick, 0, 4)}..." />  
					    </c:when>  
					   <c:otherwise>  
					   		<c:out value=" ${follow.nick}" />  
					   </c:otherwise>  
					 </c:choose> 
			     </span>
	   		</li>
	    </c:when>
	    <c:when test="${follow.type == '1'}">
		    <li>
			     <img src="${filePath}/${follow.icon}" />
			     <span> 
			     	<c:choose>
				     	<c:when test="${fn:length(follow.name) > 3}">  
					    	<c:out value="${fn:substring(follow.name, 0, 3)}..." />  
					    </c:when>  
					   <c:otherwise>  
					   		<c:out value=" ${follow.name}" />  
					   </c:otherwise>  
					 </c:choose> 
			     </span>
	   		</li>
	    </c:when>
	</c:choose>
</c:forEach>
<div class="clearit"></div>
 <div class="navpage">
 	<c:choose>
 		<c:when test="${follows.pageCount!=0}">
 			 	<c:if test="${follows.havePrePage eq true}">
	 			 <a href="javascript:void(0)" class="arr_l" onclick="loadFollow(${follows.currentPage-1})"></a>
 			 	</c:if>
 			 	<c:if test="${follows.haveNextPage eq true}">
	             <a href="javascript:void(0)" class="arr_r" onclick="loadFollow(${follows.currentPage+1})"></a>
 			 	</c:if>
 		</c:when>
 	</c:choose>
 
  <%-- <c:choose>
    <c:when test="${follows.pageCount!=0}">
      <c:choose>
        <c:when test="${follows.currentPage!=1}"> <a href="javascript:void(0)" onclick="loadFollow(1)">&laquo;</a> <a href="javascript:void(0)" onclick="loadFollow(${follows.currentPage-1})">${follows.currentPage-1}</a> <b>${follows.currentPage}</b> </c:when>
        <c:when test="${follows.currentPage==1}"> <b>1</b> </c:when>
      </c:choose>
      <c:choose>
        <c:when test="${follows.currentPage!=follows.pageCount}"> <a href="javascript:void(0)" onclick="loadFollow(${follows.currentPage+1})">${follows.currentPage+1}</a>
          <c:choose>
            <c:when test="${(follows.currentPage+2)<follows.pageCount}"> <i>...</i> </c:when>
          </c:choose>
          <c:choose>
            <c:when test="${(follows.currentPage+1)!=follows.pageCount}"> <a href="javascript:void(0)"  onclick="loadFollow(${follows.pageCount})">${follows.pageCount}</a> </c:when>
          </c:choose>
          <a href="javascript:void(0)" onclick="loadFollow(${follows.pageCount})">&raquo;</a> </c:when>
      </c:choose>
    </c:when>
  </c:choose> --%>
</div> 
 