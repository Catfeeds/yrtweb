<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common/common.jsp" %>
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>视频列表页</title>
</head>
<body>
	<div class="masker"></div>
    <div class="warp">
        <!--头部-->
    	<%@ include file="common/header.jsp" %>    
    </div>
        <!--导航 start-->
        <%@ include file="common/naver.jsp" %> 
   	<div class="wrapper" style="margin-top: 56px;">
            <!--页面主体-->
            <div class="videoList ms f14">
            	
            	<!--内容部分-->
                <div class="video_title">
                    <span class="text-white f16 ms">视频列表</span>
                </div>
                 <div class="clear"></div>
                <div class="video_list" id="videoDatas">
                	<!-- 数据列表 -->
                </div>
                
                <!--视频详情-->
                <div class="video_detail" id="video_detail" style="display: none;">
                	<div class="closeVideoDeatail"></div>
                	<!-- <div class="videoTitle">
                		<span class="text-white f20">广州俱乐部VS杭州俱乐部</span>
                	</div> -->
                	<div class="commentIcon">
                		<span>
                			<a class="goodComment" flag="1" title="赞" data-id="goodbtn" onclick="do_praise(1,this)"></a>
                		</span>
                		<span class="text-white ml20" data-id="good">0</span>
                		<span class="ml15">
                			<a class="badComment" flag="1" title="踩" data-id="badbtn" onclick="do_praise(2,this)"></a>
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
<%@ include file="common/footer.jsp" %>      
<script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">

$(function(){
	loadVideoDatas(1);
})

function loadVideoDatas(currentPage){
	$.ajax({
		type:"POST",
		url:base+"/imageVideo/videoDatas?random="+Math.random(),
		data:{"currentPage":currentPage,"pageSize":12},
		dataType:"HTML",
		beforeSend:function(data){
			$("#videoDatas").append("<div style='width:500px;text-align:center;margin:35px auto -20px;'>loading...</div>");
		},
		success:function(data){
			$("#videoDatas").empty();
			$("#videoDatas").append(data);
		}
 	});
}

//鼠标悬浮
function showBtn(dom){
	$(dom).children().find(".video_play").css("display","block");
}

//鼠标移开
function hideBtn(){
	$(".video_play").css("display","none");
}

$(".closeVideoDeatail").click(function () {
    $("#a1").html("");
    $(".masker").hide();
    $("#msg_content").val("");
    $('#video_detail').hide();
});

var commontList = new List({
	url:'${ctx}/imageVideo/queryVideoComments',
	sendData:{
		currentPage:1,
		pageSize :10
      },
   	listDataModel:$('#commentModel').get(0).outerHTML,
   	listContainer:'#commentList',
   	dynamicVMHandler:function(one){
   		var vm = $(commontList.options.listDataModel);
   		vm.css('display','block');
   		var nick = one.usernick;
   		if(nick&&nick.length>5){
   			nick = nick.substring(0,4);
   			vm.find('[data-id=usernick]').text(nick+"**").attr("title",one.usernick);
   		}else{
   			vm.find('[data-id=usernick]').text(one.usernick);
   		}
   		if(one.create_time){
   			gap(one.create_time,vm.find('[data-id=create_time]'));
   			//vm.find('[data-id=create_time]').text(Filter.formatDate(one.create_time,'yyyy-MM-dd hh:mm:ss'));
   		}
   		return vm.get(0).outerHTML;
   	}
});

function queryComments(vid,rtype){
	$("#iv_id").val(vid);
	$("#roleType").val(rtype);
	commontList.options.sendData = {
		currentPage:1,
		pageSize :10,
		id:vid,
		type:rtype
	}
	commontList.loadListData().done(function(data){
		isPageEnd(data.data.page);
		commontList.renderList(data.data.page.items,'reloaded','desc');
		$(".commentBox").scrollTop($(".commentBox")[0].scrollHeight);
	});
}

function loadMore(btn){
	commontList.options.sendData.currentPage++;
	commontList.loadListData().done(function(data){
		isPageEnd(data.data.page);
		if(data.data.page.items&&data.data.page.items.length!=0){
			commontList.renderList(data.data.page.items,'prepend');
		}else{
			$(btn).removeAttr("onclick").text("没有更多了");
		}
	});
}

function isPageEnd(page){
	if(page.currentPage*page.pageSize>page.totalCount){
		$('#load_more').removeAttr("onclick").text("没有更多了");
	}else{
		$('#load_more').attr("onclick","loadMore(this)").text("加载更多");
	}
}

function save_click_count(vid,type){
	$.post(base+'/imageVideo/updateClickCount',{iv_id:vid,roleType:type},function (data){
		if(data.data.praiseCount){
			$(".commentIcon").find("[data-id=good]").text(data.data.praiseCount.praise);
			$(".commentIcon").find("[data-id=bad]").text(data.data.praiseCount.cai);
		}
		if(data.data.ispra){
			$(".goodComment").attr("title","取消点赞")
		}else if(data.data.iscai){
			$(".badComment").attr("title","取消点踩")
		}
	});
}

function show_video(video,ctime,vid,type){
	if(check_create_time(ctime,15)){
		layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
		return;
	}
	var flashvars = {
        f: filePath+'/'+video,
        c: 0,
        b: 1
    };
    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1', 'ckplayer_a1', '662', '522', false, flashvars);
    $(".masker").height($(document).height()).fadeIn();
	$(".masker").show();
	$("#video_detail").show();
	queryComments(vid,type);
	save_click_count(vid,type);
}
function resHandler(result){
	if(result.state=='success'){
		$("#msg_content").val("");
		queryComments($("#iv_id").val(),$("#roleType").val());
	}else{
		layer.msg("发送失败",{icon: 2});
	}
}
function send_comments(){
	$.ajaxSubmit('#commentsForm','#commentsForm',resHandler,not_login)
}
var gap = function(date,div){
    var now = new Date;
    var that = new Date (date);
    var ms = Math.floor((now-that)/1000/60/60);
    var fz = Math.floor((now - that)/1000/60);
    if (ms > 24 && ms < 48){
        div.text ('昨天 ' + that.toLocaleTimeString ());
    }
    else if (ms > 48){
        div.text (Filter.formatDate(date,'yyyy-MM-dd hh:mm:ss'));
    }
    else{
    	if(fz>=60){
        	div.text(ms + ' 小时前');
    	}else if(fz>0&&fz<60){
    		div.text(fz + ' 分钟前');
    	}else{
    		//div.text("刚刚");
    	}
    }
}

function do_praise(state,dom){
	var flag = $(dom).attr("flag");
	if(flag==1){
		$(dom).attr("flag",0);
  		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/imageVideo/praise',
			data: {iv_id:$("#iv_id").val(),p_state: state,p_type:$("#roleType").val()},
			success: function(data){
				if(data.state == 'success'){
					var str = state==1?'赞':'踩';
					var type = state==1?'good':'bad';
					var pras = $(".commentIcon").find("[data-id="+type+"]");
					pras.text(data.data.praiseCount);
					if(data.data.flag==1){
						$(dom).attr('title','取消点'+str);
					}else{
						$(dom).attr('title',str);
					}
				}else{
					layer.msg("操作失败",{icon: 2});
				}
				$(dom).attr("flag",1);
			},
			error: $.ajaxError
		},not_login);
	}
}
function not_login(){
	$("#a1").html("");
    $(".masker").hide();
    $("#msg_content").val("");
    $('#video_detail').hide();
}
</script>      
</body>
</html>