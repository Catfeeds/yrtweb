<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>转会公告列表</title>
</head>
<body>
<div class="warp">
 	<!--头部-->
    <%@ include file="../../common/header.jsp" %>
	<!--导航 start-->
    <%@ include file="../../common/naver.jsp" %>    
	<!--导航 end-->
        
	<div class="wrapper" style="margin-top: 40px;">
   		<div id="league_market_list" class="zh">
        </div>
    </div>
<%@include file="../../common/footer.jsp" %>

</body>
<script type="text/javascript">
$(function(){
	load_league_market('${s_id}',1);
})

function load_league_market(s_id,cur){
	var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="width: 40px;height: 40px;margin-left: 482px;margin-top: 24px;">';
	if(!cur) cur = 1;
 	$.ajax({
 		type:"POST",
 		url:base+"/playerTrade/queryLeagueMarket",
 		data:{"s_id":s_id,currentPage:cur,pageSize:16},
 		dataType:"HTML",
 		beforeSend:function(){
 			$("#league_market_list").empty();
 			$("#league_market_list").append(tempHtml);
 		},
 		success:function(data){
 			$("#league_market_list").empty();
 			$("#league_market_list").append(data);
 		}
 	});
}

</script>
</html>