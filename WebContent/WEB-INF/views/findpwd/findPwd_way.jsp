<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择找回密码方式</title>
 <link href="${ctx}/resources/css/findPwd.css" rel="stylesheet" />
</head>
<body>
<div class="warp">
<!--头部-->
    	<%@ include file="../common/header.jsp" %>    
</div>
<div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container ms">
                
                <div class="findPwd">
                	<div class="title">
                		<div style="width: 154px;height: 100%;color: #FFF;line-height: 56px;margin-left: 40px;" class="f24">密码找回</div>
                	</div>
                	<div class="findWays">
                		
                		<div class="twoWays" >
                			<div style="width: 468px;margin: 0 auto;display: block;" id="ways">
	                			<div class="mobile" onclick="window.open('${ctx}/find/isway/phone')">
	                				<p>
	                					<span>
	                						<img src="${ctx}/resources/images/pwdMobile.png" />
	                					</span>
	                				</p>
	                				<p style="text-align: center;" onclick="findWays()"><span>通过手机号码找回</span></p>
	                			</div>
	                			<div class="mail" onclick="window.open('${ctx}/find/isway/email')">
	                				<p>
	                					<span>
	                						<img src="${ctx}/resources/images/pwdMail.png" />
	                					</span>
	                				</p>
	                				<p style="text-align: center;margin-top: 102px;" onclick="findWays1()"><span>通过电子邮箱找回</span></p>
	                			</div>
	                		</div>	
                	</div>
                </div>
            </div>
		</div>
	</div>
<%@include file="../common/footer.jsp" %>
</body>
</html>