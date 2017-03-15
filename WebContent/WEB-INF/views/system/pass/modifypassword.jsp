<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<c:set var="currentPage" value="MODIFYPASSWORD"/>
<title>修改密码</title>
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
	                <%@include file="../left.jsp" %>	
	                <div class="content ms">
                        <div class="content_top">
                            <div class="title ms">
                              	<span class="text-white f16">密码修改</span>
                            </div>
                            <form id="passForm" action="${ctx}/system/updatePassword" method="post">
	                            <div class="modify">
	                                <dl>
	                                    <dt>
	                                        <span class="f14 text-white">&emsp;旧密码</span>
	                                        <input type="password" name="oldpwd" id="oldpwd"  value="" class="phone_txt ml10" maxlength="16" />
	
	                                    </dt>
	                                    <dd class="mt15">
	                                        <span class="f14 text-white">&emsp;新密码</span>
	                                        <input type="password" name="newpwd" id="newpwd" value="" class="phone_txt ml10" maxlength="16" />
	                                    </dd>
	                                    <dd class="mt15">
	                                        <span class="f14 text-white">确认密码</span>
	                                        <input type="password" name="newpwd_t" id="newpwd_t" value="" class="phone_txt ml10" maxlength="16" />
	                                    </dd>
	                                    <dd class="mt30">
	                                        <input type="button" name="update_btn" value="更新" class="oldbtn ml55" id="update_btn" />
	                                        <input type="button" name="reset" value="重置" class="oldbtn ml15" id="reset" />
	                                    </dd>
	                                </dl>
	                            </div>
	                    	</form>        
                        </div>
                    </div>
                    <div class="clearit"></div>
	                </div>
	            </div>    
		 </div>
	</div>	
	<!-- footer start -->
	<%@include file="../../common/footer.jsp" %>
	<!-- footer end -->
</body>
<script type="text/javascript">
	//重置表单
	$("#reset").click(function() {
	    $("form input[type=password]").val("");
	});
	
	//旧密码输入
	var oldpwd = false;
    $("#oldpwd").blur(function () {
    	var pwd = $(this).val();
    	if(pwd != ""){
	        if(pwd.length==0 || pwd.length<6 || pwd.length>16 || pwd.indexOf(" ")!=-1){
	        	layer.msg("请输入6-16位密码，不含空格!",{icon:2});
	        	oldpwd = false;
	        }else{
	        	oldpwd = true;
	        }
    	}
   }); 
	
    //密码输入
    var newpwd = false;
    $("#newpwd").blur(function () {
    	var pwd = $(this).val();
    	var oldpwd = $("#oldpwd").val();
    	if(pwd != ""){
	    	if(pwd == oldpwd){
	    		layer.msg("新密码不能和旧密码一样!",{icon:2});	    
	    		newpwd = false;
	    		return;
	    	}
	        if(pwd.length==0 || pwd.length<6 || pwd.length>16 || pwd.indexOf(" ")!=-1){
	        	layer.msg("请输入6-16位密码，不含空格!",{icon:2});
	        	newpwd = false;
	        }else{
	        	newpwd = true;
	        }
    	}
   }); 
    
  //密码确认
	var newpwd_t = false;  
    $('#newpwd_t').blur(function () {
    	var pwd_t = $(this).val();
    	var pwd = $("#newpwd").val();
    	if(pwd_t != ""){
	    	if(pwd == "") {
	    		newpwd_t = false;
	        	layer.msg("请先输入新密码!",{icon:2});
	        	return;
	    	}
	        if(pwd == pwd_t){
	        	newpwd_t = true;
	        }else{
	        	layer.msg("请确认两次密码输入是否一致!",{icon:2});
	        	newpwd_t = false;
	        }
    	}
    });
    
	//提交按钮
        $("#update_btn").click(function() {
        	$.ajax({
        		type: 'POST',
        		url: "${ctx}/system/updatePassword",
        		data: $("#passForm").serializeObject(),
        		cache: false,
        		beforeSend:function(){
        			if($("#oldpwd").val()==""){
        				layer.msg("旧密码不能为空!",{icon:2});
        				return false;
        			}
        			if($("#newpwd").val()==""){
        				layer.msg("新密码不能为空!",{icon:2});
        				return false;
        			}
        			if($("#newpwd_t").val()==""){
        				layer.msg("确认密码不能为空!",{icon:2});
        				return false;
        			}
        			return true;
        		},
        		success: function(result){
        			if(result.state=='error'){
        				layer.msg(result.message.error[0],{icon:2});
        			}else{
        				layer.msg("修改成功!",{icon:1});
        			}
        		},
        		error: $.ajaxError
        	});
        });
    
</script>
</html>