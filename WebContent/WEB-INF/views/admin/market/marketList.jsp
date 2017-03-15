<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li><a href="">市场球员</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a style="cursor: pointer;" title="返回" onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueCfgOpt?id=${leagueCfg.id}',searchForm:'#searchForm'});" ><span>返回</span></a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>球员名称: <input type="text" name="username" value="${params.username}"></label>
							<a onclick="ListPage.search()" class="btn btn-info">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn btn-info">
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
							  <th>球员</th>
							  <th>出售价格</th>
							  <th>出售俱乐部</th>
							  <th>是否成交</th>
							  <th>购买者</th>
							  <th>成交日期</th>
							  <th>到期时间</th>
							  <th>是否上架</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="market">
						<tr>
							<td><yt:userName id="${market.user_id}"></yt:userName></td>
							<td>${market.price}</td>
							<td><yt:id2NameDB beanId="teamInfoService" id="${market.team_id}"></yt:id2NameDB></td>
							<td>
								<yt:dict2Name nodeKey="status" key="${market.status}"></yt:dict2Name>
							</td>
							<td><yt:id2NameDB beanId="teamInfoService" id="${market.buyer}"></yt:id2NameDB></td>
							<td><fmt:formatDate value="${market.buy_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${market.end_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<yt:dict2Name nodeKey="status" key="${market.if_up}"></yt:dict2Name>
							</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/market/marketForm?id=${market.id}','#marketForm','${ctx}/admin/market/saveMarket','${market.id}')">
									<i class="fa fa-credit-card"> 编辑</i> 
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
