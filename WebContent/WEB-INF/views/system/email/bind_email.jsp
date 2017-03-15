<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>绑定邮箱</title>
<c:set var="currentPage" value="BINDEMAIL"/>
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
                              	  <span class="text-white f16">邮箱绑定</span>
                          		</div>
                          		<!-- content start-->
                          		<div class="phone_bd">
							        <div class="windows_bd">
							            <div class="span">
							                <span class="f20 ms ml10 text-white">邮箱绑定</span>
							            </div>
							            <form id="formdata">
								            <dl>
								                <dt>
								                    <input type="text" name="email" value="" placeholder="请输入邮箱号码" maxlength="38" id="email" class="phone_num ms f14" />
								                    <input type="button" value="获取验证码" class="funbtn ms ml5" id="getCap" onclick="getCodeNum(this)" />
								                </dt>
								                <dd>
								                    <input type="text" name="code" value="" placeholder="验证码" maxlength="18" id="code" class="phone_cap ms f14" />
								                    <input type="button" value="绑定" class="funbtn mt20 ms ml5" onclick="bind()"/>
								                </dd>
								            </dl>
							            </form>
							        </div>
							    </div>
							    <!-- content end -->
	                  		 </div>
                       	</div>	 
	                </div>
	            </div>    
		 </div>
	</div>
	<!-- footer start -->
	<%@include file="../../common/footer.jsp" %>
	<!-- footer end -->
</body>
<script type="text/javascript">
    //added by bo.xie 绑定邮箱    
	function bind(){
		$.ajax({
			type:"POST",
			url:base+"/system/bindEmail?random="+Math.random(),
			data:$("#formdata").serialize(),
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
						layer.msg("绑定成功！",{icon: 1});
				}else{
						layer.msg(data.message.error[0],{icon: 2});
				}
			}
		});
	}

	 //验证码
    function getCodeNum(dom) {
		 if(new RegExp('^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z]+$').test($("#email").val())==false){
			 layer.msg("请输入正确的邮箱地址",{icon: 2});
			 return false;
		 }
		 
        $(dom).attr("disabled", "disabled");
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
        $.ajax({
			type:"POST",
			url:base+"/system/getCode?random="+Math.random(),
			data:{"bindName":$("#email").val()},
			dataType:"JSON",
			success:function(data){
				if(data.state=="error"){
					layer.msg(data.message.error[0],{icon: 2});
					clearInterval(intervalProcess);
	                $("#getCap").val("获取验证码");
	                $("#getCap").removeAttr("disabled");
				}else{
					codeProcess = setInterval(function(){
						removeCode();
					},10*60*1000);
					
				}
			}
        });
    }

	 
	 //移除session
    function removeCode(){
		$.ajax({
			type:"POST",
			url:base+"/system/removeCode?random="+Math.random(),
			data:{"bindName":$("#email").val()},
			dataType:"JSON",
			success:function(data){
				clearInterval(codeProcess);
			}
		});
    }

    
</script>
</html>