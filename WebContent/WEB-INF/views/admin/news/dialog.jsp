<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>宇任拓管理系统</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="${ctx}/resources/admin/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/font-awesome.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/jquery-ui-1.10.3.custom.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/fullcalendar.css" rel="stylesheet">	
	<link href="${ctx}/resources/admin/css/jquery.gritter.css" rel="stylesheet">	
	<link href="${ctx}/resources/admin/css/style.min.css" rel="stylesheet">
	<link href="${ctx}/resources/layer/skin/layer.css" rel="stylesheet">
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="http://localhost:8888/bootstrap/perfectum2/img/favicon.ico">
	<!-- end: Favicon -->
	
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
</head>
<body>
<div id="content" class="col-sm-10" style="width: 100%;">
</div>
<script type="text/javascript">
$(function(){
	ListPage.enter({context:'#content',url:'${ctx}/admin/teamInfo/selectTeam',searchForm:'#searchForm'},{type:2});
})

function select_team(){
	var type = $("#select_type").val();
	var table = $("#team_table");
	var haveCheck = false;
	if(type=='2'){
		var tids = "";
		var tnames = "";
		table.find('input[type=checkbox]').each(function(){
			if(this.checked){
				haveCheck = true;
				tids += this.value + ",";
				tnames += $(this).parent().parent().find("#tname").text() + ",";
			}
		});
		if(haveCheck){
			tids = tids.substring(0,tids.lastIndexOf(","));
			tnames = tnames.substring(0,tnames.lastIndexOf(","));
			window.parent.changeTeam(tids,tnames);
		}
	}else{
		table.find('input[type=radio]').each(function(){
			if(this.checked){
				haveCheck = true;
				window.parent.changeTeam(this.value,$(this).parent().parent().find("#tname").text());
			}
		});
	}
	if(!haveCheck){
		layer.msg('请选择俱乐部',{icon: 2});
	}
}
</script>
</body>
</html>
