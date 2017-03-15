<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑积分</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="integralEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${integral.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联&emsp;&emsp;赛</span>
					<c:choose>
						<c:when test="${empty flag}">
							<select class="form-control" id="league_sel" name="league_id" onchange="query_groups(this)" valid="require">
								<c:forEach items="${leagues}" var="lg">
								<option value="${lg.id}">${lg.name}</option>
								</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							<select class="form-control" id="league_sel" name="league_id" onchange="query_groups(this)" valid="require" disabled="disabled">
								<c:forEach items="${leagues}" var="lg">
								<option value="${lg.id}">${lg.name}</option>
								</c:forEach>
							</select>
						</c:otherwise>
					</c:choose>
					<script type="text/javascript">$("#league_sel").val('${integral.league_id}')</script>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">分&emsp;&emsp;组</span>
					<c:choose>
						<c:when test="${empty flag}">
							<select class="form-control" id="group_sel" name="group_id"  valid="require">
								<option value=""></option>
							</select>
						</c:when>
						<c:otherwise>
							<select class="form-control" id="group_sel" name="group_id"  valid="require" disabled="disabled">
								<option value=""></option>
							</select>
						</c:otherwise>
					</c:choose>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">俱乐&emsp;部</span>
					<input type="hidden" id="teaminfo_id" name="teaminfo_id" value="${integral.teaminfo_id}"/>
					<c:choose>
						<c:when test="${empty flag}">
							<input type="text" id="teaminfo_name" value="${teamInfo.name}" valid="require" class="form-control" style="width: 87%;">
							<a class="btn" onclick="select_team_info('teaminfo_id','teaminfo_name')">选择</a>
						</c:when>
						<c:otherwise>
							<input type="text" id="teaminfo_name" value="${teamInfo.name}" valid="require" class="form-control" readonly="readonly">
						</c:otherwise>
					</c:choose>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">比赛场次总数</span>
					<input type="text" name="games" value="${empty integral.games?0:integral.games}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">赢取场次</span>
					<input type="text" name="win_games" value="${empty integral.win_games?0:integral.win_games}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">输场次</span>
					<input type="text" name="lose_games" value="${empty integral.lose_games?0:integral.lose_games}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">平场次</span>
					<input type="text" name="flat_games" value="${empty integral.flat_games?0:integral.flat_games}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">进球数</span>
					<input type="text" name="in_ball" value="${empty integral.in_ball?0:integral.in_ball}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">失球数</span>
					<input type="text" name="lose_ball" value="${empty integral.lose_ball?0:integral.lose_ball}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">总积分</span>
					<input type="text" name="sum_integral" value="${empty integral.sum_integral?0:integral.sum_integral}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">排名</span>
					<input type="text" name="ranking" value="${empty integral.ranking?0:integral.ranking}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">
$(function(){
	query_groups('#league_sel','${integral.group_id}');
})
function query_groups(dom,gid){
	$.ajaxSec({
		type: 'POST',
		url: base+'/admin/leagueGroup/queryGroupByLid',
		data: {lid: $(dom).val()},
		success: function(data){
			if(data.data.groups&&data.data.groups.length>0){
				$("#group_sel").empty();
				for(i in data.data.groups){
					if(gid&&gid==data.data.groups[i].id){
						$("#group_sel").append('<option selected="selected" value="'+data.data.groups[i].id+'">'+data.data.groups[i].name+'</option>');
					}else{
						$("#group_sel").append('<option value="'+data.data.groups[i].id+'">'+data.data.groups[i].name+'</option>');
					}
				}
			}else{
				$("#group_sel").empty().append('<option value=""></option>');
			}
		},
		error: $.ajaxError
	});
}

var iframeTeamInfo;
/* function select_team_info(){
	iframeTeamInfo = layer.open({
	    type: 2,
	    title: '选择俱乐部',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/teamIntegral/dialog' //iframe的url
	}); 
}

function changeTeam(tid,tname){
	layer.close(iframeTeamInfo);
	$("#teaminfo_id").val(tid);
	$("#teaminfo_name").val(tname);
} */
function select_team_info(dom_id,dom_name){
	var league_id = $("#league_sel").val();
	var group_id = $("#group_sel").val();
	iframeTeamInfo = layer.open({
	    type: 2,
	    title: '选择俱乐部',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/teamIntegral/dialog?dom_id='+dom_id+'&dom_name='+dom_name+'&league_id='+league_id+"&group_id="+group_id //iframe的url
	}); 
}

function changeTeam(tid,tname,dom_id,dom_name){
	layer.close(iframeTeamInfo);
	$("#"+dom_id).val(tid);
	$("#"+dom_name).val(tname);
}

</script>