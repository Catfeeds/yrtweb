<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>联赛报名页面</title>
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

 .form-group {
     word-break: break-all;
     display: inline-block;
 }

 .t2 {
     text-indent: 2em;
 }

 .sumit {
     text-align: center;
     padding-bottom: 35px;
 }

 .ml10 {
     margin-left: 10px;
 }
    </style>
</head>
<body>
    <div class="form-group center s ms">
        <label>欢迎访问宇任拓</label>
    </div>
    <div class="container">
        <div class="form-group">
            <p class="t2">
          		  注册成功，你已可登录宇任拓官方网站，球技展示，球友交流，足球宝贝，专业联赛尽在宇任拓。
            </p>
        </div>
    </div>
    <div class="form-group center s ms" style="background: none;">
   		 <a href="http://11uniplay.com" style="font-size: 1.5em;">11uniplay.com</a>
   	</div>
    <div class="sumit" style="margin-top: 30px;">
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" onclick="surePay()">
            继续支付
        </button>
    </div>
</body>
<script type="text/javascript">
//确认付款
function surePay(){
	var url=base+"/account/toBankPay";
	post(url,{type:"2",recharge_money:"5000",sign_way:"2",league_id:"1"});
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
        // alert(opt.name)        
        temp.appendChild(opt);        
    }        
    document.body.appendChild(temp);        
    temp.submit();        
    return temp;        
} 
</script>
</html>