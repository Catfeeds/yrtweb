<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>宇任拓管理系统</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="${ctx}/resources/admin/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/font-awesome.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/jquery-ui-1.10.3.custom.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/fullcalendar.css" rel="stylesheet">	
	<link href="${ctx}/resources/layer/skin/layer.css" rel="stylesheet">
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="http://localhost:8888/bootstrap/perfectum2/img/favicon.ico">
	<!-- end: Favicon -->
	
	<script src="${ctx}/resources/admin/js/jquery-2.0.3.min.js"></script>
	<script type="text/javascript">
		window.jQuery || document.write("<script src='${ctx}/resources/admin/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
	</script>
	<script src="${ctx}/resources/admin/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${ctx}/resources/admin/js/bootstrap.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.knob.modified.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.pie.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.stack.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.resize.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.time.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.sparkline.min.js"></script>
	<script src="${ctx}/resources/admin/js/fullcalendar.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.gritter.min.js"></script>
	<script src="${ctx}/resources/admin/js/default.min.js"></script>
	<script src="${ctx}/resources/admin/js/core.min.js"></script>
	<script src="${ctx}/resources/layer/layer.js"></script>
	<script src="${ctx}/resources/js/base.js"></script>
	<script src="${ctx}/resources/js/yt.ext.js"></script>
	<script src="${ctx}/resources/js/yt.core.js"></script>
	<script src="${ctx}/resources/js/validation.js"></script>
	<script src="${ctx}/resources/admin/js/jquery-ui-timepicker-addon.js"></script>
    <script src="${ctx}/resources/admin/js/jquery-ui-timepicker-zh-CN.js"></script>
</head>
<body>
			<div class="box">
				<div class="box-header" align="center"><h3>订单详情</h3></div>
				<div class="box-content">
					<form id="orderForm" method="post" class="form-horizontal">
						<input type="hidden" name="order_id" value="${orderForm.order_id}"/>
						<table class="table table-bordered table-striped table-condensed" style="width:90%;" align="center">
							<tr>
								<td width="15%"><span class="red">订单编号：</span></td>
								<td width="35%">${orderForm.order_sn}</td>
								<td width="15%">商品期号：</td>
								<td>${orderForm.data_sn}</td>
							</tr>
							<tr>
								<td width="15%">商品名称：</td>
								<td colspan="3">${orderForm.product_title}</td>
							</tr>
							<tr>
								<td width="15%">商品简介：</td>
								<td colspan="3">${orderForm.product_second_title}</td>
							</tr>
							<tr>
								<td width="15%">购买用户：</td>
								<td><yt:userName id="${orderForm.user_id}"></yt:userName></td>
								<td width="15%">下单时间：</td>
								<td><fmt:formatDate value="${orderForm.create_time}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							</tr>
							<tr>
								<td width="15%">支付宇拓币：</td>
								<td>${orderForm.order_cash}</td>
								<td width="15%">实际支付宇拓币：</td>
								<td>${orderForm.order_actual_cash}</td>
							</tr>
							<tr>
								<td width="15%">夺宝号码：</td>
								<td><div style="width:300px;word-break:break-all;">${orderForm.order_nums}</div></td>
								<td width="15%">购买次数：</td>
								<td>${orderForm.order_count}</td>
							</tr>
							<tr>
								<td width="15%">是否中奖：</td>
								<td><span style="color: red;"><yt:dict2Name key="${orderForm.order_ifwin}" nodeKey="status"></yt:dict2Name></span></td>
								<td width="15%">中奖号码：</td>
								<td><span style="color: blue;">${orderForm.data_win_num}</span></td>
							
							</tr>
							<tr>
								<td width="15%">用户订单状态：</td>
								<td>
									<yt:dictSelect name="order_status" nodeKey="order_status" value="${orderForm.order_status}" clazz="form-control" required="require"></yt:dictSelect>
								</td>
								<td width="15%">订单是否有效：</td>
								<td>
									<yt:dictSelect name="order_ifvalid" nodeKey="status" value="${orderForm.order_ifvalid}" clazz="form-control"></yt:dictSelect>
								</td>
							</tr>
							<c:if test="${orderForm.order_ifwin eq 1}">
							<tr>
								<td width="15%">是否确认地址：</td>
								<td><span style="color: red;"><yt:dict2Name key="${orderForm.order_ifcheck}" nodeKey="status"/></span></td>
								<td width="15%">确认时间：</td>
								<td><fmt:formatDate value="${orderForm.order_check_time}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							</tr>
							<tr>
								<td width="15%">收货人姓名：</td>
								<td>${orderForm.order_user_name}</td>
								<td width="15%">收货人电话：</td>
								<td>${orderForm.order_user_phone}</td>
							</tr>
							<tr>
								<td width="15%">收货地址：</td>
								<td colspan="3">${orderForm.order_address}</td>
							</tr>
							<tr>
								<td width="15%">用户留言：</td>
								<td colspan="3">${orderForm.order_user_offer}</td>
							</tr>
							<tr>
								<td width="15%">是否发送订单：</td>
								<td>
									<yt:dictSelect name="order_ifsend" nodeKey="status" value="${orderForm.order_ifsend}" clazz="form-control" required="require"></yt:dictSelect>
								</td>
								<td width="15%">发货时间：</td>
								<td>
									<input type="text" class="form-control ui_timepicker" 
										value="<fmt:formatDate value='${orderForm.order_send_time}' pattern='yyyy-MM-dd HH:mm:ss' />" 
										name="order_send_time" data-date-format="yyyy-mm-dd HH:mm:ss">
								</td>
							</tr>
							<tr>
								<td width="15%">快递公司：</td>
								<td><input type="text" name="order_send" value="${orderForm.order_send}" class="form-control"></td>
								<td width="15%">货号：</td>
								<td>
									<c:choose>
										<c:when test="${empty orderForm.order_send_no}">
											<input type="text" name="order_send_no" value="${orderForm.product_no}" valid="require" class="form-control">
										</c:when>
										<c:otherwise>
											<input type="text" name="order_send_no" value="${orderForm.order_send_no}" valid="require" class="form-control">
										</c:otherwise>
									</c:choose>
									</td>
							</tr>
							<tr>
								<td width="15%">运费（￥）：</td>
								<td colspan="3"><input type="text" name="order_send_cash" value="${orderForm.order_send_cash}" valid="number" class="form-control"></td>
							</tr>
							</c:if>
							<tr>
								<td colspan="4">
									<a class="btn btn-primary" onclick="saveOrder()">保存</a>
									<a class="btn btn-danger" onclick="closeOrder()">取消</a>
								</td>
							</tr>					
						</table>
					</form>
				</div>
			</div>
<script>
	$(".ui_timepicker").datetimepicker({
	    //showOn: "button",
	    //buttonImage: "./css/images/icon_calendar.gif",
	    //buttonImageOnly: true,
	    showSecond: true,
	    timeFormat: 'hh:mm:ss',
	    stepHour: 1,
	    stepMinute: 1,
	    stepSecond: 1
	});
	
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	function saveOrder(){
		$.ajax({
			context:$("#orderForm"),
			url:base+"/admin/shop/saveOrder",
			data:$("#orderForm").serialize(),
			dataType:"json",
			success:function(data){
				if(data.state=="success"){
					layer.msg(data.message.success[0],{icon:1,time:1000},function(){
						//关闭后的操作
						parent.refreshList();
						parent.layer.close(index);
					});
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
			}
		});
	}
	
	function closeOrder(){
		parent.layer.close(index);
	}
</script>

</body>
</html>