<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>
<c:if test="${type == 1 }">
	比赛动态
</c:if>
<c:if test="${type == 2 }">
	俱乐部动态
</c:if>
<c:if test="${type == 3 }">
	球员动态
</c:if>  
</title>
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
       <div class="mt20">
                <div class="p_title" style="text-align: center;">
                    <span class="f14 ml20 ms text-white">
                   		<c:if test="${type == 1 }">
                   			比赛动态
                   		</c:if>
						<c:if test="${type == 2 }">
							俱乐部动态
						</c:if>
						<c:if test="${type == 3 }">
							球员动态
						</c:if>                   		
                 	</span>
                </div>
                <div class="player_pic" id="moreDatas">
                    
                </div>
            </div>
       </div>
        <!--页脚-->
    	<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">

$(function(){
	loadListPage(1);
});
function loadListPage(currentPage){
	$.ajax({
			type:"POST",
			url:base+"/more_datas?random="+Math.random(),
			data:{"currentPage":currentPage,"type":'${type}'},
			dataType:"HTML",
			success:function(data){
				$("#moreDatas").empty();
			    $("#moreDatas").append(data);
			}
		});
	
}
</script>
</body>
</html>