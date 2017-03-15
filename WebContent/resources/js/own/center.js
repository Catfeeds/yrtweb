var userModel = new Vmodel({url:base+'/system/userInfo',sendData:{oth_user_id:$("#oth_user_id").val()},modelContainer:'#user-info',modelTemp:$('#user-info-temp').eq(0).get(0).innerHTML,dynamicVMHandler:function(one){
	var vm = $(userModel.options.modelTemp);
	vm.css('display','block');
	if(one.sex==1){
		vm.find('[data-id=sex]').text("男");
	}else if(one.sex==0){
		vm.find('[data-id=sex]').text("女");
	}
	if(!one.isme){
		vm.find('[data-id=headimg]').removeAttr("onclick");
		vm.find('[data-id=message]').attr("onclick","openMsg('"+one.id+"','"+one.usernick+"')");
		vm.find('[data-id=edit]').remove();
		if(one.guanzhu==1){
			vm.find('[data-id=other]').text("【已关注】").attr("title","取消关注");
			vm.find('[data-id=other]').attr("onclick","focus_user(this,'"+one.id+"',true)");
		}else{
			vm.find('[data-id=other]').text("【关注】").attr("title","关注");
			vm.find('[data-id=other]').attr("onclick","focus_user(this,'"+one.id+"')");
		}
	}
	if(one.isme&&one.status){
		if(one.status==1){
			vm.find('[data-id=player_certificat]').html('<a href="javascript:void(0)" class="cen_btn ms f14">【球员已认证】</a>');
		}else if(one.status==2){
			vm.find('[data-id=player_certificat]').html('<a href="javascript:void(0)" onclick="layer.msg(\'认证中!请等待...\',{icon: 2});" class="cen_btn ms f14">【球员认证中】</a>');
		}else if(one.status==3){
			vm.find('[data-id=other]').text("【球员认证失败】");
		}
	}
	vm.removeAttr("style");
	vm.find("#head_image_img").attr("id","head_image_img_0");
	if(!one.head_icon){
		vm.find("#head_image_img").attr("src",base+"/resources/images/headimg.png");
	}
	vm.find("#dynamicArea").attr("id","dynamicArea_0")
	return vm.get(0).outerHTML;
},afterRenderList:function(c,v,d){
	load_user_otherDatas();
	checkIsLeague(d.id);
}});
userModel.loadData().done(function(data){
	if(data.state=='success'){
		userModel.renderModel(data.data.user,'reloaded');
	}else{
		location.href=base+"/404.html";
	}
});

function edit_user(){
	$.loadSec('#user-info',base+'/system/baseInfo',function(){});
}

function checkIsLeague(userId){
	$.ajax({
		type:"POST",
		url:base+"/league/checkIsLeague",
		data:{"id":userId},
		dataType:"json",
		success:function(data){
			if(data.data.flag==1){
				$("#user-info").find("#league_logo").show();
			}
		}
	});
}

function load_user_otherDatas(){
	$.ajax({
		type:"POST",
		url:base+"/dynamic/toOtherDatas?random="+Math.random(),
		data:{"user_id":$("#oth_user_id").val()},
		dataType:"html",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				$("#dynamicArea_0").append(data);
			}
		}
	});
}

function focus_user(dom,uid,type){
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
						$(dom).text("【关注】").attr("title","关注");
						$(dom).attr("onclick","focus_user(this,'"+uid+"')");
					}else{
						$(dom).text("【已关注】").attr("title","取消关注");
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
	$("#head_image_img_0").attr("src",filePath+"/"+path);
	userModel.datas.head_icon=path;
	if($("#edit_head_icon")){
		$("#edit_head_icon").val(path);
	}
	/*userModel.loadData().done(function(data){
		if(data.state=='success'){
			userModel.renderModel(data.data.user,'reloaded');
		}else{
			location.href=base+"/404.html";
		}
	});*/
}

