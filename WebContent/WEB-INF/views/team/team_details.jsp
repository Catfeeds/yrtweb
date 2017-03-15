<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8" />
<!--IE 浏览器运行最新的渲染模式下-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--国产浏览器高速模式-->
<meta name="renderer" content="webkit">
<link href="${ctx}/resources/js/Canlendar/ccCanlendar.css" rel="stylesheet">
<link href="${ctx}/resources/css/clubLook.css" rel="stylesheet" />
<link href="${ctx}/resources/css/center.css" rel="stylesheet" />
<c:set var="currentPage" value="TEAMDETAIL"/>
<title>俱乐部详情</title>
<style type="text/css">
.showvdo {
     position: relative;
 }

 #playSWF {
     position: absolute;
     width: 20px;
     height: 20px;
     right: 0px;
     top: -18px;
     cursor: pointer;
     z-index: 9999;
 }

</style>
</head>
<body>
<form action="" method="post" id="babyForm">
	<input type="hidden" id="teamgame_id" name="teamgame_id" value=""/>
	<input type="hidden" id="baby_count" value="${fn:length(babyTeams.items)}"/>
	<div class="babys_cheer frame" id="gamebabyArea">
	<ul class="clearfix">
		<c:forEach items="${babyTeams.items}" var="babyTeam" varStatus="b">
			<input type="hidden" name="baby_ids" id="${babyTeam.user_id}" value="">
			<li>
				<div style="position: relative;" class="my_select">
				    <img src="${ctx}/resources/images/baby_select.png" alt="" class="b_select" id="${babyTeam.user_id}"/>
				    <div class="babys_info">
				        <span class="f14">${babyTeam.usernick}</span>
				    </div>
			   		<img src="${el:headPath()}${babyTeam.head_icon}" alt="" class="babys" />
				</div>
			</li>
		</c:forEach>
	</ul>
	    <div class="closeBtn_1"></div>
	    <div class="babys_tab">
	        <table>
	            <tr>
	                <td><span class="f18 ms text-white">&emsp;联系人 /</span></td>
	                <td><input type="text" name="contact_person" value="" class="ml10 w" id="contact_person" /></td>
	            </tr>
	            <tr>
	                <td><span class="f18 ms text-white">联系电话 /</span></td>
	                <td><input type="text" name="contact_phone" value="" class="ml10 w" id="contact_phone" /></td>
	            </tr>
	            <tr>
	                <td valign="top"><span class="f18 ms text-white">备&emsp;&emsp;注 /</span></td>
	                <td>
	                    <textarea class="ml10 mt5 w" id="remark" name="remark"></textarea>
	                </td>
	            </tr>
	            <tr>
	                <td></td>
	                <td>
	                    <input type="button" name="name" value="助威" class="invi_btn mt10 ml10 f14 ms" onclick="saveCheerBaby();"/>
	                    <input type="button" name="name" value="重置" class="cheer_btn mt10 ml10 f14 ms" id="reset" />
	                </td>
	            </tr>
	        </table>
	    </div>
	</div>
