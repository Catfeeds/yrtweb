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
		<li><a>市场配置</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="cfgForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${auctionCfgForm.id}"/>
			<input type="hidden" name="s_id" value="${leagueCfg.id}"/>
			<fieldset class="col-sm-12">	
			<%-- <div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛名称</span>
					<select class="form-control" name="league_id">
						<c:forEach items="${leagueList}" var="league">
							<option value="${league.id}" <c:if test="${league.id eq auctionCfgForm.league_id}">selected</c:if>>${league.name}</option>
						</c:forEach>
					</select>
				</div>	
			</div> --%>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">竞拍开始时间</span>
					<input type="text" name="start_time" class="ui_timepicker form-control" valid="require" value="<fmt:formatDate value='${auctionCfgForm.start_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">竞拍结束时间</span>
					<input type="text" name="end_time" class="ui_timepicker form-control" valid="require" value="<fmt:formatDate value='${auctionCfgForm.end_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
				</div>	
			</div>
			<c:if test="${!empty auctionCfgForm.create_time}">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">创建时间</span>
					<span class="form-control"><fmt:formatDate value='${auctionCfgForm.create_time}' pattern='yyyy-MM-dd HH:mm:ss' /></span>
				</div>	
			</div>
			</c:if>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">市场是否开放</span>
					<yt:dictSelect name="status" nodeKey="status" value="${auctionCfgForm.status}" clazz="form-control" required="require"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">当前竞拍轮数</span>
					<input type="text" name="turn_num" value="${auctionCfgForm.turn_num}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">落选球员进入轮数</span>
					<input type="text" name="next_num" value="${auctionCfgForm.next_num}" valid="require number" class="form-control">
				</div>	
				<span style="color:red;">* 填写0表示进入市场</span>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">初始竞拍价</span>
					<input type="text" name="init_price" value="${auctionCfgForm.init_price}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">妖人初始竞拍价</span>
					<input type="text" name="y_init_price" value="${auctionCfgForm.y_init_price}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">每次加价价格</span>
					<input type="text" name="per_price" value="${auctionCfgForm.per_price}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">初始浮动价格</span>
					<input type="text" name="add_price" value="${auctionCfgForm.add_price}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员分成(例如：0.11)</span>
					<input type="text" name="user_percent" value="${auctionCfgForm.user_percent}" valid="require zhekou" class="form-control">
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
