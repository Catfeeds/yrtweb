//载入历史比赛记录
function loadListPage(currentPage,teaminfo_id,type){
		$.ajax({
			type:"POST",
			url:base+"/team/gameDatas?random="+Math.random(),
			data:{'oth_user_id':$("#user_id").val(),"teaminfo_id":teaminfo_id,"currentPage":currentPage,'type':type,pageSize:10},
			dataType:"HTML",
			success:function(data){
				$("#historyArea").empty();
				$("#historyArea").html(data);
			}
		});
	}
function loadHistoryArea(currentPage,teaminfo_id,type){
	$.ajax({
		type:"POST",
		url:base+"/team/gameDatas?random="+Math.random(),
		data:{'oth_user_id':$("#user_id").val(),"teaminfo_id":teaminfo_id,"currentPage":currentPage,'type':type},
		dataType:"HTML",
		success:function(data){
			$("#historyArea").empty();
			$("#historyArea").html(data);
		}
	});
}

//录入、确认比分
function wriBeScore(id,teaminfo_id){
	$.loadSec("#upload_matchResult",base+'/teamInvite/newResultPage',{"id":id,"teaminfo_id":$("#teaminfo_id").val()},function(){
		 var h = $(document).height();
         $(".masker").css("height", h).show();
	      $("#upload_matchResult").center().show();
   });
}

//提交比分
function submitScore(game_id,teaminfo_id){
	if($("#initiate_score").val().trim()=="" || $("#respond_score").val().trim()==""){
		layer.msg("比分不能为空！",{icon:2});
		return false;
	}
	if(parseInt($("#initiate_score").val())>30 || parseInt($("#respond_score").val())>30){
		layer.msg("比分值不得超过30",{icon:2})
		return false;
	}
	if(parseInt($("#initiate_score").val())<0 || parseInt($("#respond_score").val())<0){
		layer.msg("比分值不能小于0",{icon:2})
		return false;
	}
	
	$.ajaxSec({
		type:"POST",
		url:base+"/teamInvite/uploadResult?random="+Math.random(),
		data:{"id":game_id,"teaminfo_id":teaminfo_id,"initiate_score":$("#initiate_score").val(),"respond_score":$("#respond_score").val()},
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				window.location.reload();
			}
		}
	});
	
}

//added by bo.xie 同意、拒绝比分
function confirmCore(id,status){
	$.ajaxSec({
		type:"POST",
		url:base+"/teamInvite/checkResult?random="+Math.random(),
		data:{"id":id,"teaminfo_id":$("#teaminfo_id").val(),"status":status},
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				layer.msg(data.message.success[0],{icon: 1});	
				window.location.reload();
			}
		}
	});
}
