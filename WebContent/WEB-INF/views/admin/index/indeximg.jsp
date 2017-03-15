<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">皮肤管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="ListPage.form('${ctx}/admin/indexImg/formJsp','#indexEditForm','${ctx}/admin/indexImg/saveOrUpdate')" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 添加图片</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="indexImgForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>标题: <input type="text" name="name" value="${params.name}"></label>&nbsp;&nbsp;&nbsp;&nbsp;
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
							  <th>标题</th>
							  <th>是否显示</th>
							  <th>排序</th>
							  <th>创建人ID</th>
							  <th>创建时间</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="fb">
						<tr>
							<td>${fb.name}</td>
							<td>
								<c:if test="${fb.is_show==1}">
								是
								</c:if>
								<c:if test="${fb.is_show==0}">
								否
								</c:if>
							</td>
							<td>${fb.order_num}</td>
							<td>${fb.user_id}</td>
							<td>${fb.create_time}</td>
							<td>
								<a class="btn btn-info" title="修改" onclick="ListPage.form('${ctx}/admin/indexImg/formJsp','#indexEditForm','${ctx}/admin/indexImg/saveOrUpdate','${fb.id}')">
									<i class="fa fa-edit "></i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/indexImg/delete','${fb.id}')">
									<i class="fa fa-trash-o "></i> 
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

</script>

