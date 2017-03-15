$(function(){
	load_center_user();
	load_center_effect();
	load_center_iv();
	load_Gift_List(); 
	loadVisitor(0);
	layer.config({
	    extend: '/extend/layer.ext.js'
	});
})

//载入用户基本信息
function load_center_user(){
	$("#editUserInfo").hide();
	$("#showUserInfo").show();
	$.loadSec("#center_user_info",base+"/center/userInfo",{"oth_user_id":$("#oth_user_id").val()});
}

//编辑用户基本信息
function edit_user(){
	$("#editUserInfo").show();
	$("#showUserInfo").hide();
	$.loadSec('#editUserInfo',base+'/center/editUser',function(){});
}

//加载用户印象
function load_center_effect(){
	$.loadSec("#center_user_effect",base+"/center/userEffect",{user_id:$("#oth_user_id").val()});
}

//加载用户印象详情
function open_center_effect_detail(){
	$.ajax({
		type: 'POST',
		data:{user_id:$("#oth_user_id").val()},
		url: base+'/center/queryEffectDetail',
		dataType:"html",
		success: function(data){
			$(".masker").height($(document).height()).fadeIn();
		    $(".imp_detail").center().fadeIn();	
			$(".imp_detail").html(data);
		},
		error: $.ajaxError
	});
}

//印象填写窗口
function open_center_effect(){
	$.ajaxSec({
		type: 'POST',
		url: base+"/ifLogin",
		dataType:"JSON",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#tag").val("");
				$(".masker").height($(document).height()).fadeIn();
				$(".burn_in").center().fadeIn();
			}
		}
	});
}

