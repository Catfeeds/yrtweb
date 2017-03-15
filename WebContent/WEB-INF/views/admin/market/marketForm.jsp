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
		<li><a>联赛管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li><a>市场球员</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="marketForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${marketForm.id}"/>
			<input type="hidden" name="s_id" value="${marketForm.s_id}"/>
			<fieldset class="col-sm-12">	
			<%-- <div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛名称</span>
					<input type="text" name="league_name" class="ui_timepicker form-control" value="${league.name}" readonly="readonly">
					<input type="hidden" name="league_id"  value="${marketForm.league_id}"/>
				</div>	
			</div> --%>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员</span>
						<yt:userName id="${marketForm.user_id}" clazz="form-control"></yt:userName>
						<input type="hidden" name="user_id" value="${marketForm.user_id}"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">出售俱乐部</span>	
						<c:choose>
							<c:when test="${empty marketForm.team_id}">
								<span class="form-control">系统推荐</span>
							</c:when>
							<c:otherwise>
								<yt:id2NameDB beanId="teamInfoService" id="${marketForm.team_id}" clazz="form-control"></yt:id2NameDB>
							</c:otherwise>
						</c:choose>	
						<input type="hidden" name="team_id" value="${marketForm.team_id}"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">出售价格</span>
						<input type="text" name="price" value="${marketForm.price}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否成交</span>
						<yt:dictSelect name="status" nodeKey="status" clazz="form-control" value="${marketForm.status}" required="require number"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">购买者</span>
						<c:choose>
							<c:when test="${empty marketForm.buyer}">
								<span class="form-control">无</span>
							</c:when>
							<c:otherwise>
								<yt:id2NameDB id="${marketForm.buyer}" beanId="teamInfoService" clazz="form-control"></yt:id2NameDB>
							</c:otherwise>
						</c:choose>	
						<input type="hidden" name="buyer" value="${marketForm.buyer}"/>
				</div>	
			</div>
			<%-- <div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">出售俱乐部</span>
						<input type="hidden" name="team_id" value="${marketForm.team_id}" class="form-control" readonly="readonly">
						<yt:id2NameDB id="${marketForm.team_id}" beanId="teamInfoService" clazz="form-control"></yt:id2NameDB>
				</div>	
			</div> --%>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">成交日期</span>
					<input type="text" name="buy_time" class="ui_timepicker form-control" value="<fmt:formatDate value='${marketForm.buy_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">到期时间</span>
					<input type="text" name="end_time" class="ui_timepicker form-control" value="<fmt:formatDate value='${marketForm.end_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">竞拍轮次</span>
					<input type="text" name="turn_num" class="form-control" value="${marketForm.turn_num}">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否选中</span>
					<yt:dictSelect name="status" nodeKey="status" value="${marketForm.status}" clazz="form-control" required="require number"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否上架</span>
					<yt:dictSelect name="if_up" nodeKey="status" value="${marketForm.if_up}" clazz="form-control" required="require number"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否流拍</span>
					<yt:dictSelect name="if_sold" nodeKey="status" value="${marketForm.if_sold}" clazz="form-control"></yt:dictSelect>
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
