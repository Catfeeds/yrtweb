<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../common/common.jsp" %>
    <title>赛程球员信息统计</title>
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" />	
	<link href="${ctx}/resources/css/master.css" rel="stylesheet" />	
	<link href="${ctx}/resources/css/league.css" rel="stylesheet" />	
</head>
<body>
    <div class="warp">
         <!--头部-->
         <%@ include file="../../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>    
        <div class="wrapper" style="margin-top: 80px;">
            <div class="count">
                <div class="title">
                    <span class="f18 ms ml10"><a href="${ctx}/league/index?league_id=${matchInfo.league_id}" class="text-white">联赛首页</a>&emsp;》&emsp;
                    						  <a href="${ctx}/league/eventRecords?league_id=${matchInfo.league_id}" class="text-white">全部赛程</a>&emsp;》&emsp;</span>
                    <span class="ms" style="position: absolute;">第${eventRecord.rounds}轮 ${h_team.name} VS ${v_team.name} 技术统计</span>
                </div>
                <div class="home_guest" id="playersList">
                
				</div>
                <input type="button" name="name" value="查看球队数据" class="checkbtn f16 ms pull-right mr50 mt20" onclick="toTeamsInfoPage('${eventRecord.id}')"/>
                <div class="clearit"></div>
            </div>
        </div>
    </div>

</body>
<%@ include file="../../common/footer.jsp" %>
<script type="text/javascript">
$(function(){
	var q_match_id = "${matchInfo.id}";
	var teaminfo_id = "${h_team_id}";
	load_player_datas(q_match_id,teaminfo_id,1);
})
 
function load_player_datas(q_match_id,teaminfo_id,team_status){
	var params = $.param({q_match_id:q_match_id,teaminfo_id:teaminfo_id,team_status:team_status});
	$("#playersList").load( base+'/league/leaguePlayers', params, function () {
		if(team_status == 1){
			$("#visit").removeClass("active");
			$("#home").addClass("active");
		}else{
			$("#home").removeClass("active");
			$("#visit").addClass("active");
		}
	});
}
function toTeamsInfoPage(id){
	var params = "id="+id;
	window.location.href="${ctx}/league/statistics?"+params;
}
</script>
</html>