//保存用户印象详情
function save_center_effect(){
	if($("#tag").val().length > 5){
		layer.msg("输入内容必须小于5个汉字！",{icon: 2});
		return false;
	}
	$.ajaxSec({
		type: 'POST',
		url: base + "/player/savePlayerTag",
		data: {tag:$("#tag").val(),"user_id":$("#oth_user_id").val()},
		success: function(data){
			if(data.state=='success'){
				layer.msg(data.message.success[0],{icon: 1});
				closeAll();
				load_center_effect();
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		},
		error: $.ajaxError
	});
}
//删除用户印象
function del_center_effect(id){
	$.ajaxSec({
		type: 'POST',
		url: base + "/player/deletePlayerTag",
		data: {id:id},
		success: function(data){
			if(data.state=='success'){
				layer.msg("删除成功",{icon: 1});
				closeAll();
				load_center_effect();
			}else{
				layer.msg("删除失败",{icon: 2});
			}
		},
		error: $.ajaxError
	});
}

function load_center_iv(type,curPage){
	var curPage = curPage?curPage:1;
	var pageSize = 8;
	var params = {oth_user_id:$("#oth_user_id").val(),type:type,currentPage:curPage,pageSize:pageSize};
	$.loadSec("#myall",base+"/center/imagesOrVideos",params,function(){
		$("#center_iv_new").removeClass("active");
		$("#center_iv_video").removeClass("active");
		$("#center_iv_image").removeClass("active");
		if(type){
			$("#center_iv_"+type).addClass("active");
		}else{
			$("#center_iv_new").addClass("active");
		}
		var isme = $("#center_iv_isme").val();
		if(isme==1){
			//显示删除
			$(".adiv").mouseover(function () {
			    $(this).find(".remove").show();
			}).mouseout(function () {
			    $(this).find(".remove").hide();
			});
		}else{
			$("#upiv").remove();
		}
		create_commont_list();
		$(".closeVideoDeatail").click(function () {
   		    $("#a1").html("");
   		    $(".masker").hide();
   		    $("#msg_content").val("");
   		    $('#video_detail').hide();
   		});
		layer.ready(function(){
	        layer.photos({
	            photos: '#myall',
	            show_video:function(obj){
	            	var src = obj.attr("layer-url");
	            	var ctime = obj.attr("layer-date");
	            	var id = obj.attr("layer-pid");
	            	show_video(src,ctime,id,'PLAYER')
	            }
	        });
	    });
	});
}

var iframeTImages;
function openUpTImgs(type){
	var area = type=='image'?['704px', '276px']:['390px', '460px'];
	$.ajaxSec({
		type: 'POST',
		url: base+'/center/checkUserRole',
		success: function(data){
			var msg = type=="image"?"图片":"视频";
			iframeTImages = layer.open({
			    type: 2,
			    title: '上传'+msg,
			    shadeClose:true,
			    shade: [0.6],
			    zIndex:5,
			    area: area,
			    content: base+'/common/uploadHtml?user_id='+$("#oth_user_id").val()+'&type='+type+'&role_type=USER' //iframe的url
			}); 
		},
		error: $.ajaxError
	});
	$(".new_edit").hide();
}
function closePOpen(fileType){
	layer.close(iframeTImages);
	if("video"==fileType){
		load_center_iv();
    	layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
	}else{
		load_center_iv();
	}
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
	$("#video_detail").center().show();
	queryComments(vid,roleType);
	save_click_count(vid,'video',roleType);
}

function deleteFile(url,id,type){
	var msg = "确定要删除这张图片吗？";
	if(type=='video'){
		msg = "确定要删除这个视频吗？";
	}
	yrt.confirm(msg, {
		title:'删除确认',
	    btn: ['确定','取消'], //按钮
	    shade: true //遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: id,type:type},
			success: function(result){
				if(result.state=='success'){
					yrt.msg(result.message.success[0],{icon: 1});
					load_center_iv();
				}else{
					yrt.msg(result.message.error[0],{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

function delTag(id){
	$.ajaxSec({
		type: 'POST',
		url: url,
		data: {id:id},
		success: function(result){
			if(result.state=='success'){
				layer.msg("删除成功",{icon: 1});
				load_center_effect();
			}else{
				layer.msg("删除失败",{icon: 2});
			}
		},
		error: $.ajaxError
	});
}


var iframeIndex;
function change_head_img(){
	iframeIndex = layer.open({
	    type: 2,
	    title: '编辑头像',
	    shadeClose: true,
	    shade: [0],
	    area: ['660px', '600px'],
	    content: base+'/center/changeHeadImg' //iframe的url
	}); 
}

function closeIframe(path){
	layer.close(iframeIndex);
	layer.msg("保存成功",{icon: 1});
	$("#head_image_img_0").attr("src",ossPath+path);
	$("#edit_head_icon").val(path);
	userModel.datas.head_icon=path;
	if($("#edit_head_icon")){
		$("#edit_head_icon").val(path);
	}
}

//add by ylt 加载访客信息 2015-08-31
function loadVisitor(pageNum){
	$.loadSec("#visitorArea",base+"/visitor/visitorList",{"currentPage":pageNum,"user_id":$("#oth_user_id").val(),"visit_url":"center","visit_type":"0","pageSize":4});
}

function focus_user(dom,uid,type){
	$.ajaxSec({
		type: 'POST',
		url: base+"/ifLogin",
		dataType:"JSON",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
				}else{
				var url = base+'/user/focus';
				if(type){
					url = base+'/user/cancel';
				}
				var flag = $(dom).attr("flag");
				if(!flag){
					$(dom).attr("flag","1");
					$.ajaxSec({
							type:'POST',
							url: url,
							data: {f_user_id:uid,f_type:0},
							cache: false,
							dataType:'json',
							success: function(result){
								if(result.state=='success'){
									if(type){
										$(dom).text("关注").attr("title","关注").removeClass().addClass("enthus");
										$(dom).attr("onclick","focus_user(this,'"+uid+"')");
									}else{
										$(dom).text("取消关注").attr("title","取消关注").removeClass().addClass("give");
										$(dom).attr("onclick","focus_user(this,'"+uid+"',true)");
									}
									layer.msg(result.message.success[0],{icon: 1});
								}else{
									layer.msg('操作失败',{icon: 2});
								}
								$(dom).removeAttr("flag");
							},
							error: $.ajaxError
						});
					}
				}
		}
	});
}

//赠送礼物
function sendGift(){
	$.ajaxSec({
		type: 'POST',
		url: base+"/ifLogin",
		dataType:"JSON",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				 $(".masker").height($(document).height()).fadeIn();
			     $(".gift_list").center().fadeIn();
			     $(".gift_ul").css({ "margin-left": "90px" });
			     $(".gift_ul li:last").css({ "margin-left": "-10px" });
			}
		}
	});
	 
}

var sumbit_Give=function(p_code,cv,cp){ 
	var cwidth = '60%';
	if(PageInfo.login_user_amount>10000000){
		cwidth = '80%'
	}
	var cmsg = '<p class="f16 text-white ms" style="width:'+cwidth+'">扣除宇币：'+cp+'个</p>';
	cmsg+='<p class="f16 text-white ms" style="width:'+cwidth+'">可用宇币：'+PageInfo.login_user_amount+'个　<a style="color:#eb6100;" href="'+base+'/account/recharge" target="_blank" class="f12">充值</a></p>';
	yrt.confirm(cmsg, {
	    btn: ['确认赠送','取消'], //按钮
	    title : '赠礼确认',
	    shade: false
	}, function(){
    	var postdata='{"p_code":"'+p_code+'","rec_user_id":"'+$("#oth_user_id").val()+'","price":"'+cp +'","charm_value":"'+cv+'"}'
    	$.ajax({
    		type : "POST",
    		url : base+"/baby/buyGift",
    		data : postdata,
    		dataType : "json",
    		contentType : "application/json",
    		success : function(data) {
    			if(data.state==0){
    				yrt.msg("礼物赠送成功",{icon: 1});
    			}else{
    				yrt.msg(data.message,{icon: 0});
    			}
    			update_user_amount();
    			load_center_user();
    			closeAll();
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
	}, function(){});
	
};

var load_Gift_List=function(){ 
		$.ajax({
		type : "POST",
		url : base+"/baby/getGiftList",
		data : {},
		dataType : "json",
		contentType : "application/json",
		success : function(items) {
			$("#gift_ul").empty();
			for(i in items){
				addToGift(items[i]);
			}
			update_user_amount();
		},
		error : function(msg) {
			if (msg.statusText != "abort") {
				
			}
		}
	});
};

var update_user_amount=function(){ 
		$.ajax({
		type : "POST",
		url : base + "/user/getUserAmount",
		data : {},
		dataType : "json",
		contentType : "application/json",
		success : function(items) {
			if(items&&items.real_amount){
				PageInfo.login_user_amount=items.real_amount;
			}
		},
		error : function(msg) {
			if (msg.statusText != "abort") {
				
			}
		}
	});
}

var addToGift = function(o){
	var msg = [];
	msg.push('<li><dl><dt><div class="gift_info"><img src="'+base+'/'+o.image_src+'" title="'+o.p_name+'"/></div></dt>');
	msg.push('<dd><span>魅力值</span><span class="text-orange">+'+o.charm_value+'</span></dd>');
    msg.push('<dd><span class="text-orange">'+o.price+'</span><span class="ml10">宇币</span></dd>');
    msg.push('<dd><input type="button" name="name" onclick="sumbit_Give(\''+o.p_code+'\','+o.charm_value+','+o.price+')" value="赠送" class="invi_btn mt5" /></dd></dl></li>');

	$("#gift_ul").append(msg.join(''));
	
};

function check_user_role(){
	var flag = false;
	$.ajaxSec({
		type: 'POST',
		url: base+'/center/checkUserRole',
		success: function(result){
			if(result.state=='success'){
				flag = true;
			}
		},
		error: $.ajaxError
	});
	return flag;
}

//发送邀请短信-上传精彩瞬间 usernick:昵称 user_id：当前访问页面用户ID type:1:邀请上传精彩瞬间 2：邀请录入足球生涯功能
function inviteUpload(usernick,user_id,type){
	if(!check_user_role())return;
	var alarmtext="";
	if(type=="1"){
		alarmtext = '是否邀请（'+usernick+'）上传精彩瞬间';
	}else{
		alarmtext = '是否邀请（'+usernick+'）录入足球生涯';
	}
	layer.confirm(alarmtext,{icon: 3, title:'提示'},function(index){
		$.ajaxSec({
			type:'post',
			url:base+'/center/inviteUpload?random='+Math.random(),
			data:{"user_id":user_id,"type":type},
			dataType:'json',
			success:function(data){
				if(data.state=='success'){
					layer.msg(data.message.success[0],{icon:1});					
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
				layer.close(index);
			}
		})
	});
}
