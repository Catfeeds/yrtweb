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
		<li><a href="${ctx}/admin/eventRecord">赛程管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<%-- <span onclick="ListPage.form('${ctx}/admin/eventRecord/eventList','#_itemEditForm','${ctx}/admin/eventRecord/saveOrUpdate')" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 添加</span> --%>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>联赛名称: <input type="text" name="league_name" value="${params.league_name}"></label>
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
							  <th>联赛名称</th>
							  <th>比赛赛制</th>
							  <th>联赛状态</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="_item">
						<tr>
							<td>${_item.name}</td>
							<td>${_item.ball_format}人制</td>
							<td><yt:dict2Name nodeKey="l_status" key="${_item.status}"></yt:dict2Name></td>
							<td>											
<%-- 								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/eventRecord/eventList?id=${_item.id}','#_itemEditForm','${ctx}/admin/eventRecord/saveOrUpdate','${_item.id}')"> --%>
									<a class="btn btn-info" title="编辑" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/eventRecord/eventList?id=${_item.id}'});">
									<i class="fa fa-edit"> 赛事</i>  
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
