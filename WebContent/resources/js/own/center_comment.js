$(function(){
	load_center_comment();
})

function load_center_comment(){
	$.loadSec("#center_comments",base+"/center/comments",{oth_user_id:$("#oth_user_id").val()},function(){
	});
}

function pla_handler(result){
	if(result.state=='success'){
		layer.msg("评价成功",{icon: 1});
		closeAll();
		load_comment_list();
		commenter = new Object();
	}else{
		layer.msg("评价失败",{icon: 2});
	}
}