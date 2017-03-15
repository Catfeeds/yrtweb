var team_video_list;
$(function(){
	$.loadSec("#team_videos",base+"/team/videos",function(){
		create_team_video();
		load_videos();
	});
})

function create_team_video(){
	team_video_list = new List({
		url:base+'/team/queryTeamImages',
		sendData:{
			currentPage:1,
			pageSize : 6,
			team_id : $("#teaminfo_id").val(),
			type : 'video'
	    },
	   	listDataModel:$('#team_video_model').get(0).outerHTML,
	   	listContainer:'#team_video_list',
	   	dynamicVMHandler:function(one){
	   		var vm = $(team_video_list.options.listDataModel);
	   		vm.css('display','block');
	   		if(one.title){
	   			var title = one.title;
   				if(title&&title.length>6){
   					title = title.substring(0,6)+"...";
   				}
	   			vm.find("[data-id=title]").text(title);
	   		}
	   		if(one.ivname){
	   			vm.find("[data-id=ivname]").text(one.ivname);
	   		}
	   		if(one.praise==1){
	   			vm.find("[data-id=zan]").attr("title","取消点赞");
	   		}
	   		if(one.unpraise==2){
	   			vm.find("[data-id=cai]").attr("title","取消点踩");
	   		}
   			vm.find("[data-id=ccount]").text(one.click_count);
   			vm.find("[data-id=zan]").text(one.praise_count);
   			vm.find("[data-id=cai]").text(one.unpraise_count);
   			if(one.to_oss == 1){
   	   			vm.find(".video").attr("onclick","show_video('"+ossPath+one.f_src+"','"+one.create_time+"','"+one.id+"','"+one.role_type+"')")
   	   			vm.find(".small").attr("onclick","show_video('"+ossPath+one.f_src+"','"+one.create_time+"','"+one.id+"','"+one.role_type+"')").attr("src",ossPath+one.v_cover);
   	   		}
	   		return vm.get(0).outerHTML;
	   	},
	   	afterRenderList:function(c,v,data){
	   		if(data&&data.length<6){
	   			for (var i = 0; i < (6-data.length); i++) {
	   				$('#team_video_list').append('<li id="team_video_model" style="display: block;"><dl><dt><div class="v_2"><img src="'+base+'/resources/images/zwsp.png" alt="" style="width:179px; height:140px;"/></div></dt></dl></li>');
				}
	   		}
	   		$('#team_video_list').append('<div class="clearit"></div>');
	   		create_commont_list();
	   		$(".closeVideoDeatail").click(function () {
	   		    $("#a1").html("");
	   		    $(".masker").hide();
	   		    $("#msg_content").val("");
	   		    $('#video_detail').hide();
	   		});
	   		$(".v_2").mouseover(function () {
	   		    $(this).find(".v_1_remove").show();
	   		}).mouseout(function () {
	   		    $(this).find(".v_1_remove").hide();
	   		});
	   	}
	});
}

function load_videos(){
	team_video_list.loadListData().done(function(data){
		if(data.state=='success'&&data.data.page.items.length>0){
			team_video_list.renderList(data.data.page.items,'reloade_resetScroll');
		}else{
			//$('#team_video_list').empty().append('<span class="text-white">没有上传视频</span>');
			for (var i = 0; i < 6; i++) {
   				$('#team_video_list').append('<li id="team_video_model" style="display: block;"><dl><dt><div class="v_2"><img src="'+base+'/resources/images/zwsp.png" alt="" style="width:179px; height:140px;"/></div></dt></dl></li>');
			}
			$("#team_video_1").hide();
		}
		if(data.data.isme==0){
			$("#up_team_video").remove();
			 $(".v_2").find(".v_1_remove").remove();
		}
	});
}

var iframeTImages;
function openUpTImgs(type){
	var area = type=='image'?['704px', '240px']:['390px', '440px'];
	$.ajaxSec({
		type: 'POST',
		url: base+'/team/secTeam',
		success: function(data){
			var msg = type=="image"?"图片":"视频";
			iframeTImages = layer.open({
			    type: 2,
			    title: '上传'+msg,
			    shadeClose:true,
			    shade: [0.6],
			    zIndex:5,
			    area: area,
			    content: base+'/common/uploadHtml?type='+type+'&role_type=TEAM' //iframe的url
			}); 
		},
		error: $.ajaxError
	});
}
function closePOpen(fileType){
	layer.close(iframeTImages);
	if("video"==fileType){
		load_videos();
    	layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
	}else{
		load_team_images("#team_images_area",'image','TEAM');
	}
}

function show_video(video,ctime,vid,roleType){
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
//	$("#video_detail").center().show();
	$("#video_detail").css("position", "absolute");
	$("#video_detail").css("top", ($(window).height() - 522) / 2 + $(window).scrollTop() + "px");
	$("#video_detail").css("left", ($(window).width() - 980) / 2 + $(window).scrollLeft() + "px");
	$("#video_detail").show();
	queryComments(vid,roleType);
	save_click_count(vid,'video',roleType);
}

function deleteFile(url,id,type){
	var msg = "确定要删除这张图片吗？";
	if(type=='video'){
		msg = "确定要删除这个视频吗？";
	}
	yrt.confirm(msg, {
	    btn: ['确定','取消'], //按钮
	    shade: true //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: id,type:type},
			success: function(result){
				if(result.state=='success'){
					yrt.msg("删除成功",{icon: 1});
					if(type=='video'){
						load_videos();
					}else{
						load_team_images("#team_images_area",'image','TEAM');
					}
				}else{
					yrt.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}