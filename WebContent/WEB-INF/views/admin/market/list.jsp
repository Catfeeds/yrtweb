<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">赛季管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li><a href="">交易市场配置列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a style="cursor: pointer;" title="添加" onclick="ListPage.form('${ctx}/admin/market/cfgForm?cfg_id=${leagueCfg.id}','#cfgForm','${ctx}/admin/market/saveMarketCfg')" ><span>添加</span></a><span class="break"></span></h2>
				<h2><a style="cursor: pointer;" title="返回" onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueCfgOpt?id=${leagueCfg.id}',searchForm:'#searchForm'});" ><span>返回</span></a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
						  	  <th>id</th>
							  <th>市场开放时间</th>
							  <th>市场结束时间</th>
							  <th>配置创建时间</th>
							  <th>每次加价价格</th>
							  <th>球队分成</th>
							  <th>球员分成</th>
							  <th>本轮轮次</th>
							  <th>下轮轮次</th>
							  <th>是否开放</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="cfg">
						<tr>
							<td>${cfg.id}</td>
							<td><fmt:formatDate value="${cfg.start_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${cfg.end_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${cfg.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${cfg.per_price}</td>
							<td>${cfg.team_percent}</td>
							<td>${cfg.user_percent}</td>
							<td>${cfg.turn_num}</td>
							<td>${cfg.next_num}</td>
							<td>
								<yt:dict2Name nodeKey="status" key="${cfg.if_open}"></yt:dict2Name>
							</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/market/cfgForm?id=${cfg.id}','#cfgForm','${ctx}/admin/market/saveMarketCfg','${cfg.id}')">
									<i class="fa fa-credit-card"> 编辑</i> 
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/market/deleteCfg','${cfg.id}')">
									<i class="fa fa-trash-o"> 删除</i> 
								</a>
								<a class="btn btn-danger" title="任务" onclick="ListPage.form('${ctx}/admin/schedule/toJob?job_name=${cfg.id}','#jobForm','${ctx}/admin/schedule/saveOrUpdateJob')">
									<i class="fa fa-clock-o"> 任务</i> 
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
