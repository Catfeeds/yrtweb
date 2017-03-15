<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../common/common.jsp" %>
<title>联赛首页</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<link href="${ctx}/resources/sliderengine/amazingslider-1.css" rel="stylesheet" />
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<c:set var="currentPage" value="LEAGUEINDEX"/>
<style type="text/css">

       .chuanhang{
           position:fixed;
           bottom:30px;
           right:80px;
           width: 150px;
           height: 150px;
       }

</style>
</head>
<c:choose>
	<c:when test="${indexFlag eq true}">
		<body style="background: url(${ctx}/resources/images/lebg.jpg) no-repeat center 374px;">
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${!empty league.backgroud_src}">
				<body style="background: url(${el:headPath()}${league.backgroud_src}) no-repeat center 374px;">
			</c:when>		
			<c:otherwise>
				<body style="background: url(${ctx}/resources/images/lebg.jpg) no-repeat center 374px;">
			</c:otherwise>
		</c:choose>
	</c:otherwise> 
 </c:choose>
 
<div class="warp">
    <img src="../resources/images/chuanhang.jpg" class="chuanhang">
	<div class="masker"></div>
         <!--头部-->
         <%@ include file="../../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>    
	     <!--导航 end-->
       	<!-- 二级导航 start-->
		<input type="hidden" id="league_id" value="${league_id}"/> 	       		
		<input type="hidden" id="now_league_id" value="${now_league_id}"/> 
		<input type="hidden" id="indexFlag" value="${indexFlag}"/> 	       		
       	<c:choose>
       		<c:when test="${indexFlag eq true}">
				<%@ include file="league_naver.jsp" %> 
       		</c:when>
       		<c:otherwise>
				<%@ include file="league_son_naver.jsp" %>
       		</c:otherwise> 
       	</c:choose>
       	<!-- 二级导航end  --> 
        <!-- content start--> 
		<div class="wrapper" style="margin-top: 40px;">
            <div class="race">
                <div class="title">
                    <span class="ml20">联赛赛程</span>
		       		<c:if test="${indexFlag eq true}">
						<span class="ml10">
	                        <a href="javascript:void(0);" class="select_s_area active" onclick="loadRecords('')">全部</a>
	                        <c:forEach items="${leagueList}" var="league">
		                        <span class="select_s_area">|</span>
		                        <a href="javascript:void(0);" class="select_s_area" onclick="loadRecords('${league.id}')">${league.simple_name}</a>
	                        </c:forEach>
                  			 </span>
		       		</c:if>
		       		<c:if test="${indexFlag eq false}">
                    	<a href="${ctx}/league/eventRecords?league_id=${league_id}" class="mores" target="blank">更多</a>
                    </c:if>
                    <div class="clearit"></div>
                </div>
                <div class="race_content">
                	<!-- 赛程start -->
                    <div class="race_round mt20" id="race_frame">
                        <!-- <div class="round_info frame" >
                        	
                        
                        </div> -->
                        <div class="clearit"></div>
                    </div>
					<!-- 赛程end -->
					<!-- 视频start -->
                    <div class="video_q" id="iv_area">
                        <div class="title">
                            <span class="ml10">精彩视频</span>
                            <a href="${ctx}/indexIvList?type=videolist" class="mores" target="blank">更多</a>
                             <c:if test="${indexFlag eq true}">
                             <span class="select_s" id="finder_v1" onclick="loadIvs(2)">全&emsp;部</span>
                             <div class="select_s_season" id="finder_v2">
                             <p><a href="javascript:loadIvs(2);" class="select_s_area active">全部</a></p>
                                 <c:forEach items="${leagueList}" var="league">
				                        <p><a href="javascript:void(0);" class="select_s_area" onclick="loadIvs(2,'${league.id}')">${league.simple_name}</a></p>
			                     </c:forEach>
                            </div>
                            </c:if>
                           
                             <div class="clearit"></div>
                        </div>
                        <div id="league_index_videos">
                        <img alt="视频加载中" src="${ctx}/resources/images/loading.gif" style="position: relative;width: 40px;height: 40px;left: 145px;margin-top: 45px;">
                        </div>
                        <div class="title mt10">
                            <span class="ml10">精彩图片</span>
                            <a href="${ctx}/indexIvList?type=imagelist" class="mores" target="blank">更多</a>
                            <c:if test="${indexFlag eq true}">
							   <span class="select_s" id="finder_n3" onclick="loadIvs(1)">全&emsp;部</span>
							   <div class="select_s_season" id="finder_n4">
							   <p><a href="javascript:loadIvs(1);" class="select_s_area active">全部</a></p>
			                   <c:forEach items="${leagueList}" var="league">
				                     <p><a href="javascript:void(0);" class="select_s_area" onclick="loadIvs(1,'${league.id}')">${league.simple_name}</a></p>
			                   </c:forEach>
	                  			</div>
				       		</c:if>
				       		
				       		
                        </div>
                        <div id="league_index_images">
                        <img alt="图片加载中" src="${ctx}/resources/images/loading.gif" style="position: relative;width: 40px;height: 40px;left: 145px;margin-top: 45px;">
                        </div>
                    </div>
                    <!-- 视频end -->
                    <!-- 新闻start -->
                    <div class="nl_news">
                        <div class="title">
                            <span class="ml20">联赛新闻</span>
                            <c:choose>
                        		<c:when test="${indexFlag eq true}">
		                            <a href="${ctx}/news" class="mores" target="blank">更多</a>
                        		</c:when>
                        		<c:otherwise>
                        			 <a href="${ctx}/news?model_id=${league_id}" class="mores" target="blank">更多</a>
                        		</c:otherwise>
                        	</c:choose>
                            <c:if test="${indexFlag eq true}">
	                           
	                                <span class="select_s" id="finder_n5" onclick="loadIvs(1)">全&emsp;部</span>
	                                 <div class="select_s_season" id="finder_n6">
									 <p><a href="javascript:loadNews()" class="select_s_area active">全部</a></p>
			                        <c:forEach items="${leagueList}" var="league">
				                       
				                        <p><a href="javascript:loadNews('${league.id}')" class="select_s_area">${league.simple_name}</a></p>
			                        </c:forEach>
			                  </div>
                        	</c:if>
                        	
                        	
                            <div class="clearit"></div>
                        </div>
                        <dl id="newsArea">
                       		<!-- 联赛新闻 -->
                        </dl>
                    </div>
					<!-- 新闻end -->
                    <div class="ranking_s">
                    	<!-- 积分榜start -->
                        <div class="title" style="position: relative;">
                            <a class="mores" href="${ctx}/league/integralList?league_id=${league_id}" id="a_integral" target="blank">更多</a>
                            <span class="ms ml10">积分榜</span>
                            <c:if test="${indexFlag eq true}">
	                            <span class="select_s" id="finder_n7">${league.simple_name}</span>
	                             <div class="select_s_season" id="finder_n8">
			                        <c:forEach items="${leagueList}" var="league">
				                        <p><a href="javascript:void(0);" class="select_s_area" onclick="loadIntegral('.i_list ul li:first','','${league.id}');">${league.simple_name}</a></p>
			                        </c:forEach>
			                     </div>
                        	</c:if>
                        </div>
                        <div id="jifenArea"></div>    
						<!-- 积分榜end -->
						<!-- 射手榜start -->
                        <div class="title mt10" style="position: relative;">
                            <a class="mores" href="${ctx}/league/scorerRank?league_id=${league_id}" id="a_scorer" target="blank">更多</a>
                            <span class="ms ml10" style="cursor: pointer;">射手榜</span>
                            <c:if test="${indexFlag eq true}">
	                            <span class="select_s" id="finder_n9">${league.simple_name}</span>
	                             <div class="select_s_season" id="finder_n10">
			                        <c:forEach items="${leagueList}" var="league">
				                        <p><a href="javascript:void(0);" class="select_s_area" onclick="loadScorer('${league.id}');">${league.simple_name}</a></p>
			                        </c:forEach>
			                   </div>
                        	</c:if>
                        </div>
                        <table class="jifen" id="scorerArea"></table>
                        <!-- 射手榜end -->
                        <!-- 身价榜start -->
                        <div class="title mt10" style="position: relative;">
							<a class="mores" href="${ctx}/league/toPrice?league_id=${league_id}" id="a_price" target="blank">更多</a>                           
                            <span class="ms ml10" style="cursor: pointer;">身价榜</span>
                            <c:if test="${indexFlag eq true}">
	                            <span class="select_s" id="finder_n11">${league.simple_name}</span>
	                             <div class="select_s_season" id="finder_n12">
			                        <c:forEach items="${leagueList}" var="league">
				                         <p><a href="javascript:void(0);" class="select_s_area" onclick="loadPrice('${league.id}');">${league.simple_name}</a></p>
			                        </c:forEach>
			                   </div>
                        	</c:if>
                        </div>
                        <table class="jifen" id="priceArea"></table>
                        <!-- 身价榜end -->
                        <!-- 红黄榜start -->
                        <div class="title mt10" style="position: relative;">
                            <a class="mores" href="${ctx}/league/toCard?league_id=${league_id}" id="a_card" target="blank">更多</a>
                            <span class="ms ml10" style="cursor: pointer;">红黄榜</span>
                            <c:if test="${indexFlag eq true}">
	                           <span class="select_s" id="finder_n13">${league.simple_name}</span>
	                              <div class="select_s_season" id="finder_n14">
			                        <c:forEach items="${leagueList}" var="league">
				                        <p><a href="javascript:void(0);" class="select_s_area" onclick="loadCard('${league.id}');">${league.simple_name}</a></p>
			                        </c:forEach>
			                    </div>
			                    
			               
                        	</c:if>
                        </div>
                        <table class="jifen" id="cardArea"></table>
                        <!-- 红黄榜end -->
                    </div>
                    <div class="clearit"></div>
                </div>
            </div>
        </div>          
		<!-- content end -->
