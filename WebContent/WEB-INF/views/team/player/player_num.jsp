<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div class="closeBtn_1" onclick="cl();"></div>
<c:choose>
	<c:when test="${!empty teamPlayer}">
		<input type="hidden" name="num" id="num" value="${teamLoanPlayer.player_num}"/>
		<h3>球衣号码选择（最多选择一个）</h3>
			<ul>
				<c:forEach var="i" begin="0" end="99">
					<li>
					    <div id="${i}" class="num <c:if test="${i eq teamPlayer.player_num}">active</c:if>" onclick="checkNum('${i}')">${i}</div>
					</li>
				</c:forEach>    
				<div class="clearit"></div>
			</ul>
		<div style="width:600px;margin: 60px auto 0;text-align: center; ">
		    <input type="button" name="name" value="确认" class="btn_l f18 ms" onclick="updateNum('${teamPlayer.id}','player');">
		    <input type="button" name="name" value="取消" class="btn_g f18 ms" id="cannel" onclick="cl();"/>
		</div>	
	</c:when>
	<c:when test="${!empty teamLoanPlayer}">
		<input type="hidden" name="num" id="num" value="${teamLoanPlayer.player_num}"/>
		<h3>球衣号码选择（最多选择一个）</h3>
			<ul>
				<c:forEach var="i" begin="0" end="99">
					<li>
					    <div id="${i}" class="num <c:if test="${i eq teamLoanPlayer.player_num}">active</c:if>" onclick="checkNum('${i}')">${i}</div>
					</li>
				</c:forEach>    
				<div class="clearit"></div>
			</ul>
		<div style="width:600px;margin: 60px auto 0;text-align: center; ">
		    <input type="button" name="name" value="确认" class="btn_l f18 ms" onclick="updateNum('${teamLoanPlayer.id}','loan');">
		    <input type="button" name="name" value="取消" class="btn_g f18 ms" id="cannel" onclick="cl();"/>
		</div>	
	</c:when>
</c:choose>
 	
