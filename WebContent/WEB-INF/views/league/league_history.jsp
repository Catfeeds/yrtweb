<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${fn:length(datas.items)>0}">
		<c:forEach items="${datas.items }" var="item">
			<tr>
			    <td><span>第${item.rounds}轮</span></td>
			    <td>
			        <dl>
			            <dt><span>${item.play_time}</span></dt>
			        </dl>
			    </td>
			    <td><a style="cursor: pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${item.m_teaminfo_id}'">${item.m_team_name }</a></td>
			    <td>
		    		<c:choose>
		    	 		<c:when test="${!empty item.m_score}">
		    	 			<span class="f16 ms text-success">${item.m_score}</span>
		    	 			<span class="f16 ms text-success ml5">:</span>
		    	 		</c:when>
		    	 		<c:otherwise>
			    	 		<span class="f16 ms text-gray-s_81">--</span>
	  						<span class="f16 ms text-gray-s_81 ml5">:</span>
		    	 		</c:otherwise>
		    	 	</c:choose>
		    	 	<c:choose>
		    	 		<c:when test="${!empty item.g_score}">
		    	 		 	<span class="f16 ms text-success ml5">${item.g_score}</span>
		    	 		</c:when>
		    	 		<c:otherwise>
		    	 			<span class="f16 ms text-gray-s_81 ml5">--</span></td>
		    	 		</c:otherwise>
		    	 	</c:choose>	
	    		</td>
			    <td><a style="cursor: pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${item.g_teaminfo_id}'">${item.g_team_name }</a></td>
			    <td><span>${item.position }</span></td>
			    <td><span>
			    	<c:if test="${!empty item.m_score}">
		            	<a href="${ctx}/league/statistics?id=${item.id}" class="text-white tolbtn">统计</a>
		        	</c:if>
			    	</span>
			    </td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<td colspan="7"><font style="color:red">暂无赛程信息...</font></td>
	</c:otherwise>
</c:choose>
