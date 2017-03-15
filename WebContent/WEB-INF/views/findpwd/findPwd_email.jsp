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
                			<!--邮箱找回-->
		                		<div class="validate" style="width: 356px;margin: 0 auto;margin-top: 106px;display: block;" id="mail">
		                			<dl>
		                					<dt style="width:500px;">
		                                        <span class="f14 text-white">邮箱号：</span>
		                                        <input type="text" name="email" id="email" value="" class="phoneNumber ml10" maxlength="31" placeholder="请输入注册邮箱"/>
		                                        <input type="button" value="获取验证码" class="ValidateCode ml10" id="getCap" onclick="getCodeNum(this)"/>
		                                    </dt>
		                                    <dd class="mt15">
		                                        <span class="f14 text-white">验证码：</span>
		                                        <input type="text" id="codeNum" name="codeNum" value="" class="phoneNumber ml10" maxlength="11"/>
		                                    </dd>
		                                    <dd class="mt20">
		                                        <input type="button" name="name" value="下一步" onclick="goNext()" class="ValidateCode ml70" id="next" style="width: 114px;" onclick="nextBtn()"/>
		                                    </dd>
		                			</dl>
		                		</div>
                	</div>
                </div>
            </div>
		</div>
	</div>
<%@include file="../common/footer.jsp" %>
<script type="text/javascript">

function intervalProcess(){
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
}
//验证码
function getCodeNum(dom) {
    $.ajax({
        /* context:$("#validate"), */
		type:"POST",
		url:base+"/find/getCode?random="+Math.random(),
		data:{"bindName":$("#email").val()},
		dataType:"JSON",
		beforeSend:function(data){
			if($("#email").val()==null || $("#email").val()==""){
				layer.msg("请输入邮箱号",{icon: 0});
				return false;
			}
			return true;
		},
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
				clearInterval(intervalProcess);
                $("#getCap").val("获取验证码");
                $("#getCap").removeAttr("disabled");
			}else{
				$(dom).attr("disabled", "disabled");
				intervalProcess();
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
		url:base+"/find/removeCode?random="+Math.random(),
		data:{"bindName":$("#email").val()},
		dataType:"JSON",
		success:function(data){
			clearInterval(codeProcess);
		}
	});
}

function goNext(){
	$.ajax({
		type:"POST",
		url:base+"/find/valid?random="+Math.random(),
		data:{"name":$("#email").val(),"codeNum":$("#codeNum").val()},
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				JsPost(base+"/find/rePwd",{"name":$("#email").val()});
			}
		}
	});
}

//采用虚拟表单模拟post,提交
function JsPost(URL, PARAMS) {        
    var temp = document.createElement("form");        
    temp.action = URL;        
    temp.method = "post";        
    temp.style.display = "none";        
    for (var x in PARAMS) {        
        var opt = document.createElement("textarea");        
        opt.name = x;        
        opt.value = PARAMS[x];        
        temp.appendChild(opt);        
    }        
    document.body.appendChild(temp);        
    temp.submit();        
    return temp;        
} 
</script>
</body>
</html>