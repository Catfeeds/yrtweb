<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>宝贝列表</title>
    <link href="${ctx}/resources/css/baby.css" rel="stylesheet" />
    <c:set var="currentPage" value="BABYINDEX"/>
</head>
<body>
    <div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航-->
        <%@ include file="../common/naver.jsp" %> 
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
                		<div class="baby_topR pull-left mt70 ml25" onclick="joinUsBaby();">
                			<a href="javascript:void(0);" ></a>
                		</div> 
                	</div>
                	<!--宝贝图片展示-->
                	<div class="search_babyPic mt10 ms">
                		<!--宝贝搜索部分-->
						<div class="search_baby ms mt15">
							<form action="" method="post" id="searchForm">
								<div class="babyType pull-left ml10">
									<span class="f14 text-white">类型/</span>
									<span class="f12 text-white select_type">
										<a href="javascript:void(0);" onclick="getSt(this,'0');">未认证</a>
							<!-- 			<a href="javascript:void(0);" onclick="getSt(this,'2');">认证中</a> -->
							            <a href="javascript:void(0);" onclick="getSt(this,'1')">已认证</a>
										<a href="javascript:void(0);" onclick="getSt(this,'')">不限</a>
									</span>
									<input type="hidden" id="status" name="status" value=""/>
								</div>
							          <div class="babyCity pull-left ml15">
							              <span class="f14 text-white">昵称/</span>
							              <input type="text" name="usernick" id="usernick" value="${usernick}" class="w120"/>
							          </div>
								<div class="babyCity pull-left ml15">
									<span class="f14 text-white">城市/</span>
									<span>
										<select id="province" name="province"></select>&nbsp;
							           	<select id="city" name="city"></select>&nbsp;
							           	<select id="county" name="county" style="display: none;"></select>&nbsp;
									</span>
								</div>
								<div class="babyHeight pull-left ml15">
									<span class="f14 text-white">身高/</span>
									<span>
										<input type="text" id="height" name="height"/>
									</span>
									<span class="f14 text-white">CM以上</span>
								</div>
								<div class="babyScore pull-left ml15">
									<span class="f14 text-white">评分/</span>
									<span>
										<input type="text" id="score" name="score"/>
									</span>
									<span class="f14 text-white">以上</span>
								</div>
								<div class="babySearchBtn pull-left ml10">
									<input type="button" value="搜索" onclick="searchGirl();"/>
								</div>
							</form>
							<div class="clearit"></div>
						</div>
						
						<div id="babyArea" style="width:980px;margin: 0 auto;"></div>
                	</div>
                </div>
            </div>
        </div>
        <!--页脚-->
        <%@ include file="../common/footer.jsp" %>
    </div>
    <script src="${ctx}/resources/js/area.js"></script>
    <script src="${ctx}/resources/sliderengine/amazingslider.js"></script>
    <script src="${ctx}/resources/sliderengine/initslider-1.js"></script>
    <script src="${ctx}/resources/js/own/babylist.js"></script>
    <script type="text/javascript">
  		new PCAS('province', 'city', 'county');
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
    