<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-球员报名</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<c:set var="currentPage" value="LEAGUEINDEX"/>
</head>
<body>
	<div class="warp">
		<div class="masker"></div>
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
     	<div class="wrapper" style="margin-top: 116px;">
            <div class="league_reg">
                <div class="internal_border">
                	<input type="hidden" name="cfg_id" id="cfg_id" value="${cfg.id}"/>
                    <p class="title_1">欢迎报名参加宇任拓<yt:areaName code="${cfg.area_code}"></yt:areaName>赛区<yt:dict2Name nodeKey="season" key="${cfg.season}"></yt:dict2Name></p>
                    <p class="title_2 ms">您将以何种身份参赛</p>
                    <div class="int_pic">
                        <ul>
                            <li><a href="javascript:;" onclick="m_league_sign('${cfg.id}','team')"><img src="${ctx}/resources/images/admin.jpg" alt="" /></a> </li>
                            <li><a href="javascript:;" onclick="m_league_sign('${cfg.id}','player')"><img src="${ctx}/resources/images/player_1.jpg" alt="" /></a></li>
                            <div class="clearit"></div>
                        </ul>
                    </div>
                    <div class="btn_div">
                        <input type="button" onclick="m_league_sign('${cfg.id}','team')" value="俱乐部管理者" class="admin_sbtn ml30 mt20" />
                        <input type="button" onclick="m_league_sign('${cfg.id}','player')" value="球员" class="player_sbtn mt20" style="margin-left: 200px;"/>
                        <input type="button" onclick="javascript:window.location.href='${ctx}/league/selectArea';" value="重选赛区" class="btn_l f14" style="margin-left: 225px;margin-top:35px; font-family: 'Microsoft YaHei';"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/js/own/invite_msg.js"></script>
<script type="text/javascript">
var iframeAgree;
function agreements(cfgid,type){
	iframeAgree = layer.open({
	    type: 2,
	    title: '《联赛协议》',
	    shadeClose: true,
	    shade: [0.6],
	    area: ['670px', '560px'],
	    content: base+'/league/agreement?cfgid='+cfgid+'&type='+type //iframe的url
	}); 
}

function closeAframe(){
	layer.close(iframeAgree);
	$(".masker").fadeOut();
}

function m_league_sign(cfg_id,type){
	$.ajaxSec({
		type: 'POST',
		url: '${ctx}/league/checkAgainSign',
		data: {"cfg_id":cfg_id},
		cache: false,
		success: function(data){
			if(data.state=='success'){
				if(data.data&&data.data.sign_again=='1'){
					yrt.confirm('是否取消'+data.data.area+'赛区的报名？', {
					    btn: ['是','否'], //按钮
					    shade: true,
					    cwidth:'70%'
					}, function(){
						$.ajaxSec({
							type: 'POST',
							url: '${ctx}/league/quitLeagueSign',
							cache: false,
							success: function(result){
								if (result.state=='success') {
									yrt.msg("取消报名成功",{icon: 1});
									setTimeout(function(){
										m_league_sign(cfg_id);
									},1400);
				                } else {
				                	if(result.data&&result.data.l_status==1){
				                		yrt.msg("取消失败，您已在"+data.data.area+"赛区报名成功！",{icon: 1});
				                		setTimeout(function(){
				    						location.reload();
				    					},1400);
				            		}else{
					                	yrt.msg("取消报名失败,"+result.message.error[0],{icon: 2});
				            		}
				                }
							},
							error: $.ajaxError
						});
					}, function(){});
				}else{
					user_to_sign(cfg_id,type);
				}
			}else{
				layer.msg(data.message.error[0],{icon: 0});
			}
		},
		error: $.ajaxError
	});
}


function user_to_sign(cfgid,type,flag){
	var lurl = type=='team'?base+"/league/teamSign?cfg_id="+cfgid:base+'/league/toSign?cfg_id='+cfgid;
	$.ajaxSec({
		type:'POST',
		url: base+'/league/checkAuth',
		data:{cfg_id:cfgid,rtype:type},
		success: function(result){
			if(flag){
				if(result.state=='success'){
					location.href=lurl;
				}else{
					var t = result.data?result.data.team.type:null;
					if(t&&('staff'==t)){
						quitTeam(result.message.error[0],result.data.team.id,lurl);
					}else{
						layer.alert(result.message.error[0],{icon: 0,area:'500px'});
					}
				}
			}else{
				if(result.data&&result.data.user_cert==1){
					yrt.confirm('只有已通过实名认证的用户可选择俱乐部管理者身份参赛，请先进行实名认证！', {
					    btn: ['前往实名认证','取消'],
					    cwidth:'92%'
					}, function(){
					    location.href=base+'/certificat/IDinfo';
					}, function(){});
				}else{
					if(result.state=='success'){
						user_to_sign(cfgid,type,true);
					}else{
						layer.alert(result.message.error[0],{icon: 0,area:'500px'});
					}
				}
			}
			
		},
		error: $.ajaxError
	});
}

function quitTeam(msg,tid,lurl){
	yrt.confirm(msg, {
	    btn: ['退出俱乐部','放弃报名'], //按钮
	    shade: true
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/player/quitTeam',
			data: {"teaminfo_id":tid},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					yrt.msg("退出成功",{icon: 1});
					location.href=lurl;
                } else {
                	yrt.msg("退出失败,"+result.message.error[0],{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}
</script>
</body>
</html>