<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>工资管理</li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league_id}','#leagueForm','/admin/league/saveLeague','${league_id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league_id}"></yt:id2NameDB>
			</a>
		</li>
		<li>工资详情</li>
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
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>轮次</th>
							  <th>俱乐部名称</th>
							  <th>发放人数</th>
							  <th>应发总额</th>
							  <th>实发总额</th>
							  <th>发放时间</th>
							  <th>是否发放</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="salary">
						<tr>
							<td>${salary.turn_num}</td>
							<td>${salary.teamname }</td>
							<td>${salary.userCount }</td>
							<td>${salary.sumsalary}</td>
							<td>${salary.sum_realsalary}</td>
							<td>${salary.send_time}</td>
							<td>
								<c:choose>
									<c:when test="${salary.status == 1}"><span style="color: green;">是</span></c:when>
									<c:otherwise><span style="color: red;">否</span></c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:if test="${salary.status == 0}">
									<a href="javascript:void(0)" onclick="ListPage.confirm('是否发送？','/admin/league/pressManager',{league_id:'${salary.league_id}',turn_num:'${salary.turn_num}',teaminfo_id:'${salary.teaminfo_id}'})"
									  class="btn btn-info"><i class="fa fa-envelope-o">催发</i></a>
								</c:if>
							</td>                                       
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
				 <div>
					<a style="cursor: pointer;" class="btn btn-success" onclick="ListPage.enter({context:'#content',url:'/admin/league/salaryManage?league_id=${league_id}',searchForm:'#searchForm'});">
						<i class="fa">返回</i>                                     
					</a>
				</div>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->