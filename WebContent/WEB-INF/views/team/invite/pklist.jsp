<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/js/Canlendar/ccCanlendar.css" rel="stylesheet">
<link href="${ctx}/resources/css/clubPk.css" rel="stylesheet" />
<c:set var="currentPage" value="TEAMDETAIL"/>
<title>对战PK邀请</title>
</head>
<body>
	<div class="masker"></div>
	<input type="hidden" id="teaminfo_id" value="${teamInfo.id}"/>
	<div class="warp">
        <!--头部-->
    	<%@ include file="../../common/header.jsp" %> 
   </div>	
    <!--导航 start-->
    <%@ include file="../../common/naver.jsp" %>    
    <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container ms f14">
            	<!--内容部分-->
               <div class="middle ms f14">
               			<p class="pk_title">对战PK邀请</p>
               			<div class="pkInfo">
               				<form action="" method="post" id="pkForm">
	               				<div style="width: 915px;margin: 0 auto;margin-top: 20px;">
	               					<span>
	               						<span>比赛时间：</span>
	               						<select class="pk_select" name="play_time" id="play_time">
	               							<option value="">请选择</option>
	               							<option value="1">周末</option>
	               							<option value="2">非周末</option>
	               						</select>
	               					</span>
	               					
	               					<span style="margin-left: 30px;">
	               						<span>所在城市：</span>
	               						<select id="s_province" name="province"></select>&nbsp;
		                                <select id="s_city" name="city" id="city"></select>&nbsp;
	               					</span>
	               					
	               					<span style="margin-left: 30px;">
	               						<span>对战赛制：</span>
	               						<yt:dictSelect name="ball_format" nodeKey="ball_format" value="" clazz="pk_select"></yt:dictSelect>
	               					</span>
	               					
	               					<input type="button" value="开始匹配" class="startPk" onclick="searchPk(0)"/>
	               				</div>
               				</form>
               			</div>
               			
               			<div class="pk_bottom" id="pkArea">
               				<ul id="sArea">
               				</ul>
               				<ul class='ml110' id="xArea">
               				</ul>
               				<div id="bArea">
               				</div>
               			</div>
               </div>
               <!--PK弹出层-->
               <!-- 俱乐部邀请挑战弹窗start -->
			    <div id="inviteDialog" class="pk">
			    </div>
    		   <!-- 俱乐部邀请挑战弹窗end -->
    	</div>
	</div>
	
        <!--页脚-->
   	<%@ include file="../../common/footer.jsp" %>
   	 <script src="${ctx}/resources/js/area.js"></script>
   	 <script src="${ctx}/resources/js/mouse.js"></script>
	 <script src="${ctx}/resources/js/Canlendar/ccCanlendar.js"></script>
   	 <script src="${ctx}/resources/js/own/pklist.js"></script>
     <script type="text/javascript">
     jQuery.fn.center = function () {
         this.css("position", "absolute");
         this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
         this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
         return this;
     }
      new PCAS('province', 'city');
      //挑战界面
      function inviteTeam(r_id,r_name,r_logo){
 		/* $.ajaxSec({
			type:"POST",
			url:base+"/teamInvite/ifPk?random="+Math.random(),
			data:{"teaminfo_id":$("#teaminfo_id").val()},
			success:function(data){
				if(data.state=="success"){
					if(data.data.teamGame == null){ */
						$.loadSec("#inviteDialog",base+"/teamInvite/page",function(){
				      		$("#inviteDialog").center().css("display","block");
				      		//获取遮罩高度并显示
				        	$(".masker").height($(document).height());
				        	$('.masker').fadeIn();
				      		//向invite_page页面注入俱乐部等信息
				      		//发起邀请方
				      		$("#fa_teaminfo_id").val('${teamInfo.id}');
				      		$("#fa_t_name").val('${teamInfo.name}');
				      		$("#fa_t_logo").val('${teamInfo.logo}');
				      		//被邀请方
				      		$("#respond_teaminfo_id").val(r_id);
				      		$("#re_r_name").val(r_name);
				      		$("#re_r_logo").val(r_logo);
				      		$("#flush_page").val(false);
				      	});	
					/* }else{
						layer.msg("请确认当前俱乐部已有比赛是否已经完成并确认上传结果后再发起邀请",{icon: 2});
					}
					
				}else{
					layer.msg(data.message.error[0],{icon: 2});
				}
				
			}
 		}); */
      }
      
      
    </script>
</body>
</html>