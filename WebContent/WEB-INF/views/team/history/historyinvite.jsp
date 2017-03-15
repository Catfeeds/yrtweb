<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:forEach items="${history.items}" var="teamGame">
	<c:set var="lastGame" value="${teamGame}"></c:set>
</c:forEach>
<div class="moreRecord">
	<a href="${ctx}/team/hisGames?teaminfo_id=${teaminfo_id}" class="moreMembers"></a>
</div>
<div class="clear"></div>
<div class="match_record">
<div class="xuk">
<p class="text-white text-center f18 record_fu">比赛记录</p>
<c:choose>
	<c:when test="${!empty lastGame}">
		<div class="zuofei">
			<c:choose>
				<c:when test="${lastGame.status eq 1}">
					<img src="${ctx}/resources/images/confirm.png">
				</c:when>
				<c:when test="${lastGame.status eq 2}">
					<img src="${ctx}/resources/images/zuofei1.png">
				</c:when>
				<c:when test="${lastGame.status eq 3}">
					<img src="${ctx}/resources/images/noConfirm.png">
				</c:when>
			</c:choose>	
		</div>
		
		<div class="record_top">
			<div class="recordZzhu pull-left">
				<img src="${el:headPath()}${lastGame.t_logo}" onclick="javascript:window.location='${ctx}/team/tdetail/${lastGame.initiate_teaminfo_id}'"/>
				<p class="text-white mt5 f16 record_pclubName">${lastGame.t_name}</p>
			</div>
			<div class="pull-left vs ml80">
				<img src="${ctx}/resources/images/vsImg.png"/>
			</div>
			<div class="recordZzhu pull-left ml75">
				<img src="${el:headPath()}${lastGame.r_logo}" onclick="javascript:window.location='${ctx}/team/tdetail/${lastGame.respond_teaminfo_id}'"/>
				<p class="text-white mt5 f16 record_pclubName">${lastGame.r_name}</p>
			</div>
		</div>
		<div class="record_middle">
			<span>2015-09-30</span>
			<span class="ml55">${lastGame.initiate_score}&nbsp;:&nbsp;${lastGame.respond_score}</span>
			<span class="ml55">${lastGame.ball_format}人制</span>
		</div>
		<div class="record_bottom mt20">
			<p class="text-white f18 text-center ml20">助威宝贝</p>
			<c:choose>
				<c:when test="${!empty lastGame.users}">
					<p class="zhuImg babyImg">
						<c:forEach items="${lastGame.users}" var="baby">
							<img src="${el:headPath()}${baby.head_icon}" />
						</c:forEach>	
					</p>
				</c:when>
				<c:otherwise>
					<div class="baby_h" style="margin-top:7px;margin-left: 96px;"><img src="${ctx}/resources/images/NoBaby.png" /></div>
					<p class="text-white wei_p" style="margin-left: 88px;">本场未邀请宝贝</p>
				</c:otherwise>
			</c:choose>
		</div>
	</c:when>
	<c:otherwise>
	<!-- 无历史记录层 -->
	<div>
		<div>
			<div class="noRecord">
				<img src="${ctx}/resources/images/noRecord.png" />
			</div>
		</div>
	</div>		
	</c:otherwise>
</c:choose>
</div>
</div>
<div class="clear"></div>