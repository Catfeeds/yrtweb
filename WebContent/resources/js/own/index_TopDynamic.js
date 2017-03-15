var TopDynamic = {
	UserCSS:{"team":"index_club","baby":"index_baby","user":"index_person","coach":"index_coach","player":"index_person","agent":"index_person","user":"index_person"},
	base_url:"",
	show_last_time : 0,
	show_c : 0,
	data_tp : "news",
	loadNewAjax : null,
	init_page : function() {
		$('#text').keypress(function(e) {
			if (e.which == 13) {
				TopDynamic.sendDynamic();
				return false;
			}
		});
		TopDynamic.loadTopDynamic();
		TopDynamic.loadFirstDynamic('{"loadData":"' + TopDynamic.data_tp + '"}');
		TopDynamic.initFileUpload();


		$(".closebtn").click(function () {
			TopDynamic.hidephoto();
		});
		$(".masker").click(function () {
			TopDynamic.hidephoto();
		});
	},
	loadTopDynamic : function() {
		$.ajax({
			type : "POST",
			url : TopDynamic.base_url+"/dynamicv1/index_top",
			data : "{}",
			dataType : "json",
			contentType : "application/json",
			success : function(items) {
				$("#top_dynamic_ul").empty();
				var msg = [];
				for (i in items) {
					var o=items[i];
					var d_id='down_player_'+i;
		    		var class_name = TopDynamic.UserCSS[o.user_type];
		    		var url = "window.open('"+TopDynamic.base_url+"/center/"+o.user_id+"')";
		    		var onmousemove='onmouseout="TopDynamic.hideUserInfo(\'#'+d_id+'\')" onmouseover="TopDynamic.showUserInfo(\''+o.user_id+'\',\'#'+d_id+'\')" ';
					msg.push('<li><span class="stick song">[置顶]</span>');
					msg.push('<span style="cursor: pointer;" onclick="'+url+'"class="'+class_name+'">'+o.user_name+'：</span>');
	                msg.push('<span class="index_txt">');
	                msg.push(o.text);
	                if(o.isImages){
	               		msg.push('<a href="javascript:TopDynamic.showphoto(\''+o.image_src+'\');" class="pic_tag">图</a>');
	                }
	                msg.push('</span><div class="card" id="'+d_id+'"></div><div class="clearit"></div></li>');
				}
				if (items.length > 0) {
					$("#top_dynamic_ul").append(msg.join(''));
				}
				TopDynamic.sly("chat","scrollbar");
			},
			error : function(msg) {
				if (msg.statusText != "abort") {

				}
			}
		});
	},
	loadFirstDynamic : function(p) {
		$.ajax({
			type : "POST",
			url : TopDynamic.base_url+"/dynamicv1/def",
			data : p,
			dataType : "json",
			contentType : "application/json",
			success : function(items) {
				$("#def_dynamic_ul").empty();
				for (i in items) {
					var o=items[i];
					TopDynamic.addToWindow(o);
				}
				if(items.length>0){
				TopDynamic.sly("chat_two","scrollbar_two");
				}
				TopDynamic.loadNewMsg('{"lastTime":' + TopDynamic.show_last_time + ',"loadData":"'+ TopDynamic.data_tp + '"}');
			},
			error : function(msg) {
				if (msg.statusText != "abort") {

				}
			}
		});
	},
	loadNewMsg : function(p) {
		if (TopDynamic.loadNewAjax != null) {
			TopDynamic.loadNewAjax.abort();
		}
		TopDynamic.loadNewAjax = $.ajax({
			type : "POST",
			url : TopDynamic.base_url+"/dynamicv1/loadNewMsg",
			data : p,
			dataType : "json",
			contentType : "application/json",
			success : function(items) {
				for (i in items) {
					var o=items[i];
					TopDynamic.addToWindow(o);
				}
				if(items.length>0){
					var div = document.getElementById('chat_two');
					div.scrollTop = div.scrollHeight;
					TopDynamic.sly("chat_two","scrollbar_two");
				}
				TopDynamic.loadNewMsg('{"lastTime":' + TopDynamic.show_last_time + ',"loadData":"'+ TopDynamic.data_tp + '"}');
			},
			error : function(msg) {
				if (msg.statusText != "abort") {

				}
			}
		});
	},
	sendDynamic : function() {
		var txt = $.trim($('#text').val());
		var submit_ = false;
		if (txt.length > 0) {
			submit_ = true;
		} else {
			var imgs = $("input[name='image']");
			if (imgs.length > 0) {
				submit_ = true;
			}
		}
		if (submit_) {
			$.ajaxSubmit('#dongtaiForm', '#dongtai', TopDynamic.resHandler);
			
		}
		
	},
	resHandler:function(result){
		if(result.state==0){
			layer.msg(result.message,{icon: 1});
			$("#text").val("");
			$("#text").css({ "width": "510px", "height": "20px" });
			$("#tiao").css({  "height": "568px" });
			TopDynamic.initFileUpload();
			
		}else{
			layer.msg(result.message,{icon: 2});
		}
		 
	},
	sly:function (id,scrollbar) {
        var $frame = $('#'+id);
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
            scrollBar: $wrap.find('.'+scrollbar),
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

        $wrap.find('.toEnd').on('click', function () {
            var item = $(".dynamicContent").data('item');
            $frame.sly('toEnd', item);
        });

		$(".toEnd").trigger("click");
    },addToWindow : function(o){
    	TopDynamic.show_c++;

		var d_id='down_playerA_'+TopDynamic.show_c;
    	var msg=[];
    	var url ="";
    	var onmousemove="";
    	var class_txt = "index_txt";
    	var class_name = "index_coach";
    	if(o.msg_type=="sys"){
    		class_name = "index_sys";
    		class_txt = "index_txt sysred";
    		o.user_name = '系统';
    		//url = "window.open('"+TopDynamic.base_url+"/team/tdetail/"+o.user_id+"?.html')";
    	}else if(o.msg_type=="msg"){
    		class_txt = "index_txt";
    		class_name = TopDynamic.UserCSS[o.user_type];
    		url = "window.open('"+TopDynamic.base_url+"/center/"+o.user_id+"')";		    		
    		onmousemove='onmouseout="TopDynamic.hideUserInfo(\'#'+d_id+'\')" onmouseover="TopDynamic.showUserInfo(\''+o.user_id+'\',\'#'+d_id+'\')" ';

    	}

    	if(o.msg_me){
    		class_name = "index_me";
    		o.user_name = "我";
    	}
    	
    	msg.push('<li><div><span style="cursor: pointer;" onclick="'+url+'" '+onmousemove+' class="'+class_name+'">'+o.user_name+'：</span>');
    	msg.push('<span class="'+class_txt+'">');
		msg.push(o.text);
        if(o.isImages){
       		msg.push('<a href="javascript:TopDynamic.showphoto(\''+o.image_src+'\');" class="pic_tag">图</a>');
        }
        if(o.msg_me){
            msg.push('<a href="javascript:TopDynamic.setTop(\''+o.dynamic_id+'\');" class="pic_top">顶</a> ');
        }
        msg.push('</span><div class="card" id="'+d_id+'"></div><div class="clearit"></div></div></li>');
        TopDynamic.show_last_time = o.createtime;
		$("#def_dynamic_ul").append(msg.join(''));
    },
	setTop:function(id){
    	$.ajax({
    		type : "POST",
    		url : TopDynamic.base_url+"/dynamicv1/operTop",
    		data : '{"dynamic_id":"'+id+'"}',
    		dataType : "json",
    		contentType : "application/json",
    		success : function(data) {
    			TopDynamic.loadTopDynamic();
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
	},appendPicBox:function(str){
		var picBox = $("#picBox").find("ul").empty();
		var listBox = $("#listBox").find("ul").empty();
		var imgs = str.split(",");
		for(var i in imgs){
			//var src = filePath+'/'+imgs[i];
			var src = ossPath+imgs[i];
			picBox.append( '<li><div class="show_s"><img src="'+src+'" alt="" /></div></li>');
			listBox.append('<li><img height="64" src="'+src+'" alt="" /></li>');
		}
		picBox.append('<div class="clearit"></div>');
		listBox.append('<div class="clearit"></div>');
		load_lightBox();
		$(".mybox").center();
	},initFileUpload:function(){

		$('#dynamicImg').attr("cs-data-uid","");
		$('#dynamicImg').empty();
		$('#dynamicImg').fileUploader($.extend({},{
			uploaderType: 'imgUploader',
			itemWidth: 40,
			itemHeight: 40,
			fileNumLimit: 4,
			fileSingleSizeLimit: 6*1024*1024, /*6M*/
			fileVal: 'file',
			server: TopDynamic.base_url+'/imageVideo/uploadFile?filetype=picture',
			toolbar:{
				del: true
			},
		    afterInit:function(uid){
		    $("#filePicker-"+uid).css("border","none");
   			$('#dynamicImg').find(".webuploader-pick").css("background"," url('"+TopDynamic.base_url+"/resources/images/in_pic.png') no-repeat scroll center center");
		}
		},{inputName:'image'}));
	},hidephoto:function(){
	    $(".mybox").fadeOut();
	    $(".masker").fadeOut();
	},showphoto:function(str){
		TopDynamic.appendPicBox(str);
	    $(".mybox").fadeIn().css({"z-index":"1200"});
	    $(".masker").height($(document).height()).fadeIn();
	},hideUserInfo:function(area_id) {
		 $(area_id).show();
	},showUserInfo:function(user_id,area_id){
		$.ajax({
			type:'post',
			url:TopDynamic.base_url+'/user/card_info?random='+Math.random(),
			data:{"user_id":user_id},
			dataType:'html',
			beforeSend:function(){
				$(area_id).empty();
				$(".card").each(function () {
	                $(".card").hide();
	            });
			},
			success:function(data){
				
				$(area_id).append(data);
				$(area_id).show();
				
				$(area_id).mouseover(function() {
					
		            $(area_id).show();
		        }).mouseout(function() {
		            $(area_id).hide();
		        });

				$(document).mouseover(function (e) {
		            if (!$(area_id).is(':has(' + e.target.localName + ')') && e.target.id != 'index_baby') {
		                $(area_id).hide();
		            }
		        });
			}
		})
	}
}



function zoomin(){
	 $("#text").css({ "width": "623px", "height": "40px" });
}

 $("#text").click(function () {
	  zoomin();
});
 $("#dynamicImg").click(function () {
	  zoomin();
 });