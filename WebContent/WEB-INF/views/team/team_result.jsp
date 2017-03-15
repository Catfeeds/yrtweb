<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<input type="hidden" id="team_id" value="${team_id}"/>
	<div class="matchResult mt100 ms">
		<div class="closeBtn"></div>
		<div>
			<img src="${ctx}/resources/images/matchResult.png" width="214px" height="52px"
				style="margin: 0 auto; padding-top: 15px;" />
		</div>
		<div class="show_result">
			<div style="width: 320px; height: 36px; margin: 0 auto; margin-top: 15px;">
				<span class="f14">比赛场次：</span> 
				<select class="mat_select" style="text-align: center;" name="id" onchange="selectVal(this)">
					<c:forEach items="${games}" var="game">
						<option value="${game.id}">
							<fmt:formatDate value="${game.game_time }" pattern="yyyy-MM-dd"/>(主) ${game.t_name} vs ${game.r_name}(客)
						</option>
					</c:forEach>
				</select>
			</div>
			<c:forEach items="${games}" var="game">
				<div id="gd_${game.id}" style="display:none;">
						<fmt:formatDate value="${game.game_time }" pattern="yyyy-MM-dd" var="g_time"/>
						<input type="hidden" name="t_id" value="${game.initiate_teaminfo_id}"/><!-- 主队俱乐部ID -->
						<input type="hidden" name="t_name" value="${game.t_name}"/><!-- 主队俱乐部名称 -->
						<input type="hidden" name="t_logo" value="${game.t_logo}"/><!-- 主队俱乐部logo -->
						<input type="hidden" name="r_id" value="${game.respond_teaminfo_id}"/><!-- 客队俱乐部ID -->
						<input type="hidden" name="r_name" value="${game.r_name}"/><!-- 客队俱乐部名称 -->
						<input type="hidden" name="r_logo" value="${game.r_logo}"/><!-- 客队俱乐部logo -->
						<input type="hidden" name="ball_format" value="${game.ball_format}"/><!-- 比赛赛制 -->
						<input type="hidden" name="gameTime" value="${g_time}"/><!-- 比赛时间 -->
				</div>
			</c:forEach>
			<div style="width: 304px; height: 90px; margin: 0 auto; margin-top: 35px;">
				<div class="clubInfo">
					<c:forEach items="${games}" var="game" end="0">
						<img src="${el:headPath()}${game.t_logo}" width="46px" height="47px" style="margin: 0 auto;"/>
						<p style="color: #997570;font-size: 10px;text-align: center;">
								${game.t_name}
						</p>
					</c:forEach>
					<p style="text-align: center;">
						<select style="width: 55px; " id="initiate_score">
							<c:forEach begin="0" step="1" end="20" varStatus="num">
								<option value="${num.index}">${num.index}</option>
							</c:forEach>
						</select>
					</p>
				</div>
				<div style="width: 35px; float: left; height: 100%; margin-top: 15px; margin-left: 48px; margin-right: 48px;">
					<img src="${ctx}/resources/images/vs.png" width="35px" height="21px" />
					<p style="text-align: center; margin-top: 30px; font-size: 20px;">
						<span>:</span>
					</p>
				</div>
				<div class="clubInfo">
					<c:forEach items="${games}" var="game" end="0">
						<img src="${el:headPath()}${game.r_logo}" width="46px" height="47px" style="margin: 0 auto;"/>
						<p style="color: #997570;font-size: 10px;text-align: center;">
								${game.r_name}
						</p>
					</c:forEach>
					<p style="text-align: center;">
						<select style="width: 55px;" id="respond_score">
							<c:forEach begin="0" step="1" end="20" varStatus="num">
								<option value="${num.index}">${num.index}</option>
							</c:forEach>
						</select>
					</p>
				</div>
			</div>
			 <div class="clearit"></div>
			<div style="width: 188px; height: 68px; margin: 0 auto;">
				
					<span class="f12 ml25">赛制：<span id="ball_format">
						<c:forEach items="${games}" var="game" end="0">
							<input type="hidden" id="game_id" value="${game.id}"/>
							${game.ball_format}人制
						</c:forEach>
					</span></span>
					
				
				<p style="text-align: center;margin-top: 10px;">
					<span class="f14">比赛时间：</span>
					<span id="game_time">
						<c:forEach items="${games}" var="game" end="0">
							<fmt:formatDate value="${game.game_time }" pattern="yyyy-MM-dd"/>
						</c:forEach>	
					</span>
				</p>
			</div>	
		</div>
		<div style="clear: both;"></div>
		<div style="width: 230px; height: 25px; margin: 0 auto; margin-top: 10px;">
			<input type = "button" value="提交" class="matchResult_Btn pull-left" onclick="submitScore()"/>
			<input type = "button" value="取消" class="matchResult_Btn pull-right" id="cancel_matchResultBtn"/>
		</div>
	</div>
<script>
//取消上传比赛结果upload_matchResultBtn
$("#cancel_matchResultBtn").click(function(){
	$("#upload_matchResult").css("display","none");
	//隐藏遮罩
	$('.masker').fadeOut();
});

$(".closeBtn").click(function(){
	$("#upload_matchResult").css("display","none");
	//隐藏遮罩
	$('.masker').fadeOut();
});
var game_id=$("#game_id").val();
//切换比赛场次
function selectVal(dom){
	  game_id = $(dom).select().val();
	//主队俱乐部名称
	var t_name = $("#gd_"+game_id).children("input[name='t_name']").val();
	//主队俱乐部logo
	var t_logo = $("#gd_"+game_id).children("input[name='t_logo']").val();
	//客队俱乐部名称
	var r_name = $("#gd_"+game_id).children("input[name='r_name']").val();
	//客队俱乐部logo
	var r_logo = $("#gd_"+game_id).children("input[name='r_logo']").val();
	//比赛赛制
	var ball_format = $("#gd_"+game_id).children("input[name='ball_format']").val();
	//比赛时间
	var gameTime = $("#gd_"+game_id).children("input[name='gameTime']").val();
	
	//切换对战俱乐部log名称等等
	var l_html='<img src="'+ossPath+t_logo+'" width="46px" height="47px" style="margin: 0 auto;"/>';
		l_html+='<p style="color: #997570;font-size: 10px;text-align: center;">'+t_name+'</p>';
		$("#leftClubInfo").empty();
		$("#leftClubInfo").append(l_html);
		
	var r_html='<img src="'+ossPath+r_logo+'" width="46px" height="47px" style="margin: 0 auto;"/>';
		r_html+='<p style="color: #997570;font-size: 10px;text-align: center;">'+r_name+'</p>';
		$("#rightClubInfo").empty();
		$("#rightClubInfo").append(r_html);
		
	$("#ball_format").empty();
	$("#ball_format").append(ball_format+"人制");
	$("#game_time").empty();
	$("#game_time").append(gameTime);
}

//提交比分
function submitScore(){
	$.ajaxSec({
		type:"POST",
		url:base+"/teamInvite/uploadResult?random="+Math.random(),
		data:{"id":game_id,"teaminfo_id":$("#team_id").val(),"initiate_score":$("#initiate_score").val(),"respond_score":$("#respond_score").val()},
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
</script>