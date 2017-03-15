<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="common/common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>宇任拓首页</title>
<style type="text/css">
#showVideo{
	z-index: 99;
}
.showvdo {
     position: relative;
 }

 #playSWF {
     position: absolute;
     width: 20px;
     height: 20px;
     right: 0px;
     top: -18px;
     cursor: pointer;
     z-index: 9999;
 }
</style>
</head>
<c:set var="currentPage" value="INDEX"/>
<body>

    <div class="warp">
    <div id="showVideo" style="z-index: 120;"><img id="playSWF" src="${ctx}/resources/images/close.png"/><div id="a1" class="showvdo"></div></div>
        <!--头部-->
    	<%@ include file="common/header.jsp" %>    
    </div>
        <!--导航 start-->
        <%@ include file="common/naver.jsp" %>    
        <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <!--新闻-->
                <div class="news mt20">
                	<img src="${ctx}/resources/images/horn.png" class="pull-left" style="margin-top: 8px;margin-left: 5px;"/>
	                    <ul class="list" id="news">
	                    </ul>
                </div>
                <!--轮播-->
                <div class="carousel">
                    <div class="baby_zhan2">
                       		<img alt="宇任拓超级联赛" src="${ctx}/resources/images/league_banner.jpg" onclick="window.location='${ctx}/league/identity?league_id=1'" style="width: 994px;cursor: pointer;">
                        <%-- <ul class="baby_demo">
                        	<c:forEach items="${reMaps}" var="item">
	                            <li onclick="window.open('${ctx}/baby/base/baby/${item.baby_id}')">
	                                <div class="baby_photo">
	                                    <div class="bb_masker no"></div>
	                                      <c:if test="${item.status eq 1}">
							                    <img src="${ctx}/resources/images/rzld.png" class="rzld" />
									    </c:if>
	                                    <div class="bbinfo">
	                                        <dl>
	                                            <dt><span class="ms f24">${item.usernick }</span><span class="f24 ms ml15">${item.age}岁</span></dt>
	                                            <dd class="mt5"><span class="f18 ms">三围</span><span class="f18 ms ml20">${item.chest}/${item.waist}/${item.hip}</span></dd>
	                                        </dl>
	                                    </div>
	                                    <img src="${filePath}/${item.src}" />
	                                </div>
	                            </li>
                        	</c:forEach> 
                        	<div class="clearit"></div>
                        </ul>--%>
                    </div>
                </div>
                <!--动态-->
                  <!--动态-->
                <div class="dynamic mt20">
                    <div class="dynamic_icon">
						<span style="margin-left: 132px;">
							<a href="#game_div" id="a1"><img src="${ctx}/resources/images/match.png" id="img1" class="img1 icon" onmouseover="mouseover1()" onmouseout="mouseout1()"/></a>
						</span>
						<span style="margin-left: 223px;"><a href="#team_div" id="a2"><img id="img2" src="${ctx}/resources/images/club.png" class="icon" onmouseover="mouseover2()" onmouseout="mouseout2()"/></a></span>
						<span style="margin-left: 246px;" class="img3"><a href="#player_div" id="a3"><img id="img3" src="${ctx}/resources/images/players.png" class="icon" onmouseover="mouseover3()" onmouseout="mouseout3()"/></a></span>
                    </div>
                    
                    
                    <div class="dynamic_description ms">
                    	<div class="description1">
                    		<div class="description1_content" id="game_div" name="game_div">
                    		</div>
                    	</div>
                    	
                    	<div class="description1">
                    		<div class="description1_content" id="team_div" name="team_div">
                    		</div>
                    	</div>
                    	
                    	<div class="description1">
                    		<div class="description1_content" id="player_div" name="player_div">
                    		</div>
                    	</div>
                    </div>
                    <div class="video">
                		<a href="javascript:void(0);" style="text-align: center;">
                			<img id="img4" src="${ctx}/resources/images/video.png" onmouseover="mouseover4()" onmouseout="mouseout4()"/>
                		</a>
                	</div>
                	<div style="float: right;margin-top: -10px;">
                		<%-- <img src="${ctx}/resources/images/more.png" /> --%>
                	</div>
                	<div class="imgShow" id="videos_div">
                	   
                	</div>
                </div>
            </div>
        </div>
        <!--页脚-->
    	<%@ include file="common/footer.jsp" %>
    <!-- <script src="${ctx}/resources/sliderengine/amazingslider.js"></script>
    <script src="${ctx}/resources/sliderengine/initslider-1.js"></script> -->
    <script src="${ctx}/resources/vmodel/Filter.js"></script>
    <script src="${ctx}/resources/js/own/index.js"></script>
    <script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
    <script type="text/javascript">
    jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }
    function showVideo(video){
    	$(".login_masker").height($(document).height()).fadeIn();
		$('#showvdo').html('');
		$('#showvdo').append(video);
		$(".login_masker").show();
		$("#playSWF").show();
		$('#showVideo').center().show();
		
	}
	var btn = $("#playSWF");
    btn.click(function () {
        $("#showvdo").html("");
        $('#showVideo').hide();
        $(".login_masker").hide();
    });

    $($(".baby_photo")).each(function() {
        $(this).mouseover(function () {
            $(this).find(".bbinfo").show();
            $(this).find(".bb_masker").removeClass("no");
            
        }).mouseout(function () {
            $(this).find(".bbinfo").hide();
            $(this).find(".bb_masker").addClass("no");
            
        });
    });

    
    </script>
</body>
</html>
