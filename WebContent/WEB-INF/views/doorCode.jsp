<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宇任拓-门令</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>
<link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
</head>
<style>
      .login {
            width: 520px;
            text-align: center;
        }

        .info {
            color: #fff;
            font-size: 16px;
        }

        .input_window {
            position: relative;
        }

        .input_warp {
            position: absolute;
            width: 320px;
            height: 38px;
            background: #fff;
            margin-left: 115px;
            margin-top: 25px;
        }

        .input {
            position: absolute;
            background: #006400;
            width: 263px;
            height: 26px;
            left: 0;
            border-radius: 0;
        }
        .login_btn {
            position: absolute;
            right: 0;
            width: 42px;
            height: 38px;
            border: none;
            background: url(${ctx}/resources/images/loginp.png) no-repeat;
        }
    </style>
<body>
	<div class="login">
		<c:if test="${!empty error }">
	        <span class="info ms">${error}</span>
		</c:if>
        <div class="input_window">
            <div class="input_warp">
	             <form id="loginForm" action="${ctx}/doorCode" method="post">
	                <input type="password" name="doorCode" value="" class="input" placeholder="请输入门令卡号"/>
	                <input type="submit" name="name" value="" class="login_btn" />
	             </form>   
            </div>
        </div>
    </div>
    <script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script>
    <script src="${ctx}/resources/js/jquery.ez-bg-resize.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("body").ezBgResize({
                img: base+"/resources/images/dl_bg.jpg",
                opacity: 1,
                center: true
            });

            jQuery.fn.center = function () {
                this.css("position", "absolute");
                this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
                this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
                return this;
            }
            $(".login").center();

            $(window).resize(function () {
                $(".login").center();
            });
        });
    </script>
</body>
</html>