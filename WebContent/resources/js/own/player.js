$(function(){
	loadPlayers(0);
	loadLoanPlayers(0);
});
//add by ylt 队员信息
function loadPlayers(currentPage){
	$.ajax({
		type: 'POST',
		url: base+"/team/teamPlayerList",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"currentPage":currentPage,pageSize:8},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#playersArea").html(data);
				  $('.club_center tr').not(":first").mouseover(function () {
			            $(this).css({ "background": "#21291a","cursor":"pointer" });
			        }).mouseout(function() {
			            $(this).css({ "background": "", "cursor": "pointer" });
			        });
			}
		},
		error: $.ajaxError
	});	
}

//add by ylt 租借队员信息
function loadLoanPlayers(currentPage){
	$.ajax({
		type: 'POST',
		url: base+"/teamLoan/loanPlayerList",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"currentPage":currentPage,pageSize:3},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#loansArea").html(data);
				  $('.club_center tr').not(":first").mouseover(function () {
			            $(this).css({ "background": "#21291a","cursor":"pointer" });
			        }).mouseout(function() {
			            $(this).css({ "background": "", "cursor": "pointer" });
			        });
			}
		},
		error: $.ajaxError
	});	
}