<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>工资管理</li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league.id}','#leagueForm','/admin/league/saveLeague','${league.id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league.id}"></yt:id2NameDB>
			</a>
		</li>	
		<li>工资列表</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="settingSalary('${league.id}')" style="cursor: pointer;">设置</a><span class="break"></span></h2>
				<h2><a onclick="createSalary('${league.id}')" style="cursor: pointer;">生成工资</a><span class="break"></span></h2>
				<h2><a onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league.id}',searchForm:'#searchForm'});" 
					style="cursor: pointer;">返回</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<p>当前联赛工资标准：<span id="league_balance">${league.salary}</span></p>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>轮次</th>
							  <th>俱乐部数</th>
							  <th>生成总额</th>
							  <th>发放总额</th>
							  <th>是否发送</th>
							  <th>是否全部确认</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="salary">
						<tr>
							<td>${salary.turn_num}</td>
							<td>${salary.teams }</td>
							<td>${salary.sumsalary }</td>
							<td>${salary.sumreal_salary}</td>
							<td>
								<c:choose>
									<c:when test="${salary.is_send == salary.teams}"><span style="color: green;">已发送</span></c:when>
									<c:otherwise><span style="color: red;">未发送</span></c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${salary.status == salary.teams}"><span style="color: green;">是</span></c:when>
									<c:otherwise><span style="color: red;">否</span></c:otherwise>
								</c:choose>
							</td>
							<td>
								<a href="javascript:void(0)" onclick="ListPage.enter({context:'#content',url:'/admin/league/turnDetail?league_id=${league.id}&turn_num=${salary.turn_num}',searchForm:'#searchForm'});" class="btn btn-info"><i class="fa fa-search-plus ">查看</i></a>
								<c:if test="${salary.is_send != salary.teams}">
									<a href="javascript:void(0)" onclick="ListPage.confirm('是否发送？','/admin/league/updateSend',{league_id:'${league.id}',turn_num:'${salary.turn_num}'})" class="btn btn-info"><i class="fa fa-envelope-o">发送</i></a>
									<a href="javascript:void(0)" onclick="ListPage.confirm('是否删除工资单？','/admin/league/deleteSalaryTable',{league_id:'${league.id}',turn_num:'${salary.turn_num}'})" class="btn btn-danger"><i class="fa fa-trash-o ">删除</i></a>
								</c:if>
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
<script>
	//设置当前联赛工资标准
	function settingSalary(league_id){
		layer.open({
		    type: 2,
		    title: '联赛工资标准设置',
		    shadeClose: true,
		    shade: 0.8,
		    area: ['560px', '360px'],
		    content: base+'/admin/league/setSalaryBalance?league_id='+league_id //iframe的url
		}); 
	}
	
	function updatesalary(val){
		layer.closeAll();
		$("#league_balance").text(val);
	}
	
	//生成工资清单
	function createSalary(league_id){
		var url = base+"/admin/league/salaryMsg?league_id="+league_id;
		$("#content").load(url);
	}
</script>