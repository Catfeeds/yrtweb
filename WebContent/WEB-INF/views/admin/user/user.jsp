<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">用户管理</a></li>
		<li><a href="">用户列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>用户昵称: <input type="text" name="usernick" value="${params.usernick}"></label>
							<label>用户姓名: <input type="text" name="username" value="${params.username}"></label>
							<label>用户电话: <input type="text" name="phone" value="${params.phone}"></label>
							<label>用户邮箱: <input type="text" name="email" value="${params.email}"></label>
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
							  <th>用户ID</th>
							  <th>用户昵称</th>
							  <th>用户姓名</th>
							  <th>用户手机</th>
							  <th>用户邮箱</th>
							  <th>创建时间</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="user">
						<tr>
							<td>${user.id}</td>
							<td>${user.usernick}</td>
							<td>${user.username}</td>
							<td>${user.phone}</td>
							<td>${user.email}</td>
							<td>${user.create_time}</td>
							<td>
								<a class="btn btn-info" onclick="ListPage.form('${ctx}/admin/user/roleForm','#userRoleForm','${ctx}/admin/user/updateUserRole','${user.id}')">
									<i class="fa fa-search-plus"> 添加权限</i>  
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
