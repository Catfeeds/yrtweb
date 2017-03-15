<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-球员报名</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<link href="${ctx}/resources/css/chargeCenter.css" rel="stylesheet" />
</head>
<body>
	<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
	     <div class="wrapper" style="margin-top: 116px;">
	     	<form id="toPayForm" method="POST" action="${ctx}/account/toBankPay" onsubmit="return submit_();" target="_blank">
	     	<input type="hidden" name="league_id" id="league_id" value="${league_id}"/>
            <div class="registration">
                <div class="reg_title">
                    <span class="text-white f16 ms">球员报名</span>
                </div>
                  <div class="player_reg">
                    <ul>
                        <li class="actived"><span>1、报名须知</span></li>
                        <li class="actived"><span>2、填写资料</span></li>
                        <li class="actived"><span>3、等待审核</span></li>
                        <li class="actived"><span>4、参赛方式</span></li>
                        <!-- <li class="actived"><span>5、支付报名费</span></li> -->
                        <li class="active"><span>5、完成</span></li>
                        <div class="clearit"></div>
                    </ul>
                </div>
	            <div style="text-align: center;">
	            	<c:choose>
		            	<c:when test="${leagueCost.status == 1}">
			            	<span style="font-size: 20px;color: white;">报名成功！</span>
			            	<span style="font-size: 20px;color: white;">恭喜您已成功报名第一届宇任拓超级联赛，宇任拓，由你精彩!</span>
		            	</c:when>
		            	<c:otherwise>
			            	<span style="font-size: 20px;color: white;">报名失败！</span>
			            	<span style="font-size: 20px;color: white;">很遗憾，您的报名失败了，感谢您对宇任拓的关注。宇任拓，由你精彩!</span>
		            	</c:otherwise>
	            	</c:choose>
	            </div>	
            </div>
            </form>
        </div>
    </div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
	function submit_(){
		var money = $("#recharge_money").val();
		if(money<50) return false;
	}
</script>
</body>
</html>