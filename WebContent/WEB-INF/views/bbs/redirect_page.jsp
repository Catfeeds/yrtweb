<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布论坛</title>
	<link href="${ctx}/resources/css/forum.css" rel="stylesheet" />
	<c:set var="currentPage" value="BBS"/>
</head>  
<body>
	<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航-->
        <%@ include file="../common/naver.jsp" %>  
		<!--<div style="text-align:center;margin-top:150px;color:#F00;">  
			${info}<span id="second"></span>秒钟后自动跳转论坛首页
			<a href="${ctx}/bbs/list?plate_id=${plate_id}" class="text-white">点击进入</a>
		</div>  -->
		<div class="bbs">
		<div class="title">
                <div class="pull-left ml15">
                    <span class="active">发表成功</span>
                </div>
                 <div class="clearit"></div>
            </div>
       
            <div class="succ">
                <p class="mt100 ms f20 text-white">发表成功，页面将在${info}<span id="second"></span>秒后跳转至详情页面</p>
                <p class="mt40 f14 text-white ms">如未跳转，请点击此处<a href="${ctx}/bbs/list?plate_id=${plate_id}" class="text-success">跳转页面</a> </p>
               <!--  <input type="button" name="name" value="返回论坛首页" class="mt50 btn_l ms" onclick="javascript:history.back(-1);"/> -->
            </div>
         </div>
    </div>
<%@ include file="../common/footer.jsp" %> 	
<script language="javascript">
		var j = 4;
		function reloadurl(){
			if(j == 0){
				window.location.href="${ctx}/bbs/list?plate_id=${plate_id}";
			}else{
				j = j - 1;
				$("#second").html(j);
			}
		}  
		setInterval(reloadurl,1000);


	</script>  
</body>  
</html>  