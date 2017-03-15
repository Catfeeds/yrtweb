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
                		<div style="width: 154px;height: 100%;color: #FFF;line-height: 56px;margin-left: 40px;" class="f24">
                		<c:choose>
                			<c:when test="${flag eq true }">
                			通过邮箱找回
                			</c:when>
                			<c:otherwise>
                			通过手机找回
                			</c:otherwise>
                		</c:choose>
                		</div>
                	</div>
                	<div class="pwdTop">
                		<h3>
                			<span>1.验证身份>></span>
                			<span  style="color: red;">2.重置密码>></span>
                			<span>3.成功</span>
                		</h3>
			<!--重置密码-->
			 <form id="repwdForm">
			 <input type="hidden" name="name" value="${name}"/>
    		 <div class="confirmPwd" style="width: 266px;margin: 0 auto;margin-top: 106px;" id="resetPwd">
    			<dl>
    					<dt>
                            <span class="f14 text-white">新密码：</span>
                            <input type="password" id="newPwd" name="newPwd" value="" class="phoneNumber ml10" maxlength="31" valid="require"/>
                            
                        </dt>
                        <dd class="mt15 ml">
                            <span class="f14 text-white">确认新密码：</span>
                            <input type="password" id="rePwd" name="rePwd" value="" class="phoneNumber ml10" maxlength="31" valid="require"/>
                        </dd>
                        <dd class="mt20">
                            <input type="button" name="name" value="保存" class="ValidateCode ml70" id="next" style="width: 114px;" onclick="repwd()"/>
                        </dd>
    			</dl>
    		</div>
    		</form>
	      </div>
	      
	    
       </div>
	</div>
</div>	
<%@include file="../common/footer.jsp" %>	
<script type="text/javascript">
	//重置密码
	function repwd(){
		$.ajax({
			context:$("#repwdForm"),
			type:"POST",
			url:base+"/find/updatePwd?random="+Math.random(),
			data:$("#repwdForm").serialize(),
			dataType:"JSON",
			beforeSend:function(){
				if($("#rePwd").val()!=$("#newPwd").val()){
					layer.msg("两次输入的密码不一致！",{icon: 0});
					return false;
				}
				return true;
			},
			success:function(data){
				if(data.state=="error"){
					layer.msg(data.message.error[0],{icon: 2});
				}else{
					window.location = base+"/find/result?status=success";
				}
			}
		});
	}
</script>
</body>
</html>