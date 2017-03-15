<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图片列表页</title>
</head>
<body>
	<div class="masker"></div>
    <div class="warp">
        <!--头部-->
    	<%@ include file="../common/header.jsp" %>    
    </div>
        <!--导航 start-->
        <%@ include file="../common/naver.jsp" %> 
   	<div class="wrapper" style="margin-top: 116px;">
   	<input type="hidden" id="index_type" value="3"/>
            <div class="pic_list">
                <div class="title">
                    <span class="text-white f16 ms pull-left ml15">精彩图片</span>
                    <ul id="orderby" class="screening">
                        <li id="new_ob" onclick="load_images_videos_list('#image_list',1,1,'','new');" style="color: white;">最新</li>
                        <li id="count_ob" onclick="load_images_videos_list('#image_list',1,1,'','count');">最热</li>
                        <li id="baby_ob" onclick="load_images_videos_list('#image_list',1,1,'baby');">足球宝贝</li>
                        <li id="league_ob" onclick="load_images_videos_list('#image_list',1,1,'league');">联赛</li>
                        <li id="player_ob" onclick="load_images_videos_list('#image_list',1,1,'player');">球员</li>
                        <li id="team_ob" onclick="load_images_videos_list('#image_list',1,1,'team');">俱乐部</li>
                    </ul>
                    <ul class="screening_2">
                        <li><span class="text-gray-s_999">上传者</span><input type="text" id="user_nick" value="" class="ml10" /><a href="javascript:void(0);" onclick="load_images_videos_list('#image_list',1,1);" class="ml10 text-gray-s_999">【搜索】</a></li>
                    </ul>
                    <div class="clearit"></div>
                </div>

                <div id="image_list" class="picture_list">
                </div>
            </div>
        </div>
<%@ include file="../common/footer.jsp" %>    
<script type="text/javascript">

$(function(){
	load_images_videos_list("#image_list",1,1);
	layer.config({
	    extend: '/extend/layer.ext.js'
	});
})

function load_images_videos_list(dom,type,cur,role_type,orderBy){
	var pageSize = 8,page='video_datas';
	var showType = "video";
	if(type==1){
		showType = "image";
		pageSize = 20;
		page = "image_datas";
	}
	if(!role_type&&$("#s_role_type").val()){
		role_type = $("#s_role_type").val();
	}
	if(!orderBy){
		orderBy = $("#order_by").val();
	}else{
		role_type = "";
	}
	var uname = $("#user_nick").val();
	
	
	var params = $.param({page:page,type:showType,ivname:uname,role_type:role_type,orderby:orderBy,currentPage:cur,pageSize:pageSize});
	$(dom).load( base+'/queryImagesOrVideos', params, function () {
		$($(".picture_details")).each(function () {
		    $(this).mouseover(function () {
		        $(this).find(".picture_info").show();
		    }).mouseout(function () {
		        $(this).find(".picture_info").hide();
		    });
		});
		change_color();
		$("#user_nick").val($("#user_nick_hui").val());
		
		layer.ready(function(){
	        layer.photos({
	            photos: '#image_list'
	        });
	    });
	});
}

function change_color(orderby){
	$("#orderby").find("li").css("color","");
	var ob = $("#order_by").val();
	var rtype = $("#s_role_type").val();
	if(rtype){
		ob = rtype;
	}else{
		if(!ob) ob='new';
	}
	$("#"+ob+"_ob").css('color', "white");
}
</script>      
</body>
</html>