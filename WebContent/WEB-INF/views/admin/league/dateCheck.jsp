<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/admin/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/resources/layer/skin/layer.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>时间选择</title>
</head>
<body>
<div class="form-group">
	<div class="input-group date col-sm-4">
		<span class="input-group-addon">时间选择</span>
		<input type="text" class="form-control ui_timepicker" id="end_time"
			value="" name="end_time" data-date-format="yyyy-mm-dd HH:mm:ss">
	</div>	
</div>
<button class="btn btn-large" onclick="choosethisDate()">确认</button>
<script src="${ctx}/resources/admin/js/jquery-2.0.3.min.js"></script>
	<script type="text/javascript">
		window.jQuery || document.write("<script src='${ctx}/resources/admin/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
	</script>
	<script src="${ctx}/resources/admin/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${ctx}/resources/admin/js/bootstrap.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.knob.modified.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.pie.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.stack.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.resize.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.time.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.sparkline.min.js"></script>
	<script src="${ctx}/resources/admin/js/fullcalendar.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.gritter.min.js"></script>
	
	<script src="${ctx}/resources/admin/js/default.min.js"></script>
	<script src="${ctx}/resources/admin/js/core.min.js"></script>
	<script src="${ctx}/resources/layer/layer.js"></script>
	<script src="${ctx}/resources/js/base.js"></script>
	<script src="${ctx}/resources/js/yt.ext.js"></script>
	<script src="${ctx}/resources/js/yt.core.js"></script>
	<script src="${ctx}/resources/js/validation.js"></script>
	
	<script src="${ctx}/resources/ueditor/ueditor.config.js" type="text/javascript"></script>
	<script src="${ctx}/resources/ueditor/ueditor.all.min.js" type="text/javascript"></script>
	
	<script src="${ctx}/resources/admin/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery-ui-timepicker-addon.js"></script>
    <script src="${ctx}/resources/admin/js/jquery-ui-timepicker-zh-CN.js"></script>
    <script src="${ctx}/resources/vmodel/Filter.js"></script>
<script type="text/javascript">

$(".ui_timepicker").datetimepicker({
    showSecond: true,
    timeFormat: 'hh:mm:ss',
    stepHour: 1,
    stepMinute: 1,
    stepSecond: 1
});

function choosethisDate(){
	var end_time = $("#end_time").val();
	if(end_time==''){
		layer.msg("请选择时间",{icon:2});
		return false;
	}
	besureSend('${league_id}',end_time);
}

function besureSend(league_id,end_time){
	layer.closeAll();
	$.ajax({
		type:'post',
		url:base+'/admin/league/sendInvite',
		data:{'league_id':league_id,"end_time":end_time},
		dataType:'json',
		success:function(data){
			if(data.state=='success'){
				layer.msg(data.message.success[0],{icon:1});
			}else{
				layer.msg(data.message.error[0],{icon:2});
			}			
		}
	});
}
</script>
</body>
</html>