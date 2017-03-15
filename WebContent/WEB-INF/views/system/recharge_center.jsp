<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/chargeCenter.css" rel="stylesheet" />
<title>支付中心</title>
<c:set var="currentPage" value="RECHARGE"/>
</head>
<body>
<div class="warp">
    <div class="masker"></div>
     <div class="payment">
        <div class="closeBtn_1" onclick="cancel()"></div>
        <div class="title">
            <span class="text-white f16">付款确认</span>
        </div>
        <div class="paycentent">
            <img src="${ctx}/resources/images/result_right.png" alt="" />
            <p class="f20 ms">请在弹出的页面进行付款操作！</p>
            <p class="f16 ms text-gray-s_666">没有弹出？点这<a href="javascript:void(0)" onclick="resubmit()" class="text-orange">重新弹出</a> </p>
            <p class="f16 ms text-gray-s_666">遇到问题？点这<a href="${ctx}/about/questions" class="text-orange">常见问题</a></p>
        </div>
        <div class="sumit_div">
            <input type="button" name="name" value="支付遇到问题" onclick="javascript:window.location='${ctx}/about/questions'" class="btn_g ms f14" />
            <input type="button" name="name" onclick="javascript:window.location='${ctx}/account/recharge'" value="支付成功" class="btn_l ms f14 ml15" />
        </div>
    </div>
	<!-- 头部 -->
	<%@include file="../common/header.jsp" %>
	<!--导航 start-->
	<%@ include file="../common/naver.jsp" %>  
	<div class="wrapper" style="margin-top: 116px;">
		 <!--页面主体-->
         <div class="container ms">
             <div class="middle">
            	 <%@include file="left.jsp" %>	
            	 <!--右边内容-->
               		<div class="content ms f14">
               			<div class="content_top">
               				<div class="title ms">
               					<span class="text-white f16">充值中心</span>
               				</div>
               			</div>
               			<div class="new-coin">
                                <img src="${el:headPath()}${user.head_icon}" alt="" class="new-head" />
                                <div class="new-info">
                                    <dl>
                                        <dt><span class="f16">${user.usernick }</span></dt>
                                        <dd><span class="f14">可用金额：<span style="color: #ca324c; ">
               				            	<c:choose>
               				            		<c:when test="${!empty userAmount.real_amount}">
               				            			${userAmount.real_amount}
               				            		</c:when>
               				            		<c:otherwise>
               				            			0.00
               				            		</c:otherwise>
               				            	</c:choose>
               				            </span></span>&ensp;宇币</span></dd>
                                        <dd><span class="f14">金额转换：1人民币 = 100宇币</span></dd>
                                    </dl>
                                </div>
                                <div class="clearfix"></div>
                                <form id="toPayForm" method="POST" action="${ctx }/account/toBankPay" onsubmit="return submit_();" target="_blank">
                                <table class="paytab">
                                    <tr>
                                        <td class="w"><span class="f16">充值金额：</span></td>
                                        <td><input type="text" name="recharge_money" value="" onblur="changeMoney()"  id="amount"/><span class="f16">&ensp;宇币</span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="f16">应付金额：</span></td>
                                         <td><span class="f16" id="realMoney"></span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="f16">支付方式：</span></td>
                                        <td><input type="hidden" id="alipay" name="xzyh" value="alipay" /><span class="f16">支付宝</span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                        <button type="submit" class="qr-btn ms f14">
	               							<span class="">确认支付</span>
	               						</button>
                                            
                                        </td>
                                    </tr>
                                </table>
                                </form>
                            </div>
               		</div>
             </div>
         </div>
	</div>
</div>
	<!-- footer start -->
	<%@include file="../common/footer.jsp" %>
	<!-- footer end -->
</body>
<script type="text/javascript">
	function submit_(){
		var flag = changeMoney();
		if(flag==false)return false;
		showDialog();
	}
	//校验充值金额
    function changeMoney(){
		//充值宇拓币
		var ytb = $("#amount").val();
		if(ytb<100 || eval(ytb%100)!=0){
			layer.msg("只能充值100的整数倍！",{icon:2});
			return false;
		}else{
			$("#realMoney").text(eval(ytb/100)+"元  人民币");
			return true;			
		}
		
	} 
    jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }

    //弹窗
    function showDialog(){
        $(".masker").height($(document).height()).fadeIn();
        $(".masker").fadeIn();
        $(".payment").center().fadeIn();

    }
    
    //关闭弹窗
    function cancel(){
    	  $(".masker").hide();
    	  $(".payment").hide();
    }
    
    //重新提交
    function resubmit(){
    	$("#toPayForm").submit();
    }
</script>
</html>