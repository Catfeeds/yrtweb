﻿<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head> 
<%@ include file="common/common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>宇任拓首页</title>
	<meta name="keywords" content="足球，联赛，宇币，夺宝">
    <meta name="description" content="宇任拓是线上线下结合的真实版O2O足球经理社区平台，通过联赛球员竞拍、转会和充值方式等方式获取宇币并参与夺宝等互动。">
    <link href="${ctx}/resources/css/masterNew.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
	<link href="${ctx}/resources/css/photowindow.css" rel="stylesheet" />
	<link href="${ctx}/resources/css/flickerplate.css" rel="stylesheet" />
<style type="text/css">
#showVideo{
	z-index: 99;
}
.showvdo {
     position: relative;
 }

 #playSWF {
     position: absolute;
     width: 20px;
     height: 20px;
     right: 0px;
     top: -18px;
     cursor: pointer;
     z-index: 9999;
 }
 .card {
    background: #424242 none repeat scroll 0 0;
    box-shadow: 2px 2px 10px #111111;
    display: none;
    left: 0;
    padding-bottom: 10px;
    position: absolute;
    top: 24px;
    width: 280px;
    z-index: 12;
}
.card_info {
    margin: 5px auto;
    width: 266px;
}
.card_head {
    border-radius: 6px;
    float: left;
    height: 80px;
    width: 80px;
}
.card_name {
    color: #cbcb9f;
    font-family: "Microsoft YaHei";
    font-size: 16px;
}
.card_details {
    float: left;
    margin-left: 15px;
    width: 168px;
}
.card_details span {
    vertical-align: middle;
}
</style>
</head>
<c:set var="currentPage" value="INDEX"/>
<body>
	<div class="warp">
        <div class="lottery" style="display: none;">
             <a href="#" class="ggbb"></a>
            <a href="${ctx}/shop/luckList"></a>
        </div>
		<div class="masker"></div>
		
        <!--头部-->
        <%@ include file="common/header.jsp" %> 
        <!--导航-->
        <%@ include file="common/naver.jsp" %>    
        <div class="wrapper" style="margin-top: 116px;">
        	<input type="hidden" id="index_type" value="1"/>
            <!--页面主体-->
            <div class="container ms">
                <!--顶部banner开始-->
                <!-- <div class="contentTop">
                    <a class="index_select"></a>

                </div>
                <div class="select_content">
                    <input type="button" onclick="location.href='${ctx}/league/toSign?league_id=1'" class="indexSignBtn" />
                    <a class="index_selectTop"></a>
                </div> -->
                <!--<div class="home_banner">
                    <span class="zhuxi" onclick="javascript:window.location='${ctx}/league/choosePage'">&emsp;</span>
                    <span class="p_qiuyuan" onclick="javascript:window.location='${ctx}/league/identity?league_id=1'">&emsp;</span>
                </div>-->
                <div class="football" data-block-text="false">
                    <ul>
                    	<c:if test="${!empty banners}">
                    	<c:forEach items="${banners}" var="banner">
                        <li data-background="${el:headPath()}${banner.img_src}" onclick="go_url('${banner.img_path}','${banner.if_blank}')" style="cursor: pointer;">
                            <!-- <div class="flick-title"><a href="#" class="zhuxi_s" onclick="javascript:window.location='${ctx}/league/choosePage'"></a></div> -->
                            <%-- <div class="flick-title"><a href="#" class="p_qiuyuan_s" onclick="javascript:window.location='${ctx}/league/selectArea'"></a></div> --%>
                        </li>
                    	</c:forEach>
                    	</c:if>
                    </ul>
                </div>
                <!--顶部banner结束-->
                <!--轮播部分开始-->
                <div class="index_flow">
                    <div class="indexFlowTitle">
                        <span class="f20 ml20">
                            <a href="javascript:;" onclick="load_players_babys('#index_players_babys',1);" class="text-white index_players">球员</a>
                        </span>
                        <span class="text-gray f20 ">|</span>
                        <span class="f20">
                            <a href="javascript:;" onclick="load_players_babys('#index_players_babys',2);" class="text-white index_babys">宝贝</a>
                        </span>
                    </div>
                    <div class="clearfix"></div>
                    <div id="index_players_babys" class="flowContent">
                         <a href="javascript:void(0);" onclick="$('#icarousel').trigger('iCarousel:Previous'); return false;" class="aPrev" title="前一张"></a>
                         <a href="javascript:void(0);" onclick="$('#icarousel').trigger('iCarousel:Next'); return false;" class="aNext"></a>
                    </div>
                </div>
                <!--轮播部分结束-->
                <!--精彩视频开始-->
                <div class="index_video">
                    <div class="index_videoTitle">
                        <span class="f20 ml20">
                            <a class="text-white">精彩视频</a>
                        </span>
                        <span>
                            <a href="${ctx}/indexIvList?type=videolist" class="index_more">更多</a>
                        </span>
                    </div>
                    <div class="clearfix"></div>
                    <div id="hot_videos" class="videoBox">
                    	<div style="height: 300px;width: 100%;" align="center"> 加载中....</div>
                    </div>
                </div>
                <!--精彩视频结束-->
                <!--动态和讯息开始-->
                <div class="dynamicAndInfo mt20">
                    <!--动态开始-->
                    <div class="index_dynamic">
                        <div class="index_dynamicTile">
                            <span class="f20 ml20">
                                <a href="${ctx}/dynamicv1;" class="text-white">最新动态</a>
                            </span>
                            <span></span>
                        </div>
                     <div style="position: relative;" class="dynamicContent">
                            <div class="scrollbar">
                                <div class="handle" style="position: absolute; top: 9px; height: 98px;">
                                    <div class="mousearea"></div>
                                </div>
                            </div>
                            <div id="chat" class="frame newDynamic" style="overflow: hidden; position: relative;">
                                <ul id="top_dynamic_ul" style="width: 630px; position: absolute; top: -8px; height: 100px;" class="items">
                                </ul>
                            </div>
                            <div style="width: 100%; border-bottom: 1px solid #1c3c0d;" class=""></div>
                            <div class="scrollbar_two">
                                <div class="handle" style="position: absolute; top: 160px; height: 180px;">
                                    <div class="mousearea"></div>
                                </div>
                            </div>
                            <!--聊天部分-->
                            <button class="btn toEnd" style="display: none;" data-item="10">toEnd</button>
                            <div id="chat_two" class="frame d_content" style="overflow: hidden; position: relative;">
                                <ul id="def_dynamic_ul" class="items" style="position: absolute; top: -294px; height: 624px;">
                                </ul>
                            </div>
                            <div class="index_speak">
                    			<form id="dongtaiForm" action="${ctx}/dynamicv1/saveDyn">
                                <textarea id="text" name="text" maxlength="280" style="height: 20px;"></textarea>
                                <input type="button" id="publish" onclick="TopDynamic.sendDynamic()" class="btn_re pull-right ms f14" value="发布" name="name">
                                <div id="dynamicImg" class="add in"></div>
                                <div class="clearit"></div>
                                </form>
                            </div>
                        </div>
                        </div>
                        <div class="index_info">
                        <div class="index_dynamicTile">
                            <span class="f20 ml20">
                                <a class="text-white">讯息</a>
                            </span>
                            <span class="f12">
	                            <!-- <a href="javascript:;" onclick="load_hot_news(this,'#news_list','','')" class="active">综合</a> -->
	                            <%-- <c:forEach items="${leagueList}" var="league">
		                            <a href="javascript:;" onclick="load_hot_news(this,'#news_list','','${league.id}')">${league.simple_name}|</a>
		                        </c:forEach> --%>
	                        </span>
                            <span>
                                <a href="${ctx}/news" class="index_more">更多</a>
                            </span>
                        </div>
                        <div id="news_list" class="infoList">
                        	<div style="height: 300px;width: 100%;" align="center"> 加载中....</div>
                        </div>
                    </div>
                    <div class="clearit"></div>
                    </div>
                    
                </div>
                <!--动态结束-->
                <!--讯息开始-->
                <!--讯息结束-->
                <!--动态和讯息结束-->
                <!--精彩图片开始-->
                <div class="index_photos">
                    <div class="index_photosTile">
                        <span class="f20 ml20">
                            <a class="text-white ms">精彩图片</a>
                        </span>
                        <span>
                            <a href="${ctx}/indexIvList?type=imagelist" class="index_more">更多</a>
                        </span>
                        <div class="clearfix"></div>
                    </div>
                    <div id="hot_Images" class="showPhotos">
                    	<div style="height: 300px;width: 100%;" align="center"> 加载中....</div>
                    </div>
                </div>
                <!--精彩图片结束-->
            </div>

        </div>
        <div class="video_detail" id="video_detail" style="display: none;">
                	<div class="closeVideoDeatail"></div>
                	<!-- <div class="videoTitle">
                		<span class="text-white f20">广州俱乐部VS杭州俱乐部</span>
                	</div> -->
                	<div class="commentIcon">
                		<span>
                			<a class="goodComment" flag="1" title="赞" data-id="goodbtn" onclick="do_praise(1,this,'video')" style="cursor: pointer;"></a>
                		</span>
                		<span class="text-white ml20" data-id="good">0</span>
                		<span class="ml15">
                			<a class="badComment" flag="1" title="踩" data-id="badbtn" onclick="do_praise(2,this,'video')" style="cursor: pointer;"></a>
                		</span>
                		<span class="text-white ml25" data-id="bad">0</span>
                	</div>
                	<div id="a1" class="videoplay pull-left">
                	</div>
                	<div class="comment pull-left">
                		
                		<div class="load">
                			<a id="load_more"></a>
                		</div>
                		<div id="commentList" class="commentBox">
	                		<div id="commentModel" class="ml10 mt10" style="display: none;">
	                			<div class="pull-left">
	                				<img src="${el:headPath()}{{head_icon}}" class="other"/>
	                			</div>
	                			<div class="pull-left ml15">
	                				<p>
	                					<span class="text-gray" style="cursor: pointer;" data-id="usernick"></span>
	                					<span data-id="create_time" class="text-gray ml10"></span>
	                				</p>
	                				<p class="text-white mt5 w225">{{content}}</p>
	                			</div>
	                			<div class="clearfix"></div>
	                		</div>
                		</div>
                		<form id="commentsForm" errorType="2" action="${ctx}/imageVideo/saveComments">
          				<input type="hidden" id="iv_id" name="iv_id" value=""/>
          				<input type="hidden" id="roleType" name="roleType" value=""/>
                		<div class="publishComment">
                			<img src="${el:headPath()}${user_img}" class="publishHead"/>
                			<textarea valid="require len(0,200)" data-text="评论" id="msg_content" name="content"></textarea>
                			<input type="button" onclick="send_comments()" value="发表" class="publisBtn"/>
                		</div>
                		</form>
                	</div>
                </div>
    </div>
	<div class="mybox">
		<div class="closebtn" style=""></div>
		<div class="slide_img">
			<span id="prev" class="abtn prev"></span> <span id="next"
				class="abtn next"></span> <span id="prevTop" class="abtn prev"></span>
			<span id="nextTop" class="abtn next"></span>
			<div id="picBox" class="picBox">
				<ul class="cf"></ul>
			</div>
			<div id="listBox" class="listBox">
				<ul class="cf"></ul>
			</div>
		</div>
	</div>
	<%@ include file="common/footer.jsp" %>
    <script src="${ctx}/resources/js/SliderPlayer_3d.js"></script>
    <script src="${ctx}/resources/js/plugins.js"></script>
    <script src="${ctx}/resources/js/sly.js"></script>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
	<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
	<script src="${ctx}/resources/js/jQuery-easing.js"></script> 
	<script src="${ctx}/resources/js/raphael-min.js"></script> 
	<script src="${ctx}/resources/js/icarousel.js"></script> 
	<script src="${ctx}/resources/js/lightbox.js" type="text/javascript"></script>
    <script src="${ctx}/resources/ckplayer/ckplayer.js" type="text/javascript" charset="utf-8"></script>
    <script src="${ctx}/resources/js/own/index_new.js"></script>
    <script src="${ctx}/resources/js/own/index_TopDynamic.js"></script>
     <script src="${ctx}/resources/js/flickerplate.js"></script>
