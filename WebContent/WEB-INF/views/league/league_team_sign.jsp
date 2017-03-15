<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-俱乐部报名</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<link href="${ctx}/resources/css/clubSign.css" rel="stylesheet" />
</head>
<body>
	<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
	     <div class="wrapper" style="margin-top: 116px;">
            <div class="reg_result">
                <div class="player_reg" style="padding-top: 20px;margin-top:0;">
                    <ul style="margin-left: 148px;">
                        <li class="actived"><span>1、报名须知</span></li>
                        <li class="active"><span>2、填写资料</span></li>
                        <li class=""><span>3、完成</span></li>
                        <div class="clearit"></div>
                    </ul>
                </div>
                <div class="clubs">
                    <img src="${el:headPath()}${team.logo}" />
                </div>
                <form id="league_team_form" action="${ctx}/league/applyTeamSign">
                <input type="hidden" name="s_id" id="cfg_id" value="${cfg_id}"/>
                <input type="hidden" name="teaminfo_id" value="${team.id}"/>
                <div class="clubs_active">
                    <dl>
                        <dt><span>俱乐部名称：</span><span>${team.name}</span></dt>
                        <dt><span>俱乐部简称：</span><c:choose><c:when test="${empty team.sim_name}"><span><input type="text" name="sim_name" value="" valid="require len(1,8)" /></span></c:when>
                        	<c:otherwise>
                        <span>${team.sim_name}</span>
                        	</c:otherwise>
                        </c:choose>
                        </dt>
                        <dd><span>联赛邀请码：</span><input type="text" name="code_str" valid="require" value="" /></dd>
                    </dl>
                </div>
                <div class="result_title" style="background: none;">
                    <span class="ml20 f16 ms" style="color:#666666;">提示：俱乐管理者可在XXXX-XX-XX XX:XX 进入球员市场，竞拍您心仪的的球员。 </span>
                </div>
                </form>
                <div class="prompt" id="delArea" style="display: none">
                	<span class="text-white ml40">提示：您在宇任拓创建的俱乐部中有其他成员存在，本次联赛暂不支持组队报名，请您移除俱乐部中的其他成员或放弃参加本次联赛。</span>
                	<span>
                		<input type="button" onclick="delete_all_players()" value="移除"/>
                	</span>
                </div>
                <div style="width:600px;margin: 60px auto 0;text-align: center; ">
                    <input type="button" onclick="$.ajaxSubmit('#league_team_form','#league_team_form',league_callback);" value="报名" class="btn_l f18 ms">
                    <input type="button" onclick="location.href='/league/identity?cfg_id=${cfg_id}'" value="取消" class="btn_g f18 ms">
                </div>
            </div>

        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/js/own/invite_msg.js"></script>
<script type="text/javascript">
function league_callback(result){
	if(result.state=='success'){
		location.href=base + '/league/teamSign?cfg_id='+$("#cfg_id").val();
	}else{
		if(typeof(result.data) != "undefined"){
			$("#delArea").css("display","block");				
		}
		layer.msg(result.message.error[0],{icon:2});
	}
}

function delete_all_players(){
	yrt.confirm('是否移除俱乐部其他球员？', {
	    btn: ['是','否'], //按钮
	    shade: true
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+"/league/deleteAllPlayers",
			success: function(data){
				if(data.state=='error'){
					yrt.msg(data.message.error[0],{icon:2});
				}else{
					yrt.msg("移除成功！",{icon:1});
				}
			},
			error: $.ajaxError
		});	
	}, function(){});
}
</script>
</body>
</html>