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
        <label>平台统计数据</label>
    </div>
	<table class="table table-striped">
	  	<tr class="info">
	  		<th>注册总人数</th>
	  		<th>今注册人数</th>
	  		<th>充值总金额</th>
	  		<th>今充值金额</th>
	  	</tr>
	  	<tr>	
	  		<th style="text-align: center;">${map.sumUser}</th>
	  		<th style="text-align: center;">${map.toDayUser}</th>
	  		<th style="text-align: center;">
	  		<c:choose>
  				<c:when test="${!empty map.sumAmount}">
  					${map.sumAmount}
  				</c:when>
  				<c:otherwise>
  					0
  				</c:otherwise>
  			</c:choose>	
	  		</th>
	  		<th style="text-align: center;font-weight: 2px;">
	  			<c:choose>
	  				<c:when test="${!empty map.toDayAmount}">
	  					${map.toDayAmount}
	  				</c:when>
	  				<c:otherwise>
	  					0
	  				</c:otherwise>
	  			</c:choose>	
	  		</th>
	  	</tr>
	</table>
	<div style="border-top: 1px dashed #999;padding-bottom: 2em;"></div>
	<table class="table table-striped">
		<tr class="info">
	  		<th style="text-align: center;">报名总人数</th>
	  		<th style="text-align: center;">今报名人数</th>
	  	</tr>
  		<tr>	
  		<th style="text-align: center;">
  		  <c:choose>
 			<c:when test="${!empty map.signCount}">
  			${map.signCount}
  			</c:when>
  			<c:otherwise>
  				0
  			</c:otherwise>
 		  </c:choose>
  		</th>
  		<th style="text-align: center;">
  			  <c:choose>
	 			<c:when test="${!empty map.todaySignCount}">
	  			${map.todaySignCount}
	  			</c:when>
	  			<c:otherwise>
	  				0
	  			</c:otherwise>
	 		  </c:choose>
  		</th>
  		</tr>
	</table>
	<div style="border-top: 1px dashed #999;padding-bottom: 2em;"></div>
	<table class="table table-striped">
		<tr class="info">
	  		<th style="text-align: center;">完善报名资料总人数</th>
	  		<th style="text-align: center;">今完善报名资料人数</th>
	  	</tr>
  		<tr>	
  		<th style="text-align: center;">
  		  <c:choose>
 			<c:when test="${!empty map.inCount}">
  			${map.inCount}
  			</c:when>
  			<c:otherwise>
  				0
  			</c:otherwise>
 		  </c:choose>
  		</th>
  		<th style="text-align: center;">
  			  <c:choose>
	 			<c:when test="${!empty map.toDayuninCount}">
	  			${map.todaySignCount-map.toDayuninCount}
	  			</c:when>
	  			<c:otherwise>
	  				0
	  			</c:otherwise>
	 		  </c:choose>
  		</th>
  		</tr>
	</table>
	<div style="border-top: 1px dashed #999;padding-bottom: 2em;"></div>
	<table class="table table-striped">
		<tr class="info">
	  		<th style="text-align: center;">上传照片总次数</th>
	  		<th style="text-align: center;">今上传照片次数</th>
	  	</tr>
  		<tr>	
  		<th style="text-align: center;">
  		  <c:choose>
 			<c:when test="${!empty map.imageCount}">
  			${map.imageCount}
  			</c:when>
  			<c:otherwise>
  				0
  			</c:otherwise>
 		  </c:choose>
  		</th>
  		<th style="text-align: center;">
  			  <c:choose>
	 			<c:when test="${!empty map.todayImageCount}">
	  			${map.todayImageCount}
	  			</c:when>
	  			<c:otherwise>
	  				0
	  			</c:otherwise>
	 		  </c:choose>
  		</th>
  		</tr>
	</table>
</body>
</html>