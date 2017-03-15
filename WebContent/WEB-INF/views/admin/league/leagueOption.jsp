<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛管理</a></li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league.id}','#leagueForm','/admin/league/saveLeague','${league.id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league.id}"></yt:id2NameDB>
			</a>
		</li>
		<li><a>信息管理</a></li>
	</ul>
	<hr>
</div>
	<!-- 联赛信息管理 -->
	<div class="box">
		<div class="box-header">
			<h2>
			<i class="fa fa-tasks"></i>
			<span class="break"></span>
				信息管理
			</h2>
		</div>
		<div class="box-content">	
			<div class="row">
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/leagueGroup?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-th-large"></i>
						<p>联赛分组</p>
					</a>
				</div>
				<%-- <div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/eventRecord?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						
					 	<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/eventRecord/eventList?id=${league.id}'});" style="cursor: pointer;">
					 	<i class="fa fa-align-justify"></i>
						<p>联赛赛程</p>
					</a>
				</div>	 --%>
				<%-- <div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/eventForecast?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-file-text-o"></i>
						<p>联赛预告</p>
					</a>
				</div>	 --%>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/ivleague?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-picture-o"></i>
						<p>图片视频</p>
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/league/listCodes?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-check-circle"></i>
						<p>激活码列表</p>
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/league/listSuspend?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-list"></i>
						<p>禁赛列表</p>
					</a>
				</div>
				
			</div><!--/row-->
		</div>	
	</div>
	
	<!-- 联赛统计 -->
	<div class="box">
		<div class="box-header">
			<h2>
			<i class="fa fa-tasks"></i>
			<span class="break"></span>
				数据统计
			</h2>
		</div>
		<div class="box-content">	
			<div class="row">
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1"  onclick="ListPage.enter({context:'#content',url:'/admin/interface/leagueCount?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-bar-chart-o"></i>
						<p>接口数据</p>
						<!-- <span class="notification">7</span> -->
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/teamIntegral?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-list-ul"></i>
						<p>俱乐部积分</p>
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/leagueStatistics?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-list-ol"></i>
						<p>个人统计</p>
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/leagueScorer?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-list-ol"></i>
						<p>射手榜</p>
					</a>
				</div>
			</div><!--/row-->
		</div>	
	</div>
	<!--联赛俱乐部奖金发放 -->
	<div class="box">
		<div class="box-header">
			<h2>
			<i class="fa fa-tasks"></i>
			<span class="break"></span>
				工资管理
			</h2>
		</div>
		<div class="box-content">	
			<div class="row">
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1"  onclick="ListPage.enter({context:'#content',url:'/admin/league/salaryManage?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-envelope-o"></i>
						<p>工资管理</p>
					</a>
				</div>
				<%-- <div class="col-sm-2 col-md-1">
					<a class="quick-button span1"  onclick="ListPage.form('${ctx}/admin/league/salaryMsg?league_id=${league.id}','#leagueForm','${ctx}/admin/league/saveSalaryMsg');" style="cursor: pointer;">
						<i class="fa fa-comment-o"></i>
						<p>信息发送</p>
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1"  onclick="ListPage.enter({context:'#content',url:'/admin/league/salaryMsgRecord?league_id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-envelope-o"></i>
						<p>信息发送记录</p>
					</a>
				</div> --%>
			</div><!--/row-->
		</div>	
	</div>
	
	<!-- 参赛消息-->
	<div class="box">
		<div class="box-header">
			<h2>
			<i class="fa fa-tasks"></i>
			<span class="break"></span>
				参赛消息	
			</h2>
		</div>
		<div class="box-content">	
			<div class="row">
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="sendInviteMsg('${league.id}')" style="cursor: pointer;">
						<i class="fa fa-envelope-o"></i>
						<p>发送消息</p>
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1"  onclick="ListPage.enter({context:'#content',url:'/admin/league/inviteRecord?id=${league.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-calendar"></i>
						<p>确认消息</p>
					</a>
				</div>
			</div><!--/row-->
		</div>	
	</div>
	
	<div>
		<a class="btn" onclick="ListPage.enter({context:'#content',url:'/admin/league/listLeague',searchForm:'#searchForm'});" style="cursor: pointer;">
			返回 
		</a>
	</div>
	
	<script>

//通知联赛下俱乐部是否参加下届联赛
function sendInviteMsg(league_id){
	layer.confirm('确认发送?', {icon: 3, title:'提示'}, function(index){
		layer.close(index);
		layer.open({
		    type: 2,
		    title: '时间选择',
		    shadeClose: true,
		    shade: 0.8,
		    area: ['380px', '50%'],
		    content: base+'/admin/league/dateCheck?league_id='+league_id
		}); 
	});
}
</script>
