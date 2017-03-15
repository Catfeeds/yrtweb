$(function() {
	userSearch(0);
	gUserSearch(0);
});

/**
 * 推荐列表
 * 
 * @param pageIndex
 */
function gUserSearch(pageIndex) {
	var jsonData = $("#playerForm").serializeObject();
	jsonData.currentPage = pageIndex;
	jsonData.pageSize = 9;
	// 发送ajax获取数据
	$.ajax({
			type : 'POST',
			url : base+"/player/searchGoodList",
			data : jsonData,
			dataType:"html",
			cache : false,
			success : function(result) {
				if(result.state=='error'){
					layer.msg(result.message.error[0]);
				}else{
					$("#speciallist").html(result);
				}
			},
			error : $.ajaxError
		});
}

function allSearch(id){
	$("#s_user_id").val("");	
	$("#all").addClass("active");
	$("#foc").removeClass("active");
	userSearch(0);
}

function focusSearch(id){
	$("#s_user_id").val(id);	
	$("#foc").addClass("active");
	$("#all").removeClass("active");
	userSearch(0);
}

/**
 * 列表显示
 * 
 * @param pageIndex
 */
function userSearch(pageIndex) {
	var jsonData = $("#searchForm").serializeObject();
	jsonData.pageSize = 8;
	if(typeof(pageIndex) == "undefined"){
		var pIndex = $("#pIndex").val();
		if(pIndex == ""){
			layer.msg("输入框为空！",{icon:2});
			return false;
		}else if(isNaN(pIndex)){
		layer.msg("输入必须为数字！",{icon:2});
			return false;
		}
		jsonData.currentPage = pIndex;
	}else{
		jsonData.currentPage = pageIndex;
	}
	// 发送ajax获取数据
	$.ajax({
			type : 'POST',
			url : base+"/player/searchList",
			data : jsonData,
			dataType:"html",
			cache : false,
			success : function(result) {
				if(result.state=='error'){
					layer.msg(result.message.error[0]);
				}else{
					$("#userlist").html(result);
				}
			},
			error : $.ajaxError
		});
}

//add by ylt 常踢球时间选择
function setCd(id,dom,t){
    $(dom).attr("style","color:#669966 ").siblings().removeAttr("style");
	$(id).val(t);
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


//关注
function focus_user(dom,uid,type,pageIndex){
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
					/*if(type){
						$(dom).attr("value","关注").attr("title","关注");
						$(dom).attr("onclick","focus_user(this,'"+uid+"')");
					}else{
						$(dom).attr("value","已关注").attr("title","取消关注");
						$(dom).attr("onclick","focus_user(this,'"+uid+"',true)");
					}*/
					layer.msg("关注成功!",{icon: 1});
				}else{
					layer.msg(result.message.error[0],{icon: 2});
				}
				$(dom).removeAttr("flag");
				userSearch(pageIndex);
			},
			error: $.ajaxError
		});
	}
}

//申请签约
function sign_user(dom,id){
	var flag = $(dom).attr("flag");
	if(!flag){
		$(dom).attr("flag","1");
		$.ajaxSec({
			type:'POST',
			url: base+"/agent/signByAgent",
			data: {"playerId":id},
			cache: false,
			dataType:'json',
			success: function(result){
				if(result.state=='success'){
					layer.msg("发起签约申请成功!",{icon: 1});
				}else{
					layer.msg(result.message.error[0],{icon: 2});
				}
				$(dom).removeAttr("flag");
			},
			error: $.ajaxError
		});
	}
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


//update by gl
//试训弹窗
function trialShow(othUserId){
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
				$('.trial').find("[name=user_id]").val(othUserId);
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

function trialHide(){
	$('.trial').find("input[type=text]").val("");
	$('.trial').find("textarea").val("");
	$('.trial').hide();
}

function getSort(name,sid){
	$(".ich").each(function(i){
		if(name == "all"){
			this.value = "";
			$("#"+this.name).html("");
		}else{
			if(this.name == name){
				if(this.value == "DESC"){
					this.value = "ASC";
					$(sid).html("&#8593;");
				}else if(this.value == "ASC"){
					this.value = "DESC";
					$(sid).html("&#8595;");
				}else{
					this.value = "DESC";
					$(sid).html("&#8595;");
				}
			}else{
				this.value = "";
				$("#"+this.name).html("");
				//$(sid).html("");
			}
		}
	});
	userSearch(0);
}
