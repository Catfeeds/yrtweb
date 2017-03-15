<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>身价榜列表</title>
</head>
<body>
<div class="warp">
	<!--头部-->
	<%@ include file="../../common/header.jsp" %>
	<!--导航 start-->
	<%@ include file="../../common/naver.jsp" %>    
	<!--导航 end-->
	<!--二级导航start-->
	<%@ include file="../index/statistics_naver.jsp" %>    
	<!--二级导航 end-->
	<div class="wrapper" style="margin-top: 40px;">
       	<div class="credit_list">
                 <div class="title">
	                <span class="f18 ms pull-left ml10">${league.name}</span>
	                <div class="clearit"></div>
	            </div>
                <div class="points" id="priceArea">
                </div>
         </div>    
    </div>
</div>
<%@include file="../../common/footer.jsp" %>
</body>
<script type="text/javascript">
function loadLeaguePrice(pageIndex){
	 var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 482px;margin-top: 90px;">';
  	$.ajax({
  		type:"POST",
  		url:base+"/league/priceListData",
  		data:{"league_id":'${league.id}',pageSize:10,currentPage:pageIndex},
  		dataType:"HTML",
  		beforeSend:function(){
  			$("#priceArea").empty();
  			$("#priceArea").append(tempHtml);
  		},
  		success:function(data){
  			$("#priceArea").empty();
  			$("#priceArea").append(data);
  		}
  	});
}
loadLeaguePrice(0);
</script>
</html>