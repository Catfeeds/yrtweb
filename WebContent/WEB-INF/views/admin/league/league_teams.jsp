<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<input type="hidden" value="${event_id}" name="event_id"/>
<label class="control-label">参赛队伍：</label>
<input type="checkbox" id="allcheck" onclick="allchecked(this)"/>全选
<div class="controls" >
 <c:forEach items="${teams_league}" var="team" varStatus="tNum">
	  <label class="checkbox inline">
		<input type="checkbox" name="teaminfoids[${tNum.index}]" value="${team.id},${team.event_id}" id="teaminfo_${tNum.index}">${team.name}
		
	  </label>
 </c:forEach>
</div>