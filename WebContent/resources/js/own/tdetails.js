$(function(){
	var user_id = $("#user_id").val();
	var s_u_id = $("#s_u_id").val();
	loadPlayers(); //当前队员信息
	if(user_id == s_u_id){
		loadTeamInvite(); // 邀请对战列表
		loadBlackPlayer(); //黑名单列表
	}
	loadHistoryInvite(); //历史对战信息
	loadGameInfo(); //当前对战信息
	loadVisitor(0); //访问者列表
	loadBaby();//俱乐部宝贝信息
});
//add by ylt 俱乐部邀战信息
function loadTeamInvite(){
	$.ajax({
		type: 'POST',
		url: base+"/teamInvite/listInvite/teaminvite",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"pageSize":1},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#inviteArea").html(data);
			}
		},
		error: $.ajaxError
	});	
}

//add by ylt 俱乐部黑名单
function loadBlackPlayer(){
	$.ajax({
		type: 'POST',
		url: base+"/team/black/blackplayer",
		data: {"teaminfo_id" : $("#teaminfo_id").val(),"user_id":$("#user_id").val()},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#blackArea").html(data);
			}
		},
		error: $.ajaxError
	});	
}

//add by ylt 历史对战信息
function loadHistoryInvite(){
	$.ajax({
		type: 'POST',
		url: base+"/teamInvite/history/historyinvite",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"pageSize":1},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#historyArea").html(data);
			}
		},
		error: $.ajaxError
	});	
}
//add by ylt 当前对战信息
function loadGameInfo(){
	$.ajax({
		type: 'POST',
		url: base+"/teamInvite/game/gameinfo",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"user_id":$("#user_id").val()},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#gameArea").html(data);
			}
		},
		error: $.ajaxError
	});	
}
//add by ylt 队员信息
function loadPlayers(){
	$.ajax({
		type: 'POST',
		url: base+"/team/teamPlayerList",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"user_id":$("#user_id").val()},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#playersArea").html(data);
				  $('.club_center tr').not(":first").mouseover(function () {
			            $(this).css({ "background": "#21291a","cursor":"pointer" });
			        }).mouseout(function() {
			            $(this).css({ "background": "", "cursor": "pointer" });
			        });
			}
		},
		error: $.ajaxError
	});	
}

//add by ylt 踢出黑名单
function kickBlack(player_id){
	$.ajaxSec({
		type: 'POST',
		url: base+"/team/kickBlackPlayer",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"player_id":player_id},
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg("移除成功!",{icon:1});
				loadBlackPlayer();
			}
		},
		error: $.ajaxError
	});	
}


//add by ylt 确认邀请比赛
function checkInvite(teaminfo_id,status,id){
	var jsonData = {
		"id" : id,
		"status" : status,
		"teaminfo_id" : teaminfo_id,
		"respond_teaminfo_id" : $("#teaminfo_id").val()
	};
	$.ajaxSec({
		type: 'POST',
		url: base+"/teamInvite/acceptOrRefuseInvite",
		data: jsonData,
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				loadTeamInvite();
				loadGameInfo();
			}
		},
		error: $.ajaxError
	});	
}

function loadVisitor(pageNum){
	$.loadSec("#sysvisitor",base+"/visitor/visitorList",
			{"currentPage":pageNum,"teaminfo_id":$("#teaminfo_id").val(),"visit_url":"club","visit_type":"1"});
}

//取消副队长资格
function cancelRole(player_id){
	yrt.confirm('是否要取消副队长资格?', {
	    btn: ['确认','取消'] //按钮
	}, function(){
		var jsonData = {
				"player_id":player_id,
				"teaminfo_id":$("#teaminfo_id").val()	
			};
			$.ajaxSec({
				type: 'POST',
				url: base+"/team/cancelRole",
				data: jsonData,
				success: function(data){
					if(data.state=='error'){
						yrt.msg(data.message.error[0],{icon:2});
					}else{
						yrt.msg("操作成功!",{icon:1});
						loadPlayers();
					}
				},
				error: $.ajaxError
			});	
	}, function(){
	
	});
}	

//加载宝贝信息
function loadBaby(){
	var jsonData = {
		"teaminfo_id":$("#teaminfo_id").val(),
		"status":"1",
		"pageSize":3,
		"user_id":$("#user_id").val()
	};
	$.ajax({
		type: 'POST',
		url: base+"/babyIn/teamBabys",
		data: jsonData,
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:0});
			}else{
				$("#babyArea").html(data);
			}
		},
		error: $.ajaxError
	});	
}

function delBaby(id){
	yrt.confirm('是否需要踢出宝贝?', {
	    btn: ['确认','取消'] //按钮
	}, function(){
		$.ajax({
			type: 'POST',
			url: base+"/babyIn/kickBabyIn",
			data: {"id":id},
			dataType:"json",
			success: function(data){
				if(data.state=='error'){
					yrt.msg(data.message.error[0],{icon:2});
				}else{
					yrt.msg(data.message.success[0],{icon:1});
					loadBaby();
				}
			},
			error: $.ajaxError
		});
	});
	
}
// add by ylt 打开宝贝
function openGameBaby(teamgame_id){
	var c = $("#baby_count").val();	
	if(c == '0'){
		layer.msg("本俱乐部暂无入驻宝贝,请到宝贝中心进行助威邀请！",{icon:2});
		return false;
	}
	$("#teamgame_id").val(teamgame_id);	
	
	$("#gamebabyArea").center().show();
}

//add by ylt 批量保存宝贝
function saveCheerBaby(){
	var jsonData = $("#babyForm").serializeObject();
	if(jsonData.baby_ids == ""){
		layer.msg("请选择助威宝贝！",{icon:2});
		return false;
	}
	jsonData.teaminfo_id = $("#teaminfo_id").val();
	$.ajaxSec({
		type: 'POST',
		url: base+"/babyCheer/saveCheerBatch",
		data: jsonData,
		dataType:"json",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				$("#gamebabyArea").hide();
				loadGameInfo();
			}
		},
		error: $.ajaxError
	});
}

//弹出购买邀请码
function openBuy(){
	$.ajax({
		type: 'POST',
		url: base+"/team/toBuyCode",
		data:{"teaminfo_id":$("#teaminfo_id").val()},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$(".buyInviteCode").html(data);
			}
		},
		error: $.ajaxError
	});	
	$(".buyInviteCode").center().css("display","block");
		//获取遮罩高度并显示
  	$(".masker").height($(document).height());
  	$('.masker').fadeIn();
}

function closeBtn(){
	$(".buyInviteCode").css("display","none");
   	$('.masker').fadeOut();
   	$(".buyInviteCode").html("");
}

function buyCode(){
	$.ajaxSec({
		context:$("#buyForm"),
		type:"POST",
		url:base+"/team/buyCode?random="+Math.random(),
		data:$("#buyForm").serialize(),
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				layer.msg(data.message.success[0],{icon: 1});
				closeBtn();
				openBuy();
			}
		}
	});
}
function calculate(dom){
	var single = $(dom).val();
	var price = single * 10000;
	$("#showTotal").html(price);
	$("#price").val(price);
}