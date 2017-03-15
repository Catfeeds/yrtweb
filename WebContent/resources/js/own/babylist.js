$(function(){
	searchGirl(0);
});
//add by ylt 俱乐部列表
function searchGirl(pageIndex){
	var jsonData = $("#searchForm").serializeObject();
	jsonData.currentPage = pageIndex;
	$.ajax({
		type: 'POST',
		url: base+"/baby/searchGirl",
		data: jsonData,
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#babyArea").html(data);
			}
		},
		error: $.ajaxError
	});	
}
//add by ylt 认证状态选择
function getSt(dom,st){
    $(dom).attr("style","color:#669966").siblings().removeAttr("style");
	$("#status").val(st);
}
