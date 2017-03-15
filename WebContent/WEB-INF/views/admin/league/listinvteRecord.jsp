<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛管理</a></li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league_id}','#leagueForm','/admin/league/saveLeague','${league_id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league_id}"></yt:id2NameDB>
			</a>
		</li>
		<li><a>信息管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2>
					<i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" 
					style="cursor: pointer;">返回</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<!-- <div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>联赛名称 ： <input type="text" name="name" value=""></label>
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
						</div> -->
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>联赛名称</th>
							  <th>俱乐部名称</th>
							  <th>是否有效</th>
							  <th>截止时间</th>
							  <th>发送时间</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="league">
							<tr>
								<td>${league.league_name}</td>
								<td>${league.team_name}</td>
								<td>
									<c:choose>
										<c:when test="${league.status == 1}">有效</c:when>
										<c:otherwise>失效</c:otherwise>
									</c:choose>
								</td>
								<td><fmt:formatDate value="${league.end_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><fmt:formatDate value="${league.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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
//通知联赛下俱乐部是否参加下届联赛
function sendInviteMsg(league_id){
	layer.confirm('确认发送?', {icon: 3, title:'提示'}, function(index){
		$.ajax({
			type:'post',
			url:base+'/admin/league/sendInvite',
			data:{'league_id':league_id},
			dataType:'json',
			success:function(data){
				layer.close(index);
				if(data.state=='success'){
					layer.msg(data.message.success[0],{icon:1});
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}			
			}
		});
	});
	
}
</script>