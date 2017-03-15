<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>讯息中心</title>
</head>
<body>
	<div class="masker"></div>
	<div class="warp">
		<%@ include file="../common/header.jsp" %>    
	 	<%@ include file="../common/naver.jsp" %> 
	 	<div class="wrapper" style="margin-top: 116px;">
	 	<input type="hidden" id="league_id" value="${model_id}"/>
            <div class="pic_list">
                <div class="title">
               		<span style="cursor: pointer;" class="text-white f16 ms pull-left ml15" onclick="location.href='${ctx}/'">首页 》 </span>
                    <span class="text-white f16 ms pull-left">讯息中心</span>
                    <ul class="screening">
                        <li id="all_li" <c:if test="${empty model_id}">class="active"</c:if> onclick="load_news_list(this,'#news_list','',1,'');">综合</li>
                       <!-- <li id="gg_li" onclick="load_news_list('#news_list','2',1);">公告</li>
                        <li id="news_li" onclick="load_news_list('#news_list','1',1);">新闻</li> -->
                         <c:forEach items="${leagueList}" var="league">
	                        <li id="news_li" <c:if test="${league.id eq model_id}">class="active"</c:if> onclick="load_news_list(this,'#news_list','',1,'${league.id}');">${league.simple_name}</li>
                         </c:forEach>
                    </ul>
                    <div class="clearit"></div>
                </div>
                <div id="news_list" class="news_list">
                    
                </div>
                <div class="ad_list">
                    <dl>
                        <dd>
                            <img src="${ctx}/resources/images/ad_0004.jpg" />
                        </dd>
                        <dd>
                            <img src="${ctx}/resources/images/ad_0005.jpg" />
                        </dd>
                        <dd>
                            <img src="${ctx}/resources/images/ad_0006.jpg" />
                        </dd>
                    </dl>
                </div>
                <div class="clearit"></div>
            </div>
        </div>
	</div>
<%@ include file="../common/footer.jsp" %>      
<script type="text/javascript">
$(function(){
	var league_id = $("#league_id").val();
	if(league_id!=""){
		load_news_list('',"#news_list",'',1,league_id);
	}else{
		load_news_list('',"#news_list",'',1,"");
	}
	
})

var domthis;
function load_news_list(dthis,dom,type,cur,league_id){
	if(dthis) domthis = dthis;
	var params = $.param({type:type,page:'news_datas',model_id:league_id,currentPage:cur,pageSize:20});
	if(!type) type= $('#news_type').val();
	$(dom).load( base+'/hotNews', params, function () {
		$(domthis).addClass("active").siblings().removeClass("active");
		/* if($('#news_type').val()==1){
			$("#news_li").addClass("active");
		}else if($('#news_type').val()==2){
			$("#gg_li").addClass("active");
		}else{
			$("#all_li").addClass("active");
		} */
	});
}
</script>      
</body>
</html>