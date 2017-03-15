<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-球员报名</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
</head>
<body>
	<div class="warp">
		<div class="makser"></div>
        <div class="invitation_code">
            <div class="closeBtn_1"></div>
            <p class="ms title f24">您的俱乐部正等着您的到来</p>
            <p class="ms title_1 f18">请输入您的邀请码</p>
            <input class="activecode" type="text" id="code_str" value="" /><br />
            <input type="button" onclick="activeCode()" value="激活" class="btn_l ms f18 mt35" />
        </div>
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
	     <div class="wrapper" style="margin-top: 116px;">
            <div class="league_reg">
                <div class="internal_border">
                	<div class="player_reg">
		           		<ul>
		                     <li class="actived"><span>1、报名须知</span></li>
		                     <li class=""><span>2、填写资料</span></li>
		             		 <li class=""><span>3、等待审核</span></li>
		                     <!-- <li class=""><span>4、支付报名费</span></li> -->
		                     <li class="active"><span>4、参赛方式</span></li>
		                     <li class=""><span>5、完成</span></li>
		                     <div class="clearit"></div>
		                 </ul>
		             </div>
                    <p class="title_1 ms mt35">请选择将以何种方式参赛</p>
                    <p class="title_2 ms"></p>
                    <div class="int_pic">
                        <ul>
                            <li><a href="javascript:;" onclick="input_code()"><img src="${ctx}/resources/images/rudui.jpg" alt="" /></a> </li>
                            <li><a href="javascript:;" onclick="single_player()"><img src="${ctx}/resources/images/xunzhao.jpg" alt="" /></a></li>
                            <div class="clearit"></div>
                        </ul>

                    </div>
                    <div class="btn_div">
                    	<input type="hidden" id="league_id" value="${league_id}"/>
                        <input type="button" name="name" value="组队参赛" class="admin_sbtn f18 ms ml35" id="invi_btn" />
                        <input type="button" name="name" value="单飞球星" id="single_player" class="player_sbtn f18 ms" style="margin-left: 170px;" />
                         <p><span class="pull-left mt20 ml25 ms f18 text-info">已有邀请码，火速入队</span>  <span class="pull-right mt20 text-success f18 ms mr10">进入球员市场，踢出身价</span> </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}

function input_code(){
	$(".makser").height($(document).height()).fadeIn();
	$("#code_str").val("");
    $(".invitation_code").center().fadeIn();
}

$("#invi_btn").click(function () {
	input_code();
});
$("#single_player").click(function () {
	single_player();
});

function close() {
    $(".makser").fadeOut();
    $(".invitation_code").fadeOut();
}

$(".closeBtn_1").click(function () {
    close();
});
$(".makser").click(function () {
    close();
});

function activeCode(){
	$.ajaxSec({
		type: 'POST',
		url: base+"/league/activePlayerCode",
		data: {"code_str":$("#code_str").val()},
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg('激活陈功',{icon:1});
				location.reload();
			}
		},
		error: $.ajaxError
	});	
}
function single_player(){
	yrt.confirm('您将进入球员市场，等待俱乐部管理者的邀请！', {
	    btn: ['确认','取消'], //按钮
	    shade: true
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/league/singlePlayer',
			data: {"league_id":$("#league_id").val()},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					yrt.msg("报名成功",{icon: 1});
					location.reload();
                } else {
                	yrt.msg(result.message.error[0],{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}
</script>
</body>
</html>