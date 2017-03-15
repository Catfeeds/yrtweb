<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${!empty agent}">
	   <div class="career">
           <span class="pull-left ml15 text-gray f16">基本信息</span>
           <c:if test="${session_user_id eq oth_user_id}">
	           <span class="pull-right yt_edit" onclick="editAgentInfo()" title="编辑"></span>
           </c:if>
           <div class="clearit"></div>
       </div>
		<table class="bro_info">
		      <tbody>
			      <tr>
			          <td class="w120">
			              <span class="f12">认证号：</span>
			          </td>
			          <td>
			              <span class="f12">${agent.cer_no}</span>
			          </td>
			          <td class="w120">
			              <span class="f12">头衔：</span>
			          </td>
			          <td>
			              <span class="f12">${agent.title}</span>
			          </td>
			      </tr>
			      <tr>
			          <td class="w120">
			              <span class="f12">学历：</span>
			          </td>
			          <td>
			              <span class="f12">${agent.education}</span>
			          </td>
			          <td class="w120">
			              <span class="f12">寻找球员区域：</span>
			          </td>
			          <td>
			              <span class="f12">${agent.find_area }</span>
			          </td>
			      </tr>
			      <tr>
			          <td class="w120">
			              <span class="f12">所属公司：</span>
			          </td>
			          <td>
			              <span class="f12">${agent.company}</span>
			          </td>
			          <td class="w120">
			              <span class="f12">是否有球员经历：</span>
			          </td>
			          <td>
		         		<c:if test="${agent.is_player eq 1}">
		         			<span class="f12">是</span>
		         		</c:if>
		         		<c:if test="${agent.is_player eq 0}">
		         			<span class="f12">否</span>
		         		</c:if>
		       		  </td>
			      </tr>
			      <tr>
			          <td class="w120">
			              <span class="f12">熟悉俱乐部：</span>
			          </td>
			          <td colspan="3">
			              <span class="f12">${agent.know_clubs}</span>
			          </td>
			      </tr>
			      <tr>
			          <td valign="top" rowspan="20" class="w120">
			              <span class="f12">典型案例：</span>
			          </td>
			          <td colspan="3">
			              <span class="f12">${agent.cases}</span>
			          </td>
			      </tr>
			  </tbody>
		  </table>
	</c:when>
	<c:otherwise>
		<%@ include file="agent_editInfo.jsp" %>
	</c:otherwise>
</c:choose>
