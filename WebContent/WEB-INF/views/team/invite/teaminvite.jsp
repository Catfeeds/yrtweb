<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<p class="f16 text-white pingbi">
	<span>受邀列表</span>
	<span>
		<a href="${ctx}/teamInvite/list?teaminfo_id=${teaminfo_id}" class="moreMembers"></a>
	</span>
</p>
<div class="inviteInfo mt25 ml15">
<c:choose>
	<c:when test="${!empty listInvite}">
		<c:forEach items="${listInvite}" var="invite" varStatus="i">
			<div class="inviteDetail">
				<div class="pull-left inviteLogo">
					<img src="${el:headPath()}${invite.t_logo}" />
				</div>
				<div class="pull-left ml15">
					<p class="text-white f14">${invite.t_name}</p>
					<p class="text-gray"><fmt:formatDate value="${invite.invite_time}" pattern="yyyy-MM-dd" /></p>
					<p class="text-gray">${invite.position}</p>
					<p class="text-gray">${invite.ball_format}人制</p>
					<p class="text-white ml10 mt20">
						挑战宣言
					</p>
					<p class="text-white mt10 p_xuanyan">
						${invite.declar}
					</p>
					<p class="p_operate">
						<c:choose>
							<c:when test="${invite.status eq 1}">
								<span class="y_c">约战成功</span>
							</c:when>	
							<c:when test="${invite.status eq 0}">
								<span class="y_c">已拒绝</span>
							</c:when>
							<c:otherwise>
								<input type="button" name="name" value="接受" class="inviteYes" onclick="checkInvite('${invite.teaminfo_id}',1,'${invite.id}')"/>
								<input type="button" name="name" value="拒绝" class="inviteNo ml5" onclick="checkInvite('${invite.teaminfo_id}',0,'${invite.id}')"/>
							</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div>
		</c:forEach>
	</c:when>
<c:otherwise>
		<!-- 无对战邀请时 -->
		<div>
			<img src="${ctx}/resources/images/noRecordSmall.png" class="new_noInvite"/>
		</div>
	</c:otherwise>
</c:choose>
</div>

