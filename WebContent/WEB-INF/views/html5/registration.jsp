<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common.jsp"%>
<style>
body {
	position: absolute;
	width: 100%;
	height: 100%;
	background: url(${ctx}/resources/images/235078.jpg) center;
	background-attachment: fixed;
	background-repeat: no-repeat;
	background-size: cover;
	-moz-background-size: cover;
	-webkit-background-size: cover;
}

.container {
	padding-top: 33%;
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

.mt10 {
	margin-top: 2em;
}

.mt2 {
	margin-top: 8px;
}

.fff {
	color: #fff;
	float: left;
	margin-left: 5px;
	margin-top: 2px;
}

@
-moz-document url-prefix () {input [type="checkbox"] { margin-left:-48px!important;
	position: absolute;
}
}
</style>
</head>
<body>
	<div class="container">
		<form class="form-horizontal mt10" id="activitySign">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label fff">姓&emsp;&emsp;名</label>
				<div class="col-sm-10">
					<input type="text" id="name" name="name" class="form-control mt2" placeholder="输入你的姓名" valid="require"/>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label fff mt2">手机号码</label>
				<div class="col-sm-10">
					<input type="text" id="phone" name="phone" class="form-control mt2" 	placeholder="输入你的手机号码" valid="require"/>
				</div>
			</div>
			<p style="color:#fff;">我要看：</p>
			<label class="checkbox-inline"> 
				<input type="checkbox"  name="activity_name" value="亚冠" style="width: 18px; height: 18px; float: left" checked="checked"> 
				<span class="fff">亚冠决赛第二回合：广州恒大VS迪拜阿赫利</span>
			</label> 
			<label class="checkbox-inline" style="margin-left: 0;"> 
			    <input type="checkbox" name="activity_name" value="西甲" style="width: 18px; height: 18px; float: left"> 
			    <span class="fff">西班牙国家德比：皇家马德里VS巴塞罗那</span>
			</label>
			<div class="form-group mt10">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="btn btn-primary btn-lg btn-block" onclick="submitInfo()">报&emsp;&emsp;名</button>
				</div>
			</div>
		</form>
	</div>
</body>
<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript">
function submitInfo(){
	    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	    var name = $("#name").val();
		var phone = $("#phone").val();
		
		if(name==null || name==""){
			alert("请输入您的真实姓名！");
			return;
		}
        if (!new RegExp('^[1][3|5|7|8][0-9]{9}$').test(phone)) {
            alert('请输入正确的手机格式！');
            return;
        }
        
		$.ajax({
			type:"POST",
			url:base+"/html5/registration_save?random="+Math.random(),
			data:$("#activitySign").serialize(),
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
					alert("信息提交成功,报名结果将以短信形式通知！");
					window.location.href=base+"/html5/registration";
				}else{
					alert(data.message.error);
					return;
				}
			},
		});
}
</script>
</html>
