<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/admin/css/jquery-ui-1.10.3.custom.min.css" rel="stylesheet">
<link href="${ctx}/resources/admin/css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>赛季管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li><a>交易市场</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="cfgForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${marketCfgForm.id}"/>
			<input type="hidden" name="s_id" value="${leagueCfg.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">市场开放时间</span>
					<input type="text" name="start_time" class="ui_timepicker form-control" value="<fmt:formatDate value='${marketCfgForm.start_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">市场结束时间</span>
					<input type="text" name="end_time" class="ui_timepicker form-control" value="<fmt:formatDate value='${marketCfgForm.end_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
				</div>	
			</div>
			<c:if test="${!empty marketCfgForm.create_time}">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">创建时间</span>
					<span class="form-control"><fmt:formatDate value='${marketCfgForm.create_time}' pattern='yyyy-MM-dd HH:mm:ss' /></span>
				</div>	
			</div>
			</c:if>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">市场是否开放</span>
					<yt:dictSelect name="if_open" nodeKey="status" value="${marketCfgForm.if_open}" clazz="form-control"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">每次加价价格</span>
					<input type="text" name="per_price" value="${marketCfgForm.per_price}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员分成(例如：0.11)</span>
					<input type="text" name="user_percent" value="${marketCfgForm.user_percent}" valid="require zhekou" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球队分成(例如：0.11)</span>
					<input type="text" name="team_percent" value="${marketCfgForm.team_percent}" valid="require zhekou" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">本轮轮次</span>
					<input type="text" name="turn_num" value="${marketCfgForm.turn_num}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">下轮轮次</span>
					<input type="text" name="next_num" value="${marketCfgForm.next_num}" valid="require number" class="form-control">
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
        })
    })
    </script>
