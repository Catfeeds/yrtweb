<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>视频列表页</title>
</head>
<body>
	<div class="masker"></div>
	<div class="warp">
		<%@ include file="../common/header.jsp" %>    
	 	<%@ include file="../common/naver.jsp" %> 
	 	<div class="wrapper" style="margin-top: 116px;">
			<input type="hidden" id="index_type" value="2"/>
            <!--页面主体-->
            <div class="videoList ms f14">

                <!--内容部分-->
                <div class="video_title">
                    <span class="text-white f16 ms">视频列表</span>
                </div>
                <div class="clear"></div>
                <!--搜索条件部分-->
                <div class="searchVideo">
                    <div class="pull-left">
                        <!-- <span class="tiaojian">
                            <a href="javascritp:;" class="active" style="border: none;font-size: 14px;">综合排序</a>
                            <a href="javascritp:;">赛事</a>
                            <a href="javascritp:;">集锦</a>
                            <a href="javascritp:;">足球宝贝</a>
                            <a href="javascritp:;">进球</a>
                            <a href="javascritp:;">定位球</a>
                            <a href="javascritp:;">控球</a>
                            <a href="javascritp:;">头球</a>
                            <a href="javascritp:;">传球</a>
                            <a href="javascritp:;">防守</a>
                            <a href="javascritp:;">扑救</a>
                            <a href="javascritp:;">花式</a>
                            <a href="javascritp:;">爆笑</a>
                            <a href="javascritp:;">其他</a>
                        </span> -->
                    </div>
                    <div class="pull-left">
                        <span class="text-white ml15">上传者</span>
                        <span class="ml10">
                            <input id="user_nick" value="" type="text" class="search_txt" />
                        </span>
                        <span class="ml10">
                            <input type="button" onclick="load_images_videos_list('#video_list',2,1);" value="搜索" class="search_videoBtn" />
                        </span>
                    </div>
                    <div class="clearfix"></div>
                    <div class="mt20">
                        <span class="f16">
                            <a id="new_ob" href="javascript:;" onclick="load_images_videos_list('#video_list',2,1,'new');" class="">最新</a>
                        </span>
                        <span class="text-gray ml10 videoHot f14">
                            <a id="count_ob" href="javascript:;" onclick="load_images_videos_list('#video_list',2,1,'count');" class="">最热</a>
                        </span>
                        <span class="ml10 f14">
                            <a id="good_ob" href="javascript:;" onclick="load_images_videos_list('#video_list',2,1,'good');" class="text-gray">好评</a>
                        </span>
                    </div>
                </div>
                <!--<div class="xiantiao_video">

                </div>-->
                <div id="video_list" class="video_list">
                    
                </div>

                <!--视频详情-->
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
        </div>
	</div>
<%@ include file="../common/footer.jsp" %>      
<script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
 <script src="${ctx}/resources/js/own/index_new.js"></script>
<script type="text/javascript">
$(".closeVideoDeatail").click(function () {
    $("#a1").html("");
    $(".masker").hide();
    $("#msg_content").val("");
    $('#video_detail').hide();
});

function change_color(ob){
	$("#new_ob").css("color","#969494");
	$("#count_ob").css("color","");
	$("#good_ob").css("color","#969494");
	if(!ob) ob='new';
	$("#"+ob+"_ob").css('color', "white");
}
</script>      
</body>
</html>