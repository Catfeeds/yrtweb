<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>平台统计数据</title>
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
        <label>平台统计数据</label>
    </div>
    <div class="container">
        <form class="form-horizontal">
            <div class="form-group">
                <label for="pwd" class="col-sm-2 control-label">登录密码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="pwd" placeholder="输入登录密码">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="button" class="btn btn-primary btn-lg btn-block" onclick="validateForm()" value="登录"/>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript">
	function validateForm(){
		var pwd = $("#pwd").val(); 
		$.ajax({
			type:"POST",
			url:base+"/html5/valid?random="+Math.random(),
			data:{"pwd":pwd},
			dataType:"JSON",
			beforeSend:function(){
		        if (pwd==null || pwd=="") {
		            alert('请输入登录密码！');
		            return false;
		        }
			},
			success:function(data){
				if(data.state=="success"){
					var url=base+"/html5/searchData"
					post(url);
				}else{
					alert(data.message.error[0]);
				}
			}
		});
	}
  function post(URL, PARAMS) {        
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
</html>