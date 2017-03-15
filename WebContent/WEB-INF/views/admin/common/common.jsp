<!--added by bo.xie 存放公共使用部分  2015年7月21日15:41:04-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<meta http-equiv="X-UA-Compatible" content="IE=8">

<!-- 全局变量 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>
<!-- 公共部分资源 -->
<%-- <link rel="shortcut icon" href="${ctx}/resources/images/favicon.ico" /> --%>
<link href="${ctx}/resources/admin/css/jquery-ui-1.10.3.custom.min.css" rel="stylesheet">
<link href="${ctx}/resources/admin/css/jquery-ui-timepicker-addon.css" rel="stylesheet" />