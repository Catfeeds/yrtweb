<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>订单管理</li>
		<li>订单列表</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="orderForm">
							<div class="dataTables_filter" id="DataTables_Table_0_filter">
								<label>订单编号: <input type="text" name="order_sn" value="${params.order_sn}"></label>
								<label>是否发送订单: 
									<yt:dictSelect name="order_ifsend" nodeKey="status" value="${params.order_ifsend}"></yt:dictSelect>
								</label>
								<label>是否中奖: 
									<yt:dictSelect name="order_ifwin" nodeKey="status" value="${params.order_ifwin}"></yt:dictSelect>
								</label>
								<label>是否确认地址: 
									<yt:dictSelect name="order_ifcheck" nodeKey="status" value="${params.order_ifcheck}"></yt:dictSelect>
								</label>
								<label>
								&emsp;中奖确认时间:
								<input type="text" class="form-control ui_timepicker" style="width: 35%;display: inline-block;"
										value="${params.begin_time}" 
										id="begin_time" name="begin_time" data-date-format="yyyy-mm-dd HH:mm:ss"/>--
								
								<input type="text" class="form-control ui_timepicker" style="width: 35%;display: inline-block;"
										value="${params.end_time}" 
										id="end_time" name="end_time" data-date-format="yyyy-mm-dd HH:mm:ss"/>	
								</label>			
								<a onclick="ListPage.search()" class="btn btn-success">
									<i class="fa">查询</i>                                     
								</a>
								<a onclick="ListPage.resetSearch()" class="btn">
									<i class="fa">重置</i>                                        
								</a>
								<a onclick="toExcel();" class="btn">
									<i class="fa fa-download"> 导出</i>                                        
								</a>
							</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>订单编号</th>
							  <th>用户名称</th>
							  <th>商品名称</th>
							  <th>商品期号</th>
							  <th>确认中奖时间</th>
							  <th>是否中奖</th>
							  <th>是否确认地址</th>
							  <th>是否发送订单</th> 
							  <th>操作</th>                                         
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="item">
						<tr>
							<td>${item.order_sn}</td>
							<td><yt:userName id="${item.user_id}"></yt:userName></td>
							<td>${item.product_title}</td>
							<td>${item.data_sn}</td>
							<td>${item.order_check_time}</td>
							<td><yt:dict2Name key="${item.order_ifwin}" nodeKey="status"></yt:dict2Name></td>
							<td><yt:dict2Name key="${item.order_ifcheck}" nodeKey="status"></yt:dict2Name></td>
							<td><yt:dict2Name key="${item.order_ifsend}" nodeKey="status"></yt:dict2Name></td> 
							<td>
							<a class="btn btn-info" title="编辑" onclick="detail('${item.order_id}')">
									<i class="fa fa-edit"> 编辑</i> 
								</a>
							</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->

<script type="text/javascript">
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

	var iframeUserInfo;
	function detail(id){
		iframeUserInfo = layer.open({
		    type: 2,
		    title: '订单详情',
		    shadeClose: true,
		    shade: [0],
		    area: ['1000px', '640px'],
		    content: base+'/admin/shop/orderForm?id='+id //iframe的url
		}); 
	}
	
	function refreshList(){
		ListPage.paginate(ListPage.currentPage);
	}
	
	//导出excel
	function toExcel(){
		var jsondata = $("#orderForm").serializeObject();
		window.location.href = base+"/admin/shop/excel?order_sn="+jsondata.order_sn
				+"&order_ifsend="+jsondata.order_ifsend
				+"&order_ifcheck="+jsondata.order_ifcheck
				+"&begin_time="+jsondata.begin_time
				+"&end_time="+jsondata.end_time;
	}
</script>

