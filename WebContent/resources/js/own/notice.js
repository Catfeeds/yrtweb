$(function(){
	loadNotice();	
});
//加载公告信息
function loadNotice(){
	$.ajax({
		type: 'POST',
		url: base+"/team/loadNotice",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"pageSize":3},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#noticeArea").html(data);
			}
		},
		error: $.ajaxError
	});
}
//公告列表
function noticeList(){
	$.ajax({
		type: 'POST',
		url: base+"/team/noticeList",
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
//显示公告信息
function showNotice(id){
	$.ajax({
		type: 'POST',
		url: base+"/team/showNotice",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"id":id},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#showNoticeArea").html(data);
				$("#showNoticeArea").center().show();
			}
		},
		error: $.ajaxError
	});
}

//添加公告信息页面
function addNoticePage(id,nid){
	$.ajax({
		type: 'POST',
		url: base+"/team/addNoticePage",
		data: {"teaminfo_id":id,id:nid},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#addNoticeArea").html(data);
				$("#addNoticeArea").center().show();
			}
		},
		error: $.ajaxError
	});
	
}
//公告修改
function editNotice(id,nid){
	cl();
	addNoticePage(id,nid);
}

//保存公告信息页面
function saveNotice(){
	var jsonData = {
		"teaminfo_id":$("#teaminfo_id").val(),	
		"name" : $("#name").val(),	
		"describle" : $("#describle").val()
	};
	
	$.ajaxSec({
		context:$("#nForm"),
		type: 'POST',
		url: base+"/team/saveNotice",
		data:$("#nForm").serialize(),
		dataType:"json",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				$("#addNoticeArea").hide();
				loadNotice();	
			}
		},
		error: $.ajaxError
	});
}

function delNotice(nid){
	yrt.confirm("是否要删除这条公告？", {
	    btn: ['确定','取消'], //按钮
	    shade: true 
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/team/deleteNotice',
			data: {id: nid},
			success: function(result){
				if(result.state=='success'){
					yrt.msg("删除成功",{icon: 1});
					loadNotice();	
					cl();
				}else{
					yrt.msg(result.message.error[0],{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}