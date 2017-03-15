<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="closeBtn_1" onclick="cl();"></div>
<div class="title">
    <span class="f16 ms">公&emsp;告</span>
</div>
<div class="info">
    <h3>${notice.name}</h3>
    <p>${notice.describle}</p>
</div>
<c:choose>
	<c:when test="${isme=='1'}">
<input type="button" value="编辑" class="btn_l ml150" style="margin-left: 155px;" onclick="editNotice('${notice.teaminfo_id}','${notice.id}');">
<input type="button" value="删除" class="btn_g ml20" id="cannel" onclick="delNotice('${notice.id}');">
	</c:when>
	<c:otherwise>
<input type="button" value="关闭" class="btn_l" onclick="cl();"/>
	</c:otherwise>
</c:choose>