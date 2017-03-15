<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑射手榜</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="leagueScorerEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${scorer.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联&emsp;&emsp;赛</span>
					<select class="form-control" id="league_sel" name="league_id" disabled="disabled"  valid="require" onchange="get_groups(this)">
						<c:forEach items="${leagues}" var="lg">
						<option value="${lg.id}">${lg.name}</option>
						</c:forEach>
					</select>
					<script type="text/javascript">$("#league_sel").val('${scorer.league_id}')</script>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">分&emsp;&emsp;组</span>
					<select class="form-control" id="group_sel" name="group_id" valid="require" disabled="disabled">
					</select>
				</div>
			</div>
			<%-- <div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">比赛记录ID</span>
					<input type="text" id="pk_record_id" name="pk_record_id" value="${scorer.pk_record_id}" readonly="readonly" valid="require" class="form-control" style="width: 87%;">
					<a class="btn" onclick="select_eventrecord()">选择</a>
				</div>
			</div> --%>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员姓名</span>
					<input type="hidden" id="user_id" name="user_id" value="${scorer.user_id}"/>
					<input type="text" id="user_name" value="${empty user.username?user.usernick:user.username}" valid="require" readonly="readonly" class="form-control">
					<%-- <input type="text" id="user_name" value="${empty user.username?user.usernick:user.username}" valid="require" readonly="readonly" class="form-control" style="width: 87%;">
					<a class="btn" onclick="select_user()">选择</a> --%>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">射门次数</span>
					<input type="text" id="s_goal" name="shemen_num" value="${empty scorer.shemen_num?0:scorer.shemen_num}" readonly="readonly" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">射正次数</span>
					<input type="text" id="s_goal" name="shezheng_num" value="${empty scorer.shezheng_num?0:scorer.shezheng_num}" readonly="readonly" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">总进球数</span>
					<input type="text" id="s_goal" name="goal" value="${empty scorer.goal?0:scorer.goal}" valid="require number" readonly="readonly" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">排　　序</span>
					<input type="text" name="s_sort" value="${empty scorer.s_sort?0:scorer.s_sort}" valid="require number" class="form-control">
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
var iframeUser;
function select_user(iid){
	var lid = $("#league_sel").val();
	var gid = $("#group_sel").val();
	if(!lid || !gid){
		layer.msg("请选择联赛和分组",{icon:2});
		return;
	}
	iframeUser = layer.open({
	    type: 2,
	    title: '选择球员',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/index/dialog?id='+iid+'&lid='+lid+'&gid='+gid+'&type=teamplayer' //iframe的url
	}); 
}

function changeTeamPlayer(iid,pid,uname,unick,num){
	layer.close(iframeUser);
	$("#user_id").val(pid);
	$("#s_goal").val(num);
	if(uname){
		$("#user_name").val(uname);
	}else{
		$("#user_name").val(unick);
	}
}

var iframeRecord;
function select_eventrecord(){
	iframeRecord = layer.open({
	    type: 2,
	    title: '选择联赛记录',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/leagueScorer/recordDialog?league_id='+$("#league_sel").val() //iframe的url
	}); 
}

function changeEventRecord(eid){
	layer.close(iframeRecord);
	$("#pk_record_id").val(eid);
}

var league_id = $("#league_sel").val();
if(league_id){
	get_groups("#league_sel");
}

function get_groups(dom){
	var lid = $(dom).val();
	var gid = '${scorer.group_id}';
	$.post(base+'/admin/leagueScorer/queryLeagueGroups',{league_id:lid},function(data){
		var groups = data.data.groups;
		$("#group_sel").empty();
		if(groups.length>0){
			for(var i in groups){
				$("#group_sel").append('<option value="'+groups[i].id+'">'+groups[i].name+'</option>	');
			}
		}
		if(gid){
			$("#group_sel").val(gid);
		}
	});
}
</script>