</form>	
</div>
<div class="invitation ms" style="display: none;">
		                		 	<div class="closeBtn"></div>
				               		<div class="list">
				               			<div class="player_list">
				               				<h5 style="text-align: center;font-size: 14px;color: white;">好友列表</h5>
				               				<div class="playerBox" >
				              					<select multiple="multiple" id="left">
				              						<c:forEach items="${players}" var="player">
				               							<option value="${player.id}">${player.nick}</option>
				              						</c:forEach>
				               					</select>
				               				</div>
				               			</div>
				               			<div class="addPlayer">
				               				<div>
				               					<input type="button" value="添加" id="addBtn"/>
				               					<input type="button" value="移除" id="delBtn"/>
				               					<input type="hidden" value="" name="players" id="players"/>
				               					<input type="hidden" value="" name="players_name" id="players_name"/>
				               				</div>
				               			</div>
				               			<div class="player_list">
				               				<h5 style="text-align: center;font-size: 14px;color: white;">已选列表</h5>
				               				<div class="playerBox" >
				               					<select multiple="multiple" id="right">
				               					</select>
				               				</div>
				               			</div>
				               		</div>
			               		<div class="inviteBtn">
			               			<input type="button" onclick="inviteBtn()" value="邀请">
			               		</div>
			               		</div>
	<div class="masker"></div>
	<input type="hidden" id="teaminfo_id" value="${team.id}"/><!-- 被邀请俱乐部ID -->
	<input type="hidden" id="teaminfo_name" value="${team.name}"/><!-- 被邀请俱乐部ID -->
	<input type="hidden" id="user_id" value="${user_id}"/><!-- 游客id -->
	<input type="hidden" id="s_u_id" value="${session_user_id}"/><!-- 游客id -->
	<div class="warp">
        <!--头部-->
    	<%@ include file="../common/header.jsp" %> 
   </div>	
    <!--导航 start-->
    <%@ include file="../common/naver.jsp" %>    
    <!--导航 end-->
        <div class="wrapper" style="width:1000px; margin-top: 180px;">
            <!--页面主体-->
            <div class="container" style=" border: 3px solid rgba(255,255,255,0.2);">
                <!--俱乐部描述 start-->
                <%-- <div class="clubDescribe f14 ms">
                	<div class="clubContent">
                		<c:choose>
                			<c:when test="${!empty team.logo}">
                				<img src="${el:headPath()}${team.logo}" class="pull-left" width="116" height="122">
                			</c:when>
                			<c:otherwise>
		                		<img src="${ctx}/resources/images/default_logo.png" class="pull-left" width="116" height="122">
                			</c:otherwise>
                		</c:choose>
                		<div class="pull-left ml65 mt35">
                			<table>
                				<tr>
                					<td style="font-size: 20px;color: #159EAC;width: 178px;">${team.name}</td>
                					<td style="width: 178px;">
                						<p>
                							<span>所属城市：</span>
                							<span>${team.city}</span>
                						</p>
                						<p class="mt10">
                							<span>喜爱比赛时间：</span>
                							<span>
                								<c:choose>
                									<c:when test="${team.play_time eq 1 }">周末</c:when>
                									<c:when test="${team.play_time eq 2 }">非周末</c:when>
                									<c:otherwise>
                										不限
                									</c:otherwise>
                								</c:choose>
                							</span>
                						</p>
                					</td>
                					<td>
                						<p>
                							<span>成员数：</span>
                							<span>
                								<c:choose>
                									<c:when test="${!empty re_map.p_count}">
                										${re_map.p_count}
                									</c:when>
                									<c:otherwise>
                										0
                									</c:otherwise>
                								</c:choose>
                							</span>
                						</p>
                						<p class="mt10">
                							<span>喜爱赛制：</span>
                							<span>${team.ball_format}人制</span>
                						</p>
                					</td>
                				</tr>
                				<!-- <tr>
                					<td>
	                					<span>签名：</span>
	                					<p style="display: inline-block;">xxxxxx</p>
                					</td>
                				</tr> -->
                			</table>
                		</div>
                		
                		<div style="width: 143px;height: 132px;" class="pull-left mt5">
                			<!--<img src="${ctx}/resources/images/circleClub.png" class="pull-left"/>-->
                			<div style="width: 100%;height: 66px;">
                				<div class="circle1">
                					<p style="padding-top: 10px;">
                					<c:choose>
                						<c:when test="${!empty team.score}">
                							${team.score}
                						</c:when>
                						<c:otherwise>
                							0
                						</c:otherwise>
                					</c:choose>
                					</p>
                					<p>活跃度</p>
                				</div>
                			</div>	
                			<div class="pull-left circle2">
                				<p style="padding-top: 10px;">
                					<c:choose>
                						<c:when test="${!empty re_map.p_sum}">
			                				<fmt:formatNumber value="${re_map.p_sum}" pattern="##0"/>
                						</c:when>
                						<c:otherwise>0</c:otherwise>
                					</c:choose>
                				</p>	
                				<p>能力值</p>
                			</div>
                			<div class="pull-left circle3">
                				<p class="p1">胜</p>
                				<p class="p1" style="padding-top: 0;margin-top: -2px;">
                					<c:choose>
                						<c:when test="${!empty team.win_count }">
                							${team.win_count }
                						</c:when>
                						<c:otherwise>
                							0
                						</c:otherwise>
                					</c:choose>
                				</p>
                				<p class="p1" style="padding-top: -5px;margin-top: -20px;">
                					<span>负</span>&nbsp;&nbsp;
                					<span>平</span>
                				</p>
                				<p class="p1" style="margin-top: -8px;">
                					<span>
                						<c:choose>
                							<c:when test="${!empty team.loss_count}">
                								${team.loss_count}
                							</c:when>
                							<c:otherwise>
                								0
                							</c:otherwise>
                						</c:choose>
                						
                					</span>&nbsp;&nbsp;
                					<span>
                						<c:choose>
                							<c:when test="${!empty team.draw_count}">
                								${team.draw_count}
                							</c:when>
                							<c:otherwise>
                								0
                							</c:otherwise>
                						</c:choose>
               						</span>
                				</p>
                			</div>
                		</div>
                		<c:choose>
                			<c:when test="${session_user_id eq user_id}">
	                			<!--队长看页面-->
                				<div class="admin_operate">
		                			<input type="button" value="上传结果" class="adminBtn" id="upload_matchResultBtn"/>
		                			<input type="button" value="邀请好友" class="adminBtn" onclick="addBtn()"/>
		                		 	<input type="button" value="编    辑" class="adminBtn" onclick="javscript:window.location='${ctx}/team/info/${team.id}.html'"/>
		                			<input type="button" value="解    散" class="adminBtn" onclick="dissolve(${team.id})"/>
		                		</div>
		                		 
                			</c:when>
                			<c:otherwise>
		               			<!--游客看页面-->
		               			<div class="pull-left ml25 mt35" style="width: 146px;">
		               				<c:choose>
		               					<c:when test="${is_focus == true}">
		               						<input type="button" onclick="unfocusTeam();" value="取消关注" class="operateBtn" style="background: #eb6100;color: #FFF">
		               					</c:when>
		               					<c:otherwise>
					               			<input type="button" onclick="focusTeam();" value="+关注" class="operateBtn" style="background: #eb6100;color: #FFF">
		               					</c:otherwise>
		               				</c:choose>
			               			<input type="button" value="私信" class="operateBtn" onclick="openMsg('${team.id}');"/>
			               			<c:choose>
			               				<c:when test="${is_join == true}">
			               					<input type="button" onclick="outTeam()" value="退出" class="operateBtn mt30"/>
			               				</c:when>
			               				<c:otherwise>
					               			<input type="button" onclick="joinTeam()" value="申请加入" class="operateBtn mt30"/>
			               				</c:otherwise>
			               			</c:choose>
		               				<c:if test="${is_team == true}">
		               					<c:choose>
		               						<c:when test="${is_invite ==true }">
		               							<input type="button" value="约战中" class="operateBtn mt30"/>
		               						</c:when>
		               						<c:otherwise>
						               			<input type="button" value="挑战" class="operateBtn mt30" onclick="inviteTeam()"/>
		               						</c:otherwise>
		               					</c:choose>
		               				</c:if>
		                		</div>
                			</c:otherwise>
                		</c:choose>
                	</div>
                </div> --%>
                <!-- 俱乐部描述start -->
                 <!--俱乐部描述-->
                <div class="clubDescribe f12 ms">
                	<!--左边部分-->
                	<div class="pull-left describeLeft">
                		<div class="pull-left showLogo">
                			<c:choose>
	                			<c:when test="${!empty team.logo}">
	                				<img src="${el:headPath()}${team.logo}">
	                			</c:when>
	                			<c:otherwise>
			                		<img src="${ctx}/resources/images/default_logo.png">
	                			</c:otherwise>	
                			</c:choose>
                			<dl class="pull-left mt10 ml5">
                				<dt>
                					<span class="club_win">胜</span>
                					<span class="text-white">${team.win_count}</span>
                				</dt>
                				<dd class="mt15">
                					<span class="club_fail">负</span>
                					<span class="text-white">${team.loss_count}</span>
                				</dd>
                				<dd class="mt15">
                					<span class="club_ping">平</span>
                					<span class="text-white">${team.draw_count}</span>
                				</dd>
                			</dl>
                		</div>
                		<div>
	                		<div class="pull-left ml20 mt35 div_dl">
	                			<dl>
	                				<dt>
	                					<div class="dt_underline">
		                					<span class="club_name">${team.name}</span>
		                					<span class="text-white">【${team.city}】</span>
		                				</div>	
	                					<!--<span>
	                						<input type="button" value="【上传结果】" class="admin_btn"/>
	                					</span>-->
	                				</dt>
	                				<dd class="mt5">
	                					<span class="text-white">成员数：</span>
	                					<span class="text-white">${playerCount}</span>
	                					<!--<span class="ml162">
	                						<input type="button" value="【邀请好友】" class="admin_btn"/>
	                					</span>-->
	                				</dd>
	                				<dd class="mt5">
	                					<span class="text-white">
	                						比赛时间：<yt:dict2Name nodeKey="tp_time" key="${team.play_time}"></yt:dict2Name>
	                						&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
	                						喜爱赛制：<yt:dict2Name nodeKey="ball_format" key="${team.ball_format}"></yt:dict2Name>
	                					</span>
	                				</dd>
	                				<dd class="mt5">
	                					<div class="pull-left club_nengli">
	                						<span>能力值</span>
	                						<span class="ml10">
	                							<c:choose>
			                						<c:when test="${!empty re_map.p_sum}">
						                				<fmt:formatNumber value="${re_map.p_sum}" pattern="##0"/>
			                						</c:when>
			                						<c:otherwise>0</c:otherwise>
			                					</c:choose>
	                						</span>
	                					</div>
	                					<div class="pull-left club_huoyue">
	                						<span>活跃度</span>
	                						<span class="ml10">
											<c:choose>
		                						<c:when test="${!empty team.score}">
		                							${team.score}
		                						</c:when>
		                						<c:otherwise>
		                							0
		                						</c:otherwise>
		                					</c:choose>
											</span>
	                					</div>
	                					<div class="clear"></div>
	                				</dd>
	                			</dl>
	                		</div>
	                		<div class="pull-left monster_operate">
	                			<c:choose>
		                			<c:when test="${session_user_id==user_id}">
		                				<c:choose>
			                				<c:when test="${!empty teamLeague.id}">
			                					<input type="button" value="球员邀请码" class="admin_btn" id="inviteCode" onclick="openBuy()"/>
			                				</c:when>
			                				<c:otherwise>
					                			<input type="button" value="【上传结果】" class="admin_btn" id="upload_matchResultBtn"/>
					                			<input type="button" value="【邀请好友】" class="admin_btn" onclick="addBtn()"/>
					                			<input type="button" value="【解    散】" class="admin_btn" onclick="dissolve('${team.id}')"/>
					                			<input type="button" value="【编    辑】" class="admin_btn" onclick="javscript:window.location='${ctx}/team/info/${team.id}.html'"/>
			                				</c:otherwise>
		                				</c:choose>
			                		</c:when>
			                		<c:otherwise>
			                			<c:choose>
			               					<c:when test="${is_focus == true}">
			               						<input type="button" onclick="unfocusTeam();" value="【取消关注】" class="admin_btn">
			               					</c:when>
			               					<c:otherwise>
						               			<input type="button" onclick="focusTeam();" value="【关    注】" class="admin_btn">
			               					</c:otherwise>
			               				</c:choose>			
			               				<input type="button" value="【私    信】" class="admin_btn" onclick="openMsg('${team.id}');"/>
			               				<c:choose>
				               				<c:when test="${is_join == true}">
				               					<input type="button" onclick="outTeam()" value="【退    出】" class="admin_btn mt30"/>
				               				</c:when>
				               				<c:otherwise>
						               		<!-- 	<input type="button" onclick="joinTeam()" value="【申请加入】" class="admin_btn mt30"/> -->
				               				</c:otherwise>
				               			</c:choose>
				               			<c:if test="${is_team == true}">
			               					<c:choose>
			               						<c:when test="${is_invite ==true }">
			               							<input type="button" value="【约战中】" class="admin_btn mt30"/>
			               						</c:when>
			               						<c:otherwise>
							               			<input type="button" value="【挑    战】" class="admin_btn mt30" onclick="inviteTeam()"/>
			               						</c:otherwise>
			               					</c:choose>
			               				</c:if>
			                		</c:otherwise>
			                	</c:choose>		
	                		</div>
	                	</div>
	                	<div class="clear"></div>
                		<div class="ml165">
                			<span class="text-white">简介:</span>
                			<span class="text-gray">${team.remark}</span>
                		</div>
                	</div>
                	<!--右边公告部分-->
                	<div class="pull-left club_notice">
                		<p class="c1_p">
              				<span>公告</span>
              				<span>
              					<c:if test="${session_user_id eq user_id}">
              			    		<input type="button" id="no_btn" value="【编辑】" class="edit_clubNotice" onclick="editNotice(this);"/>
              			    	</c:if>	
              				</span>
              			</p>
              			<div class="notice_txt">
              				<textarea id="notice" name="notice" id="notice" disabled="disabled" style="overflow-y:hidden">
              					${team.notice}
              				</textarea>
              			</div>
                	</div>
                </div>
                <!-- 俱乐部描述  end-->
                
                <!--俱乐部成员start-->
                <div class="mt5 ms c1">
                	<!--俱乐部球员-->
              		<div class="c1_l pull-left">
              			<p class="c1_p">
              				<span>俱乐部成员</span>
              				<span>
              					<a href="${ctx}/team/playerList?teaminfo_id=${team.id}" class="moreMembers"></a>
              				</span>
              			</p>
              			<div class="c1_members" id="playersArea">
              			</div>
              		</div>
              		<!--俱乐部的宝贝们-->
              		<div class="c1_r pull-left ml5" id="babyArea">
              		</div>
                </div>
                <!--俱乐部成员end-->
                
                <!--对战预告和屏蔽列表start-->
                <!--下方-->
                <div class="ms">
                	<!--左边start-->
                	<div class="pull-left">
                		<!--对战预告-->
	                	<div class="c2_l pull-left bottom_l1" id="gameArea"></div>
	                	<div class="bottom_l2" id="historyArea"></div>
	                	<div class="imgAndVideo mt5 bottom_l3">
               				<!--图片和视频-->
   							<%@ include file="team_imgvideo.jsp" %>
               			</div>
                	</div>
                	<!--左边end-->
                		
                	<!--右边start-->
              		<div class="pull-left bottom_r">
              			<!--屏蔽列表start-->
              			<c:if test="${session_user_id eq user_id}">
              				<div class="c2_r pull-left ml5 bottom_r1" id="blackArea"></div>	
              			</c:if>
              			<!--屏蔽列表end-->
              			<!--受邀列表start-->
              			<c:if test="${session_user_id eq user_id}">
	                		<div class="invitList bottom_r2" id="inviteArea"></div>
	                	</c:if>
	                	<!--受邀列表end-->
	                	<!--俱乐部访客记录-->
	                	<div class="visitorRecord bottom_r3" id="sysvisitor"></div>
                	</div>
                	<!--右边end-->
                <!--历史记录、受邀列表、图片视频、俱乐部访客记录end-->
      		</div>
           		<!--下方-->
            	<div class="buyInviteCode"></div>
                <!--上传比赛结果start-->
                <div id="upload_matchResult"></div> 
                <!--上传比赛结果end-->
				<!--pk弹出层start-->               
                <div class="pk" id="inviteDialog"></div>
                <!--pk弹出层end-->  
            </div>
        </div>
         <div id="showVideo"><img id="playSWF" src="${ctx}/resources/images/close.png"/><div id="a1" class="showvdo"></div></div>
        <!--页脚-->
   	<%@ include file="../common/footer.jsp" %>
   	<script src="${ctx}/resources/layer/extend/layer.ext.js"></script>
    <script src="${ctx}/resources/sliderengine/amazingslider.js"></script>
    <script src="${ctx}/resources/sliderengine/initslider-1.js"></script>
   	<script src="${ctx}/resources/js/own/tdetails.js"></script>
   	<script src="${ctx}/resources/js/own/playeropt.js"></script>
   		<script src="${ctx}/resources/js/mouse.js"></script>
	 <script src="${ctx}/resources/js/Canlendar/ccCanlendar.js"></script>
	   <script src="${ctx}/resources/js/plugins.js"></script>
        <script src="${ctx}/resources/js/sly.js"></script>
        <script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
    <script type="text/javascript">
    
    jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }
    
    $(".babys_cheer").center();
    
    function showVideo(video){
    	
	}
	var btn = $("#playSWF");
    btn.click(function () {
        $("#showvdo").html("");
        $(".login_masker").hide();
        $('#showVideo').hide();
    });

  	  //added by bo.xie 解散俱乐部
		function dissolve(team_id){
			layer.confirm('确定要解散吗？', {
	    	    btn: ['确定','取消'], //按钮
	    	    shade: false //不显示遮罩
	    	}, function(){
	    		$.ajaxSec({
					type:"POST",
					url:base+"/team/dissolve?random="+Math.random(),
					data:{"team_id":team_id},
					dataType:"JSON",
					success:function(data){
						if(data.state=="error"){
							layer.msg(data.message.error[0],{icon: 2});
						}else{
							window.location = base+"/team/guide";
						}
					}
				});
	    	}, function(){});
       	}
        //弹出上传比赛结果
        $("#upload_matchResultBtn").click(function(){
			$.ajax({
				type:"POST",
				url:base+"/teamInvite/haveResult",
				data:{"team_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				success:function(data){
					if(data.state=="success"){
						if(data.data.size!=0){
							$.loadSec("#upload_matchResult",base+'/teamInvite/resultPage',{"team_id":$("#teaminfo_id").val()},function(){
					        	$("#upload_matchResult").css("display","block");
					        	//获取遮罩高度并显示
					        	$(".masker").height($(document).height());
					        	$('.masker').fadeIn();
				            });
						}else{
							layer.msg('没有比赛记录',{icon: 2});
						}
					}
				}
			});
        });
        //关注
        function focusTeam(){
		 $.ajaxSec({
				type:"POST",
				url:base+"/team/focusTeam?random="+Math.random(),
				data:{"f_teaminfo_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						window.location.reload();
					}
				}
			}); 
        }
        //取消关注
        function unfocusTeam(){
        	$.ajaxSec({
				type:"POST",
				url:base+"/team/cancel?random="+Math.random(),
				data:{"f_teaminfo_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						window.location.reload();
					}
				}
			});
       }
        
		//退出俱乐部
        function outTeam(){
        	$.ajaxSec({
				type:"POST",
				url:base+"/team/outTeam?random="+Math.random(),
				data:{"player_id":'${session_user_id}',"teaminfo_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						window.location.reload();
					}
				}
			});
        }

        //申请加入俱乐部
        function joinTeam(){
        	$.ajaxSec({
				type:"POST",
				url:base+"/team/joinTeam?random="+Math.random(),
				data:{"player_id":'${session_user_id}',"teaminfo_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				secMsg:"\u8bf7\u5148\u6fc0\u6d3b\u7403\u5458\u4fe1\u606f",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						window.location.reload();
					}
				}
			});
        }
        
        //挑战界面
        function inviteTeam(){
			if('${fq_login_ti.id}'==$("#teaminfo_id").val()){
				layer.msg("自己不能挑战自己",{icon: 0});
			}else{
				/* $.ajaxSec({
					type:"POST",
					url:base+"/teamInvite/ifPk?random="+Math.random(),
					data:{"teaminfo_id":$("#teaminfo_id").val()},
					success:function(data){
						if(data.state=="success"){
							if(data.data.teamGame == null){ */
								$.loadSec("#inviteDialog",base+"/teamInvite/page",function(){
									$("#inviteDialog").center().css("display","block");
									 $(".masker").height($(document).height()).fadeIn();
									//向invite_page页面注入俱乐部等信息
									//发起邀请方
									$("#fa_teaminfo_id").val('${fq_login_ti.id}');
									$("#fa_t_name").val('${fq_login_ti.name}');
									$("#fa_t_logo").val('${fq_login_ti.logo}');
									//被邀请方
									$("#respond_teaminfo_id").val($("#teaminfo_id").val());
									$("#re_r_name").val('${team.name}');
									$("#re_r_logo").val('${team.logo}');
									$("#flush_page").val(true);
								});	
						/* 	}
						}else{
							layer.msg(data.message.error[0],{icon:2});
						}
					}
				}); */
			}
        }
        $(function(){
        	load_team_img_video(base+'/team/queryTeamImages',5,'image');
        	load_team_img_video(base+'/team/queryTeamImages',5,'video');
        })
        
        //add by ylt 系统消息同意 2015-09-01
        function openMsg(t_id){
		var s_id = "";
		var usernick = "";
		$.ajaxSec({
			type: 'POST',
			url: base+"/team/getCaption",
			data:{"teaminfo_id":t_id},
			success: function(result){
				s_id = result.data.user.id;
				usernick = result.data.user.usernick;
				if(s_id == ""){
					layer.msg("获取俱乐部队长失败!",{icon: 0});
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
			},
			error: $.ajaxError
		});
	}
    //add ylt 显示邀请好友面板
    function addBtn(){
    	$('.invitation').css('display','block');
    	//获取遮罩高度并显示
    	$(".masker").height($(document).height());
    	$('.masker').fadeIn();
    }
    
  //球员选择添加按钮控件
	  $("#addBtn").click(function() {
		  var leftOption = $("#left").find("option:selected");
		  if((typeof leftOption.attr("value")) == 'undefined'){ 
			  layer.msg("请选择需要邀请的球员",{icon:0});
		  }else{
			  var clone = leftOption.clone();
			  $("#right").append(clone);
			  var players = leftOption.val()+","+$("#players").val();
			  var players_name = leftOption.text()+","+$("#players_name").val();
			  if($("#players").val() == ""){
				  players =  players.replace(",","");
				  players_name =  players_name.replace(",","");
			  }
			  $("#players").val(players);
			  $("#players_name").val(players_name);
			  leftOption.remove();
		  }
	   });
	//球员选择删除按钮控件
	  $("#delBtn").click(function() {
		  var rightOption = $("#right").find("option:selected");
		  if((typeof rightOption.attr("value") == 'undefined')){ 
			  layer.msg("请选择需要删除的球员",{icon:0});
		  }else{
			  var clone = rightOption.clone();
			  $("#left").append(clone);
			  var players = $("#players").val();
			  var players_name = $("#players_name").val();
			  if(players.indexOf(",") < 0){
				  players = "";
				  players_name = "";
			  }else{
				  if(players.indexOf(rightOption.val()) == 0){ 
					  players = players.replace(rightOption.val()+",","");
					  players_name = players_name.replace(rightOption.val()+",","");
				  }else{
					  players = players.replace(","+rightOption.val(),"");
					  players_name = players_name.replace(","+rightOption.text(),"");
				  }
			  }
			  $("#players").val(players);
			  rightOption.remove();
		  }
	   });
	  //发送加队邀请
	  function inviteBtn(){
		  var jsonData = {
		  	  "teaminfo_id":$("#teaminfo_id").val(),
		  	  "players":$("#players").val(),
		  	  "teaminfo_name":$("#teaminfo_name").val()
		  };
		  $.ajaxSec({
				type:"POST",
				url:base+"/team/sendJoinMsg?random="+Math.random(),
				data: jsonData,
				dataType:"JSON",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						layer.msg("发送成功!",{icon: 1});
						$('.invitation').css('display','none');
						$(".masker").fadeOut();//隐藏遮罩层
						//window.location.reload();
					}
				}
			});		
	  }
	  
	  //关闭按钮
	  $(".closeBtn").click(function(){
        	$('.invitation').css('display','none');
        	$('.masker').fadeOut();//去除遮罩
        });
      
	  (function () {
          var $frame = $('#gamebabyArea');
          var $wrap = $frame.parent();
          // Call Sly on frame
          $frame.sly({
        	  horizontal: 1,
              itemNav: 'forceCentered',
              smart: 1,
              activateMiddle: 1,
              mouseDragging: 1,
              touchDragging: 1,
              releaseSwing: 1,
              startAt: 1,
              scrollBar: $wrap.find('.scrollbar'),
              scrollBy: 1,
              speed: 300,
              elasticBounds: 1,
              easing: 'easeOutExpo',
              dragHandle: 1,
              dynamicHandle: 1,
          });
      }());
	  
	  $($(".my_select")).each(function () {
		    $(this).click(function () {
		        if ($(this).find(".b_select").is(":visible")) {
		            $(this).find(".b_select").hide();
		            var id = $(this).find(".b_select").attr("id");
		            $("#"+id).val("");
		        } else {
		            $(this).find(".b_select").show();
		            var id = $(this).find(".b_select").attr("id");
		            $("#"+id).val(id);
		        }
		    });

		});
	  $(".closeBtn_1").click(function(){
		  $("#gamebabyArea").hide();  
		  $("#invitation").hide();
      });
	  $("#reset").click(function () {
          $("#name").val("");
          $("#phone").val("");
          $("#zhuyi").val("");
      });
	  $("#reset").click(function () {
          $("#contact_person").val("");
          $("#contact_phone").val("");
          $("#remark").val("");
      });
	  
	  function editNotice(dom){
		  var jsonData = {
			  "teaminfo_id":$("#teaminfo_id").val(),
		  	  "notice":$("#notice").val()			  
		  }
		  if($("#notice").attr("disabled") == "disabled"){
			  $("#notice").attr("disabled",false);
			  $(dom).val("【保存】");
		  }else{
			  $.ajaxSec({
					type:"POST",
					url:base+"/team/editNotice",
					data: jsonData,
					dataType:"JSON",
					success:function(data){
						if(data.state=="error"){
							layer.msg(data.message.error[0],{icon: 2});
						}else{
							layer.msg(data.message.success[0],{icon: 1});
						  	$("#notice").attr("disabled","disabled");
						  	$(dom).val("【编辑】");
						}
					}
				});		
		  }
	  }
	  
	 
      
      
</script>
</body>
</html>