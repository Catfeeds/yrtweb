<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="${ctx}/resources/css/baby.css" rel="stylesheet" />
<title>宝贝首页</title>
<c:set var="currentPage" value="BABYINDEX"/>
 <style>
    .baby_left {
        width: 39px;
        height: 106px;
        background: url(${ctx}/resources/images/baby_left.png) no-repeat;
        position: absolute;
        top: 105px;
        left: 24px;
    }
     .baby_right {
         width: 39px;
         height: 106px;
         background: url(${ctx}/resources/images/baby_right.png) no-repeat;
         position: absolute;
         top: 105px;
         right: 24px;
     }
      #baby {
             margin-left: -350px;  
     }
</style>
</head>
<body>
<div class="warp">
        <!--头部-->
		 <%@ include file="../common/header.jsp" %>
		 <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <div class="baby">
                	<div class="baby_top ml20">
                		<div class="baby_topL mt30 ms pull-left">
                			<dl>
                				<dt class="ml15">
                					<span class="fw f50">
                						<em class="text-white">YRT</em>
                					</span>
                				</dt>
                				<dd>
                					<span class="f12 text-white">-YRT FOOTBALL BABY-</span>
                				</dd>
                				<dd>
                					<span class="f20 text-color">
                						宇任拓足球宝贝
                					</span>
                				</dd>
                			</dl>
                		</div>
                		<div class="baby_topM pull-left ml25">
                			<img src="${ctx}/resources/images/baby_top.png">
                		</div>
                		<div class="baby_topR pull-left mt50 ml65" onclick="joinUsBaby()">
                			<a href="javascript:void(0)"  class="ms"></a>
                		</div>
                	</div>
                	<!--top宝贝图片展示start-->
                	<!-- <div id="topDatas"> -->
                		 <div class="baby_pic mt10 ms frame" id="babyframe">
						   <ul class="clearfix" id="baby">
						   <c:forEach items="${reMaps}" var="item">
						       <li>
						           <div class="babyList">
						           		<c:if test="${item.status eq 1}">
						                    <img src="${ctx}/resources/images/rzld.png" class="rzld" />
								    	</c:if>
								        <a href="javascript:void(window.open('${ctx}/baby/base/baby/${item.baby_id}'))">
								            <img  src="${el:filePath(item.f_src,item.to_oss)}"/>
								        </a>
								        <p class="baby_name">
								            <a href="javascript:void(window.open('${ctx}/baby/base/baby/${item.baby_id}')" class="text-white">${item.usernick}</a>
								        </p>
						           </div>
						       </li>
						       
						     </c:forEach>  
						        
							</ul>
								<!--翻页-->
						   		<div class="baby_turn">
						   			<a href="javascript:void(0)" class="baby_left"></a>
						   			<a href="javascript:void(0)" class="baby_right"></a>
						   		</div>
						</div> 
                <!-- 	</div> -->
                	<!--top宝贝图片展示end-->
                	<!--皇冠宝贝-->
                	<div id="middleDatas">
                	
                	</div>
                	
                	<!--最新加入-->
                	<div id="bottomDatas">
                	
                	</div>
                </div>
            </div>


        </div>
        <%@ include file="../common/footer.jsp" %>
        <script src="${ctx}/resources/js/sly.js"></script>
	    <script src="${ctx}/resources/js/plugins.js"></script>
	   	<script src="${ctx}/resources/js/sly.main.js"></script>
        <script type="text/javascript">
        	$(function(){
        		/* loadtopDatas(); */
        		loadMiddleDatas();
        		loadBottomDatas();
        	})
        	
        	//载入顶部推荐宝贝数据
        	/* function loadtopDatas(){
        		$.ajax({
        			type:"POST",
        			url:base+"/babyIhome/topDatas?random="+Math.random(),
        			data:{"currentPage":1},
        			dataType:"HTML",
        			success:function(data){
        				$("#topDatas").empty();
        				$("#topDatas").append(data);
        			}
        		});
        	} */
        	//载入中部宝贝数据
        	function loadMiddleDatas(){
        		$.ajax({
        			type:"POST",
        			url:base+"/babyIhome/middleDatas?random="+Math.random(),
        			data:{"currentPage":1},
        			dataType:"HTML",
        			success:function(data){
        				$("#middleDatas").empty();
        				$("#middleDatas").append(data);
        			}
        		});
        	}
        	//载入底部宝贝数据
        	function loadBottomDatas(){
        		$.ajax({
        			type:"POST",
        			url:base+"/babyIhome/bottomDatas?random="+Math.random(),
        			data:{"currentPage":1},
        			dataType:"HTML",
        			success:function(data){
        				$("#bottomDatas").empty();
        				$("#bottomDatas").append(data);
        			}
        		});
        	}
        	
        	//加入我们成为宝贝
        	function joinUsBaby(){
        		$.ajaxSec({
        			type:"POST",
        			url:base+"/baby/isBaby",
        			dataType:"JSON",
        			success:function(data){
						if(data.state=="success"){
							window.location = base+"/baby/info";
						}else{
							layer.msg(data.message.error[0],{icon: 2});
						}        				
        			}
        		});
        	}
        </script>
</body>
</html>