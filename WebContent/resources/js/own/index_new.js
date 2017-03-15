$(function(){
	if($("#index_type")&&$("#index_type").val()==1){
		load_players_babys("#index_players_babys",1,1);
		load_videos("#hot_videos",'video');
		//load_dynamic('#dynamic_list','news',1);
		load_images("#hot_Images",'image');
		load_hot_news('','#news_list','','');
		
	}else if($("#index_type")&&$("#index_type").val()==2){
		load_images_videos_list("#video_list",2,1);
	}
});

function load_videos(dom,orderBy){
	var pageSize = 5;
	var params = $.param({title:""});
	$(dom).load( base+'/videos', params, function () {create_commont_list()});
}

function load_images(dom,orderBy){
	$(dom).load( base+'/imagess', function () {
		layer.ready(function(){
	        layer.photos({
	            photos: '#hot_Images'
	        });
	    });
	});
}

function load_hot_news(domthis,dom,type,league_id){
	var params = $.param({type:type,page:'news',model_id:league_id,pageSize:16});
	$(dom).load( base+'/hotNews', params, function () {});
	$(domthis).addClass("active").siblings().removeClass("active");
}

function load_players_babys(dom,num,orderBy){
	var type = "player";
	var url = base + "/players";
	if(num == 2){
		type == "baby";
		url = base + "/babys";
	}
	var params = $.param({type:type,orderby:orderBy,pageSize:20});
	$(dom).load( url, params, function () {create_show(num);});
}

function load_dynamic(dom,type,orderBy){
	var params = $.param({loadData:type,orderby:orderBy});
	$(dom).load( base+'/dynamicv1/indexDynamic', params, function () {create_show(3);});
}

function load_images_videos_list(dom,type,cur,orderBy){
	var pageSize = 8,page='video_datas';
	var showType = "video";
	if(type==1){
		showType = "image";
		pageSize = 20;
		page = "image_datas";
	}
	if(!orderBy){
		orderBy = $("#order_by").val();
	}
	var uname = $("#user_nick").val();
	
	var params = $.param({page:page,type:showType,ivname:uname,orderby:orderBy,currentPage:cur,pageSize:pageSize});
	$(dom).load( base+'/queryImagesOrVideos', params, function () {
		change_color(orderBy);
		if(type==2){
			create_commont_list();
		}
	});
}

function dynSly(dom,sdom){
	var $frame = $(dom);
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
        scrollBar: $wrap.find(sdom),
        scrollBy: 1,
        pagesBar: $wrap.find('.pages'),
        activatePageOn: 'click',
        speed: 300,
        elasticBounds: 1,
        easing: 'easeOutExpo',
        dragHandle: 1,
        dynamicHandle: 1,
        clickBar: 1
    });
}

/*
 * 滚动条
 */
function create_show(type){
	if(type==2){
		$("#icarousel2").iCarousel({
			easing: "easeInOutQuint",
            animationSpeed: 300,
            pauseTime: 5E3,
            perspective: 0,
            slides: 7,
            slidesSpace: 180,
            nextLabel: "下一张",
            previousLabel: "上一张",
            playLabel: "播放",
            pauseLabel: "暂停",
            timer: "160Bar",
            timerPadding: 3,
            timerOpacity: 0.5,
            timerColor: "#0F0",
            timerX: 15,
            timerY: 30
        });
	    $(".show_box").mouseover(function() {
	    	$(this).find(".baby_masker").hide();
            $(this).find(".show_baby_info").show();
        }).mouseout(function() {
        	$(this).find(".baby_masker").show();
            $(this).find(".show_baby_info").hide();
        });
	    $("svg").hide();
	   

	   
		//new Zoompic("box_wwwzzjsnet");
		var $frame = $('#chat_two');
	    var $slidee = $frame.children('ul').eq(0);
	    var $wrap = $frame.parent();

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
	        clickBar: 1
	    });
	}else if(type==3){
		dynSly('#chat','.scrollbar');
		dynSly('#chat_two','.scrollbar_two');
	}else{
		$($(".auction_super")).each(function () {
            $(this).mouseover(function () {
                $(this).find(".quote").hide();
                $(this).find(".ability").show();
            });
        }).mouseout(function () {
            $(this).find(".quote").show();
            $(this).find(".ability").hide();

        });
		$("#icarousel").iCarousel({
			easing: "easeInOutQuint",
            slides: 7,
            animationSpeed: 300,
            pauseTime: 5E3,
            perspective: 0,
            slidesSpace: 180,
            pauseOnHover: !0,
            direction: "rtr",
            nextLabel: "下一张",
            previousLabel: "上一张",
            timer: "1Bar",
            timerOpacity: 0.5,
            timerDiameter: 220,
            keyboardNav: 1,
            timerPadding: 3,
            timerStroke: 4,
            timerBarStroke: 0,
            timerX: 15,
            timerY: 30

	    });
		 $(".pic_d").mouseover(function () {
		        $(this).find(".player_masker").hide();
		    }).mouseout(function () {
		        $(this).find(".player_masker").show();
		    });
		 function hided() {
			 $("#iCarousel-timer").hide();
         }
         
		 setTimeout(hided, 3500);
		 
	}
}

var commontList;
var commontListModel;

function create_commont_list(){
	if(!commontListModel){
		commontListModel = $('#commentModel').get(0).outerHTML;
	}
	commontList = new List({
		url:base+'/imageVideo/queryVideoComments',
		sendData:{
			currentPage:1,
			pageSize :10
	      },
	   	listDataModel:commontListModel,
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
}

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

function resHandler(result){
	if(result.state=='success'){
		$("#msg_content").val("");
		queryComments($("#iv_id").val(),$("#roleType").val());
	}else{
		layer.msg("发送失败",{icon: 2});
	}
}
function not_login(){
	$("#a1").html("");
    $(".masker").hide();
    $("#msg_content").val("");
    $('#video_detail').hide();
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

function save_click_count(vid,type,roleType){
	$.post(base+'/imageVideo/updateClickCount',{iv_id:vid,type:type,roleType:roleType},function (data){
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

function show_video(video,ctime,vid,roleType){
	if(check_create_time(ctime,15)){
		layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
		return;
	}
	var flashvars = {
        f: video,
        c: 0,
        b: 1
    };
    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1', 'ckplayer_a1', '662', '522', false, flashvars);
    $(".masker").height($(document).height()).fadeIn();
	$(".masker").show();
	//$("#video_detail").center().show();
	$("#video_detail").css("position", "absolute");
	$("#video_detail").css("top", ($(window).height() - 522) / 2 + $(window).scrollTop() + "px");
	$("#video_detail").css("left", ($(window).width() - 980) / 2 + $(window).scrollLeft() + "px");
	$("#video_detail").show();
	queryComments(vid,roleType);
	save_click_count(vid,'video',roleType);
}

function do_praise(state,dom,type,ivid,rtype){
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
			data: {iv_id:$("#iv_id").val(),p_state: state,p_type:$("#roleType").val(),type:type},
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
function checkMarket(){
	$.ajax({
		type : 'POST',
		url : base+"/league/checkMarket",	
		data : {league_id : $("#league_id").val()},
		dataType:"json",
		cache : false,
		success : function(result) {
			
			if(result.state=='error'){
				layer.msg(result.message.error[0],{icon:2});
				return false;
			}else{
				window.location = base+"/auction/searchList?league_id="+$("#league_id").val();
			}
		},
		error : $.ajaxError
	});
}

