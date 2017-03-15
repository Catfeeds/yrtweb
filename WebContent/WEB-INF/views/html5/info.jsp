<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${adminSignCfg.title}</title>
<style>
 .container {
     padding-top: 5%;
 }

 .center {
     text-align: center;
 }

 .s {
     width: 100%;
     height: 55px;
     line-height: 55px;
     background: #00bfff;
     color: #fff;
     font-size: 18px;
 }

 .ms {
     font-family: "Microsoft YaHei";
    } 
</style>
</head>
<body>
<div class="form-group center s ms">
        <label>${adminSignCfg.title}</label>
    </div>
    <div class="container">
        <form class="form-horizontal">
        	<input type="hidden" name="sign_id" id="sign_id" value="${adminSignCfg.id}"/>
        	<input type="hidden" name="s_id" id="s_id" value="${adminSignCfg.s_id}"/>
        	<p style="color: red;text-indent: 2em;padding-bottom: .5em;">填写简单个人信息。</p>
            <div class="form-group">
                <label for="name" class="col-sm-2 control-label">姓名</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="name" placeholder="输入您的真实姓名">
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2 control-label">手机号码</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="phone" placeholder="输入您的手机号码">
                </div>
            </div>
            
           	<div class="form-group" <c:if test="${empty adminSignCfg.s_id}">style="display:none;"</c:if>>
                <label for="idcard" class="col-sm-2 control-label">身份证号</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="idcard" placeholder="输入您的身份证号">
                </div>
            </div>
            
           <!--  <div class="form-group">
                <div class="col-sm-12">
                    <p>
                    	<font style="color:red;">注：</font><font style="color:gray;">暂不支持微信扫码，请使用QQ，支付宝等工具扫码报名！</font>
                    </p>
                </div>
            </div> -->
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <!-- <button type="button" class="btn btn-primary btn-lg btn-block" onclick="validateForm()">下一步</button> -->
                    <input type="button" class="btn btn-primary btn-lg btn-block" onclick="validateForm()" value="下一步" style="margin-top: .3em;"/>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript">					
	function validateForm(){
	    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	    var name = $("#name").val();
		var idcard = $("#idcard").val();
		var mobile = $("#phone").val();
		var sign_id = $("#sign_id").val(); 
		var s_id = $("#s_id").val();
		
		if(name==null || name.trim()==""){
			alert("请输入您的真实姓名！");
			return false;
		}
        if (!new RegExp('^[1][3|5|7|8][0-9]{9}$').test(mobile)) {
            alert('请输入正确的手机格式！');
            return false;
        }
        
        if(s_id != ""){
	        if (reg.test(idcard) === false) {
	            alert("请输入正确的身份证号码！");
	            return false;
	        }
        }
        signName(); 
	}
	
	function signName(){
		var json_data = {
			 name : $("#name").val(),
			 mobile : $("#phone").val(),
			 sign_id : $("#sign_id").val(),
			 idcard : $("#idcard").val() 	
		};
	   
    	$.ajax({
    		type:"POST",
    		url:base+"/html5/saveSignInfo",
    		data: json_data,
    		dataType:"JSON",
    		success:function(data){
    			if(data.state=="success"){
					window.location=base+"/html5/result?flag="+data.data.flag;    				
    			}else{
    				alert(data.message.error[0]);
    			}
    		}
    		
    	});
    }

</script>
</html>