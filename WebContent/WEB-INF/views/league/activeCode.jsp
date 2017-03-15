<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<link href="${ctx}/resources/css/editClub.css" rel="stylesheet" />

<title>验证码激活</title>
<c:set var="currentPage" value="TEAMDETAIL"/>
</head>
<body>
	<div class="masker"></div>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../common/header.jsp" %>
		  <!--导航 start-->
        <%@ include file="../common/naver.jsp" %>    
        <!--导航 end-->
		<div class="wrapper" style="margin-top: 116px;">
			联赛id：<input type="text" name="id" value="${league.id}"/>
			验证码：<input type="text" name="code_str" value=""/>
		</div>	 
</div>		
<%@ include file="../common/footer.jsp" %>
</body>
</html>