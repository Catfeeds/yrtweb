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
		<li><a href="">联赛俱乐部积分管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/teamIntegral/formJsp','#integralEditForm','${ctx}/admin/teamIntegral/saveOrUpdate')" 
				 style="cursor: pointer;">添加</a><span class="break"></span></h2>
				 <h2><a onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" 
				 style="cursor: pointer;">返回</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>俱乐部: <input type="text" name="tname" value="${params.tname}"></label>
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
							  <th>积分表</th>
							  <th>联赛</th>
							  <th>分组</th>
							  <th>俱乐部</th>
							  <th>比赛场次总数</th>
							  <th>赢取场次</th>
							  <th>输场次</th>
							  <th>平场次</th>
							  <th>进球数</th>
							  <th>失球数</th>
							  <th>总积分</th>
							  <th>排名</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="integral">
						<tr>
							<td>${integral.id}</td>
							<td>${integral.lname}</td>
							<td>${integral.gname}</td>
							<td>${integral.tname}</td>
							<td>${integral.games}</td>
							<td>${integral.win_games}</td>
							<td>${integral.lose_games}</td>
							<td>${integral.flat_games}</td>
							<td>${integral.in_ball}</td>
							<td>${integral.lose_ball}</td>
							<td>${integral.sum_integral}</td>
							<td>${integral.ranking}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/teamIntegral/formJsp','#integralEditForm','${ctx}/admin/teamIntegral/saveOrUpdate','${integral.id}')">
									<i class="fa fa-edit "> 编辑</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/teamIntegral/delete','${integral.id}')">
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

