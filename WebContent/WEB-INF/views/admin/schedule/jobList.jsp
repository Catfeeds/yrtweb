<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">系统管理</a></li>
		<li><a href="">任务列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/schedule/jobForm','#jobForm','${ctx}/admin/schedule/saveOrUpdateJob')"
					 	style="cursor: pointer;">添加任务</a></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>任务描述 ： <input type="text" name="remark" value="${params.remark}"></label>
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
							  <th>任务分组</th>
							  <th>任务标志(关联表ID)</th>
							  <th>任务运行时间表达式 </th>
							  <th>任务描述</th>
							  <th>实现类</th>
							  <th>任务状态</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="job">
						<tr>
							<td>${job.id}</td>
							<td><yt:dict2Name nodeKey="job_group" key="${job.job_group}"></yt:dict2Name></td>
							<td>${job.job_name}</td>
							<td>${job.cron_expression}</td>
							<td>${job.remark}</td>
							<td><yt:dict2Name nodeKey="class_name" key="${job.class_name}"></yt:dict2Name></td>
							<td><yt:dict2Name nodeKey="job_status" key="${job.job_status}"></yt:dict2Name></td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/schedule/jobForm?id=${job.id}','#jobForm','${ctx}/admin/schedule/saveOrUpdateJob','${job.id}')">
									<i class="fa fa-edit"> 编辑</i> 
								</a>
								<a class="btn btn-danger" title="暂停" onclick="ListPage.confirm('是否暂停任务？','${ctx}/admin/schedule/stopJobForm',{id:'${job.id}'})">
									<i class="fa fa-pause"> 暂停</i> 
								</a>
								<a class="btn btn-info" title="恢复" onclick="ListPage.confirm('是否恢复任务？','${ctx}/admin/schedule/resumeJobForm',{id:'${job.id}'})">
									<i class="fa fa-play"> 恢复</i> 
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/schedule/deleteJobForm','${job.id}')">
									<i class="fa fa-trash-o"> 删除</i> 
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
