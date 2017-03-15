
function check_league_team(url){
	$.ajaxSec({
		type: 'POST',
		url: base+'/league/checkInviteMsg',
		cache: false,
		success: function(result){
			if(result.state=='success'){
				yrt.confirm('当前赛季已结束，您是否继续参加下一季度的联赛？', {
				    btn: ['是','否'],
				    cwidth:'92%'
				}, function(){
					update_invite_msg(1);
				}, function(){
					yrt.confirm('您的俱乐部将成为非联赛俱乐部，你的球员将可自由离队!', {
					    btn: ['确认','取消'],
					    cwidth:'92%'
					}, function(){
						update_invite_msg();
					}, function(){});
				});
			}else{
				if(result.data&&result.data.timeout=='1'){
					layer.msg(result.message.error[0],{icon: 2,shade:0.3},function(){
						location.href = base+ '/league/index'; 
					});
				}else{
					location.href = url;
				}
			}
		},
		error: $.ajaxError
	});
}

function update_invite_msg(flag){
	if(!check_user_role()){
		yrt.close(yrt.did);
		return;	
	}
	$.ajaxSec({
		type: 'POST',
		url: base+'/league/updateInviteMsg',
		data: {"flag":flag},
		cache: false,
		success: function(data){
			if(data.state=='success'){
				if(flag==1){
					location.href=base+'/league/teamSign';
				}else{
					location.reload();
				}
			}else{
				yrt.msg(result.message.error[0],{icon: 2});
			}
		},
		error: $.ajaxError
	});
}