function render_info(data){
	var info = $(".player_info");
	if(data.state=="success"){
		info.find("[data-id=activate]").remove();
		if(data.data.isme){
			info.find("[data-id=playerBtn]").remove();
		}else{
			info.find("[data-id=playerBtn]").show();
		}
		loadPlayerInfo();
	}else{
		info.find("[data-id=playerBtn]").remove();
		if(data.data.isme){
			info.find("[data-id=activate]").show();
			info.attr("onclick","player_activation()");
		}else{
			info.find("[data-id=activate]").remove();
		}
	}
}
//是否球员
function player_info(){
	var othUserId = $("#oth_user_id").val();
	var params = $.param({othUserId:othUserId});
	$.ajax({
		type:'POST',
		url: base+'/player/hasPlayer',
		data: params,
		cache: false,
		dataType:'json',
		success: function(result){
			render_info(result);
		},
		error: $.ajaxError
	});
}

/**
 * 球员激活按钮
 */
function player_activation(){
	layer.confirm('　　　激活球员，放飞梦想', {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		var index = layer.msg('加载中', {icon: 16,time: 0});
		loadPlayerInfo(index);
	}, function(){});
}

//加载球员信息页面
function loadPlayerInfo(index){
	$.loadSec("#playerContent",base+'/player',function(){
		$("#playerContent").stop(true).slideDown();
		layer.close(index);
		$(".player_info").find("[data-id=activate]").remove();
		$(".player_info").removeAttr("onclick");
	});
}

//试训弹窗
function trialShow(){
	trialHide();
	var othUserId = $("#oth_user_id").val();
	var params = $.param({othUserId:othUserId});
	$.ajaxSec({
		type:'POST',
		url: base+'/player/inviteTrial',
		data: params,
		cache: false,
		dataType:'json',
		success: function(result){
			if(result.data.errorMsg){
				layer.msg(result.data.errorMsg,{icon: 2});
			}else{
				$('.trial').find("[data-id=usernick]").text(result.data.userNick);
				$('.trial').center().show();
			}
		},
		error: $.ajaxError
	});
}
//试训保存回调
function trialFormHandler(result){
	if(result.data&&result.data.errorMsg){
		layer.msg(result.data.errorMsg,{icon: 2});
	}else{
		layer.msg("邀请发送成功",{icon: 1});
		trialHide();
	}
}