</div>
<%@ include file="../../common/footer.jsp" %>
<script src="${ctx}/resources/js/plugins.js"></script>
<script src="${ctx}/resources/js/sly.js"></script>
<script src="${ctx}/resources/sliderengine/amazingslider.js"></script>
<script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script src="${ctx}/resources/js/own/index_new.js"></script>
<script src="${ctx}/resources/js/own/index_league.js"></script>
<script type="text/javascript">
    $(function () {
    	layer.config({
    	    extend: '/extend/layer.ext.js'
    	});
    	
      
        var len = $(".navs .li").length;
        function clear() {
            for (var i = 0; i < len; i++) {
                $(".ui_tip_violet_1[dateindex=" + i + "]").hide();
                $(".ui_tip_violet_green[dateindex=" + i + "]").hide();
            }
        }

        $(".navs .li").each(function () {
            $(this).mouseover(function () {
                clear();
                $(this).find(".ui_tip_violet_1").show();
                $(this).find(".ui_tip_violet_green").show();
            });
        });
        
        $("#select_me").click(function () {
            $(".nums_time").show();
            $(".round_num").removeClass("round_num").addClass("round_change");
        });
        
        $(document).click(function (e) {
            if (!$("#select_me").is(':has(' + e.target.localName + ')') && e.target.id != 'select_me') {
                $(".nums_time").hide();
                $(".round_change").removeClass("round_change").addClass("round_num");
            }
        });

        $(".select_s_area").each(function() {
            $(this).click(function() {
                $(this).addClass("active").siblings().removeClass("active");
            });
        });

        function showSelect(id1, id2) {
            $(id1).mouseover(function (event) {
                event.stopPropagation();
                $(id2).show();
                return false;
            });

            $(id2 + " p").each(function () {
                $(this).click(function () {
                    var str = $(this).text();
                    $(id1).text(str);
                    $(id2).hide();

                });
            });
        }

        showSelect("#finder_v1", "#finder_v2");
        showSelect("#finder_n3", "#finder_n4");
        showSelect("#finder_n5", "#finder_n6");
        showSelect("#finder_n7", "#finder_n8");
        showSelect("#finder_n9", "#finder_n10");
        showSelect("#finder_n11", "#finder_n12");
        showSelect("#finder_n13", "#finder_n14");
     
        $(document).click(function (event) {
            var _con = $('.select_s');
            if (!_con.is(event.target) && _con.has(event.target).length === 0) {
                $('.select_s_season').hide();
            }
        });
    });	
</script>
</body>
</html>
