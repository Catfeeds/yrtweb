<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<table>
	<tr>
		<th>球衣号</th>
		<th>姓名</th>
		<th>位置</th>
	</tr>
	<c:forEach items="${team_players}" var="player" varStatus="i" begin="0" end="3">
		<tr>
			<td>
				<div class="qiu">
					<span>${player.player_num}</span>
				</div>
			</td>
			<td>
				<span class="ml10"><a href="${ctx}/center/${player.user_id}">${player.usernick}</a></span>
			</td>
			<td>
				<span><yt:dict2Name nodeKey="p_position" key="${player.position}"></yt:dict2Name></span>
			</td>
		</tr>
	</c:forEach>
</table>