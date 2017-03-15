


function showhistory(sid,mid,uid){
	var height = $(document).height();
	$(".makser").css({ "height": height }).fadeIn();
	$(".historical").center().fadeIn();
    loadhistoryDatas(sid,mid,uid,1);
}
function loadhistoryDatas(sid,mid,uid,currentPage){
	$.ajax({
		type:'post',
		url:base+'/playerTrade/marketHistorys?random='+Math.random(),
		data:{"currentPage":currentPage,"pageSize":10,"user_id":uid,"m_id":mid,"s_id":sid},
		dataType:'json',
		success:function(data){
			$("#historyData").empty();
			var len = data.data.rf.items.length;
			var html='';
				html='<table class="infos">';
				html+='<tr><th><span>出价时间</span></th><th><span>出价俱乐部</span></th><th><span>出价</span></th><th><span>状态</span></th></tr>';
			if(len>0){
			$.each(data.data.rf.items,function(i,item){
				if(i==0 && data.data.rf.currentPage==1){
					html+='<tr><td><dl><dt>'
					html+='<span class="text-orange f16">'+Filter.formatDate(item.buy_time,'yyyy-MM-dd')+'</span>';
					html+='</dt>';
					html+='<dd><span class="text-orange f16">'+Filter.formatDate(item.buy_time,'hh:mm:ss')+'</span></dd></dl></td>';
					html+='<td><span class="text-orange f16">'+item.name+'</span></td>';
					html+='<td><span class="text-orange f16">'+item.buy_price+'</span></td>';
					html+='<td><span class="text-orange f16">当前最高</span></td></tr>';
				}else{
					html+='<tr><td><dl><dt>'
					html+='<span>'+Filter.formatDate(item.buy_time,'yyyy-MM-dd')+'</span>';
					html+='</dt>';
					html+='<dd><span>'+Filter.formatDate(item.buy_time,'hh:mm:ss')+'</span></dd></dl></td>';
					html+='<td><span>'+item.name+'</span></td>';
					html+='<td><span>'+item.buy_price+'</span></td>';
					html+='<td><span>被超过</span></td></tr>';
				}
			})
				html+='</table>';
				html+='<ul class="pagination" style="float:right;margin-top:15px;">';
				html+='<li><label class="index">第'+data.data.rf.currentPage+'页/共'+data.data.pageCount+'页</label> </li>';
				html+='<li><label class="sum">共计'+data.data.rf.totalCount+'条</label> </li>';
				html+='<li><a href="javascript:void(0)" onclick="loadhistoryDatas(1);">首页</a></li>';
				if(eval(data.data.rf.currentPage-1)>0){
					html+='<li><a href="javascript:void(0)" onclick="loadhistoryDatas('+eval(data.data.rf.currentPage-1)+');">上一页</a></li>';
				}else{
					html+='<li><a href="javascript:void(0)">上一页</a></li>';
				}
				if(eval(data.data.rf.currentPage+1)>eval(data.data.pageCount)){
					html+='<li><a href="javascript:void(0)">下一页</a></li>';
				}else{
					html+='<li><a href="javascript:void(0)" onclick="loadhistoryDatas('+eval(data.data.rf.currentPage+1)+');">下一页</a></li>';
				}
				html+='<li><a href="javascript:void(0)" onclick="loadhistoryDatas('+data.data.pageCount+');">最后一页</a></li>';
				html+='</ul><div class="clearfix"></div>';
			}else{
				html+='<tr><td colspan="4">暂无竞价...</td></tr>';
			}
			$("#historyData").append(html);
		}
	});
}