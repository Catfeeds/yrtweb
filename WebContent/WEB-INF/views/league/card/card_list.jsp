<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <tr>
     <td><span class="text-gray-s_666">名次</span></td>
     <td><span class="text-gray-s_666">球员名</span></td>
     <!-- <td><span class="text-gray-s_666">俱乐部</span></td> -->
     <td><span class="text-gray-s_666">黄牌</span></td>
     <td><span class="text-gray-s_666">红牌</span></td>
 </tr>
 <c:choose>
 	<c:when test="${!empty rf.items}">
 		<c:forEach items="${rf.items }" var="card" varStatus="i" >
 			 <tr>
 			 	 <td><span class="white_four s">${i.index+1}</span></td>
		         <td>
		             <span class="white_four"><a href="${ctx}/center/${card.id}" class="text-white"><yt:userName id="${card.id}"/></a></span>
		         </td>
		         <%-- <td><span class="white_four"><a href="${ctx}/team/tdetail/${card.teaminfo_id}" class="text-white"><yt:id2NameDB beanId="teamInfoService" id="${card.teaminfo_id}"></yt:id2NameDB></a></span></td>
		          --%>
		         <td><span class="white_four"><fmt:formatNumber value="${card.huangpai_num}" pattern="#0"/></span></td>
		         <td><span class="white_four"><fmt:formatNumber value="${card.hongpai_num}" pattern="#0"/></span></td>
             </tr>    
 		</c:forEach>
 	</c:when>
 	<c:otherwise>
		<tr>
			<td colspan="7"> <div class="nodate">
                            <img src="${ctx}/resources/images/wjqqd.png" alt="Alternate Text" />
                        </div></td>
		</tr>
	</c:otherwise>
 </c:choose>
