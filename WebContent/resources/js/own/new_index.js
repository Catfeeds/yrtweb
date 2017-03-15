$(function(){
	if($("#index_type")&&$("#index_type").val()==1){
		load_players_babys("#index_players_babys",1);
		load_hot_images_videos("#hot_videos",2);
		load_hot_news('#news_list');
		load_hot_images_videos("#hot_Images",1);
	}else if($("#index_type")&&$("#index_type").val()==2){
		load_images_videos_list("#video_list",2,1);
	}
})

function load_images_videos_list(dom,type,cur,orderBy){
	var pageSize = 8,page='video_datas';
	if(type==1){
		pageSize = 20;
		page = "image_datas";
	}
	if(!orderBy){
		orderBy = $("#order_by").val();
	}
	var uname = $("#user_nick").val();
	
	var params = $.param({page:page,type:type,uname:uname,orderby:orderBy,currentPage:cur,pageSize:pageSize});
	$(dom).load( base+'/hotImageVideos', params, function () {});
}

function create_show(){
	new Zoompic("box_wwwzzjsnet");
	var $frame = $('#chat_two');
    var $slidee = $frame.children('ul').eq(0);
    var $wrap = $frame.parent();

    // Call Sly on frame
    $frame.sly({
        itemNav: 'basic',
        smart: 1,
        activateOn: 'click',
        mouseDragging: 1,
        touchDragging: 1,
        releaseSwing: 1,
        startAt: 3,
        scrollBar: $wrap.find('.scrollbar_two'),
        scrollBy: 1,
        pagesBar: $wrap.find('.pages'),
        activatePageOn: 'click',
        speed: 300,
        elasticBounds: 1,
        easing: 'easeOutExpo',
        dragHandle: 1,
        dynamicHandle: 1,
        clickBar: 1,
    });
}

function load_players_babys(dom,type,orderBy){
	var url = base+"/players";
	if(type==2){
		url = base+'/babys'
	}
	var params = $.param({orderby:orderBy,pageSize:7});
	$(dom).load( url, params, function () {create_show();});
}

function load_hot_images_videos(dom,type,orderBy){
	var pageSize = 5,page='videos';
	if(type==1){
		pageSize = 22;
		page = "images";
	}
	var params = $.param({page:page,type:type,orderby:orderBy,pageSize:pageSize});
	$(dom).load( base+'/hotImageVideos', params, function () {});
}

function load_hot_news(dom,type){
	var params = $.param({type:type,page:'news',pageSize:7});
	$(dom).load( base+'/hotNews', params, function () {});
}

var commontList = new List({
	url:base+'/imageVideo/queryVideoComments',
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
	$("#video_detail").center().show();
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

function do_praise(state,dom,ivid,rtype){
	var flag = $(dom).attr("flag");
	if(ivid){
		$("#iv_id").val(ivid);
	}
	if(rtype){
		$("#roleType").val(rtype);
	}
	if(flag==1){
		$(dom).attr("flag",0);
  		$.ajaxSec({
			type: 'POST',
			url: base+'/imageVideo/praise',
			data: {iv_id:$("#iv_id").val(),p_state: state,p_type:$("#roleType").val()},
			success: function(data){
				if(data.state == 'success'){
					var str = state==1?'赞':'踩';
					var type = state==1?'good':'bad';
					if(ivid){
						$(dom).text(data.data.praiseCount);
					}else{
						var pras = $(".commentIcon").find("[data-id="+type+"]");
						pras.text(data.data.praiseCount);
					}
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