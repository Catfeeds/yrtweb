<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>报名主题</li>
		<li>数据列表</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/sign/signCfgForm','#signCfgForm','${ctx}/admin/sign/saveSignCfg')" 
					style="cursor: pointer;">新增</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>主题 ： <input type="text" name="title" value=""></label>
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
							  <th>主题</th>
							  <th>创建人</th>
							  <th>创建时间</th>
							  <th>开始时间</th>
							  <th>结束时间</th>
							  <th>url关键字</th>
							  <th>是否显示</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="sign">
							<tr>
								<td>${sign.title}</td>
								<td><yt:userName id="${sign.user_id}"/></td>
								<td><fmt:formatDate value="${sign.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><fmt:formatDate value="${sign.start_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><fmt:formatDate value="${sign.end_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td>${sign.keyword}</td>
								<td>
									<yt:dict2Name nodeKey="status" key="${sign.if_show}"></yt:dict2Name>
								</td>
								<td>
									<a class="btn btn-info" title="人员统计" onclick="ListPage.enter({context:'#content',url:'/admin/sign/showSign?sign_id=${sign.id}',searchForm:'#searchForm'});">
										<i class="fa fa-users"> 人员</i> 
									</a>
									<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/sign/signCfgForm','#signCfgForm','${ctx}/admin/sign/saveSignCfg','${sign.id}')">
										<i class="fa fa-credit-card"> 编辑</i> 
									</a>
									<!-- <a class="btn btn-inverse" title="下载" onclick="">
										<i class="fa fa-download"> 下载</i> 
									</a> -->
									<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/sign/delSignCfg','${sign.id}')">
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
