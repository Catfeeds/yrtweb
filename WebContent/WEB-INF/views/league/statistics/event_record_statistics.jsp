<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../common/common.jsp" %>
    <title>技术统计</title>
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" />	
	<link href="${ctx}/resources/css/master.css" rel="stylesheet" />	
	<link href="${ctx}/resources/css/league.css" rel="stylesheet" />	
</head>
<body>
    <div class="warp">
         <!--头部-->
         <%@ include file="../../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>    
        <div class="wrapper" style="margin-top: 80px;">
            <div class="count">
                <div class="title">
                <div class="pull-left">
                   <span class="f18 ms ml10"><a href="${ctx}/league/index?league_id=${eventRecord.league_id}" class="text-white">联赛首页</a>&emsp;》&emsp;
                    						  <a href="${ctx}/league/eventRecords?league_id=${eventRecord.league_id}" class="text-white">全部赛程</a>&emsp;》&emsp;</span>
                    <span class="ms">第${eventRecord.rounds}轮 ${h_team.name} VS ${v_team.name} 技术统计</span>
                </div>
                <div class="pull-right mt5">
                    <span class="jiathis_style_24x24">
                    <a class="jiathis_button_tsina"></a>
                    <a class="jiathis_button_tqq"></a>
                    <a class="jiathis_button_weixin"></a>
                    <a class="jiathis_button_renren"></a>
                </span>
                <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
                </div>    
                </div>
                <div class="count_content">
                    <dl class="ycls">
                        <dt><span class="f30 ms">
                        		<yt:id2NameDB beanId="leagueService" id="${eventRecord.league_id}"></yt:id2NameDB> 
                        	</span></dt>
                    </dl>
                    <div class="gains">
                        <div class="home_team">
                            <dl>
                                <dt><span class="f18 ms">主队</span></dt>
                                <dd class="mt15">
                                    <img src="${el:headPath()}${h_team.logo}" alt="Alternate Text" />
                                </dd>
                                <dd class="mt20"><a href="${ctx}/team/tdetail/${v_team.id}" class="text-white"><span class="f14 ms">${h_team.name}</span></a></dd>
                            </dl>
                        </div>
                        <div class="vs_score">
                            <span class="scoreline ms pull-left">${h_Qsummary.score}</span>
                            <span class="scoreline ms pull-right">${v_Qsummary.score}</span>
                            <div class="clearit"></div>
                            <dl class="mt15 f16 ms">
                                <dt><span><fmt:formatDate value='${qMathInfo.date_time}' pattern='yyyy-MM-dd HH:mm:ss'/></span></dt>
                                <dd><span>${qMathInfo.space_address}</span></dd>
                            </dl>
                        </div>
                        <div class="guest_team">
                            <dl>
                                <dt><span class="f18 ms">客队</span></dt>
                                <dd class="mt15">
                                    <img src="${el:headPath()}${v_team.logo}" alt="Alternate Text" />
                                </dd>
                                <dd class="mt20"><a href="${ctx}/team/tdetail/${v_team.id}" class="text-white"><span class="f14 ms">${v_team.name}</span></a></dd>
                            </dl>
                        </div>
                        <div class="clearit"></div>
                    </div>

                    <div class="player_library">
                        <div class="home_plyaer">
                            <table>
	                           	 <c:forEach items="${h_map}" var="h" varStatus="i">
	                           	 	<c:set var="key" value="${fn:split(h.key,',')}"/>
									<tr>
	                                    <td valign="top" class="text-center">
	                                        <span class="home_num">${key[1]}</span>
	                                        <span><a href="${ctx}/center/${key[0]}" class="text-white"><yt:id2NameDB beanId="userService" id="${key[0]}"></yt:id2NameDB></a></span>
	                                    </td>
	                                    <td class="text-left" style="width: 70%;">
											<c:forEach items="${h.value}" var="hv">
		                                        <span class="ml5">${fn:substringBefore(hv.jinqiu_time,":")}'</span>
											</c:forEach>
	                                    </td>
	                               	</tr>						                            	 	
	                           	 </c:forEach>
	                           	 <c:forEach items="${h_wulongData}" var="w" >	
	                           		<tr>
	                                    <td valign="top" class="text-center">
	                                        <span class="home_num">${w.number}</span>
	                                        <span><a href="${ctx}/center/${w.user_id}" class="text-white">
	                                        	<yt:id2NameDB beanId="userService" id="${w.user_id}"></yt:id2NameDB></a></span>
	                                    </td>
	                                    <td class="text-left" style="width: 70%;">
		                               		<span class="ml5">${fn:substringBefore(w.jinqiu_time,":")}'（QG）</span>
	                                    </td>
	                               	</tr>
	                           	 </c:forEach>
                            </table>
                        </div>
                        <div class="guest_player" style="border: none;">
                            <table>
                            	<c:forEach items="${v_map}" var="v" varStatus="i">
	                           	 	<c:set var="key" value="${fn:split(v.key,',')}"/>
									<tr>
	                                    <td valign="top" class="text-left">
	                                        <span class="guest_num">${key[1]}</span>
	                                        <span><a href="${ctx}/center/${key[0]}" class="text-white"><yt:id2NameDB beanId="userService" id="${key[0]}"></yt:id2NameDB></a></span>
	                                    </td>
	                                    <td class="text-left" style="width: 70%;">
											<c:forEach items="${v.value}" var="vv">
		                                        <span class="ml5">${fn:substringBefore(vv.jinqiu_time,":")}'</span>
											</c:forEach>
	                                    </td>
	                               	</tr>						                            	 	
	                           	 </c:forEach>
	                           	 <c:forEach items="${h_wulongData}" var="w" >	
	                           		<tr>
	                                    <td valign="top" class="text-left">
	                                        <span class="guest_num">${w.number}</span>
	                                        <span><a href="${ctx}/center/${w.user_id}" class="text-white">
	                                        	<yt:id2NameDB beanId="userService" id="${w.user_id}"></yt:id2NameDB></a></span>
	                                    </td>
	                                    <td class="text-left" style="width: 70%;">
		                               		<span class="ml5">${fn:substringBefore(w.jinqiu_time,":")}'（QG）</span>
	                                    </td>
	                               	</tr>
	                           	 </c:forEach>
                            </table>
                        </div>
                        <div class="clearit"></div>
                    </div>
             
                    <div class="data_sheet">
                        <ul class="data_name">
                            <li><span>控球率</span></li>
                            <li><span>射门</span></li>
                            <li><span>射正</span></li>
                            <li><span>射门准确率</span></li>
                            <li><span>角球</span></li>
                            <li><span>任意球</span></li>
                            <li><span>抢断</span></li>
                            <li><span>扑救</span></li>
                            <li><span>犯规</span></li>
                            <li><span>黄牌</span></li>
                            <li><span>红牌</span></li>
                        </ul>
                        <div class="data_l">
                            <!--控球率左-->
                            <div class="ball_control_left">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.control_time eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.control_time*100/(h_Qsummary.control_time+v_Qsummary.control_time)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">
                                	<fmt:formatNumber value="${h_Qsummary.control_time*100/(h_Qsummary.control_time+v_Qsummary.control_time)}" pattern="#0"></fmt:formatNumber>%
                                </span>
                                <div class="clearit"></div>
                            </div>
                            <!--射门左-->
                            <div class="shot_left mt30">
                                <div class="green_progress_bg">
                                    <c:choose>
                                		<c:when test="${h_Qsummary.shemen_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.shemen_num*100/(h_Qsummary.shemen_num+v_Qsummary.shemen_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.shemen_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--射正左-->
                            <div class="shot_true_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.shezheng_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.shezheng_num*100/(h_Qsummary.shezheng_num+v_Qsummary.shezheng_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.shezheng_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--射门准确率左-->
                            <div class="shot_exact_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.shezheng_lv eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:${h_Qsummary.shezheng_lv}%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.shezheng_lv}%</span>
                                <div class="clearit"></div>
                            </div>
                            <!--角球左-->
                            <div class="corner_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.jiaoqiu_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.jiaoqiu_num*100/(h_Qsummary.jiaoqiu_num+v_Qsummary.jiaoqiu_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.jiaoqiu_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--任意球左-->
                            <div class="free_kick_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.renyi_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.renyi_num*100/(h_Qsummary.renyi_num+v_Qsummary.renyi_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.renyi_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--抢断左-->
                            <div class="steals_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.qiangduan_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.qiangduan_num*100/(h_Qsummary.qiangduan_num+v_Qsummary.qiangduan_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.qiangduan_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--扑救左-->
                            <div class="rescues_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.pujiu_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.pujiu_num*100/(h_Qsummary.pujiu_num+v_Qsummary.pujiu_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.pujiu_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--犯规左-->
                            <div class="foul_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.fangui_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.fangui_num*100/(h_Qsummary.fangui_num+v_Qsummary.fangui_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.fangui_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--黄牌左-->
                            <div class="yellow_card_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.huangpai_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.huangpai_num*100/(h_Qsummary.huangpai_num+v_Qsummary.huangpai_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.huangpai_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--红牌左-->
                            <div class="red_card_left mt30">
                                <div class="green_progress_bg">
                                	<c:choose>
                                		<c:when test="${h_Qsummary.hongpai_num eq '0'}">
                                			<div class="green_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="green_progress" style="width:<fmt:formatNumber value="${h_Qsummary.hongpai_num*100/(h_Qsummary.hongpai_num+v_Qsummary.hongpai_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr10">${h_Qsummary.hongpai_num}</span>
                                <div class="clearit"></div>
                            </div>
                        </div>
                        <div class="data_r">
                            <!--控球率右-->
                            <div class="ball_control_left">
                                <span class="pull-right f16 ms mr30">
                                	<fmt:formatNumber value="${v_Qsummary.control_time*100/(h_Qsummary.control_time+v_Qsummary.control_time)}" pattern="#0"></fmt:formatNumber>%
                                </span>
                                <div class="yellow_progress_bg">
                                	<c:choose>
                                		<c:when test="${v_Qsummary.control_time eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.control_time*100/(h_Qsummary.control_time+v_Qsummary.control_time)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>

                                <div class="clearit"></div>
                            </div>
                            <!--射门右-->
                            <div class="shot_left mt30">
                                <span class="pull-right f16 ms mr30">${v_Qsummary.shemen_num}</span>
                                <div class="yellow_progress_bg">
                                    <c:choose>
                                		<c:when test="${v_Qsummary.shemen_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                	<div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.shemen_num*100/(h_Qsummary.shemen_num+v_Qsummary.shemen_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>

                                <div class="clearit"></div>
                            </div>
                            <!--射正右-->
                            <div class="shot_true_left mt30">
                                <span class="pull-right f16 ms mr30">${v_Qsummary.shezheng_num}</span>
                                <div class="yellow_progress_bg">
                                	<c:choose>
                                		<c:when test="${v_Qsummary.shezheng_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.shezheng_num*100/(h_Qsummary.shezheng_num+v_Qsummary.shezheng_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <div class="clearit"></div>
                            </div>
                            <!--射门准确率右-->
                            <div class="shot_exact_left mt30">
                                <span class="pull-right f16 ms mr30">${v_Qsummary.shezheng_lv}%</span>
                                <div class="yellow_progress_bg">
                                    <c:choose>
                                		<c:when test="${v_Qsummary.shezheng_lv eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:${v_Qsummary.shezheng_lv}%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <div class="clearit"></div>
                            </div>
                            <!--角球右-->
                            <div class="corner_left mt30">
                                <span class="pull-right f16 ms mr30">${v_Qsummary.jiaoqiu_num}</span>
                                <div class="yellow_progress_bg">
                                    <c:choose>
                                		<c:when test="${v_Qsummary.jiaoqiu_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.jiaoqiu_num*100/(h_Qsummary.jiaoqiu_num+v_Qsummary.jiaoqiu_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                              
                                <div class="clearit"></div>
                            </div>
                            <!--任意球右-->
                            <div class="free_kick_left mt30">
                                <span class="pull-right f16 ms mr30">${v_Qsummary.renyi_num}</span>
                                <div class="yellow_progress_bg">
                                	<c:choose>
                                		<c:when test="${v_Qsummary.renyi_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.renyi_num*100/(h_Qsummary.renyi_num+v_Qsummary.renyi_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                               
                                <div class="clearit"></div>
                            </div>
                            <!--抢断右-->
                            <div class="steals_left mt30">
                                <span class="pull-right f16 ms mr30">${v_Qsummary.qiangduan_num}</span>
                                <div class="yellow_progress_bg">
                                    <c:choose>
                                		<c:when test="${v_Qsummary.qiangduan_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.qiangduan_num*100/(h_Qsummary.qiangduan_num+v_Qsummary.qiangduan_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                
                                <div class="clearit"></div>
                            </div>
                            <!--扑救右-->
                            <div class="rescues_left mt30">
                                <span class="pull-right f16 ms mr30">${v_Qsummary.pujiu_num}</span>
                                <div class="yellow_progress_bg">
                                	<c:choose>
                                		<c:when test="${v_Qsummary.pujiu_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.pujiu_num*100/(h_Qsummary.pujiu_num+v_Qsummary.pujiu_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>	
                                    <div class="clearit"></div>
                                </div>
                                
                                <div class="clearit"></div>
                            </div>
                            <!--犯规右-->
                            <div class="foul_left mt30">
                                <span class="pull-right f16 ms mr30">${v_Qsummary.fangui_num}</span>
                                <div class="yellow_progress_bg">
                                	<c:choose>
                                		<c:when test="${v_Qsummary.fangui_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.fangui_num*100/(h_Qsummary.fangui_num+v_Qsummary.fangui_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                               
                                <div class="clearit"></div>
                            </div>
                            <!--黄牌左-->
                            <div class="yellow_card_left mt30">
                                <div class="yellow_progress_bg">
                                    <c:choose>
                                		<c:when test="${v_Qsummary.huangpai_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.huangpai_num*100/(h_Qsummary.huangpai_num+v_Qsummary.huangpai_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr30">${v_Qsummary.huangpai_num}</span>
                                <div class="clearit"></div>
                            </div>
                            <!--红牌左-->
                            <div class="red_card_left mt30">
                                <div class="yellow_progress_bg">
                                   	<c:choose>
                                		<c:when test="${v_Qsummary.hongpai_num eq '0'}">
                                			<div class="yellow_progress" style="width:0%"></div>
                                		</c:when>
                                		<c:otherwise>
		                                    <div class="yellow_progress" style="width:<fmt:formatNumber value="${v_Qsummary.hongpai_num*100/(h_Qsummary.hongpai_num+v_Qsummary.hongpai_num)}" pattern="#0"></fmt:formatNumber>%"></div>
                                		</c:otherwise>
                                	</c:choose>
                                    <div class="clearit"></div>
                                </div>
                                <span class="pull-right f16 ms mr30">${v_Qsummary.hongpai_num}</span>
                                <div class="clearit"></div>
                            </div>
                        </div>
                        <div class="clearit"></div>
                    </div>
                     <label class="pull-left mt30 ml85 text-gray-s_999">本数据来源于全网足球</label>
                    <input type="button" name="name" value="查看球员数据" class="checkbtn f16 ms pull-right mr50 mt20"
                     onclick="toPlayersPage('${qMathInfo.id}','${qMathInfo.h_team_id}',1)"/>
                    <div class="clearit"></div>
                </div>
            </div>
        </div>
    </div>
<%@ include file="../../common/footer.jsp" %>
</body>

<script type="text/javascript">
function toPlayersPage(q_match_id){
	var params = "q_match_id="+q_match_id;
	window.location.href="${ctx}/league/toleaguePage?"+params;
}
</script>
</html>
