//显示操作按钮 ylt
function showBtn(b){
	$(b).css("display","block");
}
//隐藏操作按钮 ylt
function hideBtn(b){
	$(b).css("display","none");
}

//踢出球队 ylt
function kickTeam(p_id){
	yrt.confirm('是否确定踢出该名球员？不可撤销，请慎重！', {
	    btn: ['确认','取消'] //按钮
	}, function(){
		var jsonData = {
				"player_id":p_id,
				"teaminfo_id" : $("#teaminfo_id").val()
			};
			$.ajaxSec({
				type: 'POST',
				url: base+"/team/kickTeam",
				data: jsonData,
				success: function(data){
					if(data.state=='error'){
						yrt.msg(data.message.error[0]);
					}else{
						yrt.msg("操作成功!",{icon:1});
						window.location.reload();
					}
				},
				error: $.ajaxError
			});	
	}, function(){
	
	});
}

//拉黑 ylt
function defriend(p_id){
	yrt.confirm('是否要拉黑该名球员?', {
	    btn: ['确认','取消'] //按钮
	}, function(){
		var jsonData = {
				"player_id":p_id,
				"teaminfo_id" : $("#teaminfo_id").val()
			};
			$.ajaxSec({
				type: 'POST',
				url: base+"/team/defriendPlayer",
				data: jsonData,
				success: function(data){
					if(data.state=='error'){
						yrt.msg(data.message.error[0]);
					}else{
						yrt.msg("操作成功!",{icon:1});
						window.location.reload();
					}
				},
				error: $.ajaxError
			});	
	}, function(){
	
	});
}

//指认队长或者副队长
function changeRole(type,p_id){
	yrt.confirm('是否要变更身份?', {
	    btn: ['确认','取消'] //按钮
	}, function(){
		var jsonData = {
				"type":type,
				"player_id":p_id,
				"teaminfo_id" : $("#teaminfo_id").val()
			};
			$.ajaxSec({
				type: 'POST',
				url: base+"/team/changeRole",
				data: jsonData,
				success: function(data){
					if(data.state=='error'){
						yrt.msg(data.message.error[0]);
					}else{
						yrt.msg("操作成功!",{icon:1});
						window.location.reload()
					}
				},
				error: $.ajaxError
			});	
	}, function(){
		
	});
}

// 取消副队长资格
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
					window.location.reload();
				}
			},
			error: $.ajaxError
		});	
	}, function(){
		
	});
}

//选择号码
function selectNum(user_id){
	 
	var jsonData = {
		"user_id":user_id,
		"teaminfo_id":$("#teaminfo_id").val()
	};
	$.ajax({
		type: 'POST',
		url: base+"/team/toNumPage",
		data: jsonData,
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				
				$("#numArea").html(data);
				var h = $(document).height();
			     $(".masker").css("height", h).show();
			     $(".select_jersey").center().show();
			}
		},
		error: $.ajaxError
	});	
}

//选择号码
function selectLoanNum(id){
	var jsonData = {
		"id":id,
		"teaminfo_id":$("#teaminfo_id").val(),
		"loanPlayer":"true"
	};
	$.ajax({
		type: 'POST',
		url: base+"/team/toNumPage",
		data: jsonData,
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				$("#numArea").html(data);
				var h = $(document).height();
			     $(".masker").css("height", h).show();
			     $(".select_jersey").center().show();
			}
		},
		error: $.ajaxError
	});	
}

//选择号码
function updateNum(id,type){
	var jsonData = {
		"id":id,
		"num":$("#num").val(),
		"type":type
	};
	$.ajaxSec({
		type: 'POST',
		url: base+"/team/updateNum",
		data: jsonData,
		dataType:"json",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				window.location.reload();
			}
		},
		error: $.ajaxError
	});	
}

function checkNum(num){
    if($("#"+num).hasClass("active")){
        $("#"+num).removeClass("active");
        $("#num").val('');
    } else {
        if ($(".select_jersey").find(".active").length > 0) {
        	$(".select_jersey").find(".active").each(function(i){
        		$(this).removeClass("active");
        	});
        }
        $("#"+num).addClass("active");
        $("#num").val(num);
    }
}

//打开挂牌
function toSellPage(id){
	$.ajax({
		type:'post',
		url:base+"/team/isLeagueTeam?random="+Math.random(),
		data:{"id":id},
		dataType:'json',
		success:function(data){
			if(data.state=='error'){
				//关闭弹窗
				cl();
				layer.msg(data.message.error[0],{icon:2});
			}else{
				//显示弹窗
				var h = $(document).height();
	            $(".masker").css("height", h).show();
	            $(".notice").center().show();
				//打开出售界面
				$.ajax({
					type: 'POST',
					url: base+"/team/toSellPage",
					data: {"id":id},
					dataType:"html",
					success: function(data){
						if(data.state=='error'){
							layer.msg(data.message.error[0],{icon:2});
						}else{
							$("#playerArea").html(data);
						}
					},
					error: $.ajaxError
				});
			}
		}
	})
}

//出售
function sellPlayer(){
	$.ajaxSec({
		context:$("#sellForm"),
		type: 'POST',
		url: base+"/team/sellPlayer",
		data:$("#sellForm").serialize(),
		dataType:"json",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				window.location.reload();
			}
		},
		error: $.ajaxError
	});	
}

//取消挂牌
function delSell(id){
	yrt.confirm("是否取消挂牌",{icon: 3, title:'提示'},function(i){
		$.ajax({
			type:'post',
			url:base+'/team/cancelSale',
			data:{"id":id},
			dataType:'json',
			success:function(data){
				if(data.state=='success'){
					yrt.msg(data.message.success[0],{icon:1});
					layer.close(i);
					setTimeout(function(){
						window.location.reload();
					},3000)
				}else{
					yrt.msg(data.message.error[0],{icon:2});
				}
			}
		})
	});
}

//邀请球员
function invite_user(dom,id){
	var flag = $(dom).attr("flag");
	if(!flag){
		$(dom).attr("flag","1");
		$.ajaxSec({
			type:'POST',
			url: base+"/player/teamByPlayer",
			data: {"playerId":id},
			cache: false,
			dataType:'json',
			success: function(result){
				if(result.state=='success'){
					layer.msg("邀请成功!",{icon: 1});
				}else{
					layer.msg(result.message.error[0],{icon: 2});
				}
				$(dom).removeAttr("flag");
			},
			error: $.ajaxError
		});
	}
}