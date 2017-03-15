<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<c:set var="currentPage" value="MODIFYBINDPHONE"/>
<title>修改绑定手机</title>
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
                              	  <span class="text-white f16">修改手机绑定</span>
                          		</div>
                          		<!-- content start-->
                          		<form>
                          			<input type="hidden" name="id" value="${user.id}"/>
                          			<input type="hidden" id="oldphone" value="${user.phone}"/>
                          		</form>
                          		<div class="old">
                                <dl id="step_1">
                                    <dt>
                                        <span class="f14">旧手机</span>&nbsp;&nbsp;&nbsp;${user.phone}
                                        <input type="button" name="name" value="获取验证码" class="oldbtn ml10" onclick="getCodeNum(this,'oldphone','modify')"/>
                                    </dt>
                                    <dd class="mt15">
                                        <span class="f14">验证码</span>
                                        <input type="text" name="code" id="code" value="" class="phone_txt ml10" maxlength="11" />
                                    </dd>
                                    <dd class="mt30">
                                        <input type="button" value="下一步" class="oldbtn ml55" id="next" />
                                    </dd>
                                </dl>
                                <dl id="step_2">
                                    <dt>
                                        <span class="f14">新手机</span>
                                        <input type="text" name="name" id="new_phone" value="" class="phone_txt ml10" maxlength="11" />
                                        <input type="button" value="获取验证码" class="oldbtn ml10" onclick="getCodeNum(this,'new_phone')"/>
                                    </dt>
                                    <dd class="mt15">
                                        <span class="f14">验证码</span>
                                        <input type="text" name="code" id="code2" value="" class="phone_txt ml10" maxlength="11" />
                                    </dd>
                                    <dd class="mt30">
                                        <input type="button" name="name" value="上一步" class="oldbtn ml55" id="prv" />
                                        <input type="button" name="name" value="保存" class="oldbtn ml15" id="save" onclick="modifyPhone()"/>
                                    </dd>
                                </dl>
                            </div>
                          		<!-- content end-->
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

$("#next").click(function() {
	var code = $("#code").val();
	var name = $("#oldphone").val();
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
	var name = $("#new_phone").val();
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
				
			}
		}
    });
}
 //移除session
function removeCode(id){
	$.ajax({
		type:"POST",
		url:base+"/system/removeCode?random="+Math.random(),
		data:{"bindName":$("#"+id).val()},
		dataType:"JSON",
		success:function(data){
			clearInterval(codeProcess);
		}
	});
}
</script>
</html>