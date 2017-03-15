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
		<li><a>联赛创建</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="suspendForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${suspendForm.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛名称</span>
					<yt:id2NameDB id="${league_id}" beanId="leagueService" clazz="form-control"></yt:id2NameDB>
					<input type="hidden" id="league_id" name="league_id" value="${league_id}"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员姓名</span>
					<input type="hidden" id="user_id" name="user_id" value="${suspendForm.user_id}"/>
					<c:choose>
						<c:when test="${empty suspendForm.user_id}">
							<input type="text" id="user_name" value="${empty user.username?user.usernick:user.username}" valid="require" readonly="readonly" class="form-control" style="width: 87%;">
						</c:when>
						<c:otherwise>
							<yt:userName id="${suspendForm.user_id}" clazz="form-control"></yt:userName>
						</c:otherwise>
					</c:choose>
					<a class="btn" onclick="select_user()">选择</a>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">禁赛开始时间</span>
					<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${suspendForm.begin_time}' pattern='yyyy-MM-dd HH:mm:ss' />" name="begin_time" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">禁赛结束时间</span>
					<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${suspendForm.end_time}' pattern='yyyy-MM-dd HH:mm:ss' />" name="end_time" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">禁赛状态是否生效</span>
					<yt:dictSelect name="status" nodeKey="status" value="${suspendForm.status}" required="require" clazz="form-control"></yt:dictSelect>
				</div>	
			</div>
			<div class="form-group">
				<label class="control-label" for="textarea2">描述</label>
				<div class="controls">
					<textarea id="remark" name="remark" style="width: 100%; overflow: hidden;
					 word-wrap: break-word; resize: horizontal; height: 141px;" rows="6">${suspendForm.remark}</textarea>
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
	
	var iframeUser;
	function select_user(){
		var l_id = $("#league_id").val();
		iframeUser = layer.open({
		    type: 2,
		    title: '选择球员',
		    shadeClose: true,
		    shade: [0],
		    area: ['1330px', '640px'],
		    content: base+'/admin/league/userDialog' //iframe的url
		}); 
	}

	function changeUser(user_id,user_name){
		layer.close(iframeUser);
		$("#user_id").val(user_id);
		$("#user_name").val(user_name);
	}
	
</script>