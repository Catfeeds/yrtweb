<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<c:set var="currentPage" value="MODIFYBINDEMAIL"/>
<title>修改绑定邮箱</title>
</head>
<body>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../../common/header.jsp" %>
		<!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>
		 <div class="wrapper" style="margin-top: 30px;">
		 		 <!--页面主体-->
	            <div class="container ms">
	                <div class="middle">
	                	<p>${msg}</p>	 
	                </div>
	            </div>    
		 </div>
	</div>	
	<!-- footer start -->
	<%@include file="../../common/footer.jsp" %>
	<!-- footer end -->
</body>
<script type="text/javascript">

$("#next").click(function() {
	var code = $("#code").val();
	var name = $("#oldemail").val();
	$.ajaxSec({
		type:"POST",
		url:base+"/system/valid?random="+Math.random(),
		data:{"code":code,"name":name},
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				if ($("#step_1").is(":visible")){
			        $("#step_1").hide();
			        $("#step_2").show();
			    }
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
});

$("#prv").click(function () {
    if ($("#step_2").is(":visible")) {
        $("#step_2").hide();
        $("#step_1").show();
    }
});

//added by bo.xie 保存
function modifyPhone(){
	var code = $("#code2").val();
	var name = $("#new_email").val();
	$.ajaxSec({
		type:"POST",
		url:base+"/system/bindPhone?random="+Math.random(),
		data:{"phone":name,"code":code},
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				layer.msg("绑定成功！",{icon: 1});
				window.location.reload();
			}
		}
	});
}


//added by bo.xie 获取验证码
function getCodeNum(dom,id,type) {
    $(dom).attr("disabled", "disabled");
    var t = 60;
    var intervalProcess;
    intervalProcess = setInterval(function () {
    	 $(dom).val((--t) + "秒后重新获取");
    	 $(dom).attr("disabled", "disabled");
        if (t == 0) {
            clearInterval(intervalProcess);
            $(dom).val("获取验证码");
            $(dom).removeAttr("disabled");
        }
    }, 1000);
    $.ajaxSec({
		type:"POST",
		url:base+"/system/getCode?random="+Math.random(),
		data:{"bindName":$("#"+id).val(),"type":type},
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
				clearInterval(intervalProcess);
				 $(dom).val("获取验证码");
				 $(dom).removeAttr("disabled");
			}else{
				codeProcess = setInterval(function(){
					removeCode(id);
				},10*60*1000);
				if(type=="email_link"){
					gotoEmail($("#"+id).val());
				}
			}
		}
    });
}
 //移除session
function removeCode(id){
	$.ajaxSec({
		type:"POST",
		url:base+"/system/removeCode?random="+Math.random(),
		data:{"bindName":$("#"+id).val()},
		dataType:"JSON",
		success:function(data){
			clearInterval(codeProcess);
		}
	});
}

//跳转到指定的邮箱登录页面
$(".btn_actemail").click(function () {
    var uurl = $(".hide_email").val();
    uurl = gotoEmail(uurl);
    if (uurl != "") {
        $(".toopen").attr("href", "http://"+uurl);
        $(".toopen")[0].click();
    } else {
        alert("抱歉!未找到对应的邮箱登录地址，请自己登录邮箱查看邮件！");
    }
});

//功能：根据用户输入的Email跳转到相应的电子邮箱首页
function gotoEmail($mail) {
    $t = $mail.split('@')[1];
    $t = $t.toLowerCase();
    var uurl="";
    if ($t == '163.com') {
        uurl= 'mail.163.com';
    } else if ($t == 'vip.163.com') {
        uurl= 'vip.163.com';
    } else if ($t == '126.com') {
        uurl= 'mail.126.com';
    } else if ($t == 'qq.com' || $t == 'vip.qq.com' || $t == 'foxmail.com') {
        uurl= 'mail.qq.com';
    } else if ($t == 'gmail.com') {
        uurl= 'mail.google.com';
    } else if ($t == 'sohu.com') {
        uurl= 'mail.sohu.com';
    } else if ($t == 'tom.com') {
        uurl= 'mail.tom.com';
    } else if ($t == 'vip.sina.com') {
        uurl= 'vip.sina.com';
    } else if ($t == 'sina.com.cn' || $t == 'sina.com') {
        uurl= 'mail.sina.com.cn';
    } else if ($t == 'tom.com') {
        uurl= 'mail.tom.com';
    } else if ($t == 'yahoo.com.cn' || $t == 'yahoo.cn') {
        uurl= 'mail.cn.yahoo.com';
    } else if ($t == 'tom.com') {
        uurl= 'mail.tom.com';
    } else if ($t == 'yeah.net') {
        uurl= 'www.yeah.net';
    } else if ($t == '21cn.com') {
        uurl= 'mail.21cn.com';
    } else if ($t == 'hotmail.com') {
        uurl= 'www.hotmail.com';
    } else if ($t == 'sogou.com') {
        uurl= 'mail.sogou.com';
    } else if ($t == '188.com') {
        uurl= 'www.188.com';
    } else if ($t == '139.com') {
        uurl= 'mail.10086.cn';
    } else if ($t == '189.cn') {
        uurl= 'webmail15.189.cn/webmail';
    } else if ($t == 'wo.com.cn') {
        uurl= 'mail.wo.com.cn/smsmail';
    } else if ($t == '139.com') {
        uurl= 'mail.10086.cn';
    } 

    if (uurl != "") {
        window.open("http://"+uurl);
    } else {
        alert("抱歉!未找到对应的邮箱登录地址，请自己登录邮箱查看邮件！");
    }
};
</script>
</html>