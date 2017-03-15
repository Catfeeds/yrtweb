<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link rel="stylesheet" href="${ctx}/resources/css/pagination.css" type="text/css" />
<c:set var="currentPage" value="MYTEMPLATE"/>
<title>我的装扮</title>
</head>
<body>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../../common/header.jsp" %>
		
		 <div class="wrapper" style="margin-top: 116px;">
		 		 <!--页面主体-->
	            <div class="container ms">
	                <div class="middle">
	                <%@include file="../../system/left.jsp" %>	
	                <div class="content ms">
                        <div class="content_top">
               				<div class="title ms">
               					<span><a href="#" style="padding-right: 25px;" id="all_btn" onclick="changeDiv('all_btn');">全部模板</a></span>
               					<span><a href="#" class="my_btn" id="my_btn" onclick="changeDiv('my_btn');">我的模板</a></span>
               				</div>
               				<div id="mytempalte" class="template">
               					<div id="Pagination" class="pagination"></div>  
               				</div>
               				<!--全部模板-->
               				<div id="alltempalte" class="template" style="display: none;">
	               			</div>
	               			<div id="Pagination" class="m-pagination"></div>
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
<script src="${ctx}/resources/jquery.pagination.js"></script>

<script type="text/javascript">
	var pagePart = "queryMyDressRes";
	var first = true;
	
	//层切换
	function changeDiv(str){
		if(str == "my_btn"){
			$("#alltempalte").css("display","none");
			$("#mytempalte").css("display","block");
			pagePart = "queryMyDressRes";
		}else{
			$("#alltempalte").css("display","block");
			$("#mytempalte").css("display","none");
			pagePart = "queryDressRes";
			if(first){
				first = false;
				//loadListPage(0);	
			}
		}
	}
	//动态加载模版数据
	function loadListPage(pageNum){
		 $.ajax({
     		type: 'POST',
     		url: "${ctx}/center/" + pagePart,
     		data: {currentPage:pageNum},
     		dataType : 'html',
     		cache: false,
     		success: function(data){
     			if(data.state=='error'){
    				layer.msg(data.message.error[0]);
    			}else{
    				if($("#Pagination").html().length == ''){  
    	                $("#Pagination").pagination(total, {  
    	                    'items_per_page'      : 6,  
    	                    'num_display_entries' : 4,  
    	                    'num_edge_entries'    : 2,  
    	                    'prev_text'           : "上一页",  
    	                    'next_text'           : "下一页",  
    	                    'callback'            : pageselectCallback  
    	                });  
    	            }  
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
	function pageselectCallback(page_index, jq){  
		loadListPage(page_index);  
	}
	loadListPage(0);
</script>
</html>