<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty groups }">
		<c:forEach items="${groups }" var="group">
			<c:set var="flag" value="false" />  
				<li>
				    <table>
				        <tr>
				            <td rowspan="10" class="w1" valign="top"><span class="text-success f20 ms">${group.name}</span></td>
				        </tr>
				        <c:forEach items="${e_records }" var="er">
				        	<c:choose>
				        		<c:when test="${er.group_id eq group.id }">
				        		<c:set var="flag" value="true" />  
				        		   <tr>
						            <td class="w1"><span class="text-gray-s_999">${er.time }</span></td>
						            <td class="w2"><span class="text-gray-s_999">${er.m_team_name}</span></td>
						            <td><span class="text-gray-s_999">${er.position }</span></td>
						            <td class="w3"><span class="text-gray-s_999">${er.g_team_name}</span></td>
						           </tr>
				        		</c:when>
				        	</c:choose>
				        </c:forEach> 
				       	<c:if test="${!flag}">
				       				<tr>
				        				<td colspan="4" style="color: red;">暂无数据...</td>
				        			</tr>
				       	</c:if>
				    </table>
				</li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li>
			<p style="text-align: center;color: red;">暂无数据...</p>
		</li>
	</c:otherwise>
</c:choose>
