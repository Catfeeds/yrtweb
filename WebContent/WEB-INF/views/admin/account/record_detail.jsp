<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="javascript:void(0);">账户管理</a></li>
		<li><a href="javascript:void(0);">资金统计</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2>
					平台资金账户统计
				</h2>
			</div>
			<div class="box-content">
				<div class="progressBarValue">
					<span>平台送出资金</span>
					<span class="progressCustomValueVal">￥${sendTotalAmount}</span>
				</div>
				<div class="progressBarValue">
					<span>平台送出资金剩余：</span>
					<span class="progressCustomValueVal">￥${sendLeavingsAmount}</span>
				</div>
				<div class="progressBarValue">
					<span>平台送出资金消耗：</span>
					<span class="progressCustomValueVal">￥${sendUseredAmount}(消耗量小于0表示送出资金已消耗完)</span>
				</div>
				<div class="progressBarValue">
					<span>平台支付宝充值：</span>
					<span class="progressCustomValueVal">￥${depositAmount}</span>
				</div>
				<div class="progressBarValue">
					<span>平台当前总资金：</span>
					<span class="progressCustomValueVal">￥${totalAmount}</span>
				</div>
				<div class="progressBarValue">
					<span>平台盈利：</span>
					<span class="progressCustomValueVal">￥${gainAmount}</span>
				</div>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