<script type="text/javascript">

function check_winning(){
	$.ajax({
		type:"POST",
		url:base+"/shop/luckResultCount?random="+Math.random(),
		data:{},
		dataType:"json",
		success:function(result){
			if(result.state=='success'&& result.data.page.totalCount > 0){
				$(".lottery").center().show();
			}else{
				$(".lottery").hide();
			}
		}
	});
}

jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}
/*讯息部分字符截取*/
$(function () {
	check_winning();
	layer.config({
	    extend: '/extend/layer.ext.js'
	});
    $(".p_info").each(function () {
        var maxwidth = 27;
        if ($(this).text().length > maxwidth) {
            $(this).text($(this).text().substring(0, maxwidth));
            $(this).html($(this).html() + '…');
        }
    });
    $(".index_select").trigger("click");

    setTimeout(closeBanner,7000);
    
    $('.football').flicker({
    	dot_alignment: 'right',
        auto_flick_delay:5
    });
   
});

/*展开banner*/
$(".index_select").click(function () {
    $(".contentTop").hide();
    $(".select_content").show();
});
/*收起banner*/

  function closeBanner() {
	  $(".index_selectTop").trigger("click");
  }
  

$(".index_selectTop").click(function () {
    $(".select_content").hide();
    $(".contentTop").show();
});

/*轮播宝贝*/
$(".index_babys").click(function () {
    $(".index_player").hide();
    $(".index_baby").show();
});

/*轮播球员*/
$(".index_players").click(function () {
    $(".index_baby").hide();
    $(".index_player").show();
});


$(".closeVideoDeatail").click(function () {
    $("#a1").html("");
    $(".masker").hide();
    $("#msg_content").val("");
    $('#video_detail').hide();
});

$(".masker").click(function () {
   
    $(".masker").hide();
   
    $('#video_detail').hide();
});

TopDynamic.init_page("${ctx}");

$(".ggbb").click(function(){
	$(".lottery").hide();
})

$(window).scroll(function () {
    $(".lottery").center();
});

function go_url(url,target){
	if(target==1){
		window.open(url);
	}else{
		location.href = url;
	}
}
</script>
</body>
</html>
