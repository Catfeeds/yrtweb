<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-球员报名</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet" />
<link href="${ctx}/resources/admin/css/chosen.min.css" rel="stylesheet">
<c:set var="now" value="<%=new java.util.Date()%>" />
</head>
<body>
	<div class="warp">
		<div class="masker"></div>
        <div class="select_jersey">
            <div class="closeBtn_1"></div>
            <h3>球衣号码选择（最多选择三个）</h3>
            <ul>
            	<c:forEach begin="0" step="1" end="99" var="num">
	                <li>
	                	<c:choose>
	                		<c:when test="${!empty leagueSign}">
			                	<div class="num <c:forEach items="${leagueSign.love_num}" var="nums"><c:if test="${nums eq num }">active</c:if></c:forEach>"><c:choose><c:when test="${num < 10 }">0${num}</c:when><c:otherwise>${num}</c:otherwise></c:choose></div>
	                		</c:when>
	                		<c:otherwise>
	                			<div class="num"><c:choose><c:when test="${num < 10 }">0${num}</c:when><c:otherwise>${num}</c:otherwise></c:choose></div>
	                		</c:otherwise>
	                	</c:choose>
	                </li>
            	</c:forEach>
                <div class="clearit"></div>
            </ul>
            <div style="width:600px;margin: 60px auto 0;text-align: center; ">
                <input type="button" name="name" value="确认" class="btn_l f18 ms" onclick="chooseNum()">
                <input type="button" name="name" value="取消" class="btn_g f18 ms" id="cannel">
            </div>
        </div>
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
	     <div class="wrapper" style="margin-top: 116px;">
	     	<form id="league_form" action="${ctx}/league/applySign">
	     	<input type="hidden" name="cfg_id" id="cfg_id" value="${cfg_id}"/>
            <div class="registration">
                <div class="reg_title">
                    <span class="text-white f16 ms">球员报名</span>
                </div>
                  <div class="player_reg">
                    <ul>
                        <li class="actived"><span>1、报名须知</span></li>
                        <li class="active"><span>2、填写资料</span></li>
                        <li class=""><span>3、等待审核</span></li>
                        <li class=""><span>4、参赛方式</span></li>
                       <!--  <li class=""><span>5、支付报名费</span></li> -->
                        <li class=""><span>5、完成</span></li>
                        <div class="clearit"></div>
                    </ul>
                </div>
                <div class="reg_area">
                    <div id="league_image" class="reg_l">
                    	<a style="cursor: pointer;" data-id="headimg" onclick="change_league_img()">
                    	<c:choose>
                    		<c:when test="${!empty head_icon}">
                    		<img id="league_image_img_0" src="${el:headPath()}${head_icon}" alt="" style="width: 150px;height: 150px;" />
                   			<input type="hidden" id="sign_image_src" name="image_src" value="${head_icon}">
                    		</c:when>
                    		<c:otherwise>
                        	<img id="league_image_img_0" src="${ctx}/resources/images/reg_pic.png" alt="" style="width: 150px;height: 150px;" />
                        	<input type="hidden" id="sign_image_src" name="image_src" value="${head_icon}">
                    		</c:otherwise>
                    	</c:choose>
                        </a>
                    </div>
                    <div class="reg_r" style="float: left;">
                        <table>
                            <tr>
                                <td class="r"><span class="f14 ms text-white">真实姓名</span></td>
                                <td>
                                    <input type="text" id="true_name" name="name" valid="require len(0,40)" value="${certification.name}" class="check-png ml10" />
                                    <input type="hidden" id="ifCer" name="status" value="${ifCer}">
                                    <span id="true_name_span" check-png class="reg_right ml10" <c:if test="${empty certification.name}">style="display: none;"</c:if>></span>
                                </td>
                                 <td class="r"><span class="f14 ms text-white">身份证号</span></td>
                                <td>
                                    <input type="text" id="id_card" name="id_card" valid="require sfz2(1,20)" value="${certification.id_card}" class="check-png ml10" />
                                    <span id="id_card_span" check-png class="reg_right ml10"  <c:if test="${empty certification.id_card}">style="display: none;"</c:if>></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="r"><span class="f14 ms text-white">生&emsp;&emsp;日</span></td>
                                <td>
                                    <input id="birthday" class="form-control check-png ml10" name="birth_date" type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${empty leagueSign.birth_date?playerInfo.borndate:leagueSign.birth_date}" />" readonly="readonly"/>
                                   
                                    <span id="id_card_span" check-png class="reg_right ml10"  <c:if test="${empty leagueSign.birth_date&& empty playerInfo.borndate}">style="display: none;"</c:if>></span>
                                </td>
                                <td class="r"><span class="f14 ms text-white">联系电话</span></td>
                                <td>
                                    <input type="text" name="mobile" valid="require mobile" value="${empty leagueSign.mobile?playerInfo.phone:leagueSign.mobile}" class="check-png ml10" />
                                    <span check-png class="reg_right ml10"  <c:if test="${empty leagueSign.mobile&&empty playerInfo.phone}">style="display: none;"</c:if>></span>

                                </td>
                            </tr>
                            <tr>
                                <td class="r"><span class="f14 ms text-white">身&emsp;&emsp;高</span></td>
                                <td>
                                	<c:choose>
                                		<c:when test="${!empty leagueSign}">
                                    		<input type="text" name="height" valid="require numberScope(100,230)" value="<fmt:formatNumber type='number' value='${leagueSign.height}'/>" class="check-png ml10" /><span class="f14 ms text-white ml10">CM</span>
                                		</c:when>
                                		<c:otherwise>
                                			<input type="text" name="height" valid="require numberScope(100,230)" value="<fmt:formatNumber type='number' value='${playerInfo.height}'/>" class="check-png ml10" /><span class="f14 ms text-white ml10">CM</span>
                                		</c:otherwise>
                                	</c:choose>
                                    <span check-png class="reg_right ml10" <c:if test="${empty playerInfo.height}">style="display: none;"</c:if>></span>
                                </td>
                                <td class="r"><span class="f14 ms text-white">体&emsp;&emsp;重</span></td>
                                <td>
                                    <input type="text" name="weight" value="${!empty leagueSign?leagueSign.weight:playerInfo.weight}" valid="require numberFloatScope(25,150)" class="check-png ml10" /><span class="f14 ms text-white ml10">KG</span>
                                    <span check-png class="reg_right ml10" <c:if test="${empty playerInfo.weight}">style="display: none;"</c:if>></span>

                                </td>
                            </tr>
                            <tr>
                                <td class="r"><span class="f14 ms text-white">擅长位置</span></td>
                                <td>
                               <span style="margin-left: 10px;"></span>
                                    <select id="p_position" onchange="check_chosen(this)" name="p_position" sel="${!empty leagueSign?leagueSign.position:playerInfo.position}"  data-placeholder=" " valid="require" multiple="" style="width: 142px;ma" data-rel="chosen">
					                	<c:forEach items="${paramMap.get('p_position')}" var="pos">
										<option value="${pos.dict_value}">${pos.dict_value_desc}</option>
										</c:forEach>
									  </select>
                                    <span check-png class="reg_right ml10" <c:if test="${empty playerInfo.position}">style="display: none;"</c:if>></span>
                                </td>
                                <td class="r"><span class="f14 ms text-white">惯&nbsp;用&nbsp; 脚</span></td>
                                <td>
                                	<c:choose>
                                		<c:when test="${!empty leagueSign}">
                                			<input type="radio" onchange="check_radio(this)" name="cfoot" value="rfoot" <c:if test="${leagueSign.cfoot!='lfoot'&&leagueSign.cfoot!='lrfoot'}">checked="checked"</c:if> class="ml10" />
		                                    <span class="f14 ms text-white">右脚</span>
		                                    <input type="radio" onchange="check_radio(this)" name="cfoot" value="lfoot"  <c:if test="${leagueSign.cfoot=='lfoot'}">checked="checked"</c:if>/>
		                                    <span class="f14 ms text-white">左脚</span>
		                                    <span check-png class="reg_right ml10" <c:if test="${empty leagueSign.cfoot}">style="display: none;"</c:if>></span>
                                		</c:when>
                                		<c:otherwise>
                                			<input type="radio" onchange="check_radio(this)" name="cfoot" value="rfoot" <c:if test="${playerInfo.cfoot!='lfoot'&&playerInfo.cfoot!='lrfoot'}">checked="checked"</c:if> class="ml10" />
		                                    <span class="f14 ms text-white">右脚</span>
		                                    <input type="radio" onchange="check_radio(this)" name="cfoot" value="lfoot"  <c:if test="${playerInfo.cfoot=='lfoot'}">checked="checked"</c:if>/>
		                                    <span class="f14 ms text-white">左脚</span>
		                                    <span check-png class="reg_right ml10" <c:if test="${empty playerInfo.cfoot}">style="display: none;"</c:if>></span>
                                		</c:otherwise>
                                	</c:choose>

                                </td>
                            </tr>
                            <tr>
                                <td class="r"><span class="f14 ms text-white">球衣号码</span></td>
                                <td>
                                	<c:choose>
                                		<c:when test="${!empty leagueSign }">
                                			<div id="clothesNum">
                                				<input type='hidden' name='love_num' value='${leagueSign.love_num}'/>
	                                			<c:forEach items="${leagueSign.love_num}" var="nums">
	                                				<div class="chosen">${nums }</div>
	                                			</c:forEach>
                                			</div>
                                			<a href="javascript:void(0)" id="nums"><img src="${ctx}/resources/images/add_num.png" class="ml10" /></a>
                                		</c:when>
                                		<c:otherwise>
                                		<div id="clothesNum">
	                                		<!-- 球衣号码 -->
	                                	</div>
	                                    <a href="javascript:void(0)" id="nums"><img src="${ctx}/resources/images/add_num.png" class="ml10" /></a>
                                		</c:otherwise>
                                	</c:choose>
                                </td>
                                 <td class="r"><span class="f14 ms text-white">性&emsp;&emsp;别</span></td>
                                <td>
                                	<c:choose>
                                		<c:when test="${!empty leagueSign}">
                                			<input type="radio" onchange="check_radio(this)" name="sex" value="1" <c:if test="${leagueSign.sex==1}">checked="checked"</c:if> class="ml10" />
		                                    <span class="f14 ms text-white">男</span>
		                                    <input type="radio" onchange="check_radio(this)" name="sex" value="0" <c:if test="${leagueSign.sex==0}">checked="checked"</c:if> />
		                                    <span class="f14 ms text-white">女</span>
		                                    <span check-png class="reg_right ml10" <c:if test="${empty leagueSign.sex}">style="display: none;"</c:if>></span>
                                		</c:when>
                                		<c:otherwise>
                                			<input type="radio" onchange="check_radio(this)" name="sex" value="1" <c:if test="${playerInfo.sex}">checked="checked"</c:if> class="ml10" />
		                                    <span class="f14 ms text-white">男</span>
		                                    <input type="radio" onchange="check_radio(this)" name="sex" value="0" <c:if test="${!playerInfo.sex}">checked="checked"</c:if> />
		                                    <span class="f14 ms text-white">女</span>
		                                    <span check-png class="reg_right ml10" <c:if test="${empty playerInfo.sex}">style="display: none;"</c:if>></span>
                                		</c:otherwise>
                                	</c:choose>
                                </td>
                            </tr>
                            <tr>
                               <td class="r"><span class="f14 ms text-white">球员邀请码</span></td>
                               <td>
                               <c:choose>
			                    	<c:when test="${!empty leagueSign.active_code}">
                               		<input type="text" value="${leagueSign.active_code}" readonly="readonly" class="check-png ml10">
                               		<input type="button" onclick="cancel_active_code()" value="清空" class="btn_g f12">
			                    	</c:when>
			                    	<c:otherwise>
			                    	<input type="text" name="active_code" value="" class="check-png ml10">
			                    	</c:otherwise>
			                    </c:choose>
                               </td>
                            </tr>
                        </table>

                    </div>
                    <div class="clearit"></div>
                </div>
                <style>
                </style>
                <div class="reg_id">
                    <h3 class="text-white ms f16">请上传身份证正反两面</h3>
                    <ul>
                        <li id="card_image_z" msg="正">
                        	<c:if test="${!empty certification.img_src && !empty fn:substring(certification.img_src,0, fn:indexOf(certification.img_src, ','))}">
	               			<div class="fileUploader-item">
	                  			<img src="${el:headPath()}${fn:substring(certification.img_src,0, fn:indexOf(certification.img_src, ','))}">
	                  			<input type="hidden" name="img_src" value="${fn:substring(certification.img_src,0, fn:indexOf(certification.img_src, ','))}">
	               			</div>
	             			</c:if>
                        </li>
                        <li id="card_image_f" msg="反">
                        	<c:if test="${!empty certification.img_src&& !empty fn:substring(certification.img_src,fn:indexOf(certification.img_src, ',')+1, fn:length(certification.img_src))}">
	               			<div class="fileUploader-item">
	                  			<img src="${el:headPath()}${fn:substring(certification.img_src,fn:indexOf(certification.img_src, ',')+1, fn:length(certification.img_src))}">
	                  			<input type="hidden" name="img_src" value="${fn:substring(certification.img_src,fn:indexOf(certification.img_src, ',')+1, fn:length(certification.img_src))}">
	               			</div>
	             			</c:if>
                        </li>
                    </ul>
                    <div class="clearit"></div>
                </div>
                <div class="reg_ability">
                    <h3 class="text-white ms f16">个人能力值</h3>
                    <table class="abil">
                    	<tr>
                            <td><span class="score ms fw">综合能力值：<span id="player_score">${empty playerInfo.score?750: playerInfo.score}</span></span></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">速度能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="speed_bar">
				                           <div data-value="speed"></div>
				                           <span id="speed_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="speed_title" data-id="fenshu" data-name="speed" class="result">0</span>
				                   <input type="hidden" name="speed" value="${playerInfo.speed}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">力量能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="power_bar">
				                           <div data-value="power"></div>
				                           <span id="power_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="power_title" data-id="fenshu" data-name="power" class="result">0</span>
				                   <input type="hidden" name="power" value="${playerInfo.power}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">爆发能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="explosive_bar">
				                           <div data-value="explosive"></div>
				                           <span id="explosive_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="explosive_title" data-id="fenshu" data-name="explosive" class="result">0</span>
				                   <input type="hidden" name="explosive" value="${playerInfo.explosive}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">协调能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="balance_bar">
				                           <div data-value="balance"></div>
				                           <span id="balance_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="balance_title" data-id="fenshu" data-name="balance" class="result">0</span>
				                   <input type="hidden" name="balance" value="${playerInfo.balance}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">反应能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="respond_ability_bar">
				                           <div data-value="respond_ability"></div>
				                           <span id="respond_ability_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="respond_ability_title" data-id="fenshu" data-name="respond_ability" class="result">0</span>
				                   <input type="hidden" name="respond_ability" value="${playerInfo.respond_ability}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">体&emsp;&emsp;力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="physical_bar">
				                           <div data-value="physical"></div>
				                           <span id="physical_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="physical_title" data-id="fenshu" data-name="physical" class="result">0</span>
				                   <input type="hidden" name="physical" value="${playerInfo.physical}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">传球能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="pass_ability_bar">
				                           <div data-value="pass_ability"></div>
				                           <span id="pass_ability_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="pass_ability_title" data-id="fenshu" data-name="pass_ability" class="result">0</span>
				                   <input type="hidden" name="pass_ability" value="${playerInfo.pass_ability}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <table class="abil">
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">控球能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="ball_ability_bar">
				                           <div data-value="ball_ability"></div>
				                           <span id="ball_ability_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="ball_ability_title" data-id="fenshu" data-name="ball_ability" class="result">0</span>
				                   <input type="hidden" name="ball_ability" value="${playerInfo.ball_ability}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">射门能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="shot_bar">
				                           <div data-value="shot"></div>
				                           <span id="shot_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="shot_title" data-id="fenshu" data-name="shot" class="result">0</span>
				                   <input type="hidden" name="shot" value="${playerInfo.shot}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">抢断能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="tack_ability_bar">
				                           <div data-value="tack_ability"></div>
				                           <span id="tack_ability_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="tack_ability_title" data-id="fenshu" data-name="tack_ability" class="result">0</span>
				                   <input type="hidden" name="tack_ability" value="${playerInfo.tack_ability}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">头球能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="header_bar">
				                           <div data-value="header"></div>
				                           <span id="header_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="header_title" data-id="fenshu" data-name="header" class="result">0</span>
				                   <input type="hidden" name="header" value="${playerInfo.header}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">洞察能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="insight_bar">
				                           <div data-value="insight"></div>
				                           <span id="insight_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="insight_title" data-id="fenshu" data-name="insight" class="result">0</span>
				                   <input type="hidden" name="insight" value="${playerInfo.insight}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">团队能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="fill_bar">
				                           <div data-value="fill"></div>
				                           <span id="fill_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="fill_title" data-id="fenshu" data-name="fill" class="result">0</span>
				                   <input type="hidden" name="fill" value="${playerInfo.fill}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">定位球能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="free_kick_bar">
				                           <div data-value="free_kick"></div>
				                           <span id="free_kick_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="free_kick_title" data-id="fenshu" data-name="free_kick" class="result">0</span>
				                   <input type="hidden" name="free_kick" value="${playerInfo.free_kick}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bar_progress">
                                    <span class="pull-left f12 text-white">守门能力</span>
                                    <div data-type="edit" class="scale_panel">
				                       <div class="scale" id="goal_bar">
				                           <div data-value="goal"></div>
				                           <span id="goal_btn" data-abtn style=""></span>
				                       </div>
				                   	</div>
				                   <span id="goal_title" data-id="fenshu" data-name="goal" class="result">0</span>
				                   <input type="hidden" name="goal" value="${playerInfo.goal}"/>
                                    <div class="clearit"></div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div class="clearit"></div>
                </div>
                <input type="hidden" id="if_team_player" value="${ifTeamPlayer}"/>
                <c:if test="${ifTeamPlayer=='1'}">
                <div class="mt25" style="text-align: center;">
                	<input type="hidden" id="team_id" value="${teamPlayer.teaminfo_id}"/>
                    <span class="text-white ml65">本次联赛报名仅针对单飞球员，您现在已在“宇任拓”中加入了俱乐部，是否退出当前俱乐部或放弃参加本次联赛</span>
                    <input type="button" onclick="quitTeam()" value="退出" class="exitbtn" />
                </div>
                </c:if>
                <div style="width:600px;margin: 60px auto 0;text-align: center; ">
                    <input type="button" flag="1" id="apply_sign_btn" onclick="apply_sign(this)" value="提交" class="btn_l f18 ms" />
                    <c:choose>
                    	<c:when test="${!empty leagueSign}">
                    		<input type="button" onclick="location.href='${ctx}/league/toSign?cfg_id=${cfg_id}'" value="取消" class="btn_g f18 ms" />
                    	</c:when>
                    	<c:otherwise>
                    		<input type="button" onclick="location.href='/league/identity?cfg_id=${cfg_id}'" value="取消" class="btn_g f18 ms" />
                    	</c:otherwise>
                    </c:choose>
                </div>
            </div>
            </form>
        </div>
    </div>
    <c:if test="${empty playerInfo.id}">
    	<input type="hidden" id="scale_flag" value="0"/>
    </c:if>
    <c:if test="${!empty playerInfo.id}">
    	<input type="hidden" id="scale_flag" value="1"/>
    </c:if>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/admin/js/jquery.chosen.min.js"></script>
    <script src="${ctx}/resources/fileupload/webuploader/webuploader.js"></script>
	<script src="${ctx}/resources/fileupload/fileUploader.js"></script>
	<link href="${ctx}/resources/js/Canlendar/ccCanlendar.css" rel="stylesheet">
	<script src="${ctx}/resources/js/mouse.js"></script>
	<script src="${ctx}/resources/js/Canlendar/ccCanlendar.js"></script>
