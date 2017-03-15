<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/chargeCenter.css" rel="stylesheet" />
<title>购买装扮</title>
<c:set var="currentPage" value="MYTEMPLATE"/>
</head>
<body>
<div class="warp">
	<!-- 头部 -->
	<%@include file="../../common/header.jsp" %>
	<div class="wrapper" style="margin-top: 116px;">
		 <!--页面主体-->
         <div class="container ms">
             <div class="middle">
            	 <%@include file="../../system/left.jsp"%>	
            	 <!--右边内容-->
               		<div class="content ms f14">
               			<div class="content_top">
               				<div class="title ms">
               					<span><a href="javascript:void(0)" style="padding-right: 25px;">订单信息</a></span>
               				</div>
               			</div>
               			<!--选择支付方式-->
               			<div class="paymentPanel">
               				<form id="toBuyForm">
               					<input type="hidden" id="dr_id" value="${dr.id }">
               					<input type="hidden" id="name" name="name" value="${dr.name}"/><!-- 商品名称 -->
    						    <input type="hidden" name="money" value="${dr.money}" id="money"/><!-- 购买永久价格 -->
    						    <input type="hidden" name="price" value="${dr.price_month}" id="price"/><!-- 单价 -->
    						    <input type="hidden" name="sumAmount" value="" id="sumAmount"/><!-- 总价价 -->
    						    <input type="hidden" name="count" value="1" /><!-- 购买数量 -->
               					<input type="hidden" id="is_per" name="is_per" value="0"/><!-- 是否购买永久 -->
               					<input type="hidden"  name="order_num" value="${order_num}"/><!-- 是否购买永久 -->
	               				<div class="detail">
	               					<span>订单编号:</span>
	               					<span class="ml35">
	               						${order_num}
	               					</span>
	               				</div>
	               				<div class="paymentWays">
	               					<table class="ml30">
	               						<tr>
	               							<th>商品名称</th>	
	               							<th>单价</th>	
	               							<th>数量</th>	
	               							<th>期限</th>	
	               							<th>总价</th>	
               						    </tr>
               						    <tr>
               						    	<td>${dr.name}</td>
               						    	<td>${dr.price_month}/月</td>
               						    	<td>1</td>
               						    	<td>
               						    		<select onchange="selectChange(this)" name="times">
               						    			<option>--请选择期限--</option>
               						    			<option value="1">1个月</option>
               						    			<option value="3">3个月</option>
               						    			<option value="6">6个月</option>
               						    			<option value="A">永久</option>
               						    		</select>
               						    	</td>
               						    	<td><span id="payAmount"></span></td>
               						    </tr>
	               					</table>
	               				</div>
	               				<div class="payWays_next">
	               						<button type="button" onclick="submit_()">
	               							<span>购买</span>
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
	<%@include file="../../common/footer.jsp" %>
	<!-- footer end -->
</body>
<script type="text/javascript">
	function submit_(){
		var url = base+"/account/tobuyDress/"+$("#dr_id").val();
		$.ajax({
			type:"POST",
			url:url,
			data:$("#toBuyForm").serialize(),
			dataType:"JSON",
			beforeSend:function(data){
				if($("#sumAmount").val()==null || $("#sumAmount").val()=='' || $("#sumAmount").val()==0){
					layer.msg("请选择购买期限",{icon:2});
					return false;
				}
				return true;
			},
			success:function(data){
				if(data.state=="success"){
					layer.msg(data.message.success[0],{icon:1});
					setInterval(function(){
						//跳转到消费记录
						window.location = base+"/account/costRecord";
					},1000);
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
			}
		});
	}
	
	function selectChange(dom){
		if($(dom).val()=="A"){
			$("#payAmount").text($("#money").val());
			$("#sumAmount").val($("#money").val());
			$("#is_per").val(1);
		}else{
			$("#is_per").val(0);
			var sum_amount = eval($("#price").val()*$(dom).val()).toFixed(2);
			if(sum_amount=="NaN"){
				sum_amount=0.00;
			}
			$("#payAmount").text(sum_amount);
			$("#sumAmount").val(sum_amount);
		}
	}
</script>
</html>