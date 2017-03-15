<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 宝贝排行榜 -->
 <tr>
     <td></td>
     <td><span class="text-gray-s_666">球员名</span></td>
     <td><span class="text-gray-s_666">俱乐部</span></td>
     <td><span class="text-gray-s_666">黄牌</span></td>
     <td><span class="text-gray-s_666">红牌</span></td>
 </tr>
 <c:choose>
 	<c:when test="${!empty babys.items}">
 		<c:forEach items="${babys.items }" var="item" varStatus="num">
 			 <tr>
                  <td>
                  	<span class="<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if> s">
                  	${num.index+1}
                 	</span>
                  </td>
                  <td><span class="
                       <c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
	                  	${item.username }
	                  	</span>
                  	</td>
                  <td><span class="
                  		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
	                  	<c:choose>
	                  		<c:when test="${!empty item.score }">
	                  			${item.score }
	                  		</c:when>
	                  		<c:otherwise>0</c:otherwise>
	                  	</c:choose>
                  		</span>
                  </td>
                  <td><span class="
                  		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
	                  	<c:choose>
	                  		<c:when test="${!empty item.price }">
	                  			${item.price }
	                  		</c:when>
	                  		<c:otherwise>0</c:otherwise>
	                  	</c:choose>
                  		</span>
                   </td>
 		</c:forEach>
 	</c:when>
 </c:choose>