function inviteATPQ(){
	var playerId = $("#oth_user_id").val();
	var params = $.param({playerId:playerId});
	layer.confirm('确定要与该球员签约吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/agent/signByAgent',
			data: params,
			success: function(result){
				if(result.state=='success'){
					layer.msg("邀请发送成功",{icon: 1});
				}else{
					layer.msg(result.message.error[0],{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

function inviteTTPA(){
	var playerId = $("#oth_user_id").val();
	var params = $.param({playerId:playerId});
	layer.confirm('确定要邀请该球员加入球队吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/player/teamByPlayer',
			data: params,
			success: function(result){
				if(result.state=='success'){
					layer.msg("邀请发送成功",{icon: 1});
				}else{
					layer.msg(result.message.error[0],{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

function trialHide(){
	$('.trial').find("input[type=text]").val("");
	$('.trial').find("textarea").val("");
	$('.trial').hide();
}

$(function(){
	player_info();
	var user_id = $("user_id").val();
	var s_u_id = $("s_user_id").val();
	if(user_id == s_u_id){
		loadSysMsg(0);
	}
	loadFollow(0);
	loadVisitor(0);
	//loadDynamic();
})


//added by bo.xie 加载经纪人信息
function loadAgentInfo(){
	
	loadAgentBaseInfo();

	loadAgentPlayers(1);
	
	/*
	 * update by gl 加载图片和视频
	loadAgentImages();
	loadAgentVideos();*/
	loadAgentFile();
}

//added by bo.xie 经纪人基本信息
function loadAgentBaseInfo(){
	$.loadSec("#jjr_content",base+"/agent/info",{"oth_user_id":$("#oth_user_id").val()});
}
	//added by bo.xie  经纪人已签约球员 
function loadAgentPlayers(currentPage){
	$.loadSec("#agent_players",base+"/agent/agentPlayers?random="+Math.random(),{"currentPage":currentPage,"oth_user_id":$("#oth_user_id").val()});
}

//added by bo.xie  签约解约已签约球员
function breakPlayer(p_user_id){
	$.ajaxSec({
		type:"POST",
		url:base+"/agent/applyBreakPlayer?random="+Math.random(),
		data:{"p_user_id":p_user_id},
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				loadAgentPlayers(1);
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

//added by bo.xie 退出俱乐部
function outTeam(p_user_id,teaminfo_id){
	$.ajaxSec({
		type:"POST",
		url:base+"/agent/outTeam?random="+Math.random(),
		data:{"p_user_id":p_user_id,"teaminfo_id":teaminfo_id},
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				loadAgentPlayers(1);
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

//added by bo.xie 编辑经纪人基本信息
function editAgentInfo(){
	$.loadSec("#jjr_content",base+"/agent/info",{"type":"edit","oth_user_id":$("#oth_user_id").val()});
}
//added by bo.xie 经纪人信息保存
function submitFrom(){
	$.ajaxSec({
		context:$("#agentfrom"),
		type:"POST",
		url:base+"/agent/saveOrUpdate?random="+Math.random(),
		data:$("#agentfrom").serialize(),
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				$.loadSec("#agentDiv",base+"/center/isAgent",{"oth_user_id":$("#oth_user_id").val()});
				loadAgentBaseInfo();
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

//added by bo.xie 跳转到球员列表页面
function gotoPlayerList(){
	window.open(base+"/player/searchPlayer");
}
//added by bo.xie 球员申请签约经纪人
function signByAgent(id){
	layer.confirm('确定要与经纪人签约吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type:"POST",
			url:base+"/player/signByAgent?random="+Math.random(),
			data:{"agentId":id},
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
					layer.msg("申请成功！",{icon: 1});
				}else{
					layer.msg(data.message.error[0],{icon: 2});
				}
			}
		});
	}, function(){});
}

//added by bo.xie 经纪人最新图片展示
function loadAgentImages(){
	$.loadSec("#agentImages",base+"/agent/images");
}

//added by bo.xie 经纪人最新视频展示
function loadAgentVideos(){
	$.loadSec("#agentVideos",base+"/agent/videos");
}

//added by gl 
function loadAgentFile(){
	$("#agent_img_vdo").load( base+"/agent/imgAndVdo",{}, function (response,status,xhr) {});
}

//added by bo.xie 加载教练员栏信息
function loadCoachInfo(){
	loadCoachBaseInfo();
	
	loadCoachHonor();
	
	loadCoachCareers();
}

//added by bo.xie 加载教练员基本信息
function loadCoachBaseInfo(){
	$.loadSec("#coachInfo",base+"/coach/info",{"oth_user_id":$("#oth_user_id").val()});
}

//added by bo.xie 编辑教练员基本信息
function editCoachInfo(){
	$.loadSec("#coachInfo",base+"/coach/info",{"type":"edit","oth_user_id":$("#oth_user_id").val()});
}

//added bo.xie 保存或更新教练基本信息
function saveInfo(id,url){
	$.ajaxSec({
		context:$("#"+id),
		type:"POST",
		url:base+url+"?random="+Math.random(),
		data:$("#"+id).serialize(),
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				$.loadSec("#coachDiv",base+"/center/isCoach",{"oth_user_id":$("#oth_user_id").val()});
				loadCoachInfo();
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

//added by bo.xie 载入教练员荣誉
function loadCoachHonor(){
	$.loadSec("#coachHonors",base+"/coach/honors",{"oth_user_id":$("#oth_user_id").val()},function(){
		init_loadImage("#honorframe");
		
	});
}

//added by bo.xie 编辑教练员荣誉
function editCoachHonor(){
	$.loadSec("#coachHonors",base+"/coach/honors",{"type":"edit","oth_user_id":$("#oth_user_id").val()});
}

//保存或更新教练荣誉
function saveHonor(dom,url){
	var datas = $(dom).parent().serialize();
 	$.ajaxSec({
 		context:$(dom).parent(),
		type:"POST",
		url:base+url+"?random="+Math.random(),
		data:datas,
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				loadCoachInfo();
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

//added by bo.xie 加载教练员任职经历
function loadCoachCareers(){
	$.loadSec("#coachCareers",base+"/coach/careers",{"oth_user_id":$("#oth_user_id").val()});
}

//added by bo.xie 编辑教练员任职经历
function editCoachCareers(){
	$.loadSec("#coachCareers",base+"/coach/careers",{"type":"edit","oth_user_id":$("#oth_user_id").val()});
}

//added by bo.xie 保存任职经历
function saveCareer(dom,url){
	var datas = $(dom).parent().serializeObject();
	var name=datas.name;
	var id = datas.id;
	var user_id = datas.user_id;
	var bg_time = datas.bg_time;
	var ed_time = datas.ed_time;
	var describle = datas.describle;
 	$.ajaxSec({
		context:$(dom).parent().parent(),
		type:"POST",
		url:base+url+"?random="+Math.random(),
		data:{"id":id,"user_id":user_id,"name":name,"describle":describle,"bt":bg_time,"et":ed_time},
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				loadCoachInfo();
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

//added by bo.xie 删除教练员荣誉
function deleteHonor(id){
	$.ajaxSec({
		type:"POST",
		url:base+"/coach/deleteCoach?random="+Math.random(),
		data:{"id":id},
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				loadCoachInfo();
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}
//added by bo.xie 删除教练员任职经历
function deleteCareer(id){
	$.ajaxSec({
		type:"POST",
		url:base+"/coach/deleteCareer?random="+Math.random(),
		data:{"id":id},
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				loadCoachInfo();
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

//added by bo.xie 点击放大图片
function showImage(dom){
		var img = $(dom);
		var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
    var maxW = 1000;
    var maxH = 560;
    if (iw / ih >= maxW / maxH) {
        if (iw > maxW) {
            ih = maxW / iw * ih;
            iw = maxW;
        }
    } else {
        if (ih > maxH) {
            iw = maxH / ih * iw;
            ih = maxH;
        }
    }    
    var imgHTML = '<img src="' + img.attr('src') + '" style="width:100%"/>';
    layer.open({
        type: 1,
        title: false,
        closeBtn: true,
        area: [iw + 'px', ih + 'px'],
        skin: 'layui-layer-nobg', //没有背景色
        shadeClose: true,
        content: imgHTML
    });
}

//added by bo.xie 创建视频播放
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

//add by ylt 加载用户消息 2015-08-31
function loadSysMsg(pageNum){
	$.loadSec("#sysmsg",base+"/message/querySysMsg",{"currentPage":pageNum,"user_id":$("#oth_user_id").val(),"pageSize":4,"m_style":1});
}
//add by ylt 加载关注用户消息 2015-08-31
function loadFollow(pageNum){
	$.loadSec("#sysfollow",base+"/user/focusDataPage",{"currentPage":pageNum,"user_id":$("#oth_user_id").val()});
}
//add by ylt 加载访客信息 2015-08-31
function loadVisitor(pageNum){
	$.loadSec("#sysvisitor",base+"/visitor/visitorList",{"currentPage":pageNum,"user_id":$("#oth_user_id").val(),"visit_url":"center","visit_type":"0","pageSize":6});
}

//add by ylt 系统消息同意 2015-09-01
function checkMsg(id,s_user_id,relate_id,type,ifcheck){
	var jsonData = {
		"id" : id,
		"user_id" : $("#oth_user_id").val(),
		"s_user_id" : s_user_id,
		"type" : type,
		"submit" : ifcheck,
		"relate_id" : relate_id
	};
	$.ajaxSec({
		type:"POST",
		url:base+"/center/systemMsg",
		data:jsonData,
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				layer.msg("操作成功！",{icon: 1});
				$.loadSec("#sysmsg",base+"/message/querySysMsg",{"currentPage":0,"user_id":$("#oth_user_id").val()});
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

//add by ylt 系统消息同意 2015-09-01
function openMsg(s_id,usernick){
	$.ajaxSec({
		type: 'POST',
		url: base+"/ifLogin",
		dataType:"JSON",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				layer.open({
					type: 2,
 				    title: false,
 				    closeBtn:false, 
 				    shadeClose: true,
 				    shade: 0.8,
 				    shift : 4,
 				    area: ['426px', '291px'],
				    content: [base+'/message/toMsg/'+s_id+'/'+usernick, 'no']
				}); 
			}
		}
	});
}

/*//added by 加载动态信息
function loadDynamic(){
	$.ajax({
		type:"POST",
		url:base+"/dynamic/toOtherDatas?random="+Math.random(),
		data:{"user_id":$("#oth_user_id").val()},
		dataType:"html",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				$("#dynamicArea").html(data);
			}
		}
	});
}*/

//关闭播放窗口
function closePlayerWindow(){
	 $("#showvdo").html("");
	 $('#showVideo').hide();
}
