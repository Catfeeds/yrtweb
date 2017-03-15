<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/common.jsp" %>
<c:choose>
	<c:when test="${!empty careers}">
		<c:set value="${fn:length(careers)}" var="SIZE"/>
		<c:forEach items="${careers}" var="career" varStatus="num">
			<div class="career_1" <c:if test="${SIZE eq num.index+1}">style="border-bottom:none;"</c:if>>
			      <table class="carer_info">
			          <tr>
			              <td style="width: 125px;"><span class="text-gray-s_81">俱乐部名称：</span></td>
			              <td style="text-indent: 0;"><span class="text-white">${career.name }</span></td>
			          </tr>
			          <tr>
			              <td style="width: 125px;"><span class="text-gray-s_81">任职时间：</span></td>
			              <fmt:formatDate value="${career.bg_time }" var="bg" pattern="yyyy-MM-dd"/>
						  <fmt:formatDate value="${career.ed_time }" var="ed" pattern="yyyy-MM-dd"/>
			              <td style="text-indent: 0;"><span class="text-white">${bg}~${ed}</span></td>
			
			          </tr>
			          <tr>
			              <td style="width: 125px;" valign="top"><span class="text-gray-s_81">俱乐部描述：</span></td>
			              <td style="text-indent: 0;"><span class="text-white">${career.describle}</span></td>
			          </tr>
			      </table>
			  </div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div align="center" style="height: 130px;">
			<img src="${ctx}/resources/images/add_pic.jpg" <c:if test="${session_user_id eq oth_user_id}">onclick="editCoachCareers()" title="编辑"</c:if>>
		</div> 
	</c:otherwise>
</c:choose>
