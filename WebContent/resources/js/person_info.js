var card_flag = false;
var mouseoutTime;
//隐藏个人名片
function hideUserInfo(area_id,event){
	var e = event || window.event;
	mouseoutTime = setTimeout(function() {
		$(document).mouseover(function (e) {
	        if (!$(area_id).is(':has(' + e.target.localName + ')') && $(e.target).attr("class") != 'sp_name' && e.target.id != 'card_id') {
	        	card_flag = false;
	        }
	    });
		if(card_flag){
			$(area_id).show();
		}else{
			$(area_id).hide();
		}
    }, 400);
}

//显示个人名片
function showUserInfo(user_id,area_id,dom){
	clearTimeout(mouseoutTime);
		$.ajax({
			type:'get',
		　  　timeout:'300',
			url:base+'/user/card_info?random='+Math.random(),
			data:{"user_id":user_id},
			dataType:'html',
			beforeSend:function(){
				$(area_id).empty();
				$(".card").each(function () {
	                $(".card").hide();
	            });
			},
			success:function(data){
				if(dom){
					$(area_id).css("left",$(dom).position().left+"px");
				}
				$(area_id).append(data);
				$(area_id).show();
				$(area_id).mouseover(function() {
		            $(area_id).show();
		            card_flag = true;
		        }).mouseout(function() {
		            $(area_id).hide();
		            card_flag = false;
		        });

				/*$(document).mouseover(function (e) {
		            if (!$(area_id).is(':has(' + e.target.localName + ')') && $(e.target).attr("class") != 'sp_name' && e.target.id != 'card_id') {
		                $(area_id).hide();
		            }
		        });*/
			},
			complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
				//if(status=='timeout'){//超时,status还有success,error等值的情况
					//console.debug("超时");
		　　　　//}
			}
		})
	}