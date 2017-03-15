<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/about.css" rel="stylesheet" />
<title>关于我们</title>
<c:set var="currentPage" value="ABOUTUS"/>
</head>
<body>
<div class="warp">
        <!--头部-->
    	<%@ include file="../common/header.jsp" %>
    	<!--导航 start-->
        <%@ include file="../common/naver.jsp" %>    
        <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
           <%@ include file="left.jsp" %>    
            <div class="about_r">
                <div class="about_r_title">
                    <span class="f20 ms text-white"><a href="/" class="text-white">首页</a>>>关于我们</span>
                </div>
                <div class="about_content">
                    <p class="text-white">成都宇任拓网络科技有限公司（UniPlay）成立于2015年，拥有成熟的互联网技术团队和体育产业背景，公司发展方向为综合性体育O2O。宇任拓正致力于打造一个面向所有参与足球运动的人的在线展示、交流和招聘平台，让业余足球参与者也能得到职业足球般的体验。</p>
                    <p class="text-white"></p>
                </div>
            </div>
            <div class="clearit"></div>
        </div>
    </div>
     <!--页脚-->
    <%@ include file="../common/footer.jsp" %>
</body>
</html>