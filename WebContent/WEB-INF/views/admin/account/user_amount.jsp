<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">账户管理</a></li>
		<li><a href="">用户资金</a></li>
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
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
							<c:forEach items="${datas}" var="data" begin="0" end="0">
								<span style="float:right;color:green">平台总金额：￥${data.sumAmount}</span>
							</c:forEach>
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
							  <th>手机号</th>                                          
							  <th>总宇币</th>
							  <th>可用宇币</th>
							  <th>赠送宇币</th>                                          
							  <th>总人民币(￥)</th>                                          
							  <th>账户状态</th>                                          
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${datas}" var="data" varStatus="num">
						<tr>
							<td>${num.index+1}</td>
							<td>${data.username}</td>
							<td>${data.phone}</td>
							<td>${data.amount}</td>
							<td>${data.real_amount}</td>
							<td>${data.send_amount}</td>
							<td>${(data.amount-data.send_amount)/100}</td>
							<td>
								<c:choose>
									<c:when test="${data.status eq 1}">可用</c:when>
									<c:otherwise>不可用</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${data.status eq 1}">
										<span style="cursor: pointer;" onclick="updateStatus('${data.id}',0)">禁用</span>
									</c:when>
									<c:otherwise>
										<span style="cursor: pointer;" onclick="updateStatus('${data.id}',1)">启用</span>
									</c:otherwise>
								</c:choose>
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
<script>
	//更新用户资金状态
	function updateStatus(id,num){
		$.ajax({
			type:"POST",
			url:base+"/admin/account/updateStatus?random="+Math.random(),
			data:{"id":id,"status":num},
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
					layer.msg(data.message.success[0],{icon:1});
					setTimeout(function(){
						ListPage.enter();
					},1000);
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
			}
		});
	}
</script>