<script type="text/javascript">
//进度条插件
scale = function (btn, bar, title) {
    this.btn = document.getElementById(btn);
    this.bar = document.getElementById(bar);
    this.title = document.getElementById(title);
    this.step = this.bar.getElementsByTagName("DIV")[0];
    this.init();
};
scale.prototype = {
    init: function () {
        var f = this, g = document, b = window, m = Math;
        f.btn.onmousedown = function (e) {
            var x = (e || b.event).clientX;
            var l = this.offsetLeft;
            var max = f.bar.offsetWidth - this.offsetWidth;
            g.onmousemove = function (e) {
                var thisX = (e || b.event).clientX;
                var to = m.min(max, m.max(-2, l + (thisX - x)));
                f.btn.style.left = to + 'px';
                f.ondrag(m.round(m.max(0, to / max) * 100), to);
                b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();
            };
            g.onmouseup = new Function('this.onmousemove=null');
        };
    },
    ondrag: function (pos, x) {
        this.step.style.width = Math.max(0, x) + 'px';
        //this.title.innerHTML = pos + '%';
        this.title.innerHTML = pos;
        var inp = $(this.title).parent().find("input[type=hidden]");
        var oldval = inp.val();
        var score = $("#player_score").text();
        $("#player_score").text((parseInt(score)+(parseInt(pos)-parseInt(oldval))));
        inp.val(pos);
        if($("#scale_flag").val()==0){
        	$("#scale_flag").val(1);
        }
    }
}

