<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<c:set var="currentPage" value="LOGIN"/>
<title>宇任拓-404</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="wrapper" style="margin-top: 20px;">
        <div class="error_div">
            <img src="/resources/images/404jpg.png" class="pull-left mt30 ml150" />
            <a href="${ctx}/" class="return">返回首页</a>
            <a class="refresh" id="refresh" style="cursor: pointer;" onclick="window.location.reload()">再刷新一下？</a>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    <script src="${ctx}/resources/js/jQuery.md5.js"></script>
    <script type="text/javascript">
    </script>
</body>
</html>