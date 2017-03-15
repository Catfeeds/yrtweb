<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/chargeCenter.css" rel="stylesheet" />
<title>支付中心</title>
<c:set var="currentPage" value="PAYCENTER"/>
</head>
<body>
<div class="warp">
	<!-- 头部 -->
	<%@include file="../common/header.jsp" %>
	<!--导航 start-->
	<%@ include file="../common/naver.jsp" %>  
	<div class="wrapper" style="margin-top: 30px;">
		 <!--页面主体-->
         <div class="container ms">
             <div class="middle">
            	 <%@include file="left.jsp" %>	
            	 <!--右边内容-->
               		<div class="content ms f14">
               			<div class="content_top">
               				<div class="title ms">
               					<span>支付中心</span>
               				</div>
               			</div>
               			<!--选择支付方式-->
               			<div class="paymentPanel">
               				<form id="toPayForm" method="POST" action="${ctx }/account/toBankPay" onsubmit="return submit_();"  target="_blank">
	               				<input type="hidden" id="price" name="price" value="${price}"/><!-- 商品单价 -->
	               				<input type="hidden" name="osn" value="${osn}"/><!-- 订单号 -->
               					<input type="hidden" name="productName" value="${productName}"/><!-- 商品名称 -->
	               				<div class="detail">
	               					<span>有效期</span>
	               					<span class="ml35">
	               						<select name="date" onchange="selectChange(this)">
	               							<option value="0">请选择</option>
	               							<option value="1">一个月</option>
	               							<option value="3">三个月</option>
	               							<option value="6">半年</option>
	               							<option value="12">一年</option>
	               						</select>
	               					</span>
	               					<span class="ml70">价格</span>
	               					<input type="hidden" name="amount" id="amount" value=""/>
	               					<span class="ml35" id="amountText">0.00</span>元
	               				</div>
	               				<div class="paymentWays">
	               					<ul style="height: 32px;">
	               						<li style="width: 122px;" class="active">在线支付</li>
	               					</ul>
	               					<br />
	               					<table class="ml30">
	               						<tr>
	               							<td>
	               								<input type="radio" id="alipay" name="xzyh" value="alipay" checked="checked"/> 
	               								<label for="alipay"><img alt="支付宝" src="${ctx}/resources/images/bank1.png" /></label>
	               							</td>
	               						</tr>
	               					</table>
	               				</div>
	               				<div class="payWays_next">
	               						<button type="submit">
	               							<span class="">支付</span>
	               						</button>
	               				</div>
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
	function selectChange(dom){
		var date = $(dom).children(":selected").val();/* 购买时间 */
		var price = $("#price").val();
		var sumAmount = (price*date).toFixed(2);
		$("#amountText").text(sumAmount);
		$("#amount").val(sumAmount);
	}

	function submit_(){
		if($("#amount").val()==0 || $("#amount").val()==''){
			layer.msg("价格不能为0",{icon: 0});
			return false;
		}
	}
</script>
</html>