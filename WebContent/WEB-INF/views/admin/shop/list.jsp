<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">系统管理</a></li>
		<li><a href="">产品管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/product/productForm','#editForm','${ctx}/admin/product/saveProduct')"
						style="cursor: pointer;">添加</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="dictForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>产品名称: <input type="text" name="p_name" value="${params.p_name}"></label>
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
							  <th>产品代码</th>
							  <th>产品名称</th>
							  <th>图片地址</th>
							  <th>上架状态</th>
							  <th>魅力值</th>
							  <th>价格</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="item">
						<tr>
							<td>${item.id}</td>
							<td>${item.p_code}</td>
							<td>${item.p_name}</td>
							<td>${item.image_src}</td>
							<td>${item.status}</td>
							<td>${item.charm_value}</td>
							<td>${item.p_price}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/product/productForm?id=${item.id}','#editForm','${ctx}/admin/product/updateProduct','${item.id}')">
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
