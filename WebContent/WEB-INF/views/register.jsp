<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<%@ include file="common/common.jsp" %>
	<c:set var="currentPage" value="REGISTER"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>注册页</title>
    <meta charset="utf-8" />
</head>
<body style="overflow: scroll; overflow-x: hidden; ">
    <div class="warp">
		<%@ include file="common/header.jsp" %>
    </div>
    <!--登录信息-->
    <div class="alert alert-warning" role="alert" style="display: none;z-index: 7;">
        <strong>错误!</strong><span id="msg">请输入6-16位密码，不含空格!</span>
    </div>
    <!--登录框-->
    <div class="reg">

        <div class="windows">
       		<form id="registerForm" action="${ctx}/register/saveAccount" method="post">
                <div class="span">
                    <span class="f20 ms ml10">注册</span>
                </div>
                <dl>
                    <dd class="fix">
                        <input type="text" name="username" value="" placeholder="手机号或邮箱" maxlength="40" id="username" class="username ms f14" />
                    </dd>
                    <dd class="fix">
                        <input type="password" name="password" value="" placeholder="密码" maxlength="16" id="password" class="password ms f14" />
                    </dd>
                    <dd class="fix">
                        <input type="password" name="password_t" value="" placeholder="确认密码" maxlength="16" id="password_t" class="password ms f14" />
                    </dd>
                    <dd class=" mt10">
                        <input type="text" name="volidCode" value="" placeholder="输入验证码" maxlength="6" class="captxt ms f14"  id="volidCode"/>
                        <input type="button" name="getCap" value="获取验证码" class="regbtn ml10 ms" id="getCap"  />
                        <div class="clearit"></div>
                    </dd>
                    <dd class="mt10">
                        <a href="javascript:void(window.location='${ctx}/login')" class="pull-left text-white ms" id="">已有帐号？现在登录</a>
                        <a href="${ctx}/register/agreen" target="_blank" class="pull-right text-white ms"><input type="checkbox" checked="checked" name="agreement" id="agreement" value="" />阅读并接受《注册协议》</a>
                        <div class="clear" style="height: 10px;"></div>
                        <input type="button" name="register_btn" value="注册" class="ms f18 regbtn" id="register_btn"/>
                        <input type="button" name="reset" value="重置" class="ms  ml15 f18 regbtn" id="reset"/>
                    </dd>
                </dl>
            </form>
            
        </div>

    </div>
    <!--页脚-->
    <%@ include file="common/footer.jsp" %>
    <script type="text/javascript">
        //登录框自适应
        jQuery.fn.center = function () {
            this.css("position", "absolute");
            this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() - 65 + "px");
            this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
            return this;
        }

        //$(".login").center();
        //if ($(document).width() < 1400) {
        //    $(".login").center();
        //    $("div[role=alert]").center();
        //} else {
        $(".reg").center();
        $(window).resize(function(){
        	 $(".reg").center();
        	});
        $("div[role=alert]").center();
        //}
        
        var username_flag = false;
        //手机号或者邮箱
        $('#username').blur(function () {
        	var phone_email = $(this).val().trim();
        	checkUsername(phone_email);
       });
        
        function checkUsername(phone_email){
        	if(phone_email.indexOf("@") == -1){
        		var reg = /^1[3|4|5|7|8]\d{9}$/;
	        	if(phone_email && reg.test(phone_email)){
	        		username_flag = true;
	        	}else{
	        		layer.msg("请输入正确手机号",{icon: 2});
	        		//$("div[role=alert]").center().show();
	               // $("div[role=alert]").animate({opacity:"hide"}, 3000);
	                username_flag = false;
	                $("#username").css("border","1px solid #990033");
	        	}
        	}else{
        		var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
        		if(phone_email && reg.test(phone_email)){       	
        			username_flag = true;
        		}else{
        			layer.msg("请输入正确的邮箱",{icon: 2});
                	//$("div[role=alert]").center().show();
                	//$("div[role=alert]").animate({opacity:"hide"}, 3000);
                	username_flag = false;
                	$("#username").css("border","1px solid #990033");
        		}
	       	}
        	if(!username_flag) return;
        	$.ajax({
				type: 'POST',
				url: base+'/register/checkUsername',
				data:{username:phone_email},
				dataType:'json',
				async: false,
				success: function(result){
					if(result.state=="error"){
	        			$("#username").css("border","1px solid #990033");
	        			layer.msg("该用户名已注册",{icon: 2});
	        			username_flag = false;
	        		}else{
	        			$("#username").css("border","1px solid #ccc");
	        			username_flag = true;
	        		}
				},
				error: $.ajaxError
			});
        	return username_flag;
        }
        
        //密码输入
    	var pass = false;
        $('#password').blur(function () {
        	var pwd = $(this).val();
        	var pwd_t = $("#password_t").val();
            if(pwd.length==0 || pwd.length<6 || pwd.length>16 || pwd.indexOf(" ")!=-1){
            	layer.msg("请输入6-16位密码，不含空格!",{icon: 2});
            	//$("div[role=alert]").center().show(); //请输入6-16位密码，不含空格!
            	//$("div[role=alert]").animate({opacity:"hide"}, 3000);
            	pass = false;
            }else{
            	pass = true;
            }
            
       }); 
        
        //密码确认
        var pass_t = false;
        $('#password_t').blur(function () {
        	var pwd = $("#password").val();
        	var pwd_t = $(this).val();
            if(pwd == pwd_t){
            	pass_t = true;
            }else{
            	layer.msg("两次输入的密码不一致!",{icon: 2});
            	//$("div[role=alert]").center().show();// 两次输入的密码不一致
            	//$("div[role=alert]").animate({opacity:"hide"}, 3000);
            	pass_t = false;
            }
        });
        
        //重置表单
        $("#reset").click(function() {
            $("form input[type=text]").val("");
            $("form input[type=password]").val("");
        });
		
      	//用户注册提交 
        $("#register_btn").click(function() {
        	if($("#volidCode").val() == ""){
        		layer.msg("请输入验证码信息!",{icon: 2});
        		return ;
        	}
        	if(!$("#agreement").is(':checked')){
        		layer.msg("请确认注册协议!",{icon: 2});
        		return ;
        	}
        	if(username_flag == false) {
        		layer.msg("请确认注册用户手机号或者邮箱是否正确!",{icon: 2});
        		return ;
        	}
			if(pass == false) {
				layer.msg("请确认密码是否正确!",{icon: 2});
        		return ;
        	}
			if(pass_t == false) {
				layer.msg("请确认两次密码输入是否正确!",{icon: 2});
        		return ;
        	}
        	$.ajax({
        		type: 'POST',
        		url: "${ctx}/register/saveAccount",
        		data: $("#registerForm").serializeObject(),
        		cache: false,
        		success: function(result){
        			if(result.state=='error'){
        				layer.msg(result.message.error[0],{icon: 2});
        			}else{
        				layer.msg("注册成功",{icon: 1});
        				//window.history.go(-1);
    					var href = document.referrer;
    					if(href.indexOf('/register')>0||href.indexOf('/login')>0){
    						window.location.href = "/";
    					}else{
    						window.location.href = document.referrer;
    					}
        			}
        		},
        		error: $.ajaxError
        	});
        });
        
      //验证码
        $("#getCap").click(function () {
            if ($("#username").val().length ==0) {
                return false;
                layer.msg("请输入手机或邮箱!",{icon: 2});
            } else {
                    var str = $("#username").val();
            	if(str.indexOf("@")<=0){
	            	if($.cookie(str) == null){
		            	$.cookie(str, 1);
	            	}else{
		            	if(parseInt($.cookie(str)) >= 3){
		            		layer.msg("每个手机号最多发送3个验证码!",{icon: 2});
		                	return false;
		            	}else{
		            		var j = parseInt($.cookie(str));	
			               	j = j + 1;
			                $.cookie(str, j);
		            	}    
	            	}
            	}
                    if(!username_flag) return;
                    var t = 60;
                    var intervalProcess;
                    intervalProcess = setInterval(function () {
                        $("#getCap").val((--t) + "秒后重新获取");
                        $("#getCap").attr("disabled", "disabled");
                        if (t == 0) {
                            clearInterval(intervalProcess);
                            $("#getCap").val("获取验证码");
                            $("#getCap").removeAttr("disabled");
                        }
                    }, 1000);
                    //发送ajax验证
                    $.ajax({
                        type: 'POST',
                        url: "${ctx}/system/sendSecurityCode",
                        data: { username: str },
                        cache: false,
                        success: function (result) {
                            if (result.state == 'success') {
                                layer.msg("发送成功",{icon: 1});
                            }
                        },
                        error: $.ajaxError
                    });
                }
           
        });
        $(".footer").css({ "position": "absolute", "bottom": "0" });
    </script>
</body>
</html>