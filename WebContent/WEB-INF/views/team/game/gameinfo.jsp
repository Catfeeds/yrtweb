<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<p class="f16 text-white ml20 mt10">对战预告</p>
<c:if test="${session_user_id eq user_id}">
	<a href="${ctx}/teamInvite/pklist" class="a_pk">PK匹配</a>
</c:if>
<c:choose>
	<c:when test="${empty teamGame}">
		<img src="${ctx}/resources/images/noRecord.png" class="noPkImg"/>
	</c:when>
	<c:otherwise>
		<div class="ml110 mt30 pull-left">
			<div class="invite_top">
				<div class="zhu pull-left">
					<img src="${el:headPath()}${teamGame.t_logo}" onclick="javascript:window.location='${ctx}/team/tdetail/${teamGame.initiate_teaminfo_id}'"/>
					<p class="text-white mt5 pclubName">${teamGame.t_name}</p>
				</div>
				<div class="pull-left vs ml25">
					<img src="${ctx}/resources/images/shanVs.png"/>
				</div>
				<div class="zhu pull-left ml10">
					<img src="${el:headPath()}${teamGame.r_logo}" onclick="javascript:window.location='${ctx}/team/tdetail/${teamGame.respond_teaminfo_id}'"/>
					<p class="text-white mt5 pclubName">${teamGame.r_name}</p>
				</div>
			</div>
			<div class="invite_bottom mt20">
				<span class="ml45"><fmt:formatDate value="${teamGame.game_time}" pattern="yyy-MM-dd"/></span>
				<span class="ml15">${teamGame.position}</span>
				<span class="ml15">${teamGame.ball_format}人制</span>
			</div>
		</div>
		<div class="zhuweiBaby pull-left mt30 ml90">
			<p class="zhuImg">
				<c:forEach items="${babys}" var="baby">
					<img src="${el:headPath()}${baby.head_icon}" onclick="javascript:window.location='${ctx}/baby/base/user/${baby.user_id}'"/>
				</c:forEach>	
				<c:if test="${!empty session_user_id}">
					<c:choose>
						<c:when test="${session_user_id eq user_id}">
							<c:choose>
								<c:when test="${empty babys}">
									<img src="${ctx}/resources/images/addzhuBaby.png" class="addzhuBaby" onclick="openGameBaby('${teamGame.id}')" style="margin-left: 80px;"/>
								</c:when>
								<c:when test="${fn:length(babys)<3}">	
									<img src="${ctx}/resources/images/addzhuBaby.png" class="addzhuBaby" onclick="openGameBaby('${teamGame.id}')"/>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:if test="${empty babys}">
								<img src="${ctx}/resources/images/NoBaby.png" style="margin-left: 80px;"/>
							</c:if>
						</c:otherwise>
					</c:choose>	
				</c:if>
			</p>
			<p class="text-white f20 text-center mt60">助威宝贝</p>
		</div>
	</c:otherwise>
</c:choose>
