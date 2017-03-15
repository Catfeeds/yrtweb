<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-俱乐部报名</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<link href="${ctx}/resources/css/clubSign.css" rel="stylesheet" />
<link href="${ctx}/resources/css/editClub.css" rel="stylesheet" />
</head>
<body>
	<div class="warp">
	<div class="masker"></div>
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
	     <div class="wrapper" style="margin-top: 116px;">
            <div class="reg_result">
                <div class="player_reg" style="padding-top: 20px;margin-top:0;">
                    <ul style="margin-left: 148px;">
                        <li class="actived"><span>1、报名须知</span></li>
                        <li class="active"><span>2、填写资料</span></li>
                        <li class=""><span>3、完成</span></li>
                        <div class="clearit"></div>
                    </ul>
                </div>
                <form id="league_team_form" action="${ctx}/league/applyTeamSign">
                <input type="hidden" name="s_id" id="cfg_id" value="${cfg_id}"/>
                <input type="hidden" id="logo_type" name="logoType" value="0"/>
                <div class="upClubLogo" id="upClub_logo">
                    <img src="${ctx}/resources/images/upClubLogo.png" id="logo_img" style="height: 130px;width: 130px;cursor: pointer;" />
					<input type="hidden" name="logo" value="images/default_logo.png" id="logo_val">
                </div>
                <div class="clubs_active">
                    <dl>
                        <dt><span>俱乐部名称：</span><span><input type="text" name="name" value="" valid="require len(1,26)" /></span></dt>
                        <dt><span>俱乐部简称：</span><span><input type="text" name="sim_name" value="" valid="require len(1,8)" /></span></dt>
                        <dd><span>联赛邀请码：</span><input type="text" name="code_str" value="" valid="require" /></dd>
                    </dl>
                </div>
                <div class="result_title" style="background: none;">
                    <span class="ml20 f16 ms" style="color:#666666;">提示：俱乐管理者可在XXXX-XX-XX XX:XX 进入球员市场，竞拍您心仪的的球员。 </span>
                </div>
                </form>
                <div class="prompt">
                	
                </div>
                <div style="width:600px;margin: 60px auto 0;text-align: center; ">
                    <input type="button" onclick="apply_team_sign()" value="报名" class="btn_l f18 ms">
                    <input type="button" onclick="location.href='/league/identity?cfg_id=${cfg_id}'" value="取消" class="btn_g f18 ms">
                </div>
            </div>

        </div>
        <div class="clubLogo ms">
      		<div class="closeBtn_1"></div>
       		<h4 class="text-gray ml10 mt5 f16">俱乐部头像更换</h4>
       		<ul class="mt20 ml20">
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_1.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_2.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_3.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_4.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_5.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_6.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_7.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_8.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_9.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_10.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_11.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_12.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_13.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_14.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_15.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_16.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_17.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_18.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_19.png" />
       			</li>
       			<li>
       				<img src="${ctx}/resources/images/clubLogo_20.png" />
       			</li>
       			<%-- <li>
       				<input type="file" class="imgFile"/>
       				<img src="${ctx}/resources/images/upload.png"/>
       			</li> --%>
       		</ul>
       		<div class="clear" style="height:20px;"></div>
       		<a href="javascript:;" onclick="change_team_img()" class="text-white ml35">+上传自定义头像</a>
       		<div class="text-center">
       			<input type="button" value="确认" class="logoBtn" onclick="checkIcon()"/>
       			<input type="button" value="取消" class="logoBtn_cancel" />
       		</div>
       </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
$('.clubLogo').css('display','none');
//显示上传俱乐部LOGO
$("#upClub_logo").click(function(){
	 $(".masker").height($(document).height()).fadeIn();
	 $(".masker").show();
	$('.clubLogo').center().css('display','block');
});
//隐藏上传俱乐部LOGO
 $(".logoBtn_cancel").click(function(){
	$('.clubLogo').css('display','none');
});

$(".logoBtn_cancel").click(function(){
	$(".masker").hide();
	$('.clubLogo').css('display','none');
});

//LOGO选中效果
 $(".clubLogo li img").click(function(){
	$(".clubLogo li img").removeClass("clubLogoChecked");
		$(this).each(function(){
			$(this).addClass("clubLogoChecked");
		});
 });	

//选中俱乐部ICON
function checkIcon(){
	var img = $(".clubLogoChecked").attr("src");
	$("#logo_val").val(img);
	$("#logo_img").attr("src",img);
	$(".masker").hide();
	$('.clubLogo').css('display','none');
	$("#logo_type").val(0);
}

jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}

function ctl(){
	$(".masker").hide();
	$('.clubLogo').hide();
}    
$(".masker").click(function(){
	ctl();
})
 $(".closeBtn_1").click(function(){
	 $(".masker").hide();
 	$('.clubLogo').hide();
})
function league_callback(result){
	if(result.state=='success'){
		layer.msg("报名成功，创建俱乐部成功",{icon: 1});
		setTimeout(function(){
			location.href=base + '/league/teamSign?cfg_id='+$("#cfg_id").val();
		},1400);
	}else{
		layer.msg(result.message.error[0],{icon:2});
	}
}

function apply_team_sign(){
	var logo = $('#logo_val').val();
	if(!logo){
		layer.tips("请选择俱乐部LOGO",'#logo_img',{
			tips: [2, '#c00'],
			time: 3000
		});
		return;
	}
	$.ajaxSubmit('#league_team_form','#league_team_form',league_callback);
}

var iframeTIndex;
function change_team_img(){
	 $(".masker").hide();
  	$('.clubLogo').hide();
	iframeTIndex = layer.open({
	    type: 2,
	    title: '编辑俱乐部LOGO',
	    shadeClose: true,
	    shade: [0],
	    area: ['660px', '600px'],
	    content: base+'/team/changeTeamImg' //iframe的url
	}); 
}

function closeIframe(path){
	layer.close(iframeTIndex);
	$("#logo_val").val(path);
	$("#logo_img").attr("src",filePath+"/"+path);
	$("#logo_type").val(1);
}
</script>
</body>
</html>