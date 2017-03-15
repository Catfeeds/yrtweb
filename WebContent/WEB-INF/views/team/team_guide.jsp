<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>俱乐部引导</title>
<link href="${ctx}/resources/css/clubLook.css" rel="stylesheet" />
<c:set var="currentPage" value="TEAMDETAIL"/>
</head>
<body>
   <div class="warp">
   <!--头部-->
	<%@ include file="../common/header.jsp" %> 
   </div>
    <!--导航 start-->
    <%@ include file="../common/naver.jsp" %>    
    <!--导航 end-->     
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <!--俱乐部描述-->
                <div class="clubDescribe f14 ms" style="height: 484px;">
                	<div style="height: 34px;">
                		<div class="pull-left clubTile clubTile1" style="cursor: pointer;">
                			<span onclick="javscript:void(window.location='${ctx}/team/list')">俱乐部列表</span>
                		</div>
                		<div class="pull-left clubTile">
                			<span></span>
                		</div>
                	</div>
                	<div class="creatClub">
                		<img src="${ctx}/resources/images/creatClub.png"/>
                		<p style="margin: 0 auto;width: 138px;margin-top: 20px;" class="text-white">当前没有任何俱乐部</p>
                		<div class="operation">
                			<input type="button" value="自由搜索" class="creatBtn" onclick="javscript:window.location='${ctx}/team/list'"/>
                			<input type="button" value="自由创建" class="creatBtn" style="float: right;" onclick="checkIfCreateClub();"/>
                		</div>
                	</div>
                </div>
            </div>
        </div>
    <!--页脚-->
   	<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript">
function checkIfCreateClub(){
	 $.ajaxSec({
		type:"GET",
		url:base+"/team/checkIfCreateClub",
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				window.location=base+"/team/info";
			}
		}
	});
	
}
</script>
</html>