/* var league_image = {
	uploaderType: 'imgUploader',
	itemWidth: 176,
	itemHeight: 245,
	fileNumLimit: 1,
	fileSingleSizeLimit: 2*1024*1024,
	fileVal: 'file',
	server: '${ctx}/imageVideo/uploadFile?filetype=picture',
	toolbar:{
		del: true
	}
}
$('#league_image').fileUploader($.extend({},league_image,{inputName:'image_src'})); */

var iframeIndex;
function change_league_img(){
	iframeIndex = layer.open({
	    type: 2,
	    title: '编辑头像',
	    shadeClose: true,
	    shade: [0],
	    area: ['660px', '600px'],
	    content: base+'/center/changeHeadImg' //iframe的url
	}); 
}

function closeIframe(path){
	layer.close(iframeIndex);
	layer.msg("保存成功",{icon: 1});
	$("#league_image_img_0").attr("src",ossPath+path);
	$("#sign_image_src").val(path);
}

var card_image_z = {
	uploaderType: 'imgUploader',
	itemWidth: 301,
	itemHeight: 183,
	fileNumLimit: 1,
	fileSingleSizeLimit: 2*1024*1024, /*1M*/
	fileVal: 'file',
	server: '${ctx}/imageVideo/uploadFile?filetype=picture',
	toolbar:{
		del: '${ifCer}'=='1'?false:true
	}
}
$('#card_image_z').fileUploader($.extend({},card_image_z,{inputName:'img_src'}));
var card_image_f = {
	uploaderType: 'imgUploader',
	itemWidth: 301,
	itemHeight: 183,
	fileNumLimit: 1,
	fileSingleSizeLimit: 2*1024*1024, /*1M*/
	fileVal: 'file',
	server: '${ctx}/imageVideo/uploadFile?filetype=picture',
	toolbar:{
		del: '${ifCer}'=='1'?false:true
	}
}
$('#card_image_f').fileUploader($.extend({},card_image_f,{inputName:'img_src'}));
$(function(){
//$('#league_image').find(".webuploader-container").css("border","none");
//$('#league_image').find(".webuploader-pick").css("background"," url('${ctx}/resources/images/reg_pic.png') no-repeat scroll center center");
$('#card_image_z').find(".webuploader-container").css("border","none");
$('#card_image_z').find(".webuploader-pick").css("background"," url('${ctx}/resources/images/reg_id_z.png') no-repeat scroll center center");
$('#card_image_f').find(".webuploader-container").css("border","none");
$('#card_image_f').find(".webuploader-pick").css("background"," url('${ctx}/resources/images/reg_id_b.png') no-repeat scroll center center");
	var pos_val = $("#p_position").attr('sel');
	var hh=new Array();
	if(pos_val) hh = pos_val.split(',');
	$("#p_position").children().each(function(){
  		 for(var i=0;i<hh.length;i++){
  			 if($(this).attr('value')==hh[i]){
  				 $(this).attr('selected','selected');
  			 }
  		 }
	});
	var positions = $('[data-rel="chosen"],[rel="chosen"]').chosen({max_selected_options: 2,no_results_text : "未找到此选项!"});
	set_player_ability();
	check_input();
})


