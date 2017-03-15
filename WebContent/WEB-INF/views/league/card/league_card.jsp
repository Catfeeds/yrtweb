<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ include file="../../common/common.jsp" %>
    <title>红黄榜</title>
    <meta name="renderer" content="webkit">
	<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
</head>
<body>
    <div class="warp">
        <!--头部-->
        <%@ include file="../../common/header.jsp" %>
      	<!--导航 start-->
		<%@ include file="../../common/naver.jsp" %>  
		<!--二级导航start-->
	     <%@ include file="../index/statistics_naver.jsp" %>  
        <div class="wrapper" style="margin-top: 40px;">
            <div class="race">
                <div class="title">
                    <span class="ml20">${league.name}</span>
                    <div class="clearit"></div>
                </div>
            	<div class="race_content"  id="cardArea">
            	</div>
               <%--  <div class="title">
                    <span class="f18 ms ml10"><a href="javascript:void(0);" style="color:#fff" onclick="location.href='${ctx}/league/index?league_id=${league.id}'">${league.simple_name}首页</a>>>红黄榜</span>
                </div>
                <div id="cardArea">
	            </div>    
                <div class="clearit"></div> --%>
                	
            </div>
        </div>
    </div>
<%@ include file="../../common/footer.jsp" %>
<script type="text/javascript">
	function cardSearch(pageIndex){
		// 发送ajax获取数据
		$.ajax({
				type : 'POST',
				url : base+"/league/userCard",
				data : {league_id:'${league_id}',pageSize:10,currentPage:pageIndex},
				dataType:"html",
				cache : false,
				success : function(result) {
					if(result.state=='error'){
						layer.msg(result.message.error[0]);
					}else{
						$("#cardArea").html(result);
					}
				},
				error : $.ajaxError
			});
	}
	cardSearch(0);
</script>
</body>
</html>
