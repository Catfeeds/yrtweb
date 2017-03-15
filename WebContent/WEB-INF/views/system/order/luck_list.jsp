<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>幸运记录</title>
<c:set var="currentPage" value="LUCK"/>
</head>
<body>
	<div class="warp">
		<!-- 头部 -->
		<div class="my_duo" id="my_duo">
        </div>
        <div class="masker"></div>
		<%@include file="../../common/header.jsp" %>
		<!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>  
		<div class="wrapper" style="margin-top: 30px;">
			 <!--页面主体-->
	            <div class="container ms">
	                <div class="middle">
	                	<%@include file="../left.jsp" %> 
	                	<div class="content ms">
               				<div class="content_top">
                            <div class="title ms">
                                <span class="text-white f14">当前位置：我的夺宝&ensp;>&ensp;幸运记录</span>
                            </div>
                            <div id="order_area"></div>
                        </div>
	                    </div>
	                </div>
                </div>	
		</div>
</div>		
<%@ include file="../../common/footer.jsp" %>
</body>
 <script type="text/javascript">
 	$(function(){
 		luckSearch(0);
	});

      jQuery.fn.center = function () {
          this.css("position", "absolute");
          this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
          this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
          return this;
      }
    
    //中奖订单列表
      function luckSearch(currentPage){
      	$.ajax({
      		type: 'POST',
      		url: base+"/shop/luckResult",
      		data: {"currentPage":currentPage,pageSize:3},
      		dataType:"html",
      		success: function(data){
      			if(data.state=='error'){
      				layer.msg(data.message.error[0]);
      			}else{
      				$("#order_area").html(data);   				
      			}
      		},
      		error: $.ajaxError
      	});	
      }
      
    //查看号码
    function showNum(id){
    	$.ajax({
      		type: 'POST',
      		url: base+"/shop/showNum",
      		data: {id:id},
      		dataType:"json",
      		success: function(data){
				var html_str = "<div class='d_bian'>我的夺宝号码<span class='pull-right close_the' onclick='closeNum();'>X</span>"
	          				+"<div class='clearfix'></div></div>"
	       				+"<div class='d_bian'> 您本期一共参与了"+ data.order_count +"人次</div>"
	       				+"<div class='d_bian2 ml10'>"
	       				+ data.create_time
	       				+" <div style='width: 100%;height: 240px;overflow: auto'>"
	       				+"<p>"+ data.order_nums +"</p>"
	       				+"</div>"
	       				+"</div>";
	       				
				$("#my_duo").html(html_str);
				lookNum();
      		},
      		error: $.ajaxError
      	});	
    }
    
    function lookNum(){
  	  var h = $(document).height();
        $(".masker").css("height", h).show();
        $(".my_duo").center().fadeIn();
    }
    
    function closeNum(){
  	  $(".masker").fadeOut();
        $(".my_duo").fadeOut();
    }
    
  //参与最新
    function toNew(pro){
    	$.ajax({
    		type: 'POST',
    		url:base+"/shop/recentProduct",
    		data:{"product_id":pro},
    		dataType:"json",
    		success:function(data){
    			if(data.state=="success"){
    				window.location = base + "/shop/product/" + data.data.data_id;
    			}else{
    				layer.msg(data.message.error[0],{icon:2});
    			}
    		}
    	});
    }

    
  </script>
</html>