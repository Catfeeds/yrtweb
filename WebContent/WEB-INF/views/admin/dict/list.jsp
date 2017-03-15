<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛管理</a></li>
		<li><a href="">字典管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/dict/dictForm','#dictForm','${ctx}/admin/dict/saveDict')"
					 	style="cursor: pointer;">添加</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="dictForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>字典标识: <input type="text" name="dict_column" value="${params.dict_column}"></label>
							<label>字典描述: <input type="text" name="dict_desc" value="${params.dict_desc}"></label>
							<label>父节点id: <input type="text" name="parent_id" value="${params.parent_id}"></label>
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
							  <th>id</th>
							  <th>字典标识</th>
							  <th>字典描述</th>
							  <th>字典编号</th>
							  <th>字典含义</th>
							  <th>父节点id</th>
							  <th>排序</th>
							  <th>是否叶子节点 </th>
							  <th>是否有效</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="dict">
						<tr>
							<td>${dict.id}</td>
							<td>${dict.dict_column}</td>
							<td>${dict.dict_desc}</td>
							<td>${dict.dict_value}</td>
							<td>${dict.dict_value_desc}</td>
							<td>${dict.parent_id}</td>
							<td>${dict.dict_sort}</td>
							<td>${dict.if_leaf}</td>
							<td>${dict.dict_flag}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/dict/dictForm?id=${dict.id}','#dictForm','${ctx}/admin/auction/saveDict','${dict.id}')">
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
