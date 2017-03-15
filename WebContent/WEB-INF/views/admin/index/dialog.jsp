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
<input type="hidden" id="select_rtype" value="${type}"/>
<input type="hidden" id="iid" value="${iid}"/>
<input type="hidden" id="tid" value="${tid}"/>
<input type="hidden" id="lid" value="${lid}"/>
<input type="hidden" id="gid" value="${gid}"/>
<input type="hidden" id="iv_sort" value="${sort}"/>
<script type="text/javascript">
$(function(){
	var rtype = $("#select_rtype").val();
	var url = base + '/admin/index/queryImagesOrVideos';
	if(rtype=='baby'){
		url = base + '/admin/index/queryBabys';
	}
	if(rtype=='player'){
		url = base + '/admin/index/queryPlayers';
	}
	if(rtype=='teamplayer'){
		url = base + '/admin/index/queryTeamPlayers?tid='+$("#tid").val()+'&lid='+$("#lid").val()+'&gid='+$("#gid").val();
	}
	ListPage.enter({context:'#content',url:url,searchForm:'#searchForm'},{stype:1,type:rtype});
})

function select_iv(){
	var type = $("#select_type").val();
	var rtype = $("#select_rtype").val();
	var table = $("#iv_table");
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
				if(rtype=='baby'){
					window.parent.changeBaby($("#iid").val(),this.value);
				}else if(rtype=='player'){
					window.parent.changePlayer($("#iid").val(),this.value);
				}else if(rtype=='teamplayer'){
					var uname = $(this).parent().parent().find("[data-value=username]").text();
					var unick = $(this).parent().parent().find("[data-value=usernick]").text();
					var num = $(this).parent().parent().find("[data-value=jinqiu_num]").text();
					window.parent.changeTeamPlayer($("#iid").val(),this.value,uname,unick,num);
				}else if(rtype=='image'){
					window.parent.changeImage($("#iid").val(),this.value,$("#iv_sort").val());
				}else{
					window.parent.changeIv($("#iid").val(),this.value);
				}
			}
		});
	}
	var msg = "图片";
	if(rtype=='video') msg= "视频";
	if(rtype=='baby') msg = "宝贝";
	if(rtype=='player'||rtype=='teamplayer') msg = "球员";
	if(!haveCheck){
		layer.msg('请选择'+msg,{icon: 2});
	}
}
</script>
</body>
</html>