function set_player_ability(){
	var abil = $(".reg_ability");
	abil.find('.bar_progress').each(function(){
		//ability.find('[data-abtn]').show();
		var fenshu = $(this).find("[data-id=fenshu]");
		var name = fenshu.attr("data-name");
		var val = $(this).find("input[type='hidden']").val();
		if(!val){
			val = 50;
		}
		fenshu.text(val);
		abil.find('[data-value='+name+']').css("width",(150*(parseFloat(val)/100)));
		$('#'+name+'_btn').css("left",(150*(parseFloat(val)/100))+'px');
		$('#'+name+'_title').parent().find("input[type=hidden]").val(val);
		new scale(name+'_btn', name+'_bar', name+'_title');
	})
}
function check_input(){
	var ifCer = $("#ifCer").val();
	if("1"==ifCer){
		$("#true_name").attr("readonly","readonly");
		$("#true_name_span").attr("title","实名认证后不能修改");
		$("#id_card").attr("readonly","readonly");
		$("#id_card_span").attr("title","实名认证后不能修改");
	}
	$(".check-png").each(function(){
		$(this).blur(function(){
			var check_png = $(this).parent().find("[check-png]");
			var result = $.valid_oth(this);
			if(result){
				$('#apply_sign_btn').attr("flag","0");
				check_png.attr("title",result).removeClass("reg_right").addClass("reg_err").show();
			}else{
				$('#apply_sign_btn').attr("flag","1");
				check_png.attr("title","").removeClass("reg_err").addClass("reg_right").show();
			}
        });
	});
}

