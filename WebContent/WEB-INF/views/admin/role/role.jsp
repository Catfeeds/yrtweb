<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">系统管理</a></li>
		<li><a href="">角色管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/role/formJsp','#roleEditForm','${ctx}/admin/role/saveOrUpdate')"
					style="cursor: pointer;">添加角色</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="roleForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>角色名称: <input type="text" name="role_name" value="${params.role_name}"></label>
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
							  <th>角色ID</th>
							  <th>角色名称</th>
							  <th>角色标识</th>
							  <th>是否后台权限</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="role">
						<tr>
							<td>${role.role_id}</td>
							<td>${role.role_name}</td>
							<td>${role.role_str}</td>
							<td>
								<c:choose>
									<c:when test="${role.role_state==1}">
										是
									</c:when>
									<c:otherwise>
										否
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<a class="btn btn-info" title="修改" onclick="ListPage.form('${ctx}/admin/role/formJsp','#roleEditForm','${ctx}/admin/role/saveOrUpdate','${role.role_id}')">
									<i class="fa fa-edit "> 修改</i>  
								</a>
								<a class="btn btn-info" title="资源" onclick="ListPage.form('${ctx}/admin/role/roleResources','#roleResForm','${ctx}/admin/role/saveRoleRes','${role.role_id}')">
									<i class="fa fa-search-plus"> 资源</i> 
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/role/deleteRole','${role.role_id}')">
									<i class="fa fa-trash-o "> 删除</i> 
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
