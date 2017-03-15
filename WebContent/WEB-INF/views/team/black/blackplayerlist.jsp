<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../common/common.jsp" %>
<title>宇任拓-球员列表</title>
<link href="${ctx}/resources/css/photoAlbum.css" rel="stylesheet" />
</head>
<body>
    <div class="warp">
        <!--头部、导航-->
		<%@ include file="../../common/header.jsp" %>
		<input type="hidden" id="teaminfo_id" value="${teaminfo_id}"/><!-- 俱乐部ID -->
		<input type="hidden" id="user_id" value="${user_id}"/><!-- 俱乐部队长ID -->
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <div class="mt20">
                    <div class="p_title_1" style="text-align: center;">
                        <span class="f14 ml20 ms text-white">球员黑名单</span>
                        
                    </div>
                    <div class="blacklist" id="blacklist">
                    </div>
                </div>
            </div>
        </div>
    </div>
  	<%@ include file="../../common/footer.jsp" %>
    <script type="text/javascript">
        $(function () {
            $(".be tr:odd").not("th").css({ "background": "#2d2d2d" });
            loadBlackList(0);
        });

      //add by ylt 踢出黑名单
      function kickBlack(player_id){
      	$.ajaxSec({
      		type: 'POST',
      		url: base+"/team/kickBlackPlayer",
      		data: {"teaminfo_id":$("#teaminfo_id").val(),"player_id":player_id},
      		success: function(data){
      			if(data.state=='error'){
      				layer.msg(data.message.error[0]);
      			}else{
      				layer.msg("移除成功!");
      				loadBlackList(0);
      			}
      		},
      		error: $.ajaxError
      	});	
      }
      
    //add by ylt 俱乐部黑名单
      function loadBlackList(pageIndex){
      	$.ajax({
      		type: 'POST',
      		url: base+"/team/black/result_black",
      		data: {"teaminfo_id":$("#teaminfo_id").val(),"currentPage":pageIndex,"user_id":$("#user_id").val()},
      		dataType:"html",
      		success: function(data){
      			if(data.state=='error'){
      				layer.msg(data.message.error[0]);
      			}else{
      				$("#blacklist").html(data);
      			}
      		},
      		error: $.ajaxError
      	});	
      }
    </script>
</body>
</html>
