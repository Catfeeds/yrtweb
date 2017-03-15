<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>奖金发放</li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league.id}','#leagueForm','/admin/league/saveLeague','${league.id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league.id}"></yt:id2NameDB>
			</a>
		</li>
		<li>信息发送记录</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
							<div class="dataTables_filter" id="DataTables_Table_0_filter">
								<input type="hidden" name="league_id" value="${params.league_id}">
								<label>轮次 ： <input type="text" name="rounds" value="${params.rounds}"></label>
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
							  <th>俱乐部名称</th>
							  <th>轮次</th>
							  <th>状态</th>
							  <th>发送时间</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="salary">
						<tr>
							<td>${salary.league_name}</td>
							<td>${salary.team_name }</td>
							<td>${salary.turn_num }</td>
							<td>
								<c:choose>
									<c:when test="${salary.status eq '1'}"><span style="color: green;">发送成功</span></c:when>
									<c:otherwise><span style="color: red;">发送失败</span></c:otherwise>
								</c:choose>
							</td>
							<td>
							<fmt:formatDate value="${salary.create_time}" pattern="yyyy-MM-dd HH:mm:ss" />
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
