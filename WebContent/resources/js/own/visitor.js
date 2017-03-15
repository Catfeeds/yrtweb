$(function(){
	loadVisitor(0); //访问者列表	
});

function loadVisitor(pageNum){
	$.loadSec("#visitArea",base+"/visitor/visitorList",
			{"currentPage":pageNum,"pageSize":4, "teaminfo_id":$("#teaminfo_id").val(),"visit_url":"club","visit_type":"1"});
}