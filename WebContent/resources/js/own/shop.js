$(function(){});

//立即购买
function toBuy(data){
	var num = $("#num").val();
	if(!num){
		num = 1;
	}
	if(check_user_role()){
		window.location = base + "/shop/toBuy/" + data + "?num=" + num;
	}
}

