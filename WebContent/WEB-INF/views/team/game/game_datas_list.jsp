<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>比赛历程</title>
</head>
<body>
<div class="warp">
        <div class="masker"></div>
        <!--录入比分-->
        <div class="notice" id="upload_matchResult" style="height: 350px;">
           
        </div>
       <%@ include file="../../common/header.jsp" %>       
		<%@ include file="../../common/naver.jsp" %> 
        <div class="wrapper" style="margin-top: 116px;">
            <input type="hidden" id="teaminfo_id" value="${teaminfo_id}"/>
            <input type="hidden" id="user_id" value="${user_id}"/>
			<input type="hidden" id="s_u_id" value="${session_user_id}"/><!-- 登录用户id -->
            <div class="credit_list">
                <div class="title">
                    <span class="f18 ms pull-left ml10">比赛历程</span>
                    <c:if test="${session_user_id eq user_id}">
                    <div class="pull-right mr10">
                        <a href="${ctx}/teamInvite/pklist" class="active">PK对战</a>
                       <!--  <span>|</span>
                        <a href="javascript:void(0);">上传比赛历史</a> -->
                    </div>
                    </c:if>
                    <div class="clearit"></div>
                </div>
                <div style="padding-bottom: 25px;">
                    <span class="pull-left f30 ms ml30 mt20">战绩：<span class="ml10 text-red">${teamInfo.win_count }胜</span><span class="ml10 text-gray-s_666">${teamInfo.draw_count }平</span><span class="ml10 text-success">${teamInfo.loss_count }负</span></span>
                    <span class="pull-left f30 ms ml110 mt20">总进球：<span>${teamInfo.sumballs }</span></span>
                    <div class="clearit"></div>
                </div>
                <div class="l_fenge mt20"></div>
                <div class="race_course mt10">
                	<div id="historyArea">
	                   
                	</div>
                </div>
            </div>
        </div>
    </div>
   <%@ include file="../../common/footer.jsp" %>
</body>
<script src="${ctx}/resources/js/own/games_record.js"></script>
<script type="text/javascript">
jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}
$("#release").click(function () {
	var h = $(document).height();
    $(".masker").css("height", h).show();
    $(".notice").center().show();
});



function cl() {
    $(".masker").hide();
    $(".select_jersey").hide();
    $("#upload_matchResult").hide();
    $(".notice_info").hide();
    $(".notice_argee").hide();
}

function closeWin(){
	 cl();
}

$("#cannel2").click(function () {
    cl();
});
$(".closeBtn_1").click(function () {
    cl();
});

$(".diagram img").each(function () {
    $(this).mouseover(function () {
        $(this).addClass("active");
    }).mouseout(function () {
        $(this).removeClass("active");
    });
});


($(".diagram").children()).each(function () {
    $(this).mouseover(function () {
        $(this).find(".info_cluster").show();
    }).mouseout(function () {
        $(this).find(".info_cluster").hide();
    });
});

$("#me").click(function () {
    $(".e_menu").show();
});
$(function(){
	loadListPage(1,'${teaminfo_id}','LIST');
});
</script>
</html>