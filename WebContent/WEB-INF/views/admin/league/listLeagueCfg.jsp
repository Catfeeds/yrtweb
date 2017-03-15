<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛管理</a></li>
		<li><a href="">联赛分类列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2>
					<i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
					<a onclick="ListPage.form('${ctx}/admin/league/cfgForm','#leagueCfgForm','${ctx}/admin/league/saveLeagueCfg')" style="cursor: pointer;">创建联赛分类</a><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>年份</th>
							  <th>区域</th>
							  <th>赛季</th>
							  <th>赛季开始时间</th>
							  <th>赛季结束时间</th>
							  <th>赛季状态</th>
							  <th>是否结算</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="cfg">
						<tr>
							<td>${cfg.year}</td>
							<td><yt:areaName code="${cfg.area_code}"/></td>
							<td><yt:dict2Name nodeKey="season" key="${cfg.season}"/></td>
							<td><fmt:formatDate value="${cfg.s_starttime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${cfg.s_endtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<yt:dict2Name nodeKey="l_status" key="${cfg.status}"></yt:dict2Name>
							</td>
							<td>
								<yt:dict2Name nodeKey="status" key="${cfg.if_balance}"></yt:dict2Name>
							</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/league/cfgForm?id=${cfg.id}','#leagueCfgForm','${ctx}/admin/league/saveLeagueCfg','${cfg.id}')">
									<i class="fa fa-credit-card"> 编辑</i> 
								</a>
								<a class="btn btn-info" title="管理" onclick="ListPage.form('${ctx}/admin/league/leagueCfgOpt?id=${cfg.id}','#leagueCfgForm','${ctx}/admin/league/saveLeagueCfg','${cfg.id}')">
									<i class="fa fa-gear"> 配置</i> 
								</a>
								<a class="btn btn-info" title="联赛" onclick="ListPage.enter({context:'#content',url:'/admin/league/listLeague?s_id=${cfg.id}',searchForm:'#searchForm'});">
									<i class="fa fa-adn"> 联赛</i> 
								</a>
								<a class="btn btn-info" onclick="ListPage.enter({context:'#content',url:'/admin/interface/leagueCount',searchForm:'#searchForm'});">
									<i class="fa fa-file"> 接口</i>
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
