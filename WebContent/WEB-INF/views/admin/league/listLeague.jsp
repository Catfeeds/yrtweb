<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛管理</a></li>
		<li><a href="">联赛列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2>
					<i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
					<a onclick="ListPage.form('${ctx}/admin/league/leagueForm','#leagueForm','${ctx}/admin/league/saveLeague')" style="cursor: pointer;">创建联赛</a><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>联赛名称 ： <input type="text" name="name" value="${param.name}"></label>
							<label>联赛状态 ： 
									<yt:dictSelect nodeKey="l_status" name="status" value="${param.status}"></yt:dictSelect>
							</label>
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
							  <th>城市</th>
							  <th>联赛简称</th>
							  <th>联赛名称</th>
							  <th>联赛状态</th>
							  <th>赛制</th>
							  <th>联赛开始时间</th>
							  <th>联赛结束时间</th>
							  <!-- <th>验证码期限</th> -->
							  <th>前台是否展示</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="league">
						<tr>
							<td>${league.id}</td>
							<td><yt:areaName code="${league.city}"/></td>
							<td>${league.simple_name}</td>
							<td>${league.name}</td>
							<td>
								<yt:dict2Name nodeKey="l_status" key="${league.status}"></yt:dict2Name>
							</td>
							<td>${league.ball_format}</td>
							<td><fmt:formatDate value="${league.bg_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${league.end_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<%-- <td><fmt:formatDate value="${league.s_starttime}" pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
							<%-- <td><fmt:formatDate value="${league.s_endtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
							<td>
								<yt:dict2Name nodeKey="status" key="${league.if_show}"></yt:dict2Name>
							</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/league/leagueForm?id=${league.id}','#leagueForm','${ctx}/admin/league/saveLeague','${league.id}')">
									<i class="fa fa-credit-card"> 编辑</i> 
								</a>
								<a class="btn btn-info" title="管理" onclick="ListPage.form('${ctx}/admin/league/leagueOpt?id=${league.id}','#leagueForm','${ctx}/admin/league/saveLeague','${league.id}')">
									<i class="fa fa-gear"> 管理</i> 
								</a>
								<%-- <a class="btn btn-info" title="消息发送" onclick="sendInviteMsg('${league.id}')">
									<i class="fa fa-envelope-o"> 发送</i> 
								</a>
								<a class="btn btn-info" title="消息记录" onclick="ListPage.enter({context:'#content',url:'/admin/league/inviteRecord?id=${league.id}',searchForm:'#searchForm'});">
									<i class="fa fa-calendar"> 记录</i> 
								</a> --%>
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
