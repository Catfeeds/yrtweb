<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="common/common.jsp" %>
<c:set var="currentPage" value="LOGIN"/>
<title>宇任拓-登录</title>
</head>
<body style="overflow: scroll; overflow-x: hidden; ">
	<%@ include file="common/header.jsp" %>
	<!--登录信息-->
    <div class="alert alert-warning" role="alert" style="display: none;z-index: 10;">
        <strong>错误!</strong> <span id="errorMsg">${errorMsg}</span>
    </div>
	<!--登录框-->
    <div class="login">
        <div class="windows">
            <div class="span">
                <span class="f20 ms ml10">登录</span>
            </div>
            <form id="loginForm" action="${ctx}/doLogin" method="post">
		 	<input type="hidden" id='captcha_flag' name="captcha_flag" value="true"/>
            <dl>
                <dt>
                    <input type="text" name="username" valid="require len(1,40)" value="${username}" data-text="用户名" placeholder="用户名" maxlength="40" id="user" class="username ms f14" />
                </dt>
                <dd>
                    <input type="password" name="password" valid="require len(1,40)" value="" data-text="密码" placeholder="密&emsp;码" maxlength="16" id="user" class="password ms f14" />
                </dd>
                <dd class="ml10 mt10">
                    <input type="text" id='j_captcha' name="j_captcha" valid="" value="" placeholder="输入验证码" maxlength="6" class="captxt ms f14" style="display: none;"/>
                   
                    <img src="${ctx}/jcaptcha.jpg" id="captchaImg" alt="验证码" class="cap" style="display: none;" />
                    <div class="clearit"></div>
                </dd>
                <dd>
                    <input type="button" onclick="$.submitLogin('#loginForm','#loginForm',errorMsg);getCookie();" value="登录" class="pull-left ml10 mt10 ms f18 signbtn" />
                    <div id="w_captcha" style="display: none;"><a onclick="refreshCaptcha()" style="cursor: pointer;" class="ml20 text-white">看不清？换一个</a></div>
                    <br/>
                    <a href="${ctx}/register/registerAccount" class="pull-left  ml70 text-white f12 ms">注册</a>
                    <a href="${ctx}/find/way" target="_blank;" class="pull-left  ml15 text-white f12 ms">忘记密码</a>
                    <div class="clear"></div>
                </dd>
            </dl>
            </form>
        </div>

    </div>
    <%@ include file="common/footer.jsp" %>
    <script type="text/javascript">
	  //登录框自适应
	    jQuery.fn.center = function () {
	        this.css("position", "absolute");
	        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() - 80 + "px");
	        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
	        return this;
	    }
	    $(".footer").css({ "position": "fixed", "bottom": "0" });
	    $(".login").center();
	    $(window).resize(function(){
	    	 $(".login").center();
	    	});
	   
	    $("div[role=alert]").center();
    
    
    	$(document).keydown(function(event){
	    	if(event.keyCode==13){
	    		$.submitLogin('#loginForm','#loginForm',errorMsg);getCookie();
	    	}
    	}); 
    	if($.cookie("j") == null){
	    	$.cookie("j", "1"); 
    	}else{
    		 var j = parseInt($.cookie("j"));  
             if(j > 3){
	    		$("#j_captcha").css("display","block");
	       		$("#captchaImg").css("display","block");
	       		$("#w_captcha").css("display","block");
	       		$("#j_captcha").attr("valid","require");
	       		$("#captcha_flag").val("false");
             }
             
    	}
        
        $(function(){
        	var result = '${errorMsg}';
        	if(result){
        		errorMsg(result);
        	}
        })

        //错误信息调用
		function errorMsg(result){
			if(result){
				//$("#errorMsg").text(result);
				layer.msg(result,{icon: 2});
				/* $("div[role=alert]").center().show();
	        	setTimeout(function(){
	        		$("div[role=alert]").center().hide();
	        	}, 2000); */
			}
		}
        
        function refreshCaptcha(){
        	$('#captchaImg').hide().attr('src','${ctx}/jcaptcha.jpg?' + Math.floor(Math.random() * 100)).fadeIn();
        }
        
        /*获取cookie*/  
        function getCookie(){  
        	
            var j = parseInt($.cookie("j"));  
            if(j > 3){
           		$("#j_captcha").css("display","block");
           		$("#captchaImg").css("display","block");
           		$("#w_captcha").css("display","block");
           		$("#j_captcha").attr("valid","require");
           		$("#captcha_flag").val("false");
            }else{
            	 j = j + 1;
            	 $.cookie("j", j);
            }
        }  
        
    </script>
</body>
</html>