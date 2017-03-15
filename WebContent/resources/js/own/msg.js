//add by ylt 系统消息同意 2015-09-01
 function openMsg(s_id,usernick){
 	$.ajaxSec({
 		type: 'POST',
 		url: base+"/ifLogin",
 		dataType:"JSON",
 		success: function(data){
 			if(data.state=='error'){
 				layer.msg(data.message.error[0]);
 			}else{
 				layer.open({
 				    type: 2,
 				    title: false,
 				    closeBtn:false, 
 				    shadeClose: true,
 				    shade: 0.8,
 				    shift : 4,
 				    area: ['426px', '291px'],
 				    content: [base+'/message/toMsg/'+s_id+'/'+usernick, 'no']
 				}); 
 			}
 		}
 	});
 }