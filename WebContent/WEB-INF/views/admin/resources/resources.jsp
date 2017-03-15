<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">系统管理</a></li>
		<li><a href="">资源管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/resources/formJsp','#resourcesEditForm','${ctx}/admin/resources/saveOrUpdate')" 
				 style="cursor: pointer;">添加资源</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="resourcesForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>资源名称: <input type="text" name="res_name" value="${params.res_name}"></label>
							<label>上级资源: <input id="res_parentid" type="hidden" name="res_parentid" value="${params.res_parentid}"/><input id="parent_name" name="parent_name" type="text" value="${params.parent_name}" readonly="readonly">
								<div id="select_tree" style="display:none;margin-left:63px;position:absolute;background:#fff none repeat scroll 0 0;border:1px solid #e5e5e5;cursor:pointer;z-index:5;">
								</div>
							</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
							<script type="text/javascript">$("#query_parent_id").val('${params.res_parentid}')</script>
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>资源ID</th>
							  <th>资源名称</th>
							  <th>上级资源</th>
							  <th>资源URL</th>
							  <th>资源序号</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="res">
						<tr>
							<td>${res.res_id}</td>
							<td>${res.res_name}</td>
							<td>${res.parentName}</td>
							<td>${res.res_url}</td>
							<td>${res.res_sort}</td>
							<td>
								<a class="btn btn-info" title="修改" onclick="ListPage.form('${ctx}/admin/resources/formJsp','#resourcesEditForm','${ctx}/admin/resources/saveOrUpdate','${res.res_id}')">
									<i class="fa fa-edit "> 修改</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/resources/delete','${res.res_id}')">
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
<script type="text/javascript">
ListPage.select_tree("#select_tree",{
		url:'${ctx}/admin/role/queryResources',
		name:'res_name',
		idKey:'res_id',
		pIdKey:'res_parentid',
		input_id:'parent_name'
	},function(e,tid,treeNode){
	$("#res_parentid").val(treeNode.res_id);
	$("#parent_name").val(treeNode.res_name);
	$("#select_tree").hide();
});
</script>