function quitTeam(){
	yrt.confirm('是否退出当前俱乐部？', {
	    btn: ['是','否'], //按钮
	    shade: true
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/player/quitTeam',
			data: {"teaminfo_id":$("#team_id").val()},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					$("#if_team_player").val('0')
					yrt.msg("退出成功",{icon: 1});
                } else {
                	yrt.msg("退出失败,"+result.message.error[0],{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

function check_chosen(dom){
	var val = $(dom).val();
	if(val&&val.length>0){
		$(dom).parent().find("[check-png]").attr("title","可选择两个").removeClass("reg_err").addClass("reg_right").show();
	}else{
		$(dom).parent().find("[check-png]").attr("title","请选择擅长位置,最多可选择两个").removeClass("reg_right").addClass("reg_err").show();
	}
}

function check_radio(dom){
	$(dom).parent().find("[check-png]").attr("title","").removeClass("reg_err").addClass("reg_right").show();
}

function apply_sign(dom){
	var flag = $(dom).attr("flag");
	if(flag==0){
		var t = $("#true_name").offset().top-100;
        $('body,html').animate({
            scrollTop:t+'px'
        });
		return;
	}
	var data = $("#league_form").serializeObject();
	var flag = true;
	if(!(data['image_src'])){
		layer.msg("请上传一张免冠照",{icon: 2});
		return;
	}
	var img_src = data['img_src'];
	if((!img_src)||img_src.length<2){
		layer.msg("请上传身份证正反面",{icon: 2});
		return;
	}
	for(var key in data){
		if(!data[key]){
			if(key!='love_num'&&key!='active_code'){
				layer.msg("请完善报名信息",{icon: 2});
				flag = false;
				var t = $("#true_name").offset().top-100;
		        $('body,html').animate({
		            scrollTop:t+'px'
		        });
				break;
			}
		}
	}
	if(!(data['sex'])||!(data['cfoot'])){
		layer.msg("请完善报名信息",{icon: 2});
		return;
	}
	if($("#if_team_player").val()=='1'){
		layer.msg("请先退出俱乐部",{icon: 2});
		return;
	}
	if($("#scale_flag").val()==0){
		layer.msg("请拖动一次个人能力值",{icon: 0});
		return;
	}
	if(flag){
		$(dom).attr("flag","0");
		var score = parseInt($("#player_score").text());
		if(score >= 1350){
			yrt.confirm('你的能力已经超过80%的用户,是否提交资料?', {
			    btn: ['是','否'], //按钮
			    shade: true
			}, function(){
				$.ajaxSubmit('#league_form',league_callback);
			}, function(){$(dom).attr("flag","1");});
		}else{
			$.ajaxSubmit('#league_form',league_callback);
		}
	}
}

function league_callback(result){
	if(result.state=='success'){
		yrt.msg("报名成功，我们将在24小时内审核您的报名资料并将通过手机短信向您发送审核结果",{icon: 1});
		setTimeout(function(){
			location.href=base+"/league/toSign?cfg_id="+$("#cfg_id").val();
		},2000);
	}else{
		if(result.data&&result.data.l_status==1){
			location.reload();
		}else{
			yrt.msg(result.message.error[0],{icon: 2});
		}
	}
	$("#apply_sign_btn").attr("flag","1");
}

function cancel_active_code(){
	yrt.confirm('是否取消使用邀请码？', {
	    btn: ['是','否'], //按钮
	    shade: true
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/league/deleteActiveCode',
			data: {"cfg_id":$("#cfg_id").val()},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					yrt.msg("取消成功!",{icon: 1});
					setTimeout(function(){
						location.reload();
					},1400);
                } else {
                	if(result.data&&result.data.l_status==1){
                		yrt.msg("取消失败，您已经报名成功！",{icon: 1});
                		setTimeout(function(){
    						location.reload();
    					},1400);
            		}else{
	                	yrt.msg("取消失败!,"+result.message.error[0],{icon: 2});
            		}
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

$(function(){
	jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }

    $("#nums").click(function () {
        $(".masker").height($(document).height()).fadeIn();
        $(".select_jersey").center().show();
    });

    $($(".select_jersey .num")).each(function() {
        $(this).click(function() {
            if ($(this).hasClass("active")) {
                $(this).removeClass("active");
            } else {
                $(this).addClass("active");
            }
        });
    });

    $("#cannel").click(function() {
        cl();
    });
    $(".closeBtn_1").click(function() {
        cl();
    });
});

function cl() {
    $(".masker").hide();
    $(".select_jersey").hide();
}

//选择球衣
function chooseNum(){
	var num = $(".select_jersey ul li div.active").text();
	if(num.length>6){
		layer.alert("最多选择三个！");
		return false;
	}
	num1 = num.substring(0,2);
	num2 = num.substring(2,4);
	num3 = num.substring(4,6);
	$("#clothesNum").empty();
	var love_num="";
	if(num1!=''){
		$("#clothesNum").append('<div class="chosen">'+num1+'</div> ');
		love_num = num1;
	}
	if(num2!=''){
		$("#clothesNum").append('<div class="chosen">'+num2+'</div> ');
		love_num = num1+","+num2;
	}
	if(num3!=''){
		$("#clothesNum").append('<div class="chosen">'+num3+'</div> ');
		love_num = num1+","+num2+","+num3;
	}
	$("#clothesNum").append("<input type='hidden' name='love_num' value='"+love_num+"'/>")
	 cl();
}

$('#birthday').ccCanlendar({
	iniValue:false,
	startYear:1970,
	hasHourPanel:false,
	hasMinitePanel:false,
	autoSetMinLimit:false,
	showNextMonth:false,
	maxLimit:'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" />'
});
</script>
</body>
</html>