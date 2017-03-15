<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../common/common.jsp" %>
<title>宇任拓-系统信息</title>
<!--IE 浏览器运行最新的渲染模式下-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="${ctx}/resources/css/clubLook.css" rel="stylesheet" />
<style type="text/css">
.disabled { pointer-events: none; }
</style>
</head>
<body>
<div class="warp">
	<!--头部-->
	<%@ include file="../../common/header.jsp" %>
	<%@ include file="../../common/naver.jsp" %>  
    <div class="wrapper" style="margin-top: 116px;">
       <div class="club_show" id="sysMsgArea" style="min-height:450px;">
            
       </div>
    </div>
</div>
<%@ include file="../../common/footer.jsp" %>
</body>
<script type="text/javascript">
$(function(){
	loadSysMsgList(1,'${user_id}');
});
//加载系统消息
function loadSysMsgList(currentPage,user_id){
	$.ajax({
		type:"POST",
		url:base+"/message/querySysMsg?random="+Math.random(),
		data:{"currentPage":currentPage,"user_id":user_id,"pageSize":10,"m_style":1},
		dataType:"HTML",
		success:function(data){
			$("#sysMsgArea").empty();
			$("#sysMsgArea").html(data);
		}
	});
}
function checkMsg(id,user_id,s_user_id,relate_id,type,ifcheck){
	var jsonData = {
		"id" : id,
		"user_id" : user_id,
		"s_user_id" : s_user_id,
		"type" : type,
		"submit" : ifcheck,
		"relate_id" : relate_id
	};
    $.ajaxSec({
		type:"POST",
		url:base+"/center/systemMsg",
		data:jsonData,
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				layer.msg("操作成功！",{icon: 1});
				$.loadSec("#sysMsgArea",base+"/message/querySysMsg",{"currentPage":1,"user_id":user_id,"pageSize":10,"m_style":1});
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}
//add by ylt 系统消息同意 2015-09-01
function openMsg(s_id,usernick){
	$.ajaxSec({
		type: 'POST',
		url: base+"/ifLogin",
		dataType:"JSON",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				layer.open({
					type: 2,
 				    title: false,
 				    closeBtn:false, 
 				    shadeClose: true,
 				    shade: 0.8,
 				    shift : 4,
 				    area: ['426px', '291px'],
				    content: [base+'/message/toMsg/'+s_id+'/'+usernick, 'no']
				}); 
			}
		}
	});
}
</script>
</html>