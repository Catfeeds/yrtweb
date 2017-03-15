<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>竞拍列表</title>
</head>
<body>
<div class="warp">
	<div class="makser"></div>
	<!--头部-->
	<%@ include file="../common/header.jsp" %>
	<!--导航 start-->
	<%@ include file="../common/naver.jsp" %>    
	<!--导航 end-->
	<div class="wrapper" style="margin-top: 116px;">
		<div class="duel">
                <div class="title">
                    <span class="ms f14 text-white">球员市场</span>
                </div>
                <div class="aggregate">
                    <div class="left_tip">
                        <span>以竞价的形式购买自由球员，竞拍 结算时出价最高的主席得到该球员</span>
                    </div>
                    <div class="right_tip">
                        <span>以一口价的形式购买联赛球员，第 一个出价的俱乐部得到该球员</span>
                    </div>
                    <a href="javascript:goAuction('1');" class="markets"></a>
                    <a href="javascript:goMarket('1');" class="transfer"></a>
                </div>
            </div>
	</div>	
	<script src="${ctx}/resources/js/own/checkleague.js"></script>
	<%@ include file="../common/footer.jsp" %>   
	<script type="text/javascript">
        $(".markets").mouseover(function() {
            $(".left_tip").show();
        }).mouseout(function() {
            $(".left_tip").hide();
        });

        $(".transfer").mouseover(function () {
            $(".right_tip").show();
        }).mouseout(function () {
            $(".right_tip").hide();
        });
    </script>
</body>
</html>