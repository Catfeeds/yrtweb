<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
		 <!-- banner -->
		 <div class="advert">
		 	<c:choose>
		 		<c:when test="${!empty league.banner_src}">
		            <img src="${el:headPath()}${league.banner_src}"/>
		 		</c:when>		
		 		<c:otherwise>
		 			<img src="${ctx}/resources/images/banner_ce.jpg"/>
		 		</c:otherwise>
		 	</c:choose>
         </div>
         <!-- banner -->
         <!-- 二级导航 start-->
         <div class="nl_nav">
            <ul class="navs">

                <li class="li" style="margin-left: 108px;">
                    <a href="javascript:void(0);" class="anav_green">赛事选择</a>
                    <div class="ui_tip_violet_green" dateindex="0">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                    <span class="ui_txt f12 ms active" onclick="window.location='${ctx}/league/index'">联赛首页</span>
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
                    <a href="#" class="anav_green" style="margin-left: 50px;">赛事报名</a>
                    <div class="ui_tip_violet_green" dateindex="1">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/identity?cfg_id=${league.s_id}')">球员报名</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/identity?cfg_id=${league.s_id}')">俱乐部报名</a>
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
                    <a href="javascript:void(0);" class="anav_green" style="margin-left: 50px;">球员竞拍</a>
                    <div class="ui_tip_violet_green" dateindex="2">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/auction/searchList?s_id=${league.s_id}')">竞拍市场</a>
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
                    <a href="#" class="anav_green" style="margin-left: 50px;">转会交易</a>
                    <div class="ui_tip_violet_green" dateindex="3">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                    <a class="ui_txt f12 ms" onclick="javascript:isOpenMarket('${league.s_id}')">转会市场</a>
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
                    <a href="#" class="anav_green" style="margin-left: 50px;">赛事数据</a>
                    <div class="ui_tip_violet_green" dateindex="4">
                        <div class="ui_tip_content">
                            <ul>
                                <li>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/record/toRecord?league_id=${league.id}')">赛程</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/integralList?league_id=${league.id}')">积分榜</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/scorerRank?league_id=${league.id}')">射手榜</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/assistsRank?league_id=${league.id}')">助攻榜</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/toPrice?league_id=${league.id}')">身价榜</a>
                                    <a class="ui_txt f12 ms" onclick="window.open('${ctx}/league/toCard?league_id=${league.id}')">红黄榜</a>
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
$(".ui_tip_violet_green[dateindex=0]").css({ "left": "-108px" });
$(".ui_tip_violet_green[dateindex=0] .arrow_border_top").css({ "left": "14%", "top": "-18px" });
$(".ui_tip_violet_green[dateindex=0] .arrow_content_top").css({ "left": "14%", "top": "-17px" });
//赛事报名
$(".ui_tip_violet_green[dateindex=1]").css({ "left": "-228px" });
$(".ui_tip_violet_green[dateindex=1] .arrow_border_top").css({ "left": "31%", "top": "-18px" });
$(".ui_tip_violet_green[dateindex=1] .arrow_content_top").css({ "left": "31%", "top": "-17px" });
//球员竞拍
$(".ui_tip_violet_green[dateindex=2]").css({ "left": "-398px" });
$(".ui_tip_violet_green[dateindex=2] .arrow_border_top").css({ "left": "47%","top":"-18px" });
$(".ui_tip_violet_green[dateindex=2] .arrow_content_top").css({ "left": "47%", "top": "-17px" });
//转会交易
$(".ui_tip_violet_green[dateindex=3]").css({ "left": "-568px" });
$(".ui_tip_violet_green[dateindex=3] .arrow_border_top").css({ "left": "65%", "top": "-18px" });
$(".ui_tip_violet_green[dateindex=3] .arrow_content_top").css({ "left": "65%", "top": "-17px" });
//赛事数据
$(".ui_tip_violet_green[dateindex=4]").css({ "left": "-738px" });
$(".ui_tip_violet_green[dateindex=4] .arrow_border_top").css({ "left": "82%", "top": "-18px" });
$(".ui_tip_violet_green[dateindex=4] .arrow_content_top").css({ "left": "82%", "top": "-17px" });
</script>