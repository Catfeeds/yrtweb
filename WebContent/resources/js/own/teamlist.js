$(function(){
	load_team_recommend(1);
	var ftype = $("#f_is_focus").val();
	if(ftype==1){
		$('.title_new').find('[focus=1]').addClass("active");
		$('.title_new').find('[focus=0]').removeClass("active");
		if(!check_user_role())return;
	}
	loadTeamList(0);
})
//add by gl 推荐俱乐部
function load_team_recommend(curPage){
	var pageSize = 14;
	var params = {currentPage:curPage,pageSize:pageSize};
	$.loadSec("#team_recommendations",base+"/team/queryRecommends",params);
}

function change_focus(type,dom){
	$("#f_is_focus").val(type);
	$(dom).parent().find("[focus]").removeClass('active');;
	$(dom).addClass("active");
	if(type==1){
		if(!check_user_role())return;
	}
	loadTeamList(0);
}

//add by ylt 俱乐部列表
function loadTeamList(pageIndex,orderby,dom){
	var jsonData = $("#searchForm").serializeObject();
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
	jsonData.pageSize = 12;
	if(orderby){
		jsonData = changeOrderBy(jsonData,orderby,dom);
	}else{
		jsonData.order_str = $("#p_order_str").val();
		jsonData.order_type = $("#p_order_type").val();
	}
	$.ajax({
		type: 'POST',
		url: base+"/team/searchTeam",
		data: jsonData,
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				$("#teamList").html(data);
			}
		},
		error: $.ajaxError
	});	
}

function changeOrderBy(jsonData,orderby,dom){
	jsonData.order_str = orderby;
	var type = $(dom).attr("ret");
	jsonData.order_type = type
	if(type=='1'){
		$(dom).attr("ret","0");
	}else{
		$(dom).attr("ret","1");
	}
	var str = $(dom).attr('orderby');
	if(str=='combat'){
		$(dom).parent().find("[orderby='amount']").attr("ret","1");
	}else{
		$(dom).parent().find("[orderby='combat']").attr("ret","1");
	}
	$(dom).parent().find("[orderby]").removeClass('active');
	$(dom).addClass("active");
	return jsonData;
}

function resetTeamList(){
	$("#searchForm").find("input[name=name]").val('');
	$("#s_ball_format").val('');
	$("#s_province").val('');
	$("#s_city").empty().append('<option value="">选择城市</option>');
	loadTeamList(0);
}

//add by ylt 进球总数选择
function getSumballs(dom,begin,end){
    $(dom).attr("style","color:#669966 ").siblings().removeAttr("style");
	$("#beginScore").val(begin);
	$("#endScore").val(end);
}
//add by ylt 常踢球时间选择
function getPlayTime(dom,t){
    $(dom).attr("style","color:#669966 ").siblings().removeAttr("style");
	$("#play_time").val(t);
}
//add by ylt 进球数选择
function getBall(dom,t){
    $(dom).attr("style","color:#669966 ").siblings().removeAttr("style");
	$("#ball_format").val(t);
}

//add by ylt 系统消息同意 2015-09-01
function openMsg(id){
	$.ajaxSec({
		type: 'POST',
		url: base+"/team/getCaption",
		dataType:"JSON",
		data: {"teaminfo_id":id},
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.open({
					type: 2,
 				    title: false,
 				    closeBtn:false, 
 				    shadeClose: true,
 				    shade: 0.8,
 				    shift : 4,
 				    area: ['426px', '291px'],
				    content: [base+'/message/toMsg/'+data.data.user.id+'/'+data.data.user.usernick, 'no']
				}); 
			}
		},
		error: $.ajaxError
	});
}

//加入球队
function join(id){
	$.ajaxSec({
		type: 'POST',
		url: base+"/team/joinTeam",
		dataType:"JSON",
		data: {"teaminfo_id":id},
		secMsg:"\u8bf7\u5148\u6fc0\u6d3b\u7403\u5458\u4fe1\u606f",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon: 1});
			}
		},
		error: $.ajaxError
	});
}


//关注球队
function t_focus(id,pageIndex){
	$.ajaxSec({
		type: 'POST',
		url: base+"/team/focusTeam",
		dataType:"JSON",
		data: {"f_teaminfo_id":id},
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon: 1});
				loadTeamList(pageIndex);
			}
		},
		error: $.ajaxError
	});
}

//关注球队
function deleteFocus(id,pageIndex){
	$.ajaxSec({
		type: 'POST',
		url: base+"/team/cancel",
		dataType:"JSON",
		data: {"f_teaminfo_id":id},
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon: 1});
				loadTeamList(pageIndex);
			}
		},
		error: $.ajaxError
	});
}
