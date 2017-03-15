<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>      
<ul class="p_list">
    <c:if test="${empty ivs}">
		<c:forEach var="i" begin="1" end="6">
		<li>
			<div class="" style="position: relative; width: 160px;">
			<img src="${ctx}/resources/images/zwtp.png" class="small">
			</div>
		</li>
		</c:forEach>
	</c:if>
	<c:if test="${!empty ivs}">
	<c:forEach items="${ivs.items }" var="item" varStatus="status">
	<li><img layer-type="image" layer-pid="${item.id}" layer-src="${el:filePath(item.f_src,item.to_oss)}" num="${status.index+1}" alt="" src="${el:filePath(item.f_src,item.to_oss)}" class="picc"></li>
	</c:forEach>
	<c:if test="${ivs.items.size()<6}">
    <c:forEach var="i" begin="1" end="${6-ivs.items.size()}">
	<li>
		<div class="" style="position: relative; width: 160px;">
		<img src="${ctx}/resources/images/zwtp.png" class="small">
		</div>
	</li>
	</c:forEach>
    </c:if>
	</c:if>
    <div class="clearit"></div>
</ul>
