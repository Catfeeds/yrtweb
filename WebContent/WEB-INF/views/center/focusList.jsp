<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/center.css" rel="stylesheet" />
<title>关注列表</title>
</head>
<body>
 <div class="warp">
         <!--头部-->
		 <%@ include file="../common/header.jsp" %>
		 <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
	     <div class="wrapper" style="margin-top: 220px;">
	     		<input type="hidden" name="u_id" id="u_id" value="${u_id}"/>
	     		<div class="all_attention">
	                <div class="att_title">
	                    <span class="text-white f16 ms">关注列表</span>
	                </div>
	                 <div id="focusData">
	                 
	                 </div>
	                <div class="clearit"></div>  
	            </div>    
	     </div>
 </div>	     
 <%@ include file="../common/footer.jsp" %>
 <script type="text/javascript">
$(function(){
	loadFocusDatas(1);
	 $(".att_name").each(function () {
         var maxwidth = 7;
         if ($(this).text().length > maxwidth) {
             $(this).text($(this).text().substring(0, maxwidth));
             $(this).html($(this).html() + '…');
         }
     });
});
 
 //载入关注用户数据
 function loadFocusDatas(currentPage){
 		$.ajax({
 			type:"POST",
 			url:base+"/user/focusDatas?random="+Math.random(),
 			data:{"currentPage":currentPage,"u_id":$("#u_id").val()},
 			dataType:"HTML",
 			beforeSend:function(data){
				$("#focusData").append("<div style='width:500px;text-align:center;margin:35px auto -20px;'>loading...</div>");
			},
 			success:function(data){
 				$("#focusData").empty();
 				$("#focusData").html(data);
 			}
 		});
 }
 
 //取消关注
 function unfocus(user_id,type){
	 $.ajax({
		 type:"POST",
		 url:base+"/user/cancel",
		 data:{"f_user_id":user_id,"type":type},
		 dataType:"json",
		 success:function(data){
			 if(data.state=="success"){
				 layer.msg("取消成功！",{icon:1});
				 loadFocusDatas(1);
			 }else{
				 layer.msg("取消失败！",{icon:2});
			 }
		 }
	 })
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
</body>
</html>