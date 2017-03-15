<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>助攻榜列表</title>
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
            <div class="race">
                <div class="title">
                    <span class="ml20">${league.name}</span>
                    <div class="clearit"></div>
                </div>
                <div id="assists_list" class="race_content">
                </div>
            </div>
        </div>
<%@include file="../../common/footer.jsp" %>
</body>
<script type="text/javascript">
//赛区一
$(".ui_tip_violet_1[dateindex=0]").css({ "left": "-74px" });
$(".ui_tip_violet_1[dateindex=0] .arrow_border_top").css({ "left": "16%", "top": "-18px" });
$(".ui_tip_violet_1[dateindex=0] .arrow_content_top").css({ "left": "16%", "top": "-17px" });
//赛区二
$(".ui_tip_violet_1[dateindex=1]").css({ "left": "-278px" });
$(".ui_tip_violet_1[dateindex=1] .arrow_border_top").css({ "left": "36%", "top": "-18px" });
$(".ui_tip_violet_1[dateindex=1] .arrow_content_top").css({ "left": "36%", "top": "-17px" });
//赛区三
$(".ui_tip_violet_1[dateindex=2]").css({ "left": "-482px" });
$(".ui_tip_violet_1[dateindex=2] .arrow_border_top").css({ "left": "56%", "top": "-18px" });
$(".ui_tip_violet_1[dateindex=2] .arrow_content_top").css({ "left": "56%", "top": "-17px" });
//赛区四
$(".ui_tip_violet_1[dateindex=3]").css({ "left": "-686px" });
$(".ui_tip_violet_1[dateindex=3] .arrow_border_top").css({ "left": "77%", "top": "-18px" });
$(".ui_tip_violet_1[dateindex=3] .arrow_content_top").css({ "left": "77%", "top": "-17px" });

//显示子菜单
var len = $(".navs .li").length;
function clear() {
    for (var i = 0; i < len; i++) {
        $(".ui_tip_violet_1[dateindex=" + i + "]").hide();
    }
}

$(".navs .li").each(function () {
    $(this).mouseover(function () {
        clear();
        $(this).find(".ui_tip_violet_1").show();
    });
});

//切换子菜单项
$(".ui_txt").each(function () {
    $(this).click(function () {
        $(this).addClass("active").siblings().removeClass("active");
    });
});

$(".select_season p:last").css({ "border": "none" });

$(".select_condition").mouseover(function () {
    $(".select_season").show();
});
$(".select_season p").each(function() {
    $(this).click(function() {
        var str = $(this).text();
        $(".select_condition").text(str);
        $(".select_season").hide();

    });
});

$(function(){
	load_assists(null,1);
})

function load_assists(dom,cur){
	if(dom){
		$(dom).addClass("active").siblings().removeClass("active");
	}
	 var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="width: 40px;height: 40px;margin-left: 482px;margin-top: 24px;">';
	if(!cur) cur = 1;
 	$.ajax({
 		type:"POST",
 		url:base+"/league/assistsList",
 		data:{"league_id":'${league_id}',currentPage:cur,pageSize:10},
 		dataType:"HTML",
 		beforeSend:function(){
 			$("#assists_list").empty();
 			$("#assists_list").append(tempHtml);
 		},
 		success:function(data){
 			$("#assists_list").empty();
 			$("#assists_list").append(data);
 		}
 	});
}
</script>
</html>