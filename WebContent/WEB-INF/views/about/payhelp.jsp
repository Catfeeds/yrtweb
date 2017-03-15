<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/about.css" rel="stylesheet" />
<title>支付帮助</title>
<c:set var="currentPage" value="PAYHELP"/>
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
                    <span class="f20 ms text-white"><a href="/" class="text-white">首页</a>>>支付帮助</span>
                </div>
                <div class="about_content">
                    <p class="text-white">宇任拓支持以下几种支付方式：</p>
                    <p class="text-white fw">1、在线支付：</p>
                    <p class="text-white">使用支付宝、网银等进行在线支付；</p>
                    <p class="text-white fw">2、余额支付：</p>
                    <p class="text-white">如果你在宇任拓上要下多个订单，建议先充值，之后就可以用余额进行支付。</p>
                    <!-- <p class="text-white fw">3、线下支付：</p>
                    <p class="text-white">可通过线下支付来购买产品。</p>
                    <p class="text-white fw">4、账户信息如下</p>
                    <p class="text-white">开户行 ：工商银行成都茶店子支行</p>
                    <p class="text-white">账&emsp;号 ：4402-2210-1910-0273-651</p>
                    <p class="text-white">单位名称： 成都律金刚网络科技有限公司</p> -->
                </div>
            </div>
            <div class="clearit"></div>
        </div>
    </div>
     <!--页脚-->
    <%@ include file="../common/footer.jsp" %>
</body>
</html>