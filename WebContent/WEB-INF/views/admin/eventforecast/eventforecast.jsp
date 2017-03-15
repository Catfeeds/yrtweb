<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛信息管理</a></li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league_id}','#leagueForm','/admin/league/saveLeague','${league_id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league_id}"></yt:id2NameDB>
			</a>
		</li>	
		<li><a href="${ctx}/admin/eventForecast">赛事预告</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="ListPage.form('${ctx}/admin/eventForecast/formJsp','#_itemEditForm','${ctx}/admin/eventForecast/saveOrUpdate')" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 添加</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>俱乐部名称: <input type="text" name="teaminfo_name" value="${params.teaminfo_name}"></label>
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
							<a class="btn btn-success" onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" style="cursor: pointer;">
								<i class="fa">返回</i>                                     
							</a>
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>联赛ID</th>
							  <th>主场俱乐部ID</th>
							  <th>主队名称</th>
							  <th>客场俱乐部ID</th>
							  <th>客队名称</th>
							  <th>比赛时间</th>
							  <th>比赛赛制</th>
							  <th>第几轮</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="_item">
						<tr>
							<td>${_item.league_id}</td>
							<td>${_item.m_teaminfo_id}</td>
							<td>${_item.m_team_name}</td>
							<td>${_item.g_teaminfo_id}</td>
							<td>${_item.g_team_name}</td>
							<td>${_item.play_time}</td>
							<td>${_item.ball_format}</td>
							<td>${_item.rounds}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/eventForecast/formJsp','#_itemEditForm','${ctx}/admin/eventForecast/saveOrUpdate','${_item.id}')">
									<i class="fa fa-edit"> 编辑</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/eventForecast/delete','${_item.id}')">
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
