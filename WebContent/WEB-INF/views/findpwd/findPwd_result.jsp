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
            <div class="container ms">
                
                <div class="findPwd">
                	<div class="title">
                		<div style="width: 154px;height: 100%;color: #FFF;line-height: 56px;margin-left: 40px;" class="f24">通过手机找回</div>
                	</div>
                	<div class="pwdTop">
                		<h3>
                			<span>1.验证身份>></span>
                			<span>2.重置密码>></span>
                			<c:choose>
                				<c:when test="${status eq 'error' }">
			                		<span style="color: red;">3.失败</span>
                				</c:when>
                				<c:otherwise>
                					<span style="color: red;">3.成功</span>
                				</c:otherwise>
                			</c:choose>
                		</h3>
	     		 <!--找回密码成功-->
	     		 <c:choose>
            		<c:when test="${status eq 'success' }">
            			<div class="pwd_success" id="pwd_success" onclick="backBtn()">
		     				<p style="margin-top: 0px;">
		     					<img src="${ctx}/resources/images/doit (2).png" />
		     				</p>
		     				<p style="margin-top: 0px;color: white;font-size: 14px;margin-top: 15px;margin-left: 26px;">修改成功</p>
		     				<input type="button" class="ValidateCode mt30" style="width: 114px;" value="首页" onclick="javascript:window.location='${ctx}/'"/>
		     			</div>
            		</c:when>
	                <c:otherwise>
	                
	                </c:otherwise>
                </c:choose>				
	      </div>
       </div>
	</div>
</div>	
<%@include file="../common/footer.jsp" %>	
</body>
</html>