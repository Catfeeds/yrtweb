<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报名结果页面</title>
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
        <label>支付成功</label>
    </div>
    <div class="container">
        <div class="form-group">
        	<c:choose>
        		<c:when test="${flag eq true }">
		            <p class="t2">您的报名费用已经支付成功。请您尽快前往宇任拓官方网站
		            			（<a href="http://www.11uniplay.com">www.11uniplay.com</a>）,选择“联赛”并点击“报名”,进入相关页面，完成后续操作。如2015-12-12前未完成将视为弃权，报名费不予退还。
		            </p>
        		</c:when>
        		<c:otherwise>
        		  <p class="t2">您的报名费用支付失败！</p>
        		</c:otherwise>
        	</c:choose>
        </div>
       <!--  <div class="sumit">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
               	 完成
            </button>
        </div> -->
    </div>
</body>
</html>