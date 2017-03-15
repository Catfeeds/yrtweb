<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑联赛预告</a></li>
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
							<span class="form-control"><yt:id2NameDB beanId="leagueService" id="${_item.league_id}"></yt:id2NameDB></span>
						</div>
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">主队名称</span>
							<input type="hidden" name="m_teaminfo_id" value="${_item.m_teaminfo_id}" valid="require len(1,200)" class="form-control">
							<input type="text" name="m_team_name" value="${_item.m_team_name}" valid="require len(1,200)" class="form-control" readonly="readonly">
						</div>	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">客队名称</span>
							<input type="hidden" name="g_teaminfo_id" value="${_item.g_teaminfo_id}" valid="require len(1,200)" class="form-control">
							<input type="text" name="g_team_name" value="${_item.g_team_name}" valid="require len(1,200)" class="form-control" readonly="readonly">
						</div>	
						
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛时间</span>
							<input type="text" name="play_time" class="ui_timepicker form-control" 
								value="<fmt:formatDate value='${_item.play_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">	
						</div>
						
						<div class="input-group date col-sm-4" >
							<span class="input-group-addon">比赛赛制</span>
							<input type="text" name="ball_format" value="${_item.ball_format}" valid="require len(1,200)" class="form-control" readonly="readonly">
						</div>
						
						<div class="input-group date col-sm-4" >
							<span class="input-group-addon">第 几 轮</span>
							<input type="text" name="rounds" value="${_item.rounds}" valid="require len(1,200)" class="form-control" readonly="readonly">
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">联赛</span>
							<input type="hidden" name="league_id" value="${_item_i.league_id}" valid="require len(1,200)" class="form-control" readonly="readonly">
							<input type="hidden" name="group_id" value="${_item_i.group_id}" valid="require len(1,200)">
							<span class="form-control">${league.name}</span>
						</div>
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">主队名称</span>
							<input type="hidden" name="m_teaminfo_id" value="${_item_i.m_teaminfo_id}" valid="require len(1,200)" class="form-control" >
							<input type="text" name="m_team_name" value="${_item_i.m_team_name}" valid="require len(1,200)" class="form-control" readonly="readonly">
						</div>	
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">客队名称</span>
							<input type="hidden" name="g_teaminfo_id" value="${_item_i.g_teaminfo_id}" valid="require len(1,200)" class="form-control">
							<input type="text" name="g_team_name" value="${_item_i.g_team_name}" valid="require len(1,200)" class="form-control" readonly="readonly">
						</div>	
						
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">比赛时间</span>
							<input type="text" name="play_time" class="ui_timepicker form-control" 
								value="<fmt:formatDate value='${_item_i.play_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
						</div>
						
						<div class="input-group date col-sm-4" >
							<span class="input-group-addon">比赛赛制</span>
							<input type="text" name="ball_format" value="${_item_i.ball_format}" valid="require len(1,200)" class="form-control" readonly="readonly">
						</div>
						
						<div class="input-group date col-sm-4" >
							<span class="input-group-addon">比赛地点</span>
							<input type="text" name="position" value="${_item_i.position}" valid="require len(1,200)" class="form-control" readonly="readonly">
						</div>
						
						<div class="input-group date col-sm-4" >
							<span class="input-group-addon">第 几 轮</span>
							<input type="text" name="rounds" value="${_item_i.rounds}" valid="require len(1,200)" class="form-control" readonly="readonly">
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