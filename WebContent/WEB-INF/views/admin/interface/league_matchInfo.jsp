<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
    <style>
        body {
        
            background: url(${ctx}/resources/admin/img/dbg.jpg) repeat;
        }

        .count {
            width: 100%;
            padding-bottom: 25px;
            color: #646464;
        }

            .count .title {
                width: 100%;
                height: 35px;
                line-height: 35px;
                background: #fff;
                border: 1px solid #ddd;
                border-bottom: none;
                color: #aaa;
                text-shadow: 0 1px 1px #fff;
            }

        .count_content {
            width: 100%;
            padding-bottom: 35px;
            border: 1px solid #ddd;
        }

            .count_content .ycls {
                width: 50%;
                margin: 40px auto 20px;
                text-align: center;
            }

        .gains {
           position:relative;
            width: 720px;
            margin: 0 auto;
        }

        .home_team, .vs_score, .guest_team {
            float: left;
        }

        .home_team, .guest_team {
            width: 210px;
            display: table-cell;
            text-align: center;
            vertical-align: middle;
        }

            .home_team img, .guest_team img {
                display: inline-block;
                border-radius: 6px;
                width: 80px;
                height: 80px;
            }

        .vs_score {
            width: 290px;
            height: 130px;
            background: url(${ctx}/resources/images/vs-g.png) no-repeat center 64%;
            text-align: center;
        }

            .vs_score dl {
                margin-top: 15px;
                font-size: 16px;
                line-height: 24px;
                font-family: "Microsoft YaHei";
            }

        

        .scoreline {
            width: 40px;
            height: 40px;
            line-height: 40px;
            font-size: 20px;
            color: #646464;
            margin-top: 45px;
        }

        .player_library {
            position:relative;
            width: 928px;
            margin: 70px auto;
            padding-top:30px;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
        }

        .home_plyaer, .guest_player {
            float: left;
            width: 430px;
            padding-top: 10px;
            padding-bottom: 10px;
            border-right: 1px solid #ddd;
        }

            .home_plyaer table {
                width:97%;
                text-align: center;
            }

                .home_plyaer table td {
                    padding-top: 5px;
                    padding-bottom: 5px;
                }

            .guest_player table {
                 width:97%;
                text-align: center;
            }

                .guest_player table td {
                    padding-top: 5px;
                    padding-bottom: 5px;
                }

        .home_num {
            display: inline-block;
            text-align: center;
            width: 31px;
            height: 23px;
            line-height: 23px;
            color: #fff;
            background: url(${ctx}/resources/images/jersey_two.png) -3px -14px no-repeat;
        }

        .guest_num {
            display: inline-block;
            text-align: center;
            width: 31px;
            height: 23px;
            line-height: 23px;
            color: #fff;
            background: url(${ctx}/resources/images/jersey_two.png) -3px -60px no-repeat;
        }

        .data_sheet {
            position: relative;
            width: 930px;
            margin: 30px auto;
        }

        .data_l {
            float: left;
            width: 465px;
        }

        .data_r {
            float: right;
            width: 465px;
        }

        .green_progress_bg {
            float: right;
            width: 380px;
            height: 12px;
            margin-top: 8px;
            background: url(${ctx}/resources/images/nlbg_l.png) no-repeat;
        }

        .green_progress {
            float: right;
            width: 170px;
            height: 9px;
            margin-top: -2px;
            background: url(${ctx}/resources/images/data_l.jpg) repeat-x;
            border-radius: 4px 0 0 4px;
        }

        .yellow_progress_bg {
            float: left;
            width: 380px;
            height: 12px;
            margin-top: 8px;
            background: url(${ctx}/resources/images/nlbg_l.png) no-repeat;
        }

        .yellow_progress {
            float: left;
            width: 170px;
            height: 9px;
            margin-top: -2px;
            background: url(${ctx}/resources/images/data_r.jpg) repeat-x;
            border-radius: 0 4px 4px 0;
        }

        .data_name {
            position: absolute;
            margin-left: 430px;
            top: -35px;
        }

            .data_name li {
                text-align: center;
                line-height: 60px;
            }

        .checkbtn {
            padding: 7px 15px;
            background: #eb6100;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        .btn-success {
            padding: 5px 15px;
            background: #5cb85c;
            border-color: #4cae4c;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        .num_txt {
            width: 36px;
            height: 28px;
        }
        .name_txt {
            width: 65px;
            height: 28px;
        }
        .p_txt {
            width: 40px;
            height: 30px;
            font-size: 12px;
        }

        .t1 {
            width: 160px;
        }
        .scoreline {
    width: 50px;
    height: 50px;
    line-height: 40px;
    font-size: 20px;
    color: #ba9866;
    margin-top: 45px;
        text-align: center;
}
.qyinfo{
   font-size: 12px;
   color: #646464;
}
  .savebtn{
    padding: 6px 12px;
    color: #fff;
    background: #4ab4e8;
    background: -webkit-gradient(linear,left top,left bottom,from(#77c7ee),to(#4ab4e8));
    background: -webkit-linear-gradient(top,#77c7ee,#4ab4e8);
    background: -moz-linear-gradient(top,#77c7ee,#4ab4e8);
    background: -o-linear-gradient(top,#77c7ee,#4ab4e8);
    background: -ms-linear-gradient(top,#77c7ee,#4ab4e8);
    background: linear-gradient(top,#77c7ee,#4ab4e8);
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    border: none;
    cursor: pointer;
  }
  .one{
    position: absolute;
    right:-150px;
  }
  .two{
    position: absolute;
    right:-49px;
    top:-2px;
  }
  .three{
    position: absolute;
    right:-49px;
    top:-72px;
  }
  .btn_div {
            width: 80%;
            margin: 60px auto 0;
            text-align: center;
        }
    </style>
</head>
<body>
	<div class="masker"></div>
	<div>
		<hr>
		<ul class="breadcrumb">
			<li><a>接口管理</a></li>
			<li><a>球队比赛数据管理</a></li>
		</ul>
		<hr>
	</div>
    <form id="matchForm" action="" method="post">
    <div class="count">
        <div class="title">
            <span class="f18 ms ml10"></span>
        </div>
        <div class="count_content">
            <dl class="ycls">
                <dt><span class="f30 ms">
                	<yt:id2NameDB beanId="leagueService" id="${qMatchInfo.league_id}"></yt:id2NameDB>
                	<c:choose>
                		<c:when test="${!empty qMatchInfo.record_id}">
                			<span style="color: red;">（已关联赛事）</span>
                		</c:when>
                		<c:otherwise>
                			<span style="color: red;">（未关联赛事）</span>
                		</c:otherwise>
                	</c:choose>
                		比分：${h_qSummary.score} VS ${v_qSummary.score}
                	</span>
                </dt>
            </dl>
	            <div class="gains">
	            	<input type="hidden" name="id" id="id" value="${qMatchInfo.id}"/>
	               
	                <div class="home_team">
	                    <dl>
	                        <dt><span class="f18 ms">主队</span>  
	                        <a onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/interface/leaguePlayers',searchForm:'#searchForm'},{q_match_id:'${qMatchInfo.id}',teaminfo_id:'${h_team.id}',team_status:'${h_qSummary.team_status}',league_id:'${qMatchInfo.league_id}'});" style="cursor: pointer;" class="qyinfo">查看球员详情</a></dt>
	                        <dd class="mt15">
	                            <img src="${el:headPath()}${h_team.logo}" id="h_logo" alt="球队LOGO" />
	                        </dd>
	                        <dd class="mt20">
	                        	<input type="button" name="name" value="选择" class="btn-success" onclick="select_team_info('h_team_id','h_team');"/>
	                        	<input type="text" name="h_team" id="h_team" value="${h_team.name}" class="ml5" />
	                        	<input type="hidden" name="h_team_id" id="h_team_id" value="${h_team.id}">
	                        	<c:choose>
			                		<c:when test="${!empty qMatchInfo.h_team_id}">
			                			<span style="color: red;">（已关联主队）</span>
			                		</c:when>
			                		<c:otherwise>
			                			<span style="color: red;">（未关联主队）</span>
			                		</c:otherwise>
			                	</c:choose>
	                        </dd>
	                    </dl>
	                </div>
	                <div class="vs_score">
	                   	<input type="text" name="jinqiu_num" value="${h_qSummary.jinqiu_num}" class="scoreline ms pull-left" readonly="readonly" alt="进球"/>
	                    <input type="text" name="jinqiu_num" value="${v_qSummary.jinqiu_num}" class="scoreline ms pull-right" readonly="readonly" alt="进球"/>
	                    <div class="clearit"></div>
	                    <dl class="mt15 f16 ms">
	                        <dd>
	                        	<span>时间</span>
	                        	<input type="text" name="date_time" class="ui_timepicker ml10" 
	                        		value="<fmt:formatDate value='${qMatchInfo.date_time}' pattern='yyyy-MM-dd HH:mm:ss'/>">
	                        </dd>
	                        <dd class="mt10">
	                        	<span>场地</span>
	                        	<input type="text" name="space_address" value="${qMatchInfo.space_address}" class="ml10" />
	                        </dd>
	                    </dl>
	                </div>
	                <div class="guest_team">
	                    <dl>
	                        <dt><span class="f18 ms">客队</span>  
	                        <a onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/interface/leaguePlayers',searchForm:'#searchForm'},{q_match_id:'${qMatchInfo.id}',teaminfo_id:'${v_team.id}',team_status:'${v_qSummary.team_status}',league_id:'${qMatchInfo.league_id}'});" style="cursor: pointer;" class="qyinfo">查看球员详情</a></dt>
	                        <dd class="mt15">
	                            <img src="${el:headPath()}${v_team.logo}" alt="球队LOGO" />
	                        </dd>
	                        <dd class="mt20">
	                        	<input type="button" name="name" value="选择" class="btn-success" onclick="select_team_info('v_team_id','v_team');"/>
	                        	<input type="text" name="v_team" id="v_team" value="${v_team.name}" class="ml5" />
	                        	<input type="hidden" name="v_team_id" id="v_team_id" value="${v_team.id}">
	                        	<c:choose>
			                		<c:when test="${!empty qMatchInfo.v_team_id}">
			                			<span style="color: red;">（已关联客队）</span>
			                		</c:when>
			                		<c:otherwise>
			                			<span style="color: red;">（未关联客队）</span>
			                		</c:otherwise>
			                	</c:choose>
	                        </dd>
	                    </dl>
	                </div>	
	                <div class="clearit"></div>
	            </div>
            <%-- <div class="player_library">
            
                <div class="home_plyaer">
                    <table>
                    	<caption>进球人员</caption>
                        <tr>
                            <td>号码</td>
                            <td>姓名</td>
                            <td>时间</td>
                        </tr>
                        <c:forEach items="${scoreList}" var="s">
                        	<tr>
	                            <td></td>
	                            <td><yt:id2NameDB beanId="userService" id="${s.user_id}"></yt:id2NameDB> </td>
	                            <td>${h.jinqiu_time}</td>
                        	</tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="guest_player" style="border: none;">
                    <table>
                        <table>
                    	<caption>进球人员</caption>
                        <tr>
                            <td>号码</td>
                            <td>姓名</td>
                            <td>时间</td>
                        </tr>
                        <c:forEach items="${v_scoreList}" var="v">
                        	<tr>
	                            <td></td>
	                            <td><yt:id2NameDB beanId="userService" id="${v.user_id}"></yt:id2NameDB> </td>
	                            <td>${v.jinqiu_time}</td>
                        	</tr>
                        </c:forEach>
                    </table>
                    </table>
                </div>
                <div class="clearit"></div>
            </div> --%>

            <div class="data_sheet">
           
                <ul class="data_name">
                	<li><span>进球数</span></li>
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
                <input type="hidden" name="matchId" id="matchId" value="${qMatchInfo.id}"/>
                <div class="data_l">
                	<!--比分左-->
                    <div class="score_left">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="hidden" name="summarys[0].id" value="${h_qSummary.id}"/>
                        <input type="hidden" name="summarys[0].q_match_id" value="${h_qSummary.q_match_id}"/>
                        <input type="hidden" name="summarys[0].team_id" value="${h_qSummary.team_id}"/>
                        <input type="hidden" name="summarys[0].teaminfo_id" value="${h_qSummary.teaminfo_id}"/>
                        <input type="hidden" name="summarys[0].team_status" value="${h_qSummary.team_status}"/>
                        <input type="hidden" name="summarys[0].score" value="${h_qSummary.score}"/>
                        <input type="text" name="summarys[0].jinqiu_num" value="${h_qSummary.jinqiu_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--控球率左-->
                    <div class="ball_control_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].control_time" value="${h_qSummary.control_time}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--射门左-->
                    <div class="shot_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].shemen_num" value="${h_qSummary.shemen_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--射正左-->
                    <div class="shot_true_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].shezheng_num" value="${h_qSummary.shezheng_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--射门准确率左-->
                    <div class="shot_exact_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].shezheng_lv" value="${h_qSummary.shezheng_lv}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--角球左-->
                    <div class="corner_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].jiaoqiu_num" value="${h_qSummary.jiaoqiu_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--任意球左-->
                    <div class="free_kick_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].renyi_num" value="${h_qSummary.renyi_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--抢断左-->
                    <div class="steals_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].qiangduan_num" value="${h_qSummary.qiangduan_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--扑救左-->
                    <div class="rescues_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].pujiu_num" value="${h_qSummary.pujiu_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--犯规左-->
                    <div class="foul_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].fangui_num" value="${h_qSummary.fangui_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--黄牌左-->
                    <div class="yellow_card_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].huangpai_num" value="${h_qSummary.huangpai_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="clearit"></div>
                    </div>
                    <!--红牌左-->
                    <div class="red_card_left mt30">
                        <div class="green_progress_bg">
                            <div class="green_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <input type="text" name="summarys[0].hongpai_num" value="${h_qSummary.hongpai_num}" class="pull-right f16 ms mr30 p_txt" />

                        <div class="clearit"></div>
                    </div>
                </div>
                <div class="data_r">
                	<!--比分右-->
                    <div class="score_left">
                    	<input type="hidden" name="summarys[1].id" value="${v_qSummary.id}"/>
                        <input type="hidden" name="summarys[1].q_match_id" value="${v_qSummary.q_match_id}"/>
                        <input type="hidden" name="summarys[1].team_id" value="${v_qSummary.team_id}"/>
                        <input type="hidden" name="summarys[1].teaminfo_id" value="${v_qSummary.teaminfo_id}"/>
                        <input type="hidden" name="summarys[1].team_status" value="${v_qSummary.team_status}"/>
                        <input type="hidden" name="summarys[1].score" value="${v_qSummary.score}"/>
                        <input type="text" name="summarys[1].jinqiu_num" value="${v_qSummary.jinqiu_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <div class="clearit"></div>
                    </div>
                    <!--控球率右-->
                    <div class="ball_control_left mt30">
                        <input type="text" name="summarys[1].control_time" value="${v_qSummary.control_time}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>

                        <div class="clearit"></div>
                    </div>
                    <!--射门右-->
                    <div class="shot_left mt30">
                        <input type="text" name="summarys[1].shemen_num" value="${v_qSummary.shemen_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>

                        <div class="clearit"></div>
                    </div>
                    <!--射正右-->
                    <div class="shot_true_left mt30">
                        <input type="text" name="summarys[1].shezheng_num" value="${v_qSummary.shezheng_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <div class="clearit"></div>
                    </div>
                    <!--射门准确率右-->
                    <div class="shot_exact_left mt30">
                        <input type="text" name="summarys[1].shezheng_lv" value="${v_qSummary.shezheng_lv}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <div class="clearit"></div>
                    </div>
                    <!--角球右-->
                    <div class="corner_left mt30">
                        <input type="text" name="summarys[1].jiaoqiu_num" value="${v_qSummary.jiaoqiu_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>

                        <div class="clearit"></div>
                    </div>
                    <!--任意球右-->
                    <div class="free_kick_left mt30">
                        <input type="text" name="summarys[1].renyi_num" value="${v_qSummary.renyi_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>

                        <div class="clearit"></div>
                    </div>
                    <!--抢断右-->
                    <div class="steals_left mt30">
                        <input type="text" name="summarys[1].qiangduan_num" value="${v_qSummary.qiangduan_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>

                        <div class="clearit"></div>
                    </div>
                    <!--扑救右-->
                    <div class="rescues_left mt30">
                        <input type="text" name="summarys[1].pujiu_num" value="${v_qSummary.pujiu_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>

                        <div class="clearit"></div>
                    </div>
                    <!--犯规右-->
                    <div class="foul_left mt30">
                        <input type="text" name="summarys[1].fangui_num" value="${v_qSummary.fangui_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>

                        <div class="clearit"></div>
                    </div>
                    <!--黄牌左-->
                    <div class="yellow_card_left mt30">
                        <input type="text" name="summarys[1].huangpai_num" value="${v_qSummary.huangpai_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>

                        <div class="clearit"></div>
                    </div>
                    <!--红牌左-->
                    <div class="red_card_left mt30">
						<input type="text" name="summarys[1].hongpai_num" value="${v_qSummary.hongpai_num}" class="pull-right f16 ms mr30 p_txt" />
                        <div class="yellow_progress_bg">
                            <div class="yellow_progress"></div>
                            <div class="clearit"></div>
                        </div>
                        <div class="clearit"></div>
                    </div>
                </div>

                <div class="clearit"></div>
            </div>
            <div class="btn_div">
                <input type="button" name="name" value="审核通过" class="btn btn-info" onclick="reviewDatas('${qMatchInfo.id}');"/>
                <input type="button" name="name" value="保存" class="btn btn-info" onclick="updateQMatch();"/>
                <input type="button" name="name" value="返回" class="btn btn-info" onclick="ListPage.enter({context:'#content',url:'/admin/interface/leagueCount?league_id=${qMatchInfo.league_id}',searchForm:'#searchForm'});"/>
                <input type="button" name="notice" class="btn btn-danger" style="margin-top: 4px;" value="删除数据" onclick="deleteMatchInfo('${qMatchInfo.id}')"/>
            </div>
        </div>
    </div>
	</form>
    <script type="text/javascript">
	   $(".ui_timepicker").datetimepicker({
		    //showOn: "button",
		    //buttonImage: "./css/images/icon_calendar.gif",
		    //buttonImageOnly: true,
		    showSecond: true,
		    timeFormat: 'hh:mm:ss',
		    stepHour: 1,
		    stepMinute: 1,
		    stepSecond: 1
		});
	   
	   var iframeTeamInfo;
	   function select_team_info(dom_id,dom_name){
	   	var league_id = $("#league_id").val();
	   	var group_id = $("#group_sel").val();
	   	iframeTeamInfo = layer.open({
	   	    type: 2,
	   	    title: '选择俱乐部',
	   	    shadeClose: true,
	   	    shade: [0],
	   	    area: ['1330px', '640px'],
	   	    content: base+'/admin/interface/dialog?dom_id='+dom_id+'&dom_name='+dom_name+'&league_id='+league_id+"&group_id="+group_id //iframe的url
	   	}); 
	   }

	   function changeTeam(tid,tname,dom_id,dom_name){
	   	layer.close(iframeTeamInfo);
	   	$("#"+dom_id).val(tid);
	   	$("#"+dom_name).val(tname);
	   }
	   
	   function updateQMatch(){
		   $.ajax({
       		type: 'POST',
       		url: "${ctx}/admin/interface/updateMatchInfo",
       		data: $("#matchForm").serializeObject(),
       		cache: false,
       		beforeSend:function(){
       			var h = document.body.clientHeight;   
		       		 $("<div></div>").css({display:"block",width:"100%",height:h}).appendTo("body");   
		       		 $("<div></div>").html("正在保存数据，请稍候。。。").appendTo("body").css({display:"block",  
		       		  left:($(document.body).outerWidth(true) - 190) / 2,  
		       		  top:(h - 45) / 2});
    		},
       		success: function(result){
    			$('.datagrid-mask-msg').remove();  
    			$('.datagrid-mask').remove();	
       			if(result.state=='error'){
       				layer.msg(result.message.error[0],{icon: 2});
       			}else{
       				layer.msg("保存成功",{icon: 1});
       			}
       		},
       		error: $.ajaxError
       	});
	   }
	   
	   function updateQSummary(){
		   $.ajax({
       		type: 'POST',
       		url: "${ctx}/admin/interface/updateQSummary",
       		data: $("#summerForm").serializeObject(),
       		cache: false,
       		success: function(result){
       			if(result.state=='error'){
       				layer.msg(result.message.error[0],{icon: 2});
       			}else{
       				layer.msg("保存成功",{icon: 1});
       				
       			}
       		},
       		error: $.ajaxError
       	});
	   }
	   /**审核数据*/
	     function reviewDatas(id){
	    	 if(id == ''){
	    		 layer.msg("接口联赛id不能为空",{icon: 1});
	    		 return;
	    	 }
	    	 $.ajaxSec({
					type: 'POST',
					url: '${ctx}/admin/interface/reviewQMatchInfo',
					data: {id: id},
					success: function(data){
						if (data.state=='success') {
							layer.msg("数据审核成功",{icon: 1});
							//ListPage.paginate(ListPage.currentPage);
							ListPage.enter({context:'#content',url:'/admin/interface/leagueCount?league_id=${qMatchInfo.league_id}',searchForm:'#searchForm'});
						}else{
							layer.msg(data.message.error[0],{icon: 2});
							ListPage.paginate(ListPage.currentPage);
						}
				    },
				   error: $.ajaxError
			  });
	     }
	   
	     /*
	      *删除接口赛事相关信息
	      */
	      function deleteMatchInfo(matchId){
	     	 if(matchId == ''){
	     		 layer.msg("接口联赛id不能为空",{icon: 1});
	     		 return;
	     	 }
	     	 var ifdelete = confirm("你确定要删除该数据");
	     	 if(ifdelete){
	     		$.ajaxSec({
	 				type: 'POST',
	 				url: base+'/admin/interface/deleteQMatchInfo',
	 				data: {matchId: matchId},
	 				success: function(data){
	 					if (data.state=='success') {
	 						layer.msg("数据删除成功",{icon: 1});
	 						ListPage.paginate(ListPage.currentPage);
	 					}else{
	 						layer.msg("数据删除失败",{icon: 2});
	 						ListPage.paginate(ListPage.currentPage);
	 					}
	 			    },
	 			   error: $.ajaxError
	 		  });
	     	 }else{
	     		 return;
	     	 }
	     	 
	      }
   </script> 
</body>
</html>
