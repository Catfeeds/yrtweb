<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<c:set var="currentPage" value="MYTEMPLATE"/>
<title>我的装扮</title>
</head>
<body>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../../common/header.jsp" %>
		<!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>
		 <div class="wrapper" style="margin-top: 116px;">
		 		 <!--页面主体-->
	            <div class="container ms">
	                <div class="middle">
	                <%@include file="../../system/left.jsp" %>	
	                <div class="content ms">
                        <div class="content_top">
               				<div class="title ms">
               					<span><a href="javascript:void(0)" class="all_btn" id="all_btn" onclick="changeDiv('all_btn');">全部模板</a></span>
               					<span><a href="javascript:void(0)" class="my_btn ml10 active" id="my_btn" onclick="changeDiv('my_btn');">我的模板</a></span>
               				</div>
               				<div id="mytempalte" class="template">
               				</div>
               				<!--全部模板-->
               				<div id="alltempalte" class="template" style="display: none;">
	               			</div>
                      </div>
	            </div>    
		 </div>
	</div>	
	</div>
	</div>
	<!-- footer start -->
	<%@include file="../../common/footer.jsp" %>
	<!-- footer end -->
</body>
<script type="text/javascript">
	var pagePart = "queryMyDressRes";
	var first = true;
	
	//层切换
	function changeDiv(str){
		if(str == "my_btn"){
			$("#alltempalte").css("display","none");
			$("#mytempalte").css("display","block");
			$(".my_btn").addClass("active");
			$(".all_btn").removeClass("active");
			pagePart = "queryMyDressRes";
		}else{
			$("#alltempalte").css("display","block");
			$("#mytempalte").css("display","none");
			$(".my_btn").removeClass("active");
			$(".all_btn").addClass("active");
			pagePart = "queryDressRes";
			if(first){
				first = false;
				loadListPage(0);	
			}
		}
	}
	//动态加载模版数据
	function loadListPage(pageNum){
		 $.ajax({
     		type: 'POST',
     		url: "${ctx}/centerold/" + pagePart,
     		data: {currentPage:pageNum},
     		dataType : 'html',
     		cache: false,
     		success: function(data){
     			if(data.state=='error'){
    				layer.msg(data.message.error[0]);
    			}else{
    				
    				if(pagePart == "queryDressRes"){
    					$("#alltempalte").html(data);
    				}else{
    					$("#mytempalte").html(data);
    				}
    			}
     		},
     		error: $.ajaxError
     	});
	}
	loadListPage(0);
</script>
</html>