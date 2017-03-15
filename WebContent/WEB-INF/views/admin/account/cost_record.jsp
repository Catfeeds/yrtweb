<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">账户管理</a></li>
		<li><a href="">充值记录</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2>
				<i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>用户名称: <input type="text" name="username" value="${params.username}"></label>
							<label>手机号: <input type="text" name="phone" value="${params.phone}"></label>
							<label>订单号: <input type="text" name="orderNo" value="${params.orderNo}"></label>
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>序号</th>
							  <th>用户姓名</th>
							  <th>年龄</th>
							  <th>性别</th>
							  <th>所属城市</th>                                          
							  <th>手机号</th>                                          
							  <th>消费金额</th>                                          
							  <th>订单号</th>                                          
							  <th>消费时间</th>                                          
							  <th>消费状态</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${datas}" var="data" varStatus="num">
						<tr>
							<td>${num.index+1}</td>
							<td>${data.username}</td>
							<td>${data.age}</td>
							<td>${data.sex}</td>
							<td>${data.city}</td>
							<td>${data.phone}</td>
							<td>${data.amount}</td>
							<td>${data.order_no}</td>
							<td>${data.create_time}</td>
							<td>${data.status}</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
