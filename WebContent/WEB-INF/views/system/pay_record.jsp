<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/chargeCenter.css" rel="stylesheet" />
<title>充值记录</title>
<c:set var="currentPage" value="PAYRECORD"/>
</head>
<body>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../common/header.jsp" %>
		<!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>  
		<div class="wrapper" style="margin-top: 30px;">
			 <!--页面主体-->
	            <div class="container ms">
	                <div class="middle">
	                	<%@include file="left.jsp" %>
	                	<div class="content ms">
	                        <!--消费记录-->
               				<div class="title ms content_top" style="padding-left:0px;">
               					<span class="text-white f16">&nbsp;&nbsp;&nbsp;充值记录</span>
               					<div class="buyRecord f14" style="margin-top:11px;" id="datas">
	               					<!-- 列表数据 -->
	               				</div>
               				</div>
	                    </div>
	                </div>
                </div>	
		</div>
</div>		
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript">
$(function(){
	loadListPage(1);
});

//充值记录拉取
function loadListPage(currentPage){
	$.ajax({
		type:"POST",
		url:base+"/account/payData?random="+Math.random(),
		data:{"currentPage":currentPage},
		dataType:"HTML",
		success:function(data){
			$("#datas").empty();
			$("#datas").html(data);
		}
	});
}
</script>
</html>