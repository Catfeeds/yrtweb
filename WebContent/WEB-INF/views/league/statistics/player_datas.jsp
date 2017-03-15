<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<ul>
<li class="active" id="home"
	onclick="load_player_datas('${matchInfo.id}','${matchInfo.h_team_id }',1);">主队</li>
<li id="visit"
	onclick="load_player_datas('${matchInfo.id}','${matchInfo.v_team_id }',2);">客队</li>
	<div class="clearit"></div>
</ul>
<div class="j_fenge"></div>
<table class="hg_tab">
	<tr>
		<th><span>号码</span></th>
		<th><span>姓名</span></th>
		<!-- <th><span>场上位置</span></th> -->
		<th><span>参赛时长</span></th>
		<th><span>射门</span></th>
		<th><span>射正</span></th>
		<th><span>射偏</span></th>
		<th><span>进球</span></th>
		<th><span>助攻</span></th>
		<th><span>抢断</span></th>
		<th><span>解围</span></th>
		<th><span>扑救</span></th>
		<th><span>犯规</span></th>
		<th><span>红牌</span></th>
		<th><span>黄牌</span></th>
	</tr>
	<c:choose>
<c:when test="${!empty players}">
    <c:forEach items="${players}" var="ps" varStatus="status">
	<tr>
		<td><span>${ps.number }</span></td>
		<td><span>${ps.name }</span></td>
		<!--<td><span><yt:dict2Name nodeKey="p_position" key="${ps.position}"></yt:dict2Name></span></td>  -->
		<td><span>${ps.durtime}</span></td>
		<td><span>${ps.shemen_num}</span></td>
		<td><span>${ps.shezheng_num}</span></td>
		<td><span>${ps.shepian_num}</span></td>
		<td><span>${ps.jinqiu_num}</span></td>
		<td><span>${ps.zhugong_num}</span></td>
		<td><span>${ps.qiangduan_num}</span></td>
		<td><span>${ps.jiewei_num}</span></td>
		<td><span>${ps.pujiu_num}</span></td>
		<td><span>${ps.fangui_num}</span></td>
		<td><span>${ps.hongpai_num}</span></td>
		<td><span>${ps.huangpai_num}</span></td>
	</tr>
   </c:forEach>
  </c:when>
</c:choose>
</table>
				