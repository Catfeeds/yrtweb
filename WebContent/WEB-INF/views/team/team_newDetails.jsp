<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/clubLook.css" rel="stylesheet" />
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<link href="${ctx}/resources/css/jedate.css" rel="stylesheet">
<title>俱乐部详情</title>
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
 .notice_img{
	 position: absolute; 
	 width: 8px; 
	 height: 8px; 
	 left: 40px; 
	 margin-top: 4px;
	 z-index: 1;
 }
 .update_btn_css{
    float: right;
    margin-top: 10px;
    margin-right: 10px;
    width: 45px;
    height: 20px;
    line-height: 20px;
    text-align: center;
    border: none;
    border-radius: 4px;
    background: #eb6100;
    color: #fff;
 }
 .card {
    background: #424242 none repeat scroll 0 0;
    box-shadow: 2px 2px 10px #111111;
    display: none;
    left: 0;
    padding-bottom: 10px;
    position: absolute;
    top: 24px;
    width: 280px;
    z-index: 12;
}
.card_info {
    margin: 5px auto;
    width: 266px;
    text-align: left;
}
.card_head {
    border-radius: 6px;
    float: left;
    height: 80px;
    width: 80px;
}
.card_name {
    color: #cbcb9f;
    font-family: "Microsoft YaHei";
    font-size: 16px;
}
.card_details {
    float: left;
    margin-left: 15px;
    width: 168px;
}
.card_details span {
    vertical-align: middle;
}
</style>
</head>
<body>
 <div class="warp">
        <div class="masker"></div>
 		<div class="auction_super_l" id="playerArea">
        </div>
         <!--充值弹窗-->
        <div class="pay_num">
            <div class="closeBtn_1"></div>
            <div class="pay_tl">
                <span class="f16 ms text-white">贡献宇币</span>
            </div>
            <table>
               <%--  <tr>
                    <td class="lefts"><span class="text-white f16 ms">充值类型：</span></td>
                    <td><span class="text-orange ms f16">给俱乐部充值</span><a href="${ctx}/account/recharge" class="text-info ml10">个人充值点此</a></td>
                </tr> --%>
                <tr>
                    <td><span class="text-white f16 ms">账户名称：</span></td>
                    <td><span class="text-orange ms f16">${team.name}</span></td>
                </tr>
                <tr>
                    <td><span class="text-white f16 ms">贡献金额：</span></td>
                    <td><input type="text" id="payamount" name="payamount" value="" onblur="onchangePayAmonunt()"/><span class="text-white f14 ms ml10">宇币</span></td>
                </tr>
                <tr>
                    <td><span class="text-white f16 ms">支付方式：</span></td>
                    <td>
                        <input type="radio" name="payway" value="1" checked="checked"/><span class="text-white f14 ms ml5">余额支付</span>
                        <input type="radio" name="payway" value="2" /><span class="text-white f14 ms ml5">支付宝</span>
                    </td>
                </tr>
                <tr>
                    <td><span class="text-white f16 ms">应付金额：</span></td>
                    <td>
                        <span class="text-orange ms f16" id="yutuobi">0宇拓币</span>
                        <span class="text-orange ms f16">/</span>
                        <span class="text-orange ms f16" id="renminbi">￥0</span>
                    </td>
                </tr>
            </table>
            <div class="btn_div">
                <input type="button" name="name" value="确认" class="btn_l f14 ms" onclick="payFor()">
                <input type="button" name="name" value="取消" class="btn_g f14 ms ml10" onclick="closeWin()"/>
            </div>
        </div>
        <!--宝贝助威-->
        <div class="baby_zhuwei" id="gamebabyArea"></div> 
        <!--录入比分-->
        <div class="notice" id="upload_matchResult" style="height: 350px;">
        </div>
        <!--公告 -->
        <div class="notice" id="addNoticeArea" style="display: none;">
        </div>
        <div class="notice_info" id="showNoticeArea" style="display: none;">
        </div>
        <!--pk弹出层start-->               
		<div class="pk" id="inviteDialog" style="display: none;"></div>
		<!--pk弹出层end-->
		<!--关于俱乐部-->
        <div class="about_club">
            <div class="title">
                <div class="closeBtn_1" title="关闭"></div>
                <span class="f16 ms">关于俱乐部</span>
            </div>
            <div class="img_region">
                <c:if test="${!empty team.remark_images}">
               	<c:forEach items="${fn:split(team.remark_images, ',')}" var="rimg" begin="0" end="0">
                	<img src="${el:headPath()}${rimg}" alt="" class="b_img" />
               	</c:forEach>
               	</c:if>
            </div>
            <div class="img_select">
                <c:if test="${!empty team.remark_images}">
            	<c:forEach items="${fn:split(team.remark_images, ',')}" var="rimg" varStatus="status" end="2">
                <img src="${el:headPath()}${rimg}" alt="" />
            	</c:forEach>
            	</c:if>
            </div>
            <div class="txt_region">
                <p class="text-white f14 ms">俱乐部介绍</p>
                <p class="main_txt">${team.remark}</p>
            </div>
        </div>
        <div class="buyInviteCode"></div>
		<%@ include file="../common/header.jsp" %>       
		<%@ include file="../common/naver.jsp" %> 
        <div class="wrapper" style="margin-top: 116px;">
        	<input type="hidden" id="teaminfo_id" value="${team.id}"/><!-- 被邀请俱乐部ID -->
			<input type="hidden" id="teaminfo_name" value="${team.name}"/><!-- 被邀请俱乐部ID -->
			<input type="hidden" id="user_id" value="${user_id}"/><!-- 被访问user -->
			<input type="hidden" id="s_u_id" value="${session_user_id}"/><!-- 登录用户id -->
            <div class="club_show">
                <div class="club">
                    <div class="title">
                        <span class="f18 ms pull-left ml10">俱乐部</span>
                        <div class="pull-right mr10" style="position: relative;">
                        	<c:choose>
	                            <c:when test="${session_user_id eq user_id}">
		                            <%-- <img id="mg_hint" src="${ctx}/resources/images/msginfo.png" alt="" class="notice_img" style="display: none;"> --%>
		                            <div style="left: 34px;top:-3px;z-index:2;" class="msg_case" id="team_msg_case_png">
	                                    <span class="msg_num">1</span>
	                                </div>
		                            <a href="${ctx}/teamInvite/msg?teaminfo_id=${team.id}" class="buy_act" style="color:#fff;">信息</a>
		                            
		                            <a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;">管理</a>
			                            <div class="e_menu" style="display:none;">
			                                <ul>
			                                    <li><span onclick="javscript:window.location='${ctx}/team/info/${team.id}.html'">编辑资料</span></li>
			                                    <li onclick="javascript:window.location='${ctx}/team/gameLists?teaminfo_id=${team.id}&other_user_id=${user_id}'"><span>对战管理</span></li>
			                                    <li><span onclick="javscript:window.location='${ctx}/team/playerList?teaminfo_id=${team.id}'">成员管理</span></li>
			                                    <li><span onclick="javscript:window.open ('${ctx}/team/wage?teaminfo_id=${team.id}','newwindow','height=900,width=900,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')">奖金发放</span></li>
			                                    <li><span onclick="javscript:window.location='${ctx}/team/wagePayroll?teaminfo_id=${team.id}'">工资发放</span></li>
			                                    <li style="border: none;" onclick="dissolve('${team.id}')"><span>解&emsp;&emsp;散</span></li>
			                                </ul>
			                            </div>
		                         </c:when>
		                         <c:otherwise>  
			                         <c:choose>
		               					<c:when test="${is_focus == true}">
		               						<a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;" onclick="unfocusTeam();">取消关注</a>
		               					</c:when>
		               					<c:otherwise>
		               						<a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;" onclick="focusTeam();">关注</a>
		               					</c:otherwise>
		               				</c:choose>	
		               						<a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;" onclick="openMsg('${team.id}');">私信</a>	
		               				<c:choose>
			               				<c:when test="${is_join == true}">
			               					<!-- <a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;" onclick="outTeam();">退出</a>	 -->
			               				</c:when>
			               				<c:otherwise>
			               					<c:choose>
				               					<c:when test="${is_team == true}">
					               					<a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;" onclick="inviteTeam();">挑战</a>
				               					</c:when>
				               					<c:otherwise>
							               			<!-- <a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;" onclick="joinTeam();">申请加入</a> -->
				               					</c:otherwise>
			               					</c:choose>
			               				</c:otherwise>
			               			</c:choose>
			               		</c:otherwise>
		               		</c:choose>
	                        <%--  <c:if test="${is_join eq true}">
	                         	<a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;">退队</a> 
	                         </c:if>	
	                         
	                         <c:if test="${is_focus eq true}">
	                         	<a href="javascript:void(0);" id="me" class="buy_act" style="color:#fff;">关注</a> 
	                         </c:if> --%>
                        </div>
                    </div>

                    <div class="club_show_time">
                        <table>
                            <tr>
                                <td rowspan="6" valign="top" style="position: relative;text-align: center;">
									<c:if test="${tl_flag}">
	                                    <a class="match_3"></a>
									</c:if>	
	                                <c:choose>
			                			<c:when test="${!empty team.logo}">
			                				<img src="${el:headPath()}${team.logo}" class="l_myhead">
			                				  <div class="clearfix"></div>
			                			</c:when>
			                			<c:otherwise>
					                		<img src="${ctx}/resources/images/default_logo.png" class="l_myhead">
			                			</c:otherwise>	
		                			</c:choose>
		                			<c:if test="${session_user_id eq user_id}">
			                			<c:if test="${!empty teamLeague.id}">
						                	<p><input type="button" name="name" value="购买邀请码" class="buy_act ml25 mt10" id="inviteCode" onclick="openBuy()" /></p>
				                		 </c:if>
				                	</c:if>	
                                </td>
                                <td colspan="4">
                                    <span class="club_nick ms fw ml10">${team.name}</span>
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="5" class="sfpl">
                                    <table>
                                        <tr>
                                            <td><span class="win">胜</span><span class="ml10">${team.win_count}</span></td>
                                            <td><span class="loss">负</span><span class="ml10">${team.loss_count}</span></td>
                                        </tr>
                                        <tr>
                                            <td><span class="flat mt20">平</span><span class="ml10">${team.draw_count}</span></td>
                                            <td><span class="winrate">率</span>
                                            	<span class="ml5"><c:choose>
	                                            		<c:when test="${team.win_count+team.loss_count == 0}">
		                                            		0%
	                                            		</c:when>
                                            			<c:otherwise>
                                            				<fmt:formatNumber type="number" value="${team.win_count*100/(team.win_count+team.loss_count)}" maxFractionDigits="0"/>%
                                            			</c:otherwise>
                                            		</c:choose>
                                            	</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="pt15"><span class="ml10 f12">城市：</span><span class="f12">${team.city}</span></td>
                                <td class="pt15"><span class="ml10 f12">宝贝：</span><span class="f12">${babyCount}/3</span></td>
                            </tr>
                            <tr>
                                <td style="cursor: pointer;" onclick="javascript:window.location='${ctx}/center/${team.user_id}'">
                                	<span class="ml10 f12">主席：</span>
                                	<span class="f12"><yt:id2NameDB beanId="userService" id="${team.user_id}"></yt:id2NameDB></span>
                               	</td>
                                <td><span class="ml10 f12">成员：</span><span class="f12">${playerCount}</span></td>
                            </tr>
                            <tr>
                                <td><span class="ml10 f12">资产：</span><span class="f12" id="teamAmount">${userAmount.amount}宇币</span></td>
                                <td><span class="ml10 f12">创建时间：</span><span class="f12"><fmt:formatDate value='${team.create_time}' pattern='yyyy-MM-dd' /></span></td>
                            </tr>
                            <tr>
                                <td colspan="4"><span class="ml10 f12">主场：</span><span class="f12">${team.play_position}</span></td>
                            </tr>
                        </table>

                        <div class="attr">
                            <ul>
                                <li>
                                    <dl>
                                        <dt class="nl" title="招募强力球员，可以提升俱乐部能力值">
                                        	<span>能力值</span>
                                        	<span class="pull-right">
                                        		<c:choose>
			                						<c:when test="${!empty re_map.p_sum}">
			                							<c:choose>
			                								<c:when test="${re_map.p_sum<10000}">
								                				<fmt:formatNumber value="${re_map.p_sum}" pattern="##0"/>
			                								</c:when>
			                								<c:otherwise>
			                									<fmt:formatNumber value="${re_map.p_sum/10000}" pattern="##0.00"/>万
			                								</c:otherwise>
			                							</c:choose>
			                						</c:when>
			                						<c:otherwise>0</c:otherwise>
			                					</c:choose>
                                        	</span>
                                        </dt>
                                        <!--<dd>
                                             <div class="att_n"></div>
                                            <div class="att_bg1"></div> 
                                        </dd>-->
                                    </dl>
                                </li>
                                <li>
                                    <dl class="hy" title="完善资料，参加比赛，可以提升活跃度">
                                        <dt><span>活跃度</span><span class="pull-right">
                                        		<c:choose>
			                						<c:when test="${!empty team.score}">
			                							${team.score}
			                						</c:when>
			                						<c:otherwise>
			                							0
			                						</c:otherwise>
		                						</c:choose>
                                        	</span></dt>
                                        <!-- <dd>
                                            <div class="att_h"></div>
                                            <div class="att_bg2"></div> 
                                        </dd>-->
                                    </dl>
                                </li>
                                <li>
                                    <dl class="sj" title="参加联赛，积极运营，提高俱乐部价值">
                                        <dt><span>总身价</span>
                                        	<span class="pull-right">
                                        		<c:choose>
				                					<c:when test="${priceCount<10000}">
						                				<fmt:formatNumber value="${priceCount}" pattern="##0"/>
		               								</c:when>
		               								<c:otherwise>
		               									<fmt:formatNumber value="${priceCount/10000}" pattern="##0.00"/>万
		               								</c:otherwise>
	               								</c:choose>
                                        	</span></dt>
                                        <!--<dd>
                                             <div class="att_s"></div>
                                            <div class="att_bg3"></div> 
                                        </dd>-->
                                    </dl>
                                </li>
                                <li>
                                    <dl class="zl" title="参加联赛，可激活此属性">
                                        <dt><span>战力</span><span class="pull-right">${team.combat}</span></dt>
                                    </dl>
                                </li>
                                <div class="clearit"></div>
                            </ul>
                        </div>

                    </div>
                </div>
                 <div class="zijin">
                    <div class="title">
                        <span class="f18 ms pull-left ml20">俱乐部当前资金</span>
                        <div class="clearit"></div>
                    </div>
                    <div class="zijin_num">
                        <input type="button" name="name" value="贡献" class="contribution" />
                        <span class="price" id="teamSumAmount"><fmt:formatNumber value="${userAmount.amount}" pattern="0"/> <span class="f14 text-white ml5 ms">宇币</span></span>
                        <div class="clearit"></div>
                    </div>
                    <div class="title mt20">
                        <span class="f18 ms pull-left ml20">贡献榜</span>
                        <div class="clearit"></div>
                    </div>
                    <div class="pay_list">
                        <table>
                            <tr>
                                <th><span>排名</span></th>
                                <th><span>用户姓名</span></th>
                                <th><span>贡献（宇币）</span></th>
                            </tr>
                            <tbody id="firstAream">
                            
                            </tbody>
                        </table>
                        <div class="hidetab">
                            <table id="secondAream">
                            	
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="clearit"></div>

                <div class="club_left">
                    <div class="title">
                        <span class="f18 ms pull-left ml10">公告</span>
                        <div class="pull-right mr10">
                            <c:if test="${session_user_id eq user_id}">
	                            <a href="javascript:void(0);" class="buy_act" style="color:#fff;" onclick="addNoticePage('${team.id}');">发布</a>
	                            
	                        </c:if>    
                            <a href="${ctx}/team/loadNoticeList?team_id=${team.id}&pageSize=10" class="buy_act" style="color:#fff;">更多</a>
                        </div>
                        <div class="clearit"></div>
                    </div>
                    <dl class="gonggao" id="noticeArea">
                    
                    </dl>
                    <div class="title mt15">
                        <span class="f18 ms pull-left ml10">精彩视频</span>
                        <div class="pull-right mr10">
                            <a id="up_team_video" href="javascript:openUpTImgs('video');" class="buy_act" style="color:#fff;">上传</a>
                          
                            <a href="${ctx}/imageVideoTeam/video?team_id=${team.id}" class="buy_act" style="color:#fff;">更多</a>
                        </div>
                        <div class="clearit"></div>
                    </div>

                    <div id="team_videos" class="video_area">
                        
                    </div>
                </div>
				<!-- 球员列表 -->
                <div class="club_center mt15" >
                	<!-- 正式球员列表 -->
                	<div id="playersArea"></div>
					<!-- 租借球员列表 -->
                	<div id="loansArea"></div>
                </div>
				<!-- 球员阵型 -->
				<div class="about mt15">
                    <div class="title">
                        <span class="f18 ms pull-left ml10">关于俱乐部</span>
                        <div class="pull-right mr10 mt5">
                       
                           <!--  <a href="javascript:void(0);">编辑</a> -->
                        </div>
                        <div class="clearit"></div>
                    </div>
                
                    <div class="club_sh">
                        <c:if test="${!empty team.remark_images}">
                       	<c:forEach items="${fn:split(team.remark_images, ',')}" var="rimg" begin="0" end="0">
                       		<div id="remark_img" align="center" style="width: 155px;height: 95px;float:left;">
                            <img src="${el:headPath()}${rimg}" alt="" class="one_show" style="float: none;" />
                           </div>
                       	</c:forEach>
                       	</c:if>
                        <dl>
                            <dt><span class="f14 ms">俱乐部展示</span></dt>
                            <dd>
                                <span class="about_font">${team.remark}</span>
                                <a href="javascript:void(0);" class="text-info" id="detailed">详情</a>
                            </dd>
                        </dl>
                        <div class="clearit"></div>
                        <div id="show_remark_images" class="pic_l_show">
                        	<c:if test="${!empty team.remark_images}">
                        	<c:forEach items="${fn:split(team.remark_images, ',')}" var="rimg" varStatus="status" end="2">
                        	<div align="center">
                            <img layer-pid="${status.index+1}" layer-src="${el:headPath()}${rimg}" alt="" num="${status.index+1}" src="${el:headPath()}${rimg}" alt="1">
                            </div>
                        	</c:forEach>
                        	</c:if>
                            <div class="clearit"></div>
                        </div>
                    </div>

                </div>
                <div class="club_right mt15">
                    <div>
                        <div class="title">
                            <span class="f18 ms pull-left ml10">球员阵形</span>
                            <c:if test="${session_user_id eq user_id}">
                            <a href="${ctx}/tformat/setedPage"  class="update_btn_css" style="color: #fff;">编辑</a>
                            </c:if>
                            <div class="clearit"></div>
                        </div>
                        <div class="diagram" id="teamFormatDiagram">
                            
                        </div>
                        
                    </div>
                </div>
                <div class="clearit"></div>

                <div class="race_course mt10">
                    <div class="title">
                        <span class="f18 ms pull-left ml10">比赛历程</span>
                        <div class="pull-right mr10">
                            <a href="${ctx}/team/gameLists?teaminfo_id=${team.id}&other_user_id=${user_id}" class="buy_act" style="color:#fff;">更多</a>
                        </div>
                        <div class="clearit"></div>
                    </div>
                   
                    <div id="historyArea">
	                   
                	</div>
                	<!-- 暂无数据-->
                                </div>
               
                <div class="trace mt10">
                 <div class="title">
                            <span class="f18 ms pull-left ml10">足球宝贝</span>
                            <div class="clearit"></div>
                        </div>

                        <ul class="baby_exh" id="babyArea">
                            
                        </ul>
                    <div class="title mt10">
                        <span class="f18 ms pull-left ml10">访客记录</span>
                        <div class="clearit"></div>
                    </div>
                    <div id="visitArea">
                    </div>
                </div>
                <div class="clearit"></div>
                <div class="index_photos">
                    <div class="index_photosTile">
                        <span class="f20 ml20">
                            <a class="text-white ms">精彩图片</a>
                        </span>
                        <!-- <span class="f12">
                            <a onclick="load_team_images('#team_images_area','image','team','new');" class="text-gray">最新|</a>
                            <a onclick="load_team_images('#team_images_area','image','team','count');" class="text-gray">最热|</a>
                            <a onclick="load_team_images('#team_images_area','image','team','good');" class="text-gray">好评</a>
                        </span> -->
                        <div class="pull-right mr10">
                            <a id="up_team_image" href="javascript:openUpTImgs('image');" class="buy_act" style="color:#fff;">上传</a>
                            <a href="${ctx}/imageVideoTeam/photo?team_id=${team.id}" class="buy_act" style="color:#fff;">更多</a>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="showPhotos_fix" id="team_images_area">
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
    <script src="${ctx}/resources/vmodel/Filter.js"></script>
    <script src="${ctx}/resources/js/own/index_new.js"></script>
    <script src="${ctx}/resources/js/own/notice.js"></script>
    <script src="${ctx}/resources/js/own/player.js"></script>
    <script src="${ctx}/resources/js/own/baby.js"></script>
    <script src="${ctx}/resources/js/own/visitor.js"></script>
    <script src="${ctx}/resources/js/own/games_record.js"></script>
    <script src="${ctx}/resources/js/own/team_iv.js"></script>
    <script src="${ctx}/resources/js/mouse.js"></script>
    <script src="${ctx}/resources/js/jedate.js"></script>
    <script src="${ctx}/resources/js/person_info.js"></script>
    <script type="text/javascript">
	    jQuery.fn.center = function () {
	        this.css("position", "absolute");
	        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
	        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
	        return this;
	    }
        $("#release").click(function () {
        	var h = $(document).height();
            $(".masker").css("height", h).show();
            $(".notice").center().show();
        });
		
        

        function cl() {
            $(".masker").hide();
            $(".select_jersey").hide();
            $("#upload_matchResult").hide();
            $(".notice_info").hide();
            $(".notice_argee").hide();
            $(".notice").hide();
            $(".baby_zhuwei").hide();
            $(".about_club").hide();
            $(".pay_num").hide();
            $(".auction_super_l").hide();
        }

        function closeWin(){
        	 cl();
        }
        
        $("#cannel2").click(function () {
            cl();
        });
        $(".closeBtn_1").click(function () {
            cl();
        });
        $(".pic_l_show div").each(function () {
        	//$.fixImageWH(this);
            $(this).find("img").mouseover(function () {
                $(".one_show").attr({ src: $(this).attr("src") });
            	$.fixImageWH("#remark_img");
            });
        });

        $(".diagram img").each(function () {
            $(this).mouseover(function () {
                $(this).addClass("active");
            }).mouseout(function () {
                $(this).removeClass("active");
            });
        });

		//显示俱乐部成员阵型信息
        function showInfo(){
        	($(".diagram").children()).each(function () {
            	
                $(this).mouseover(function () {
                    $(this).find(".info_cluster").show();
                }).mouseout(function () {
                    $(this).find(".info_cluster").hide();
                });
            });
        } 
        
        $("#me").mouseover(function () {
        	
	            $(".e_menu").show();
        	
        	
        });
        $(document).click(function (e) {
            if (!$("#me").is(':has(' + e.target.localName + ')') && e.target.id != 'me') {
                $(".e_menu").hide();
            }
        });
        $(function(){
        	loadTAmountDetail('${team.id}');
        	loadHistoryArea(1,'${team.id}');
        	loadTeamPlayers();
        	$.fixImageWH("#remark_img");
        	load_team_images("#team_images_area",'image','TEAM');
        	layer.config({
        	    extend: '/extend/layer.ext.js'
        	});
        	layer.ready(function(){
		        layer.photos({
		            photos: '#show_remark_images'
		        });
		    });
        	check_msg_count('${team.id}');
        });
        /*检查信息是否有信息消息*/
        function check_msg_count(teamId){
        	$.ajax({
        		type: 'post',
        		url: base+'/teamInvite/queryNotReadTeamMsg?teaminfo_id='+teamId,
        		dataType:'json',
        		success: function(result){
        			if(result.count > 0){
					    //$("#mg_hint").show();
					    $("#team_msg_case_png").find(".msg_num").text(result.count);
					    $("#team_msg_case_png").show();
					}else{
						//$("#mg_hint").hide();
						$("#team_msg_case_png").hide();
					}
        				
        		},
        		error: $.ajaxError
        	});
        }
        
      //弹出购买邀请码
        function openBuy(){
        	$.ajax({
        		type: 'POST',
        		url: base+"/team/toBuyCode",
        		data:{"teaminfo_id":$("#teaminfo_id").val()},
        		dataType:"html",
        		success: function(data){
        			if(data.state=='error'){
        				layer.msg(data.message.error[0]);
        			}else{
        				$(".buyInviteCode").html(data);
        			}
        		},
        		error: $.ajaxError
        	});	
        	$(".buyInviteCode").center().css("display","block");
        		//获取遮罩高度并显示
          	$(".masker").height($(document).height());
          	$('.masker').fadeIn();
        }
      
        function closeBtn(){
        	$(".buyInviteCode").css("display","none");
           	$('.masker').fadeOut();
           	$(".buyInviteCode").html("");
        }
        
      //added by bo.xie 解散俱乐部
		function dissolve(team_id){
			yrt.confirm('确定要解散吗？', {
	    	    btn: ['确定','取消'], //按钮
	    	    shade: true
	    	}, function(){
	    		$.ajaxSec({
					type:"POST",
					url:base+"/team/dissolve?random="+Math.random(),
					data:{"team_id":team_id},
					dataType:"JSON",
					success:function(data){
						if(data.state=="error"){
							yrt.msg(data.message.error[0],{icon: 2});
						}else{
							window.location = base+"/team/guide";
						}
					}
				});
	    	}, function(){});
       	}
		
		function load_team_images(dom,type,img_type,orderBy){
			var pageSize = 10;
			var params = $.param({user_id:$("#teaminfo_id").val(),type:type,role_type:img_type,orderby:orderBy,pageSize:pageSize});
			$(dom).load( base+'/team/images', params,function () {
				layer.ready(function(){
			        layer.photos({
			            photos: '#team_imgs'
			        });
			    });
			});
		}
		
		function buyCode(){
			$.ajaxSec({
				context:$("#buyForm"),
				type:"POST",
				url:base+"/team/buyCode?random="+Math.random(),
				data:$("#buyForm").serialize(),
				dataType:"JSON",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						layer.msg(data.message.success[0],{icon: 1});
						closeBtn();
						openBuy();
					}
				}
			});
		}
		function calculate(dom,single_price){
			var single = $(dom).val();
			var price = single * single_price;
			console.log(price);
			$("#showTotal").html(price);
			$("#price").val(price);
		}
		
		
		//载入俱乐部阵型成员列表
        function loadTeamPlayers(){
        	$.ajax({
        		type:'post',
        		url:base+'/tformat/datas?random='+Math.random(),
        		data:{'teaminfo_id':$('#teaminfo_id').val()},
        		dataType:"json",
        		beforeSend:function(){
        			
        		},
        		success:function(data){
        			if(data.data.tps.length>0){
        				var html='';
        				$.each(data.data.tps,function(i,item){
		                        html+='<div index="'+eval(parseInt(item.position_num)+1)+'" class="p'+eval(parseInt(item.position_num)+1)+'">';
		                        html+='<div class="info_cluster">';
		                        html+='<img src="'+ossPath+item.head_icon+'" />';
		                     	html+='<dl class="pull-left ml50">';
		                     	if(typeof(item.username)!='undefined'){
			                        html+='<dt><span class="pull-left">'+item.username+'</span><div class="clearit"></div></dt>';
		                     	}else{
		                     		html+='<dt><span class="pull-left">暂无</span><div class="clearit"></div></dt>';
		                     	}
		                     	if(typeof(item.score)!='undefined'){
			                        html+='<dt><span class="pull-left">能力</span><span class="text-orange ml5">'+item.score+'</span><div class="clearit"></div></dt>';
		                     	}else{
		                     		html+='<dt><span class="pull-left">能力</span><span class="text-orange ml5">0</span><div class="clearit"></div></dt>';
		                     	}
		                     	if(typeof(item.current_price)!='undefined'){
			                        html+='<dd><span class="pull-left">身价</span><span class="text-orange ml5">'+item.current_price+'</span><div class="clearit"></div></dd>';
		                     	}else{
		                     		html+='<dd><span class="pull-left">身价</span><span class="text-orange ml5">0</span><div class="clearit"></div></dd>';
		                     	}
		                        html+='</dl>';
		                        html+='</div>';
		                        html+='<img src="'+ossPath+item.head_icon+'" />';
		                        html+='</div>';
        				});
        				$("#teamFormatDiagram").append(html);
        				showInfo();
        			}
        		}
        	});
        }
		
      //add by ylt 系统消息同意 2015-09-01
        function openMsg(t_id){
		var s_id = "";
		var usernick = "";
		$.ajaxSec({
			type: 'POST',
			url: base+"/team/getCaption",
			data:{"teaminfo_id":t_id},
			success: function(result){
				s_id = result.data.user.id;
				usernick = result.data.user.usernick;
				if(s_id == ""){
					layer.msg("获取俱乐部队长失败!",{icon: 0});
				}else{
					layer.open({
						type: 2,
	 				    title: false,
	 				    closeBtn:false, 
	 				    shadeClose: true,
	 				    shade: 0.8,
	 				    shift : 4,
	 				    area: ['426px', '291px'],
					    content: [base+'/message/toMsg/'+s_id+'/'+usernick, 'no']
					}); 
				}
			},
			error: $.ajaxError
		});
	}
	
      //申请加入俱乐部
        function joinTeam(){
        	$.ajaxSec({
				type:"POST",
				url:base+"/team/joinTeam?random="+Math.random(),
				data:{"player_id":'${session_user_id}',"teaminfo_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				secMsg:"\u8bf7\u5148\u6fc0\u6d3b\u7403\u5458\u4fe1\u606f",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						window.location.reload();
					}
				}
			});
        }
      
      //关注
        function focusTeam(){
		 $.ajaxSec({
				type:"POST",
				url:base+"/team/focusTeam?random="+Math.random(),
				data:{"f_teaminfo_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						window.location.reload();
					}
				}
			}); 
        }
        //取消关注
        function unfocusTeam(){
        	$.ajaxSec({
				type:"POST",
				url:base+"/team/cancel?random="+Math.random(),
				data:{"f_teaminfo_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						window.location.reload();
					}
				}
			});
       }
        
		//退出俱乐部
        function outTeam(){
        	$.ajaxSec({
				type:"POST",
				url:base+"/team/outTeam?random="+Math.random(),
				data:{"player_id":'${session_user_id}',"teaminfo_id":$("#teaminfo_id").val()},
				dataType:"JSON",
				success:function(data){
					if(data.state=="error"){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						window.location.reload();
					}
				}
			});
        }
		
      //挑战界面
        function inviteTeam(){
			if('${fq_login_ti.id}'==$("#teaminfo_id").val()){
				layer.msg("自己不能挑战自己",{icon: 0});
			}else{
				$.loadSec("#inviteDialog",base+"/teamInvite/page",function(){
					$("#inviteDialog").center().css("display","block");
					 $(".masker").height($(document).height()).fadeIn();
					//向invite_page页面注入俱乐部等信息
					//发起邀请方
					$("#fa_teaminfo_id").val('${fq_login_ti.id}');
					$("#fa_t_name").val('${fq_login_ti.name}');
					$("#fa_t_logo").val('${fq_login_ti.logo}');
					//被邀请方
					$("#respond_teaminfo_id").val($("#teaminfo_id").val());
					$("#re_r_name").val('${team.name}');
					$("#re_r_logo").val('${team.logo}');
					$("#flush_page").val(true);
				});	
			}
        }
      
      //关于俱乐部
        $(".img_select img").each(function () {
            $(this).mouseover(function () {
                $(".img_region img").attr({ src: $(this).attr("src") });
            });
        });

        $(document).ready(function () {
            //限制字符个数
            $(".about_font").each(function () {
                var maxwidth = 22;
                if ($(this).text().length > maxwidth) {
                    $(this).text($(this).text().substring(0, maxwidth));
                    $(this).html($(this).html() + '...');
                }
            });
        });
        
        $("#detailed").click(function () {
            var h = $(document).height();
            $(".masker").css("height", h).show();
            $(".about_club").center().fadeIn();
        });

        //展示资金
        $(".pay_list").mouseover(function () {
            $(".pay_list").css({ "background": "#1f1f1f" });
            $(".hidetab").show();
        }).mouseout(function () {
            $(".pay_list").css({ "background": " transparent" });
            $(".hidetab").hide();
        });
        
        //充值金额
        $(".contribution").click(function () {
            var h = $(document).height();
            $(".masker").css("height", h).show();
            $(".pay_num").center().show();
        });
        
        function onchangePayAmonunt(){
        	var amount = $("#payamount").val();
        	if(amount<100 || eval(amount%100)!=0){
    			layer.msg("只能充值100的整数倍！",{icon:2});
    			return false;
    		}else{
    			$("#yutuobi").text(amount+"宇拓币");
    			$("#renminbi").text("￥"+eval(amount/100));
    			return true;
    		}
        }
        
        //充值
        function payFor(){
        	var flag = onchangePayAmonunt();
    		if(flag==false)return false;
        	
        	//支付方式 1：余额支付， 2：支付宝支付
        	var payway = $("input[name='payway']:checked").val(); 
        	var teaminfo_id = $("#teaminfo_id").val();
        	var amount = $("#payamount").val();
        	
        	if(payway==1){
        		yuePayfor(teaminfo_id,amount);
        	}else if(payway==2){
        		zhifubaoPayFor(teaminfo_id,amount);
        	}
        	
        }
        
        //余额充值 当前登录用户ID,俱乐部ID,充值宇拓币
        function yuePayfor(teaminfo_id,amount){
        	$.ajaxSec({
        		type:'post',
        		url:base+'/team/payForTeam?random='+Math.random(),
        		data:{'teaminfo_id':teaminfo_id,'amount':amount},
        		dataType:'json',
        		success:function(data){
        			if(data.state=="success"){
        				loadTAmountDetail(teaminfo_id);
        				layer.msg(data.message.success[0],{icon:1});
        				closeWin();
        			}else{
        				layer.msg(data.message.error[0],{icon:2});
        			}
        		}
        	});
        }
        
        //跳转到 支付宝充值
        function zhifubaoPayFor(teaminfo_id,amount){
        	var url = base+"/account/toBankPay";
        	post(url,{u_type:"2",recharge_money:amount,teaminfo_id:teaminfo_id});
        }
        
        
        function post(URL, PARAMS) {        
            var temp = document.createElement("form");        
            temp.action = URL;        
            temp.method = "post";        
            temp.style.display = "none";        
            for (var x in PARAMS) {        
                var opt = document.createElement("textarea");        
                opt.name = x;        
                opt.value = PARAMS[x];        
                temp.appendChild(opt);        
            }        
            document.body.appendChild(temp);        
            temp.submit();        
            return temp;        
        } 
        
        //充值榜
        function loadTAmountDetail(teaminfo_id){
        	$.ajax({
        		type:'post',
        		url:base+'/team/tamount?random='+Math.random(),
        		data:{'teaminfo_id':teaminfo_id},
        		dataType:'json',
        		success:function(data){
        			var firstAream = "";
        			var secondAream = "";	
        			var data_length = data.data.datas.length;
        			var num=1;
        			var teamSumAmount = data.data.teamSumAmount.amount;
        			$("#teamSumAmount").text(teamSumAmount);
        			$("#teamAmount").text(teamSumAmount+'宇币');
        			$.each(data.data.datas,function(i,item){
        				if(num<4){
	        				firstAream+="<tr>";
	        				if(num==1){
		        				firstAream+="<td><span class='red_one s'>"+num+"</span></td>";
		        				firstAream+="<td><a href='${ctx}/center/"+item.user_id+"' class='red_one'>"+item.usernick+"</a></td>";
		        				firstAream+="<td><span class='red_one'>"+item.amount+"</span></td>";
	        				}else if(num==2){
	        					firstAream+="<td><span class='green_two s'>"+num+"</span></td>";
	        					firstAream+="<td><a href='${ctx}/center/"+item.user_id+"' class='green_two'>"+item.usernick+"</a></td>";
		        				firstAream+="<td><span class='green_two'>"+item.amount+"</span></td>";
	        				}else if(num==3){
	        					firstAream+="<td><span class='blue_three s'>"+num+"</span></td>";
	        					firstAream+="<td><a href='${ctx}/center/"+item.user_id+"' class='blue_three'>"+item.usernick+"</a></td>";
		        				firstAream+="<td><span class='blue_three'>"+item.amount+"</span></td>";
	        				}else{
	        					firstAream+="<td><span class='white_four s'>"+num+"</span></td>";
		        				firstAream+="<td><a href='${ctx}/center/"+item.user_id+"' class='white_four'>"+item.usernick+"</a></td>";
		        				firstAream+="<td><span class='white_four'>"+item.amount+"</span></td>";
	        				}
	        				firstAream+="</tr>"
        				}
        				
        				if(data_length>3&&num>3){
        					secondAream+="<tr>";
        					secondAream+="<td><span class='white_four s'>"+num+"</span></td>";
        					secondAream+="<td><a href='${ctx}/center/"+item.user_id+"' class='white_four'>"+item.usernick+"</a></td>";
        					secondAream+="<td><span class='white_four'>"+item.amount+"</span></td>";
        					secondAream+="</tr>";
        				}
        				
        				num++;
        			});
        			$("#firstAream").empty()
        			$("#firstAream").append(firstAream);
        			$("#secondAream").empty();
        			$("#secondAream").append(secondAream);
        		}
        	});
        }
        
        //发送求购信息
        function sendTransferMsg(user_id){
        	$.ajaxSec({
				type: 'POST',
				url: base+"/teamInvite/sendTransferMsg",
				dataType:"json",
				data:{"user_id":user_id,price:$("#price").val()},
				success: function(data){
					if(data.state=='error'){
						layer.msg(data.message.error[0],{icon:2});
					}else{
						layer.msg(data.message.success[0],{icon:1});
						cl();
						loadPlayers(0);	
					}
				},
				error: $.ajaxError
			});	
        }
        
        //查看球员信息
        function lookPlayer(user_id,teaminfo_id){
        	$.ajaxSec({
				type: 'POST',
				url: base+"/teamInvite/ifBuy",
				dataType:"json",
				data:{"user_id":user_id,"teaminfo_id":teaminfo_id},
				success: function(data){
					if(data.state=='error'){
						layer.msg(data.message.error[0],{icon:2});
					}else{
						$.ajax({
							type: 'POST',
							url: base+"/teamInvite/lookPlayer",
							data: {"user_id":user_id},
							dataType:"html",
							success: function(data){
								if(data.state=='error'){
									layer.msg(data.message.error[0],{icon:2});
								}else{
									$("#playerArea").html(data);
									var height = $(document).height();
							        $(".masker").css({ "height": height}).show();
							        $(".auction_super_l").center().show();
								}
							},
							error: $.ajaxError
						});	
					}
				},
				error: $.ajaxError
			});	
        }
        
        function cancelBuy(id){
        	yrt.confirm('确定要撤销吗？', {
        	    btn: ['确定','取消'], //按钮
        	    shade: true
        	}, function(){
	        	$.ajaxSec({
					type: 'POST',
					url: base+"/teamInvite/cancelBuy",
					data: {"id":id},
					dataType:"json",
					success: function(data){
						if(data.state=='error'){
							yrt.msg(data.message.error[0],{icon:2});
						}else{
							yrt.msg(data.message.success[0],{icon:1});
							loadPlayers(0);	
						}
					},
					error: $.ajaxError
				});	
        	});
        }
        
      //发送租借信息
        function sendLoanMsg(user_id){
        	$.ajaxSec({
				type: 'POST',
				url: base+"/teamLoan/sendLoanMsg",
				dataType:"json",
				data:{"user_id":user_id,"price":$("#price").val(),"end_time":$("#end_time").val()},
				success: function(data){
					if(data.state=='error'){
						layer.msg(data.message.error[0],{icon:2});
					}else{
						layer.msg(data.message.success[0],{icon:1});
						cl();
						loadPlayers(0);	
					}
				},
				error: $.ajaxError
			});	
        }
        
        //查看球员信息
        function lookLoanPlayer(user_id,teaminfo_id){
        	$.ajaxSec({
				type: 'POST',
				url: base+"/teamLoan/ifLoan",
				dataType:"html",
				data:{"user_id":user_id,"teaminfo_id":teaminfo_id},
				success: function(data){
					if(data.state=='error'){
						layer.msg(data.message.error[0],{icon:2});
					}else{
						$.ajax({
							type: 'POST',
							url: base+"/teamLoan/lookLoanPlayer",
							data: {"user_id":user_id},
							dataType:"html",
							success: function(data){
								if(data.state=='error'){
									layer.msg(data.message.error[0],{icon:2});
								}else{
									$("#playerArea").html(data);
									var height = $(document).height();
							        $(".masker").css({ "height": height}).show();
							        $(".auction_super_l").center().show();
								}
							},
							error: $.ajaxError
						});	
					}
				},
				error: $.ajaxError
			});	
        }
        
        function cancelLoan(id){
        	yrt.confirm('确定要撤销吗？', {
        	    btn: ['确定','取消'], //按钮
        	    shade: true
        	}, function(){
	        	$.ajaxSec({
					type: 'POST',
					url: base+"/teamLoan/cancelLoan",
					data: {"id":id},
					dataType:"json",
					success: function(data){
						if(data.state=='error'){
							yrt.msg(data.message.error[0],{icon:2});
						}else{
							yrt.msg(data.message.success[0],{icon:1});
							loadPlayers(0);	
						}
					},
					error: $.ajaxError
				});	
        	});
        }
    </script>
</body>
</html>
