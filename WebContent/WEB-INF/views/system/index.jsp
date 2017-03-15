<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>系统设置</title>
</head>
<body>
 <div class="warp">
<%@include file="../common/header.jsp" %>
<!--导航 start-->
<%@ include file="../common/naver.jsp" %>        
<div class="wrapper" style="margin-top: 30px;">


            <!--页面主体-->
            <div class="container ms">
                <div class="middle">
                   <%@include file="left.jsp" %>
                    <div class="content ms">
                        <div class="content_top">
                            <div class="title ms">
                                <span><a href="#" class="ml10">登录信息</a></span>
                            </div>
                              <div class="prv_time">
                                <img src="${ctx}/resources/images/creatClub.png" />
                               <div>
                               <p class="text-white f14">上次登录时间：<fmt:formatDate value="${last_login}" pattern="yyyy-MM-dd HH:mm:ss"/></p>  
                               <p class="text-white f14">&emsp;上次登录IP：${last_login_ip}</p>
                               <p class="text-white f14">上次登录城市：<c:if test="${!empty map }">${map.country}-${map.province}-${map.city}</c:if></p>
                               </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearit"></div>

                </div>


            </div>
        </div>

        </div>
	<!-- footer start -->
	<%@include file="../common/footer.jsp" %>
	<!-- footer end -->
</body>
</html>