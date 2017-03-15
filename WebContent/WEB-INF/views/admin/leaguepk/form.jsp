<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑联赛赛事</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="_itemEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${_item.id}"/>
			<fieldset class="col-sm-12">
			<c:choose>
				<c:when test="${!empty _item}">
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">联赛</span>
							<input type="hidden" name="league_id" value="${_item.league_id}" valid="require len(1,200)">
							<input type="hidden" name="group_id" value="${_item.group_id}" valid="require len(1,200)">
							<span class="form-control">${league.name}</span>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">分组</span>
							<span class="form-control">${leagueGroup.name}</span>
						</div>
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">第 几 轮</span>
							<span class="form-control">${_item.rounds}</span>
						</div>
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">球队</span>
							<span class="form-control">${_item.m_team_name} VS ${_item.g_team_name}</span>
						</div>
					</div>		
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比分:</span>
							<input type="hidden" name="m_teaminfo_id" value="${_item.m_teaminfo_id}" valid="require len(1,200)">
							<input type="hidden" name="m_team_name" value="${_item.m_team_name}" valid="require len(1,200)">
							<input type="hidden" name="g_teaminfo_id" value="${_item.g_teaminfo_id}" valid="require len(1,200)">
							<input type="hidden" name="g_team_name" value="${_item.g_team_name}" valid="require len(1,200)">
							<input type="text" name="m_score" value="${_item.m_score}" valid="require len(1,30)" size="10px">
								VS	
							<input type="text" name="g_score" value="${_item.g_score}" valid="require len(1,30)" size="10px">
						</div>	
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛时间</span>
							<input type="text" name="play_time" class="ui_timepicker form-control" 
								value="<fmt:formatDate value='${_item_i.play_time}' pattern='yyyy-MM-dd HH:mm:ss'/>" valid="require">	
						</div>
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4" >
							<span class="input-group-addon">比赛赛制</span>
							<yt:dictSelect name="ball_format" nodeKey="ball_format" value="${_item.ball_format}"></yt:dictSelect>	
						</div>
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛地点</span>
							<input type="text" name="position" value="${_item.position}" valid="require len(1,200)" class="form-control">
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">联赛</span>
							<input type="hidden" name="league_id" value="${_item.league_id}" valid="require len(1,200)">
							<input type="hidden" name="group_id" value="${_item.group_id}" valid="require len(1,200)">
							<span class="form-control">${league.name}</span>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">分组</span>
							<span class="form-control">${leagueGroup.name}</span>
						</div>
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">第 几 轮</span>
							<span class="form-control">${_item.rounds}</span>
						</div>
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">球队</span>
							<span class="form-control">${_item.m_team_name} VS ${_item.g_team_name}</span>
						</div>
					</div>		
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比分:</span>
							<input type="hidden" name="m_teaminfo_id" value="${_item.m_teaminfo_id}" valid="require len(1,200)">
							<input type="hidden" name="m_team_name" value="${_item.m_team_name}" valid="require len(1,200)">
							<input type="hidden" name="g_teaminfo_id" value="${_item.g_teaminfo_id}" valid="require len(1,200)">
							<input type="hidden" name="g_team_name" value="${_item.g_team_name}" valid="require len(1,200)">
							<input type="text" name="m_score" value="${_item.m_score}" valid="require len(1,30)" size="10px">
								VS	
							<input type="text" name="g_score" value="${_item.g_score}" valid="require len(1,30)" size="10px">
						</div>	
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛时间</span>
							<input type="text" name="play_time" class="ui_timepicker form-control" 
								value="<fmt:formatDate value='${_item_i.play_time}' pattern='yyyy-MM-dd HH:mm:ss'/>" valid="require">	
						</div>
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4" >
							<span class="input-group-addon">比赛赛制</span>
							<yt:dictSelect name="ball_format" nodeKey="ball_format" value="${_item.ball_format}"></yt:dictSelect>	
						</div>
					</div>
					<div class="form-group">	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛地点</span>
							<input type="text" name="position" value="${_item.position}" valid="require len(1,200)" class="form-control">
						</div>
					</div>
				</c:otherwise>
			</c:choose>	
			
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
	})
</script>