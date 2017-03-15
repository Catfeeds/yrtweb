/**
 * index.js 首页广场加载
 * @author ylt
 */
 //新闻滚动功能
function autoScroll(obj) {
    $(obj).find(".list").animate({
        marginTop: "-25px"
    }, 500, function () {
        $(this).css({ marginTop: "0" }).find("li:first").appendTo(this);
    });
}
$(function () {
    setInterval('autoScroll(".news")', 4000);
    //首页加载新闻动态消息
    $.ajax({
		type: "POST",
		url: base+"/queryNewMsgRecord",
		success: function(data){
			 if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				var html = "";
				$.each(data.data.records,function(idx,item){
					html +="<li><div class='w960'><span class='text-news'>【"+Filter.formatDate(item.create_time,"yyyy-MM-dd")+"】"+item.content+"</span></div></li>";
				});
				$("#news").html(html);
			} 
		},
		error: $.ajaxError
	});
    
   /*  //首页轮播
    $.ajax({
		type: 'POST',
		url: "${ctx}/getMessage",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}
		},
		error: $.ajaxError
	}); */
   
  //首页比赛动态
   $.ajax({
		type: 'POST',
		url: base+"/queryHotGame",
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#game_div").append(data);
			}
		},
		error: $.ajaxError
	});
	
  //首页俱乐部动态
     $.ajax({
		type: 'POST',
		url: base+"/teamDynamicList",
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#team_div").append(data);
			}
		},
		error: $.ajaxError
	});
    
  //首页球员动态
    $.ajax({
		type: 'POST',
		url: base+"/queryIvComments",
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#player_div").append(data);
			}
		},
		error: $.ajaxError
	});
      	
  //首页热门视频
    $.ajax({
		type: 'POST',
		url: base+"/imageVideo/hotImageVideos",
		data: {type:2},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#videos_div").append(data);
			}
		},
		error: $.ajaxError
	}); 
});
//点击比赛动态
$("#img1").click(function () {
	$("#img1").attr("src","resources/images/Turnmatch.png");
});

$("#a1").click(function() {  
    $("html, body").animate({  
        scrollTop: $($(this).attr("href")).offset().top + "px"  
    }, {  
        duration: 1000,  
        easing: "swing"  
    });  
    return false;  
});
//鼠标悬浮时 比赛动态、俱乐部动态、运动员动态 样式
/*$(".icon").each(function() {
    $(".icon img").mouseover(function () {
    	$("#img1").attr("src","resources/images/Turnmatch.png");
    	$("#img2").attr("src","resources/images/TurnClub.png");
    	$("#img3").attr("src","resources/images/TurnPlayer.png");
    }).mouseout(function () {
    	$("#img1").attr("src","resources/images/match.png");
    	$("#img2").attr("src","resources/images/club.png");
    	$("#img3").attr("src","resources/images/players.png");
    });
});*/

function mouseover1(){
	$("#img1").attr("src","resources/images/Turnmatch.png");
}

function mouseout1(){
	$("#img1").attr("src","resources/images/match.png");
}

function mouseover2(){
	$("#img2").attr("src","resources/images/TurnClub.png");
}

function mouseout2(){
	$("#img2").attr("src","resources/images/club.png");
}

function mouseover3(){
	$("#img3").attr("src","resources/images/TurnPlayer.png");
}

function mouseout3(){
	$("#img3").attr("src","resources/images/players.png");
}

function mouseover4(){
	$("#img4").attr("src","resources/images/TurnVideo.png");
}

function mouseout4(){
	$("#img4").attr("src","resources/images/video.png");
}

//点击俱乐部动态
$("#img2").click(function () {
	$("#img2").attr("src","resources/images/TurnClub.png");
});

$("#a2").click(function() {  
    $("html, body").animate({  
        scrollTop: $($(this).attr("href")).offset().top + "px"  
    }, {  
        duration: 1000,  
        easing: "swing"  
    });  
    return false;  
});  

$("#a3").click(function() {  
    $("html, body").animate({  
        scrollTop: $($(this).attr("href")).offset().top + "px"  
    }, {  
        duration: 1000,  
        easing: "swing"  
    });  
    return false;  
});  
//点击运动员动态   
$("#img3").click(function () {
	$("#img3").attr("src","resources/images/TurnPlayer.png");
});

 //点击热门视频
$("#img4").click(function () {
	$("#img4").attr("src","resources/images/TurnVideo.png");
});  


//added by gl 创建视频播放
function createVideo(video,ctime){
	if(check_create_time(ctime,15)){
			layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
			return;
		}
   	var flashvars = {
	        f: filePath+'/'+video,
	        c: 0,
	        b: 1
	    };
	    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1', 'ckplayer_a1', '600', '400', false, flashvars);
	  	$(".login_masker").height($(document).height()).fadeIn();
	$(".login_masker").show();
	$('#showVideo').center().show();
}
