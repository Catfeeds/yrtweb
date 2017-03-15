<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/about.css" rel="stylesheet" />
<title>联系我们</title>
<c:set var="currentPage" value="CONTACTUS"/>
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
                    <span class="f20 ms text-white"><a href="/" class="text-white">首页</a>>>联系我们</span>
                </div>
                <div class="about_content">
                	<!-- <p class="text-white">
                    	    电话：4000-777-366
                    </p> -->
                    <p class="text-white">
                     	   联系方式：028-86667832
                    </p>
                    <p class="text-white">
                      	  公司地址：成都市青羊区草市街69号恒昌大厦四楼A25
                    </p>
                    <p class="text-white">
                   	     新浪微博：宇任拓足球
                    </p>
                    <p class="text-white">
                        <img src="${ctx}/resources/images/yrt_sina.jpg" alt="宇任拓微博" class="ml25"/>
                    </p>
                    <p class="text-white">
                    	    微信订阅号：宇任拓订阅号 
                    </p>
                    <p class="text-white">
                        <img src="${ctx}/resources/images/yrt_wechat.jpg" alt="宇任拓订阅号" class="ml25" />
                    </p>
                </div>
            </div>
            <div class="clearit"></div>
        </div>
    </div>
     <!--页脚-->
    <%@ include file="../common/footer.jsp" %>
</body>
</html>