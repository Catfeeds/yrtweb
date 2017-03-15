<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>经纪人信息编辑</title>
</head>
<body>
		<!-- 基本信息start -->
			<div class="career">
			    <span class="pull-left ml15 text-gray f16">基本信息</span>
			    <c:if test="${session_user_id eq oth_user_id}">
			    <span class="pull-right yt_edit" onclick="editAgentInfo()" title="编辑"></span>
			    <span class="pull-right yt_save" onclick="submitFrom()" title="保存"></span>
			    </c:if>
			    <div class="clearit"></div>
			</div>
			<form id="agentfrom">
				<input type="hidden" name="id" value="${agent.id}"/>
				<input type="hidden" name="user_id" value="${agent.user_id}"/>
				<table class="bro_info">
					<tr>
						 <td class="w120">
				              <span class="f12">认证号：</span>
				          </td>
						<td>
							<span class="f12"><input type="text" name="cer_no"  class="shuju" value="${agent.cer_no}"  valid="require len(1,60)"/></span>
						</td>
						<td class="w120">
			              <span class="f12">头衔：</span>
			            </td>
						<td>
							<span class="f12"><input type="text" name="title"  class="shuju" value="${agent.title}"/></span>
						</td>
					</tr>
				<%-- 	<tr>
						<td class="w120">
							<span class="f12">代理过球员:</span>
						</td>
						<td>
							<span class="f12"><input type="text" name="agent_plays"  class="shuju" value="${agent.agent_plays}"/></span>
						</td>
					</tr> --%>
					<tr>
				          <td class="w120">
				              <span class="f12">学历：</span>
				          </td>
				          <td>
				              <span class="f12"><input type="text" name="education"  class="shuju" value="${agent.education}"/></span>
				          </td>
				          <td class="w120">
				              <span class="f12">寻找球员区域：</span>
				          </td>
				          <td>
				              	<select name="find_area">
				              		<option>--请选择--</option>
				              		<option value="欧洲" <c:if test="${agent.find_area eq '欧洲'}">selected</c:if>>欧洲</option>
				              		<option value="美洲" <c:if test="${agent.find_area eq '美洲'}">selected</c:if>>美洲</option>
				              		<option value="华南" <c:if test="${agent.find_area eq '华南'}">selected</c:if>>华南</option>
				              		<option value="华北" <c:if test="${agent.find_area eq '华北'}">selected</c:if>>华北</option>
				              		<option value="华东" <c:if test="${agent.find_area eq '华东'}">selected</c:if>>华东</option>
				              		<option value="华中" <c:if test="${agent.find_area eq '华中'}">selected</c:if>>华中</option>
				              		<option value="西南" <c:if test="${agent.find_area eq '西南'}">selected</c:if>>西南</option>
				              		<option value="东北" <c:if test="${agent.find_area eq '东北'}">selected</c:if>>东北</option>
				              		<option value="西北" <c:if test="${agent.find_area eq '西北'}">selected</c:if>>西北</option>
				              	</select>
				          </td>
					</tr>
					<tr>
						<td class="w120">
				              <span class="f12">所属公司：</span>
				          </td>
				          <td>
				              <span class="f12"><input type="text" name="company"  class="shuju" value="${agent.company}"/></span>
				          </td>
				          <td class="w120">
				              <span class="f12">是否有球员经历：</span>
				          </td>
				          <td>
				             <input type="radio" name="is_player" value="1" <c:if test="${agent.is_player eq 1}">checked</c:if>/>是
							 <input type="radio" name="is_player" value="0" <c:if test="${agent.is_player eq 0}">checked</c:if>/>否
				          </td>
					</tr>
					<tr>
						<td class="w120">
			              <span class="f12">熟悉俱乐部：</span>
			           </td>
			           <td colspan="3">
							<span class="f12"><textarea style="width: 450px;height: 60px;" name="know_clubs">${agent.know_clubs}</textarea></span>
						</td>
					</tr>
					<tr>
						  <td valign="top" rowspan="20" class="w120">
				              <span class="f12">典型案例：</span>
				          </td>
				          <td colspan="3">
				              <span class="f12"><textarea style="width: 450px;height: 60px;" name="cases">${agent.cases}</textarea></span>
				          </td>
					</tr>
				</table>
			</form>
			<div class="clearit"></div>
			<div style="height: 10px;"></div>
		<!-- 基本信息end -->
</body>
</html>