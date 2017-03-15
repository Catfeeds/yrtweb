<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-球员列表</title>
<c:set var="now" value="<%=new java.util.Date()%>" />
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link href="${ctx}/resources/js/Canlendar/ccCanlendar.css" rel="stylesheet">
</head>
<body>
	<div class="trial" style="display: none;">
 		<form id="trialFrom" action="${ctx}/player/saveTrial" method="post">
 		<input type="hidden" name="user_id" value="${oth_user_id}" />
        <table>
            <tr>
                <td class="r"><span>试训人：</span></td>
                <td><span data-id="usernick"></span></td>
            </tr>
            <tr>
                <td class="r"><span>试训时间：</span></td>
                <td><input id="trial_tdate" name="tdate" class="form-control" type="text" value="" valid="require" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="r"><span>试训地点：</span></td>
                <td><input type="text" name="trail_position" valid="require" value="" /></td>
            </tr>
            <tr>
                <td class="r" valign="top"><span>其他：</span></td>
                <td><textarea name="trail_other"></textarea></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="button" onclick="$.ajaxSubmit('#trialFrom','#trialFrom',trialFormHandler)" value="确定" /><input type="button" onclick="trialHide()" value="取消" class="ml65"/>
                </td>
            </tr>
        </table>
        </form>
        <div class="clearit"></div>
    </div>
	<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航-->
        <%@ include file="../common/naver.jsp" %>  
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <div class="player clearfix">
                    <div class="player_se">
                    	<form action="" method="post" id="searchForm">
	                        <ul class="filter">
	                        	<li class="clearfix">
	                                <div class="f_title">
	                                    <span>&emsp;&emsp;&emsp;&emsp;名称：</span>
	                                </div>
	                                <div class="filters ml10">
	                                    <input type="text" name="usernick" value="${usernick}" style="background:transparent;color: #fff;margin-top:6px;" />
	                                </div>
	                            </li>
	                            <li class="clearfix">
	                                <div class="f_title">
	                                    <span>球员综合评分：</span>
	                                </div>
	                                <div class="filters ml10" style="width:500px;">
	                                   <input type="text" name="begin_score" value="" style="background:transparent;color: #fff;" />
	                                   ~
	                                   <input type="text" name="end_score" value="" style="background:transparent;color: #fff;" />
	                                </div>
	                            </li>
	                            <li class="clearfix">
	                                <div class="f_title">
	                                    <span>&emsp;&emsp;场上位置：</span>
	                                </div>
	                                <div class="filters ml10" style="margin-top:6px;">
	                                    <!-- <a href="javascript:void(0);" onclick="setCd('#position',this,'forward')">前场</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#position',this,'midfield')">中场</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#position',this,'back')">后场</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#position',this,'gk')">守门员</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#position',this,'')">不限</a>
	                                    <input type="hidden" id="position" name="position" value=""/> -->
	                                    <select name="position" style="width:80px;">	
				                            <option value="">请选择</option>
				                        	<optgroup label="前场位置">
				                                <option value="rw">右边锋</option>
				                                <option value="lw">左边锋</option>
				                                <option value="st">中锋</option>
				                            </optgroup>
				                            <optgroup label="中场位置">
				                                <option value="cam">前腰</option>
				                                <option value="cdm">后腰</option>
				                                <option value="lm">左前卫</option>
				                                <option value="rm">右前卫</option>
				                                <option value="cm">中前卫</option>  
				                            </optgroup>
				                            <optgroup label="后场位置">
				                                <option value="lb">左后卫</option>
				                                <option value="cb">中后卫</option>
				                                <option value="rb">右后卫</option>
				                            </optgroup>
				                            <optgroup label="守门">
				                                <option value="gk">守门员</option>
				                            </optgroup>
				                    	</select>
	                                </div>
	                                <div class="f_title ml40" style="float: left;">
	                                    <span>&emsp;常踢球时间：</span>
	                                </div>
	                                <div class="filters" style="float: left;margin-top:6px;">
	                                    <!-- <a href="javascript:void(0);" onclick="setCd('#time_period',this,'1')">周末</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#time_period',this,'2')">非周末</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#time_period',this,'')">不限</a> -->
	                                    <yt:dictSelect name="time_period" nodeKey="tp_time" value="" style="width:80px;"></yt:dictSelect>
										<!-- <input type="hidden" id="time_period" name="time_period" value=""/> -->
	                                </div>
	                                <div class="f_title ml40" style="float: left;">
	                                    <span>&emsp;常参与赛制：</span>
	                                </div>
	                                <div class="filters" style="float: left;margin-top:6px;">
	                                   <!--  <a href="javascript:void(0);" onclick="setCd('#ball_format',this,'5')">5人制</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#ball_format',this,'7')">7人制</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#ball_format',this,'7')">8人制</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#ball_format',this,'11')">11人制</a>
	                                    <a href="javascript:void(0);" onclick="setCd('#time_period',this,'')">不限</a> -->
	                                    <yt:dictSelect name="ball_format" nodeKey="ball_format" value="" style="width:80px;"></yt:dictSelect>
	                                </div>
	                                <a href="javascript:void(0);" id="showBtn" style="color: yellow;margin-left: 13px;" class="ml10">更多选项</a>
	                            </li>
	                            <li class="clearfix hide">
	                                <div class="f_title">
	                                    <span>&emsp;&emsp;&emsp;&emsp;年龄：</span>
	                                </div>
	                                <div class="filters">
	                                     <input type="text" name="begin_age" value="" style="background:transparent;color: #fff;margin-left: 10px;" />
	                                   ~
	                                   <input type="text" name="end_age" value="" style="background:transparent;color: #fff;" />
	                                </div>
	                            </li>
	                            <li class="clearfix hide mt5">
	                                <div class="f_title">
	                                    <span>&emsp;&emsp;所属城市：</span>
	                                </div>
	                                <div class="filters ml10">
	                                    <select id="s_province" name="province"></select>&nbsp;
	                                    <select id="s_city" name="city"></select>&nbsp;
	                                </div>
	                            </li>
	                            <li class="clearfix mt5 hide">
	                                <div class="f_title">
	                                    <span>&emsp;所属俱乐部：</span>
	                                </div>
	                                <div class="filters ml10">
	                                    <input type="text" name="t_name" value="" style="background:transparent;color: #fff;" />
	                                </div>
	                            </li>
	                            
	                            <li class="clearfix mt5 ml15">
	                                <input type="button" class="ms f14 tools_btn" style="padding:3px 13px;" value="搜索" onclick="userSearch(0)"/>
	                            </li>
	                        </ul>
                        </form>
                    </div>
                    <div id="userlist">
                    	
	                </div>    
                    <div class="clearit"></div>
                  <!--   <div id="Pagination"></div>
					<div><small>共计：<span id="total" class="total"></span>条</small></div> -->
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/js/jquery.pagination.js"></script>
    <script src="${ctx}/resources/js/area.js"></script>
    <script src="${ctx}/resources/js/Utils.js"></script>
    <script src="${ctx}/resources/js/own/playerlist.js"></script>
    <script src="${ctx}/resources/js/mouse.js"></script>
<script src="${ctx}/resources/js/Canlendar/ccCanlendar.js"></script>
        <script type="text/javascript">
        jQuery.fn.center = function () {
            this.css("position", "absolute");
            this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
            this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
            return this;
        }
        $(".screening").center();

        new PCAS('province', 'city');

        $("#showBtn").click(function () {
            if ($(".hide").is(":hidden")) {
                $(".hide").show();
                $("#showBtn").html("收起选项");
            } else {
                $(".hide").hide();
                $("#showBtn").html("更多选项");
            }

        })
        
        $("#trial_tdate").ccCanlendar({
	    	iniValue:false,
	    	startYear:1970,
	    	hasHourPanel:false,
	    	hasMinitePanel:false,
	    	autoSetMinLimit:false,
	    	showNextMonth:false,
	    	minLimit:'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" />'
	    });

    </script>
</body>
</html>