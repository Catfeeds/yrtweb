<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 射手榜 -->
<tr>
    <td></td>
    <td><span class="text-gray-s_666">球员</span></td>
    <td><span class="text-gray-s_666">俱乐部</span></td>
    <td><span class="text-gray-s_666">进球</span></td>
</tr>
<c:choose>
	<c:when test="${!empty scorers.items}">
		<c:forEach items="${scorers.items}" var="item" varStatus="num">
			    <tr>
                  <td>
                  	<span class="<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if> s">
                  	${num.index+1}
                 	</span>
                  </td>
                  <td><span style="cursor: pointer;" onclick="javascript:window.location='${ctx}/center/${item.user_id}'" class="
                       <c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
	                  	${empty item.username?item.usernick:item.username}
	                  	</span>
                  	</td>
                  <td><span style="cursor: pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${item.teaminfo_id}'" class="
                  		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
                  		${item.name }
                  		</span>
                  </td>
                  <td><span class="
                  		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
                  		<fmt:formatNumber value="${item.goal}" pattern="0"/>
                  		</span>
                   </td>
              </tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="4"> <div class="nodate">
                            <img src="${ctx}/resources/images/wjqqd.png" alt="Alternate Text" />
                        </div></td>
		</tr>
	</c:otherwise>
</c:choose>
