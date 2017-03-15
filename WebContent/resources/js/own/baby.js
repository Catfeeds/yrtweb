$(function(){
	loadBaby();	
});
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

//add by ylt 保存宝贝
function saveCheerBaby(){
	/*var jsonData = $("#babyForm").serializeObject();
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
			}
		},
		error: $.ajaxError
	});*/
	
	if($("#game_id").val() == ""){
		layer.msg("请选择比赛后再邀请！",{icon: 2});
		return false;
	}
	var jsonData = $("#babyForm").serializeObject();
	jsonData.teaminfo_id = $("#teaminfo_id").val();
	jsonData.teamgame_id = $("#game_id").val();
	jsonData.user_id = $("#baby_user_id").val();
	$.ajaxSec({
		context:$("#cheerForm"),
		type:"POST",
		url:base+"/babyCheer/saveCheer?random="+Math.random(),
		data:jsonData,
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				layer.msg(data.message.success[0],{icon: 1});
				cl();
				//刷新当前页面
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		},
	});
}

//add by ylt 打开宝贝
function openGameBaby(id){
	$.ajax({
		type: 'POST',
		url: base+"/team/openGameBaby",
		data: {user_id:id,teaminfo_id:$("#teaminfo_id").val()},
		dataType:"html",
		success: function(data){
			 $("#gamebabyArea").html(data);
			 var h = $(document).height();
             $(".masker").css("height", h).show();
             $("#gamebabyArea").center().show();	
		},
		error: $.ajaxError
	});
}

//删除宝贝
function delBaby(id){
	yrt.confirm('是否需要踢出宝贝?', {
		title:'踢出确认',
	    btn: ['确定','取消'], //按钮
	    shade: true //显示遮罩
	}, function(){
		$.ajax({
			type: 'POST',
			url: base+"/babyIn/kickBabyIn",
			data: {"user_id":id},
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

//add by ylt 比赛展现
function gameshow(){
	var id = $("#game_id").val();
	var teaminfo_id = $("#teaminfo_id").val();
	if(id == ""){
		$("#cheer_time").val("");
		$("#cheer_address").val("");
		$("#team_name").val("");
		$("#logo").val("");
		$("#cheer_time_s").html("");
		$("#cheer_address_s").html("");
		$("#team_name_s").html("");
	}else{
		$.ajax({
			type:"POST",
			url:base+"/teamInvite/gameInfo?random="+Math.random(),
			data:{"id":$("#game_id").val()},
			success:function(result){
				$("#cheer_time").val(result.data.teamGame.game_time);
				$("#cheer_time_s").html(Filter.formatDate(result.data.teamGame.game_time,"yyyy-MM-dd"));
				$("#cheer_address").val(result.data.teamGame.position);
				$("#cheer_address_s").html(result.data.teamGame.position);
				if(result.data.teamGame.initiate_teaminfo_id == teaminfo_id){
					$("#team_name").val(result.data.teamGame.t_name);
					$("#team_name_s").html(result.data.teamGame.t_name);
					$("#logo").val(result.data.teamGame.t_logo);
				}else{
					$("#team_name").val(result.data.teamGame.r_name);
					$("#team_name_s").html(result.data.teamGame.r_name);
					$("#logo").val(result.data.teamGame.r_logo);
				}
			},
		});
	}
}