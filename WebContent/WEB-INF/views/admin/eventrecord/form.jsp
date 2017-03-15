<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>${league.name}</a></li>
		<li><a>赛程编辑</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="_itemEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" id="id" value="${event.id}"/>
			<input type="hidden" name="game_id" id="game_id" value="${event.game_id}"/>
			<input type="hidden" id="league_id" name="league_id" value="${league.id}"/>
			<input type="hidden" id="win_teaminfo_id" name="win_teaminfo_id" value="${event.win_teaminfo_id}"/>
			<fieldset class="col-sm-12">	
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">联&emsp;&emsp;赛</span>
							<span class="form-control">${league.name}</span>	
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">分&emsp;&emsp;组</span>
							<select class="form-control" id="group_sel" name="group_id"  valid="require">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">俱乐部(主队)</span>
							<input type="hidden" id="m_teaminfo_id" name="m_teaminfo_id" value="${event.m_teaminfo_id}"/>
							<span class="form-control">
								<input type="text" id="m_team_name" name="m_team_name" value="${event.m_team_name}" valid="require" class="form-control" style="width: 80%;"/>
								<a class="btn" onclick="select_team_info('m_teaminfo_id','m_team_name')">选择</a>
							</span>	
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">俱乐部(客队)</span>
							<input type="hidden" id="g_teaminfo_id" name="g_teaminfo_id" value="${event.g_teaminfo_id}"/>
							<span class="form-control">
								<input type="text" id="g_team_name" name="g_team_name" value="${event.g_team_name}" valid="require" class="form-control" style="width: 80%;"/>
								<a class="btn" onclick="select_team_info('g_teaminfo_id','g_team_name')">选择</a>
							</span>	
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛时间</span>
							<input type="text" name="play_time" class="ui_timepicker form-control" 
							value="<fmt:formatDate value='${event.play_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛赛制</span>
							<yt:dictSelect name="ball_format" nodeKey="ball_format" value="${event.ball_format}" clazz="form-control"></yt:dictSelect>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛地点</span>
							<input type="text" name="position" value="${event.position}" valid="require(1,200)" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛轮次</span>
							<input type="text" name="rounds" value="${event.rounds}" valid="require number" class="form-control">
						</div>
					</div>
					<c:choose>
						<c:when test="${!empty flag}">
							<div class="form-group">
								<div class="input-group date col-sm-4">
									<span class="input-group-addon">球队</span>
									<span class="form-control">${event.m_team_name} VS ${event.g_team_name}</span>
								</div>	
							</div>
							<div class="form-group">
								<div class="input-group date col-sm-4">
									<span class="input-group-addon">比分</span>
									<c:choose>
										<c:when test="${empty event.game_id}">
											<span class="form-control">
												<input type="text" name="m_score" value="${event.m_score}" valid="require len(1,30)" size="10px">
													VS	
												<input type="text" name="g_score" value="${event.g_score}" valid="require len(1,30)" size="10px">
											</span>
										</c:when>
										<c:otherwise>
											<span class="form-control">
												${event.m_score} VS ${event.g_score}
												（已生成球队历史纪录不可修改，必须先删除球队历史记录）
												<input type="hidden" id="m_score" name="m_score" value="${event.m_score}"/>
												<input type="hidden" id="g_score" name="g_score" value="${event.g_score}"/>
											</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<input type="hidden" id="m_score" name="m_score" value="${event.m_score}"/>
							<input type="hidden" id="g_score" name="g_score" value="${event.g_score}"/>
						</c:otherwise>
					</c:choose>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛状态</span>
							<yt:dictSelect name="status" nodeKey="l_status" value="${event.status}" clazz="form-control"></yt:dictSelect>
						</div>
					</div>
					<div class="form-actions">
						<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
						<c:choose>
							<c:when test="${empty event.game_id}">
								<a class="btn btn-primary" onclick="saveGame()">生成历史记录</a>
							</c:when>
							<c:otherwise>
								<a class="btn btn-danger" onclick="delGame()">删除历史记录</a>
							</c:otherwise>
						</c:choose>
						<a class="btn" onclick="ListPage.paginate()">返回</a>
					</div>		
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">
$(function () {
    $(".ui_timepicker").datetimepicker({
        //showOn: "button",
        //buttonImage: "./css/images/icon_calendar.gif",
        //buttonImageOnly: true,
        showSecond: true,
        timeFormat: 'hh:mm:ss',
        stepHour: 1,
        stepMinute: 1,
        stepSecond: 1
    });
    
	query_groups('#league_id','${event.group_id}');
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
						$("#group_sel").attr("disabled",true);
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
function select_team_info(dom_id,dom_name){
	var league_id = $("#league_id").val();
	var group_id = $("#group_sel").val();
	iframeTeamInfo = layer.open({
	    type: 2,
	    title: '选择俱乐部',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/eventRecord/dialog?dom_id='+dom_id+'&dom_name='+dom_name+'&league_id='+league_id+"&group_id="+group_id //iframe的url
	}); 
}

function changeTeam(tid,tname,dom_id,dom_name){
	layer.close(iframeTeamInfo);
	$("#"+dom_id).val(tid);
	$("#"+dom_name).val(tname);
}

function saveGame(){
	$.ajaxSec({
		type: 'POST',
		url: base+'/admin/eventRecord/saveGame',
		data: {id:$("#id").val()},
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				ListPage.form('${ctx}/admin/eventRecord/formJsp?league_id=${league.id}&id=${event.id}&flag=true','#_itemEditForm',
						'${ctx}/admin/eventRecord/saveOrUpdate')
			}
		},
		error: $.ajaxError
	});
}

function delGame(){
	$.ajaxSec({
		type: 'POST',
		url: base+'/admin/eventRecord/delGame',
		data: {id:$("#id").val()},
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				ListPage.form('${ctx}/admin/eventRecord/formJsp?league_id=${league.id}&id=${event.id}&flag=true','#_itemEditForm',
				'${ctx}/admin/eventRecord/saveOrUpdate')
			}
		},
		error: $.ajaxError
	});
}

</script>