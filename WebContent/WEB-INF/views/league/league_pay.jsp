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
	  <div class="makser"></div>
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <div class="pay_status" style="">
            <div class="pay_title">
                <div class="closeBtn_1"></div>
                <span class="text-white ms f14">支付状态</span>
            </div>
            <div class="pay_tips">
                <p class="text-white f20 ms">
                    请在弹出的页面进行付款操作!
                </p>
            </div>
            <div style="text-align: center;">
                <input type="button" name="name" value="支付完成" class="btn_l ms f14 ml5" id="invi_btn" onclick="window.location='${ctx}/league/toSign?league_id=${league_id}'"/>
                <input type="button" name="name" value="支付遇见问题" class="btn_l ms f14" style="margin-left: 116px;" onclick="window.location='${ctx}/about/payhelp'"/>
            </div>
        </div>
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
                        <li class="active"><span>4、支付报名费</span></li>
                        <li class=""><span>5、参赛方式</span></li>
                        <li class=""><span>6、完成</span></li>
                        <div class="clearit"></div>
                    </ul>
                </div>
	            <div style="text-align: center;">
	            	<span class="f18 ms text-white">第一届宇任拓超级联赛报名费	|	应付金额￥50.00元</span>
	            	<input type="hidden" id="recharge_money" name="recharge_money" value="5000"/>
	            	<input type="hidden" id="type" name="type" value="2"/>
	            	<input type="hidden" id="sign_way" name="sign_way" value="1"/>
	            	<div class="paymentWays" style="margin-left: 90px;width: 800px;">	
	   					<ul style="height: 32px;">
	   						<li style="width: 122px;" class="active">在线支付</li>
	   					</ul>
	   					<div class="pay_dd">
		   					<table class="ml30">
		   						<tr>
		   							<td>
		   								<input type="radio" id="alipay" name="xzyh" value="alipay" checked="checked"/> 
		   								<label for="alipay"><img alt="支付宝" src="${ctx}/resources/images/bank1.png" /></label>
		   							</td>
		  						</tr>
		   					</table>
	   					</div>
   					</div>
   					<div class="payWays_next">
   						<button type="submit" style="margin-right: 105px;" id="submit">
   							<span class="f14 ms">支付</span>
   						</button>
       				</div>
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
		var flag = true;
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/league/checkPayCost',
			data: {"league_id":$("#league_id").val()},
			success: function(result){
				if(result.state=='success'){
					flag = false;
					layer.msg('您已支付了报名费用',{icon: 1});
					setTimeout(function(){location.reload();},2000);
				}else{
					checkPayCost();
				}
			},
			error: $.ajaxError
		});
		return flag;
	}
	jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }

	function checkPayCost(){
		$(".makser").height($(document).height()).fadeIn();
        $(".pay_status").center().fadeIn();
	}

    $("#submit").click(function () {
        
    });

    function close() {
        $(".makser").fadeOut();
        $(".pay_status").fadeOut();
    }

    $(".closeBtn_1").click(function () {
        close();
    });
    $(".makser").click(function () {
        close();
    });
</script>
</body>
</html>