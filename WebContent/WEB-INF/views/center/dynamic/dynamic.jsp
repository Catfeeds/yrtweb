<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div class="c_g">
    <dl>
        <dt><span class="fw f14 ms">${dynCount.gznum}</span></dt>
        <dd><span class="f12" onclick="window.location='${ctx}/user/focusList/${u_id}'" style="cursor: pointer;">关注</span></dd>
    </dl>
</div>
<div class="c_g">
    <dl>
        <dt><span class="fw f14 ms">${dynCount.bgznum}</span></dt>
        <dd><span class="f12" onclick="window.location='${ctx}/user/fansList/${u_id}'" style="cursor: pointer;">粉丝</span></dd>
    </dl>
</div>
<div class="c_g" style="border: none;">
    <dl>
        <dt><span class="fw f14 ms">${dynCount.dtnum}</span></dt>
        <dd><span class="f12">动态</span></dd>
    </dl>
</div>
<div class="clearit"></div>
