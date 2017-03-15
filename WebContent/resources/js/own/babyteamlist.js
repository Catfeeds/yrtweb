$(function(){
	searchCheer(1);
	searchIn(1);
});
//add by ylt 助威列表
function searchCheer(pageIndex){
	$.ajax({
		type: 'POST',
		url: base+"/babyCheer/listDatas",
		data:{"user_id":$("user_id").val(),"pageSize":3,"currentPage":pageIndex},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#zwArea").html(data);
			}
		},
		error: $.ajaxError
	});	
}

//add by ylt 入住列表
function searchIn(pageIndex){
	$.ajax({
		type: 'POST',
		url: base+"/babyIn/listDatas",
		data:{"user_id":$("user_id").val(),"pageSize":3,"currentPage":pageIndex},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#dyArea").html(data);
			}
		},
		error: $.ajaxError
	});	
}

//助威确认
function checkCheer(id,status){
	$.ajax({
		type: 'POST',
		url: base+"/babyCheer/updateStatus",
		data:{"id":id,"status":status},
		dataType:"JSON",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				layer.msg(data.message.success[0],{icon:1});
				searchCheer(0);
			}
		},
		error: $.ajaxError
	});	
}

//入住确认
function checkIn(id,status){
	$.ajax({
		type: 'POST',
		url: base+"/babyIn/updateStatus",
		data:{"id":id,"status":status},
		dataType:"JSON",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				searchIn(0);
			}
		},
		error: $.ajaxError
	});	
}