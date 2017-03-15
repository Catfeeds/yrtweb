<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
		 <!-- banner -->
		 <div class="advert">
		 	<%-- <c:choose>
		 		<c:when test="${!empty league.banner_src}">
		            <img src="${el:headPath()}${league.banner_src}"/>
		 		</c:when>		
		 		<c:otherwise> --%>
		 			<img src="${ctx}/resources/images/banner_ce.jpg"/>
		 		<%-- </c:otherwise>
		 	</c:choose> --%>
         </div>
         <!-- banner -->
         <!-- 二级导航 start-->
         <div class="nl_nav">
            <ul class="navs">
                <li class="li" style="margin-left: 80px;">
                    <a href="javascript:void(0);" class="anav">赛事选择</a>
                    <div class="ui_tip_violet_1" dateindex="0">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                    <span class="ui_txt f12 ms active" onclick="window.location='${ctx}/league/index">联赛首页</span>
                                    <c:forEach items="${leagueList}" var="league">
                                    	<span class="ui_txt f12 ms" onclick="window.location='${ctx}/league/index?league_id=${league.id}'">${league.simple_name}</span>
                                    </c:forEach>
                                </li>
                                <div class="clearit"></div>
                            </ul>
                        </div>
                        <div class="ui_millde">
                            <div class="arrow_border arrow_border_top"></div>
                            <div class="arrow_content arrow_content_top"></div>
                        </div>
                    </div>
                </li>
                <li class="li">
                    <a href="#" class="anav" style="margin-left: 75px;">赛事报名</a>
                    <div class="ui_tip_violet_1" dateindex="1">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                	<c:forEach items="${leagueCfgList}" var="leagueCfg">
                                    	<a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/identity?cfg_id=${leagueCfg.id}')">
	                                    	${leagueCfg.year}<yt:areaName code="${leagueCfg.area_code}"/><yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/>
                                    	</a>
                                	</c:forEach>
                                </li>
                                <div class="clearit"></div>
                            </ul>
                        </div>
                        <div class="ui_millde">
                            <div class="arrow_border arrow_border_top"></div>
                            <div class="arrow_content arrow_content_top"></div>
                        </div>
                    </div>
                </li>
                <li class="li">
                    <a href="javascript:void(0);" class="anav" style="margin-left: 75px;">球员竞拍</a>
                    <div class="ui_tip_violet_1" dateindex="2">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                   	<c:forEach items="${leagueCfgList}" var="leagueCfg">
                                    	<a class="ui_txt f12 ms" onclick="window.open('${ctx}/auction/searchList?s_id=${leagueCfg.id}')">
	                                    	${leagueCfg.year}<yt:areaName code="${leagueCfg.area_code}"/><yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/>
                                    	</a>
                                	</c:forEach>
                                </li>
                                <div class="clearit"></div>
                            </ul>

                        </div>
                        <div class="ui_millde">
                            <div class="arrow_border arrow_border_top"></div>
                            <div class="arrow_content arrow_content_top"></div>
                        </div>
                    </div>
                </li>
                <li class="li">
                    <a href="#" class="anav" style="margin-left: 75px;">转会交易</a>
                    <div class="ui_tip_violet_1" dateindex="3">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                               		<c:forEach items="${leagueCfgList}" var="leagueCfg">
	                                   	<a class="ui_txt f12 ms" onclick="javascript:isOpenMarket('${league.s_id}')">
	                                    	${leagueCfg.year}<yt:areaName code="${leagueCfg.area_code}"/><yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/>
	                                   	</a>
                                	</c:forEach>
                                </li>
                                <div class="clearit"></div>
                            </ul>
                        </div>
                        <div class="ui_millde">
                            <div class="arrow_border arrow_border_top"></div>
                            <div class="arrow_content arrow_content_top"></div>
                        </div>
                    </div>
                </li>
                <li class="li">
                    <a href="#" class="anav" style="margin-left: 75px;">赛事数据</a>
                    <div class="ui_tip_violet_1" dateindex="4">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/record/toRecord?league_id=${league_id}')">赛程</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/integralList?league_id=${league_id}')">积分榜</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/scorerRank?league_id=${league_id}')">射手榜</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/assistsRank?league_id=${league_id}')">助攻榜</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/toPrice?league_id=${league_id}')">身价榜</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/toCard?league_id=${league_id}')">红黄榜</a>
                                </li>
                                <div class="clearit"></div>
                            </ul>

                        </div>
                        <div class="ui_millde">
                            <div class="arrow_border arrow_border_top"></div>
                            <div class="arrow_content arrow_content_top"></div>
                        </div>
                    </div>
                </li>
                <div class="clearit"></div>
            </ul>
        </div>
        <!-- 二级导航end  --> 
<script>
//赛事选择
$(".ui_tip_violet_1[dateindex=0]").css({ "left": "-80px" });
$(".ui_tip_violet_1[dateindex=0] .arrow_border_top").css({ "left": "12%", "top": "-18px" });
$(".ui_tip_violet_1[dateindex=0] .arrow_content_top").css({ "left": "12%", "top": "-17px" });
//赛事报名
$(".ui_tip_violet_1[dateindex=1]").css({ "left": "-200px" });
$(".ui_tip_violet_1[dateindex=1] .arrow_border_top").css({ "left": "31%", "top": "-18px" });
$(".ui_tip_violet_1[dateindex=1] .arrow_content_top").css({ "left": "31%", "top": "-17px" });
//球员竞拍
$(".ui_tip_violet_1[dateindex=2]").css({ "left": "-395px" });
$(".ui_tip_violet_1[dateindex=2] .arrow_border_top").css({ "left": "50%","top":"-18px" });
$(".ui_tip_violet_1[dateindex=2] .arrow_content_top").css({ "left": "50%", "top": "-17px" });
//转会交易
$(".ui_tip_violet_1[dateindex=3]").css({ "left": "-590px" });
$(".ui_tip_violet_1[dateindex=3] .arrow_border_top").css({ "left": "70%", "top": "-18px" });
$(".ui_tip_violet_1[dateindex=3] .arrow_content_top").css({ "left": "70%", "top": "-17px" });
//赛事数据
$(".ui_tip_violet_1[dateindex=4]").css({ "left": "-785px" });
$(".ui_tip_violet_1[dateindex=4] .arrow_border_top").css({ "left": "89%", "top": "-18px" });
$(".ui_tip_violet_1[dateindex=4] .arrow_content_top").css({ "left": "89%", "top": "-17px" });
$(".s_choice").click(function(event) {
	 event.stopPropagation();
	 $(".s_select").toggle();
	 return false;
});
$(".s_select p").each(function() {
    $(this).click(function() {
        var str = $(this).text();
        $(".s_choice").text(str);
        $(".s_select").hide();
    });
});
$(document).click(function (event) {
    var _con = $('.s_select'); 
    if (!_con.is(event.target) && _con.has(event.target).length === 0) { 
        $('.s_select').hide(); 
    }
});
</script>