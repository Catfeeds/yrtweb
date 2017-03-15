<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<p class="f16 text-white pingbi">
	<span>屏蔽列表</span>
	<span>
		<a href="${ctx}/team/blacklist/blacklist?teaminfo_id=${teaminfo_id}&user_id=${user_id}" class="moreMembers"></a>
	</span>
</p>
<div class="pingbi_list">
	<table>
		<tr style="border-bottom: 1px solid gray;">
			<th><span>头像</span></th>
			<th><span>昵称</span></th>
			<th><span>操作</span></th>
		</tr>
		<c:forEach items="${rf.items}" var="bPlayer" varStatus="i">
			<c:if test="${i.index < 3}">
				<tr>
					<td>
						<img src="${el:headPath()}${bPlayer.head_icon}"/>
					</td>
					<td>
						<span>${bPlayer.usernick}</span>
					</td>
					<td>
						<input type="button"  value="【移除】" class="removeBtn" onclick="kickBlack('${bPlayer.user_id}');"/>
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
</div>





