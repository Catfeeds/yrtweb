<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报名结果</title>
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
        .t2 span{
        text-indent: 0em;
           display: inline-block;
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
        <label>预报名成功！</label>
    </div>
    <div class="container">
        <div class="form-group">
            <p class="t2" style="line-height: 25px;" >
          		账户为您填写的手机号，密码将会以短信形式发送到您的注册手机。
            </p>
             <p class="t2">
            	<font style="color: red;">特别提示：</font>要想被成为正式参赛球员，并被俱乐部主席选中，成为万众瞩目的球星，还请从电脑端访问<span>http://www.11uniplay.com</span> ，登录账户，点击“联赛”选择“完善资料”哦！</p>
        </div>
       <!--  <div class="sumit">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
               	 完成
            </button>
        </div> -->
    </div>
</body>
</html>