<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${!empty coach}">
	   <div class="career">
           <span class="pull-left ml15 text-gray f16">基本信息</span>
           <c:if test="${session_user_id eq oth_user_id}">
	           <span class="pull-right yt_editer" onclick="editCoachInfo()" ></span>
           </c:if>
           <div class="clearit"></div>
       </div>
		<table style="margin-top: 20px;">
		    <tr>
		        <td class="w110">
		            <span class="f12 text-gray-s_81">球员经历：</span>
		        </td>
		        <td>
		        	<c:choose>
		        		<c:when test="${coach.is_player eq 1}">
		        			<span class="text-white f12">是</span>
		        		</c:when>
		        		<c:otherwise>
		        			<span class="text-white f12">否</span>
		        		</c:otherwise>
		        	</c:choose>
		        </td>
		    </tr>
		    <tr>
		        <td class="w110">
		            <span class="f12 text-gray-s_81">证书编号：</span>
		        </td>
		        <td>
		            <span class="f12 text-white">
		           	 ${coach.cer_no }
		            </span>
		        </td>
		    </tr>
		    <tr>
		        <td class="w110">
		            <span class="f12 text-gray-s_81">所属俱乐部：</span>
		        </td>
		        <td>
		            <span class="f12 text-white">
		            	${coach.in_team }
		            </span>
		        </td>
		    </tr>
		    <tr>
		        <td class="w110">
		            <span class="f12 text-gray-s_81">所培养球星：</span>
		        </td>
		        <td>
		            <span class="f12 text-white">
		            ${coach.stars }
		            </span>
		        </td>
		    </tr>
		</table>
	</c:when>
	<c:otherwise>
		<%@ include file="coach_editinfo.jsp" %>
	</c:otherwise>
</c:choose>
