<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/center.css" rel="stylesheet" />
<title>我的粉丝列表</title>
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
	                    <span class="text-white f16 ms">粉丝列表</span>
	                </div>
	                 <div id="fansData">
	                 
	                 </div>
	                <div class="clearit"></div>  
	            </div>    
	     </div>
 </div>	     
 <%@ include file="../common/footer.jsp" %>
 <script src="${ctx}/resources/js/own/msg.js"></script>
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
 			url:base+"/user/fansDatas?random="+Math.random(),
 			data:{"currentPage":currentPage,"u_id":$("#u_id").val()},
 			dataType:"HTML",
 			beforeSend:function(data){
				$("#fansData").append("<div style='width:500px;text-align:center;margin:35px auto -20px;'>loading...</div>");
			},
 			success:function(data){
 				$("#fansData").empty();
 				$("#fansData").html(data);
 			}
 		});
 }
 
 //取消关注
 function unfocus(user_id){
	 $.ajax({
		 type:"POST",
		 url:base+"/user/cancel",
		 data:{"f_user_id":user_id,"f_type":0},
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
 
 //关注
 function focusUser(user_id){
	 $.ajax({
		 type:"POST",
		 url:base+"/user/focus",
		 data:{"f_user_id":user_id,f_type:0},
		 dataType:"json",
		 success:function(data){
			 if(data.state=="success"){
				 layer.msg("关注成功！",{icon:1});
				 loadFocusDatas(1);
			 }else{
				 layer.msg("关注失败！",{icon:2});
			 }
		 }
	 })
 }
 </script>
</body>
</html>