<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">反馈管理</a></li>
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
						<form id="feedbackForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>姓名: <input type="text" name="name" value="${params.name}"></label>&nbsp;&nbsp;&nbsp;&nbsp;
							<label>是否处理: <select id="status" name="status"><option value="">全部</option><option value="1">已处理</option><option value="0">未处理</option></select></label>&nbsp;&nbsp;&nbsp;&nbsp;
							<script type="text/javascript">$("#status").val('${params.status}');</script>
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
							  <th>姓名</th>
							  <th>联系电话</th>
							  <th>联系邮箱</th>
							  <th>反馈内容</th>
							  <th>ip地址</th>
							  <th>创建时间</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="fb">
						<tr>
							<td>${fb.name}</td>
							<td>${fb.phone}</td>
							<td>${fb.email}</td>
							<td>${fb.content}</td>
							<td>${fb.ip_str}</td>
							<td>${fb.create_time}</td>
							<td>
								<c:choose>
									<c:when test="${fb.status==0}">
									<a class="btn btn-info" title="处理" onclick="changeStatus('${fb.id}')">
										<i class="fa fa-edit "></i>  
									</a>
									</c:when>
									<c:otherwise>
									已处理
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
<script type="text/javascript">
function changeStatus(fid){
	layer.confirm('是否处理选中记录？', {
	    btn: ['是','否'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/admin/feedback/changeStatus',
			data: {id: fid},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					layer.msg("处理成功",{icon: 1});
					ListPage.paginate(ListPage.currentPage);
                } else {
                	layer.msg("处理失败",{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}
</script>

