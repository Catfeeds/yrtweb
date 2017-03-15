$(function(){
	InList(0);
});

//add by ylt 入住列表
function InList(pageIndex){
	$.ajax({
		type: 'POST',
		url: base+"/babyIn/inListDatas",
		data:{"user_id":$("#user_id").val(),"pageSize":16},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#listArea").html(data);
			}
		},
		error: $.ajaxError
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