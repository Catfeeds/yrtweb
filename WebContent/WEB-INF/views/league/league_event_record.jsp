<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>联赛赛程</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<c:set var="currentPage" value="LEAGUEINDEX"/>
</head>
<body>
<div class="warp">
	<div class="masker"></div>
		<input type="hidden" id="league_id" value="${league.id}"/>
         <!--头部-->
         <%@ include file="../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <<div class="wrapper" style="margin-top: 80px;">
            <div class="schedule_show">
                <div class="title">
                    <span class="f18 ms ml10" onclick="location.href='${ctx}/league/index?league_id=${league.id}'" style="cursor: pointer;">联赛首页&emsp;》&emsp;全部赛程</span>
                </div>
                <div id="record_group" class="fenzu">
                    <ul>
                        <li val="all" onclick="load_event_records(1,'all')" class="active">全部</li>
                        <c:forEach items="${groups}" var="group">
                        <li val="${group.id}" onclick="load_event_records(1,'${group.id}')">${group.name}</li>
                        </c:forEach>
                        <div class="clearit"></div>
                    </ul>
                </div>
                <div class="j_fenge"></div>
                <div id="even_record_datas">
                </div>
            </div>

        </div>
    </div>
   
    <%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
$(function(){
	load_event_records(1);
})
function load_event_records(currentPage,gid){
	$("#record_group").find("li").each(function (i) {
		var val = $(this).attr("val");
		if(gid&&gid==val){
           	$(this).addClass("active").siblings().removeClass("active");
		}
    });
	if(gid=='all') gid="";
	var params = {league_id:'${league.id}',group_id:gid,currentPage:currentPage,pageSize:8};
	$.loadSec('#even_record_datas',base+'/league/queryEventRecords',params);
}
</script>
</body>
</html>
