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
		<li><a href="">联赛分组管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a style="cursor: pointer;" title="添加" onclick="ListPage.form('${ctx}/admin/leagueGroup/formJsp','#groupsEditForm','${ctx}/admin/leagueGroup/saveOrUpdate')" ><span>添加</span></a><span class="break"></span></h2>
				<h2><a style="cursor: pointer;" title="返回" onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" ><span>返回</span></a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>分组名称: <input type="text" name="name" value="${params.name}"></label>
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
							  <th>分组ID</th>
							  <th>联赛名称</th>
							  <th>分组名称</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="groups">
						<tr>
							<td>${groups.id}</td>
							<td>${groups.lname}</td>
							<td>${groups.name}</td>
							<td>
								<a class="btn btn-info" title="分组" onclick="ListPage.form('${ctx}/admin/leagueGroup/toEditGroup','#teamsForm','${ctx}/admin/leagueGroup/editGroup','${groups.league_id}')">
									<i class="fa fa-edit "> 分组</i>  
								</a>
								<a class="btn btn-info" title="赛程" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/eventRecord/newEventList?id=${groups.league_id}&group_id=${groups.id}'});">
									<i class="fa fa-list "> 赛程</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/leagueGroup/delete','${groups.id}')">
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
