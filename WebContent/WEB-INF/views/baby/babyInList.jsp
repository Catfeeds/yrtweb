<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@ include file="../common/common.jsp" %>
    <title></title>
    <!--IE 浏览器运行最新的渲染模式下-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--国产浏览器高速模式-->
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/center.css" rel="stylesheet" />
    <c:set var="currentPage" value="BABYINDEX"/>
</head>
<body>
    <div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航-->
        <%@ include file="../common/naver.jsp" %> 
        <div class="wrapper" style="margin-top: 116px;">
        	<input type="hidden" id="user_id" name="user_id" value="${user_id}"/>
            <div class="bb_sy">
                <span class="f16 text-white ms">已代言列表</span>
            </div>
            <div class="zhu_dai" style="padding-bottom: 20px;" id="listArea">
                
            </div>
        </div>
	<%@ include file="../common/footer.jsp" %>
    </div>
  	<script src="${ctx}/resources/js/own/babyinlist.js"></script>
</body>
</html>
