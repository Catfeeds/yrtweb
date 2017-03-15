/**
 * 跳转竞拍市场页面
 */
function goAuction(league_id){
	$.ajax({
		type : 'POST',
		url : base+"/league/checkAuction",	
		data : {league_id : league_id},
		dataType:"json",
		cache : false,
		success : function(result) {
			if(result.state=='error'){
				layer.msg(result.message.error[0],{icon:2});
				return false;
			}else{
				window.location = base+"/auction/searchList?league_id="+league_id;
			}
		},
		error : $.ajaxError
	});
}

/**
 * 跳转转会市场页面
 */
function goMarket(s_id){
	$.ajax({
		type : 'POST',
		url : base+"/playerTrade/isOpenMarket",	
		data : {s_id : s_id},
		dataType:"json",
		cache : false,
		success : function(result) {
			if(result.state=='error'){
				layer.msg(result.message.error[0],{icon:2});
				return false;
			}else{
				window.location = base+"/playerTrade/list?league_id="+s_id;
			}
		},
		error : $.ajaxError
	});
}

