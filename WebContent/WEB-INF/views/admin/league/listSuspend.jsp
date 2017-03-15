<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>联赛管理</li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league_id}','#leagueForm','/admin/league/saveLeague','${league_id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league_id}"></yt:id2NameDB>
			</a>
		</li>
		<li>禁赛列表</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/league/toSuspend?league_id=${league.id}','#suspendForm','${ctx}/admin/league/saveOrUpdateSuspend')" 
				style="cursor: pointer;">添加禁赛球员</a><span class="break"></span></h2>
				<h2><a onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" 
				style="cursor: pointer;">返回</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
							<div class="dataTables_filter" id="DataTables_Table_0_filter">
								<label>昵称 ： <input type="text" name="usernick" value="${params.usernick}"></label>
								<label>姓名 ： <input type="text" name="username" value="${params.username}"></label>
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
							  <th>球员昵称</th>
							  <th>球员名称</th>
							  <th>禁赛开始时间</th>
							  <th>禁赛结束时间</th>
							  <th>禁赛创建时间</th>
							  <th>禁赛状态是否生效</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="suspend">
						<tr>
							<td>${suspend.usernick}</td>
							<td>${suspend.username}</td>
							<td><fmt:formatDate value="${suspend.begin_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${suspend.end_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${suspend.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<yt:dict2Name nodeKey="status" key="${suspend.status}"></yt:dict2Name>
							</td>
							<td>
								<a class="btn btn-success" title="编辑" onclick="ListPage.form('${ctx}/admin/league/toSuspend?league_id=${league.id}','#suspendForm','${ctx}/admin/league/saveOrUpdateSuspend','${suspend.id}')">
									<i class="fa fa-credit-card"> 编辑</i> 
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/league/deleteSuspend','${suspend.id}')">
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
