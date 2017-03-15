$(function(){
	loadListPage(1);
});

//取消按钮，关闭当前弹窗
function cl() {
    $(".baby_daiyan").fadeOut();
    $(".baby_zhuwei").fadeOut();
    $(".baby_zan").fadeOut();
    $(".masker").fadeOut();
    $(".gift_list").fadeOut();
    //需求是宝贝必须点赞，才可以进行其他操作
    //if ($(".baby_zan").is(":visible")) {
    //    $(".masker").show();
    //} else {
    //    $(".masker").fadeOut();
    //}

}

//宝贝评分
function pfBaby(){
	//评价分数
	var score = $("input[name='score']").val();
	if(score==""){
		layer.msg("评分不能为空！",{icon: 2});
		return false;
	}
	//当前宝贝用户ID
	var user_id = $("#baby_user_id").val();
	$.ajaxSec({
		type:"POST",
		url:base+"/baby/inScore?random="+Math.random(),
		data:{"score":score,"user_id":user_id},
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				layer.msg(data.message.success[0],{icon: 1});
				setInterval(function(){
					window.location.reload();
				},1000);
			}
		}
	},closePjWin());
}

//关闭遮罩
function closePjWin(){
	 $(".baby_zan").fadeOut();
	 $(".masker").fadeOut();
	 
}
//邀请宝贝代言
function inviteProxy(){
	$.ajaxSec({
		context:$("#inInfo"),
		type:"POST",
		url:base+"/babyIn/save?random="+Math.random(),
		data:$("#inInfo").serialize(),
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				layer.msg(data.message.success[0],{icon: 1});
				//关闭当前弹窗
				//cl();
				//刷新当前页面
				window.location.reload();
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		},
	});
}

//宝贝评价列表分页
function loadListPage(currentPage){
	$.ajax({
		type:"POST",
		url:base+"/babyeval/pjList?random="+Math.random(),
		data:{"user_id":$("#baby_user_id").val()},
		dataType:"HTML",
		success:function(data){
			$("#pjListDatas").empty();
			$("#pjListDatas").append(data);
		},
	});
}

//add by ylt 系统消息同意 2015-09-01
function openMsg(id,usernick){
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
				    content: [base+'/message/toMsg/'+id+'/'+usernick, 'no']
				}); 
			}
		}
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

//邀请宝贝助威
function cheerGame(){
	if($("#game_id").val() == ""){
		layer.msg("请选择比赛后再邀请！",{icon: 2});
		return false;
	}
	var jsonData = $("#cheerForm").serializeObject();
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

//add by ylt 退出俱乐部入住
function quitTeamIn(id){
	yrt.confirm('是否退出俱乐部入住?', {
	    btn: ['确认','取消'] //按钮
	}, function(){
		$.ajax({
			type: 'POST',
			url: base+"/babyIn/quitTeamIn",
			data:{id:id},
			success: function(data){
				if(data.state=='error'){
					yrt.msg(data.message.error[0]);
				}else{
					yrt.msg(data.message.success[0],{icon:1});
				}
			},
			error: $.ajaxError
		});	
	});
}

//关注宝贝
function focusBaby(id){
	var html = '<input type="button" name="取消关注" value="取消关注" onclick="unfocusBaby('+id+')" class="invi_btn ms f14 pull-right  mt25 mr15" />';
	$.ajaxSec({
		type:"POST",
		url:base+"/user/focus?random="+Math.random(),
		data:{"f_user_id":id,"f_type":0},
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				$("#focusBabySpan").empty();
				$("#focusBabySpan").append(html);
				
			}
		}
	}); 
}
//取消关注宝贝
function unfocusBaby(id){
	var html='<input type="button" name="关注" value="关注" onclick="focusBaby('+id+')" class="invi_btn ms f14 pull-right  mt25 mr15" />';
	$.ajaxSec({
		type:"POST",
		url:base+"/user/cancel?random="+Math.random(),
		data:{"f_user_id":id,"f_type":0},
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				$("#focusBabySpan").empty();
				$("#focusBabySpan").append(html);
			}
		}
	}); 
}