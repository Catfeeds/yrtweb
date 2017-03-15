<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
<link href="${ctx}/resources/css/master.css" rel="stylesheet" />
<link href="${ctx}/resources/css/center.css" rel="stylesheet" />
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝贝基本信息</title>
<c:set var="currentPage" value="BABYINDEX"/>
</head>
<style>
     #prevTop {
         left: 10px;
         height: 72px !important;
         width: 20px !important;
         background: url(${ctx}/resources/images/np.png) -30px -44px no-repeat !important;
     }
     #prevTop:hover{
         background: url(${ctx}/resources/images/np.png) -104px -44px no-repeat !important;
     }
     #nextTop {
         right: 10px;
         height: 72px !important;
         width: 20px !important;
         background: url(${ctx}/resources/images/np.png) -34px -147px no-repeat !important;
     }
     #nextTop:hover{
         background: url(${ctx}/resources/images/np.png) -108px -147px no-repeat !important;
     }
 </style>
<body>
<div class="masker"></div>

 <!--礼物弹窗-->

<div class="gift_list">
    <div class="closeBtn_1"></div>
    <p class="title mt20 f16 ms">礼物列表</p>
    <p class="title_1 mt10">给ta送礼会引起她的注意哦，更有可能受到ta的青睐哟~</p>
    <ul id="gift_ul" class="gift_ul"></ul>
</div>
<!--礼物弹窗END-->
<div class="video_detail" id="video_detail" style="display: none;">
	<div class="closeVideoDeatail"></div>
	<!-- <div class="videoTitle">
		<span class="text-white f20">广州俱乐部VS杭州俱乐部</span>
	</div> -->
	<div class="commentIcon">
		<span>
			<a class="goodComment" flag="1" title="赞" data-id="goodbtn" onclick="do_praise(1,this,'video')" style="cursor: pointer;"></a>
		</span>
		<span class="text-white ml20" data-id="good">0</span>
		<span class="ml15">
			<a class="badComment" flag="1" title="踩" data-id="badbtn" onclick="do_praise(2,this,'video')" style="cursor: pointer;"></a>
		</span>
		<span class="text-white ml25" data-id="bad">0</span>
	</div>
	<div id="a1" class="videoplay pull-left">
	</div>
	<div class="comment pull-left">
		
		<div class="load">
			<a id="load_more"></a>
		</div>
		<div id="commentList" class="commentBox">
 		<div id="commentModel" class="ml10 mt10" style="display: none;">
 			<div class="pull-left">
 				<img src="${el:headPath()}{{head_icon}}" class="other"/>
 			</div>
 			<div class="pull-left ml15">
 				<p>
 					<span class="text-gray" style="cursor: pointer;" data-id="usernick"></span>
 					<span data-id="create_time" class="text-gray ml10"></span>
 				</p>
 				<p class="text-white mt5 w225">{{content}}</p>
 			</div>
 			<div class="clearfix"></div>
 		</div>
		</div>
		<form id="commentsForm" errorType="2" action="${ctx}/imageVideo/saveComments">
		<input type="hidden" id="iv_id" name="iv_id" value=""/>
		<input type="hidden" id="roleType" name="roleType" value=""/>
  		<div class="publishComment">
  			<img src="${el:headPath()}${user_img}" class="publishHead"/>
			<textarea valid="require len(0,200)" data-text="评论" id="msg_content" name="content"></textarea>
			<input type="button" onclick="send_comments()" value="发表" class="publisBtn"/>
		</div>
		</form>
	</div>
</div>
    <!--邀请代言-->
    <div class="baby_daiyan">
    <div class="closeBtn_1"></div>
        <div class="bb_title">
            <span class="f20 ms text-white">邀请代言</span>
        </div>
        <div class="bb_xx">
        	<form id="inInfo">
	            <div class="bb_touxiang">
	                <img src="${el:headPath()}${user.head_icon}" class="pull-left ml150 mt30" />
	                <dl class="pull-left mt60 ml15">
	                    <dt><span class="text-white f20 ms">${user.usernick }</span></dt>
	                   <!--  <dd class="mt5"><span class="text-white f20 ms">Vivian</span></dd> -->
	                </dl>
	                <div class="clearit"></div>
	            </div>
	            <div class="bb_info_day">
	                <table>
	                    <tr>
	                        <td><span class="bb_text f16 ms fw">&emsp;代言天数 /</span></td>
	                        <td><input type="text" name="days" valid="require numberNotZero" value="" class="ml10"/><span class="text-white ms f16 ml5">天</span><span class="text-santand ml5">*</span></td>
	                    </tr>
	                    <tr>
	                        <td><span class="bb_text f16 ms fw">代言俱乐部 /</span></td>
	                        <td><span class="ml10 f14 ms text-white">${teamInfo.name}</span></td>
	                    </tr>
	                </table>
	            </div>
	            <div class="fenge"></div>
	            <div class="bb_info_day" style="width: 320px;">
	                <table class="ml30">
	                <input type="hidden" id="baby_user_id" name="user_id" value="${baby_user_id}"/><!--足球宝贝用户user_id-->
					<input type="hidden" id="teaminfo_id" name="teaminfo_id" value="${teamInfo.id}"/>
	                    <tr>
	                        <td><span class="bb_text f16 ms fw">&emsp;联系人 /</span></td>
	                        <td><input type="text" name="contact_person" valid="require" value="" class="ml10"/><span class="text-santand ml5">*</span></td>
	                    </tr>
	                    <tr>
	                        <td><span class="bb_text f16 ms fw">联系电话 /</span></td>
	                        <td><input type="text" name="contact_phone" valid="require mobile" value="" class="ml10" /><span class="text-santand ml5">*</span></td>
	                    </tr>
	                    <tr>
	                        <td valign="top"><span class="bb_text f16 ms fw">备&emsp;&emsp;注 /</span></td>
	                        <td><textarea class="beizhu" name="remark"></textarea></td>
	                    </tr>
	                    <tr>
	                        <td></td>
	                        <td>
	                            <input type="button" name="name" value="邀请" onclick="inviteProxy()" class="invi_btn ml10" />
	                            <input type="button" name="guanbi" value="取消" class="cheer_btn ml10" />
	                        </td>
	                    </tr>
	                </table>
	            </div>
            </form>
        </div>
    </div>
    <!--邀请助威-->
    <div class="baby_zhuwei">
    <div class="closeBtn_1"></div>
        <div class="bb_title">
        
            <span class="f20 ms text-white">邀请助威</span>
        </div>
        <div class="bb_xx">
            <div class="bb_touxiang">
                <img src="${el:headPath()}${user.head_icon}" class="pull-left ml150 mt30" />
                <dl class="pull-left mt60 ml15">
                    <dt><span class="text-white f20 ms">${user.usernick}</span></dt>
                    <!-- <dd class="mt5"><span class="text-white f20 ms">Vivian</span></dd> -->
                </dl>
                <div class="clearit"></div>
            </div>
          	<c:choose>
            	<c:when test="${!empty listGame}">
  				 <form action="" method="post" id="cheerForm">
           			<div class="bb_info_day" style="width: 420px;margin-left:85px;">
		             	 <table>
		                    <tr>
		                        <td><span class="bb_text f16 ms fw">&emsp;助威比赛 /</span></td>
		                        <td>
		                            <select class="ml10" onchange="gameshow()" id="game_id">
		                            		<option value="">请选择</option>
		                            	<c:forEach items="${listGame}" var="game">
		                            		<option value="${game.id}">${game.t_name}(主) VS ${game.r_name}(客)</option>
										</c:forEach>
		                            </select>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td><span class="bb_text f16 ms fw">&emsp;助威时间 /</span></td>
		                        <td>
		                        	<span class="ml10 f14 ms text-white" id="cheer_time_s"></span>
		                        	<input type="hidden" name="cheer_time" id="cheer_time" value=""/>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td><span class="bb_text f16 ms fw">&emsp;助威地点 /</span></td>
		                        <td>
		                        	<span class="ml10 f14 ms text-white" id="cheer_address_s"></span>
		                        	<input type="hidden" name="cheer_address"  id="cheer_address" value=""/>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td><span class="bb_text f16 ms fw">助威俱乐部 /</span></td>
		                        <td>
		                        	<span class="ml10 f14 ms text-white" id="team_name_s"></span>
		                        	<input type="hidden" name="team_name" id="team_name" value=""/>
		                        </td>
		                    </tr>
		                </table>
		                <input type="hidden" name="logo" id="logo" value=""/>
            		</div>
            	<div class="fenge"></div>
            	<div class="bb_info_day" style="width: 320px;">
	                <table class="ml30">
	                    <tr>
	                        <td><span class="bb_text f16 ms fw">&emsp;联系人 /</span></td>
	                        <td><input type="text" name="contact_person" value="" class="ml10" valid="require len(1,30)"/><span class="text-santand ml5">*</span></td>
	                    </tr>
	                    <tr>
	                        <td><span class="bb_text f16 ms fw">联系电话 /</span></td>
	                        <td><input type="text" name="contact_phone" value="" class="ml10" valid="require mobile"/><span class="text-santand ml5">*</span></td>
	                    </tr>
	                    <tr>
	                        <td valign="top"><span class="bb_text f16 ms fw">备&emsp;&emsp;注 /</span></td>
	                        <td><textarea class="beizhu" name="remark"></textarea></td>
	                    </tr>
	                    <tr>
	                        <td></td>
	                        <td>
	                            <input type="button" name="name" value="邀请" class="invi_btn ml10" onclick="cheerGame();"/>
	                            <input type="button" name="guanbi" value="取消" class="cheer_btn ml10" />
	                        </td>
	                    </tr>
	                </table>
	                	  
            	</div>
            </form>	
          	</c:when>
          	<c:otherwise>
          		当前俱乐部无赛事无法邀请！
          	</c:otherwise>	
		</c:choose>
        </div>
    </div>
    <!--宝贝点赞-->
    <div class="baby_zan">
     <div class="closeBtn_1"></div>
        <div class="bb_title">
           
            <span class="f20 ms text-white">宝贝评分</span>
        </div>
        <div class="bb_xx">
            <div class="bb_touxiang">
                <img src="${el:headPath()}${user.head_icon}" class="pull-left ml150 mt30" />
                <dl class="pull-left mt60 ml15">
                    <dt><span class="text-white f20 ms">${user.usernick}</span></dt>
                    <!-- <dd class="mt5"><span class="text-white f20 ms">Vivian</span></dd> -->
                </dl>
                <div class="clearit"></div>
            </div>
            <div class="bb_info_day">
                <span class="lx ms">-- 留下你的评分吧 --</span>
                <div class="clearit"></div>
                <div class="dian_zan"></div>
                <div class="clearit"></div>
                <input type="button" name="name" value="提交" onclick="pfBaby()" class="invi_btn mt15 ml75" />
                <input type="button" name="re_set" value="重置" class="cheer_btn mt15 ml10" />
            </div>

        </div>
    </div>
    <div class="warp">
         <!--头部-->
		 <%@ include file="../common/header.jsp" %>
		 <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <div class="ft_baby">
                    <span class="bb_name pull-left ml60 mt30 ms f24">
                        ${user.usernick}
                    </span>
                    <c:choose>
                    	<c:when test="${!empty user.username}">
		                    <img src="${ctx}/resources/images/bbyrz.png" title="已认证" class="mt30 ml10 pull-left" />
                    	</c:when>
                    	<c:otherwise>
                    		<img src="${ctx}/resources/images/bbywrz.png" title="未认证" class="mt30 ml10 pull-left" />
                    	</c:otherwise>
                    </c:choose>
                    <c:choose>
                    	<c:when test="${isOwn eq false }">
		                    <%-- <input type="button" name="name" value="她的代言" class="cheer_btn ms f14 pull-right mr15  mt25" onclick="window.open('${ctx}/babyIn/toInListDatas/${baby_user_id}')"/> --%>
                    	</c:when>
                    	<c:otherwise>
                    		<c:if test="${!empty session_user_id }">
	                    	   	<div class="invi_div">
			                        <span class="baby_info text-white">${info_count}</span>
			                        <input type="button" name="name" value="我的邀请" class="invi_btn ms f14  mr15  mt25" onclick="window.open('${ctx}/baby/toTeamBaby')"/>
			                    </div>
                    		</c:if>
                   		   <%-- <input type="button" name="name" value="我的代言" class="invi_btn pull-right  ms f14  mr15  mt25" onclick="window.open('${ctx}/babyIn/toInListDatas/${user.id}')"/> --%>
                    	</c:otherwise>
                    </c:choose>
                    <c:choose>
                    	<c:when test="${isOwn eq true }">
	                    	<input type="button" name="name" value="编辑" class="invi_btn ms f14 mt25 pull-right mr15" onclick="window.location='${ctx}/baby/editInfo'"/>
                   	 	</c:when>
                    	<c:otherwise>
		                    <input type="button" name="name" value="私信" class="invi_btn ms f14 pull-right mr15  mt25" onclick="openMsg('${user.id}','${user.usernick}');"/>
                    	</c:otherwise>
                    </c:choose>
                    <%-- <c:if test="${isOwn eq false }"> --%><!-- 自己不能邀请自己 -->
                    <c:choose>
                    	<c:when test="${flag eq true}">
                    	  <input type="button" name="yidaiyan" value="已邀请代言" class="invi_btn ms f14 pull-right mr15  mt25" />
                    	</c:when>
                    	<c:otherwise>
		                    <%-- <c:if test="${!empty teamInfo}"> --%>
				                    <input type="button" name="daiyan" value="代言" class="invi_btn ms f14 pull-right mr15  mt25" />
		                    <%-- </c:if> --%>
                    	</c:otherwise>
                    </c:choose>
                    <span id="focusBabySpan">
              			<c:if test="${session_user_id ne babyInfo.user_id}">
	                    	<c:choose>
	                    		<c:when test="${empty focusCount}">
				                    	<input type="button" name="关注" value="关注" onclick="focusBaby('${babyInfo.user_id}')" class="invi_btn ms f14 pull-right  mt25 mr15" />
	                    		</c:when>
	                    		<c:otherwise>
		                    		<c:choose>
			                    		<c:when test="${focusCount  < 1}">
						                    <input type="button" name="关注" value="关注" onclick="focusBaby('${babyInfo.user_id}')" class="invi_btn ms f14 pull-right  mt25 mr15" />
			                    		</c:when>
			                    		<c:otherwise>
			                    			<input type="button" name="取消关注" value="取消关注" onclick="unfocusBaby('${babyInfo.user_id}')" class="invi_btn ms f14 pull-right  mt25 mr15" />
			                    		</c:otherwise>
		                    		</c:choose>
	                    		</c:otherwise>
	                    	</c:choose>
                		</c:if>
                    </span>
	               	<input type="button" name="zhuwei" value="助威" class="invi_btn ms f14 pull-right  mt25 mr15" />
 				<%-- 	</c:if> --%>
                    <div class="clearit"></div>

                    <div class="mybox">
                        <div class="slide_img">
                            <span id="prev" class="abtn prev" style="margin-top: 370px;"></span>
                            <span id="next" class="abtn next" style="margin-top: 370px;"></span>
                            <span id="prevTop" class="abtn prev" style="top:50px;"></span>
                            <span id="nextTop" class="abtn next" style="top:50px;"></span>
                            <div id="picBox" class="picBox">
                                <ul class="cf">
                                    <li>
                                        <div class="bb_content">
                                            <div class="bb_info">
                                                <!--<span class="te fw">ELITE<span class="te2">MEMBER</span><span class="text-gray ml10">精英</span> </span>-->
                                                <span class="te fw">YRT<span class="te2">BABY</span><span class="text-gray ml10">宝贝</span> </span>
                                                <div class="clearit"></div>
                                                <table class="bb_tab">
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                昵&emsp;&emsp;称 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${user.usernick }</span>
                                                        </td>
                                                    </tr>
                                                    <!-- <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                生&emsp;&emsp;日 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>1995/05/21</span>
                                                        </td>
                                                    </tr> -->
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                星&emsp;&emsp;座 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${babyInfo.constellation }</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                所在城市 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${user.city }</span>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                身&emsp;&emsp;高 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${babyInfo.height }CM</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                体&emsp;&emsp;重 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span><fmt:formatNumber value="${babyInfo.weight }" pattern="0"/>KG</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                胸&emsp;&emsp;围 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span><fmt:formatNumber value="${babyInfo.chest }" pattern="0"/></span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                腰&emsp;&emsp;围 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span><fmt:formatNumber value="${babyInfo.waist }" pattern="0"/></span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                臀&emsp;&emsp;围 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span><fmt:formatNumber value="${babyInfo.hip }" pattern="0"/></span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                身&emsp;&emsp;价 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${ps.price }</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                喜爱球队 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${babyInfo.love_team }</span>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                所获成就 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${babyInfo.achievement }</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                爱&emsp;&emsp;好 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${babyInfo.hobby }</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                个性签名 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span>${babyInfo.intro }</span>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div style="margin-left: 50px;margin-top: 70px;">
                                                    <dl>
                                                        <dt><h3 class="f24 ms">宝贝评分：</h3></dt>
                                                        <dd class="mt25">
                                                            <div id="Score"></div><span class="pf ms">${babyInfo.score}</span>
                                                            <c:choose>
                                                            	<c:when test="${is_pj eq true }">
		                                                            <span class="toshe_end">已评分</span>
                                                            	</c:when>
                                                            	<c:otherwise>
                                                            		<span class="toshe">给她评分</span>
                                                            	</c:otherwise>
                                                            </c:choose>
                                                            <div class="clearit"></div>
                                                        </dd>
                                                        <dd class="mt25">
                                                            <span class="f16 ms">&ensp;已助威&ensp;<span class="text-yellow">${icCount.bc_count }</span>场比赛</span>
                                                           	<c:choose>
                                                           		<c:when test="${!empty baby_teamInfo.name}">
                                                           			<span class="f14 ms ml15">已代言<span style="cursor: pointer;" class="text-yellow" onclick="window.location='${ctx}/team/detail/${baby_teamInfo.user_id}.html'">${baby_teamInfo.name}</span></span>
		                                                            <c:if test="${isOwn eq true}">
		                                                            	<c:choose>
		                                                            		<c:when test="${baby_teamInfo.bt_status eq 1}">
					                                                          <%-- <span class="exitbtn" onclick="quitTeamIn('${baby_teamInfo.baby_team_id}')">退出</span> --%>
					                                                            <div class="dy_day">
					                                                                <span class="f12 ms">剩余代言天数：</span>
					                                                                <span class="text-yellow f12 ms">${baby_teamInfo.re_days}</span>
					                                                                <span class="f12 ms">天</span>
					                                                            </div>
		                                                            		</c:when>
		                                                            		<c:otherwise>
		                                                            			<span class="exitbtn_ing">退出中</span>
		                                                            		</c:otherwise>
		                                                            	</c:choose>
		                                                            </c:if>
                                                           		</c:when>
                                                           		<c:otherwise>
                                                           			<span class="f16 ms ml15">暂无代言俱乐部</span>
                                                           		</c:otherwise>
                                                           	</c:choose>
                                                        </dd>
                                                    </dl>
                                                </div>
                                            </div>
                                            <div class="bb_pic">
                                            	 <c:forEach items="${images}" var="img" begin="0" end="0">
	                                                <img src="${el:filePath(img.f_src,img.to_oss)}" style="max-width: 498px;height: 645px;float: right" />
                                            	 </c:forEach>
                                            </div>
                                            <div class="clearit"></div>
                                        </div>
                                    </li>
                                    <c:forEach items="${images}" var="img" begin="1">
	                                    <li>
	                                        <div class="bb_content">
	                                            <img src="${el:filePath(img.f_src,img.to_oss)}" class="boximg" />
	                                        </div>
	                                    </li>
                                    </c:forEach>
                                    <div class="clearit"></div>
                                </ul>
                            </div>
                            <div class="gift" style="position: relative;">
                                <ul id="gift_rec">
                                </ul>
                                    
								
												<input type="button" id="give" class="invi_btn f14 ms"
													value="赠礼" name="name" style="position:absolute; right:10px;top:33px;">
											
							</div>
                            
                            <div id="listBox" class="listBox">
                                <ul class="cf">
                                     <c:forEach items="${images}" var="img" varStatus="num">
	                                    <li <c:if test="${num.index==0 }">class="on"</c:if> ><img src="${el:filePath(img.f_src,img.to_oss)}" alt="" /></li>
                                     </c:forEach>
                                    <div class="clearit"></div>
                                </ul>
                            </div>
                        </div>
                        <div class="shipin">
                            <span class="te3 fw">VIDE<span class="te2">OS</span><span class="text-gray ml10">视频</span></span>
                            <c:choose>
                              		<c:when test="${!empty videos}">
                              			<span class="bb_prev"></span>
			                            <span class="bb_next"></span>
			                            <div class="bb_frame frame" id="baby_moive">
			                                <ul class="clearfix">
			                                	<c:forEach items="${videos}" var="video">
				                                    <li>
				                                       <div style="position: relative;">
				                                    	<img src="${ctx}/resources/images/video_p.png" onclick="show_video('${el:filePath(video.f_src,video.to_oss)}','${video.create_time}','${video.id}','BABY')" alt="Alternate Text" style="position: absolute;width: 32px;height: 32px;top: 49px;left: 89px;" />
				                                        <img src="${el:filePath(video.v_cover,video.to_oss)}"/>
				                                       </div>
				                                    </li>
			                                	</c:forEach>
			                                </ul>
			                            </div>
                              		</c:when>
 			                        <c:otherwise>
 			                         <div id="no_movie"></div>
 			                        </c:otherwise>    		
                            </c:choose> 		
                        </div>
                        <div class="pingjia">
                            <span class="te3 fw">EVALU<span class="te2">ATION</span><span class="text-gray ml10">评价</span></span>
                        </div>
                       <div id="pjListDatas" style="position: relative;min-height: 40px;">
                     	  	<img src="${ctx}/resources/images/loading.gif" style="position: absolute;width: 40px;height: 40px;left: 457px;margin-top: 12px;">
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/js/lightbox2.js" id="lighbox"></script>
    <script src="${ctx}/resources/js/jquery.raty.min..js"></script>
    <script src="${ctx}/resources/js/babyInfo.js"></script>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
    <script src="${ctx}/resources/vmodel/Filter.js"></script>
    <script src="${ctx}/resources/js/sly.js"></script>
    <script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/resources/js/fakeloader.min.js" charset="utf-8"></script>
    <script src="${ctx}/resources/js/own/index_new.js"></script>
    <script type="text/javascript">
    $(".closeVideoDeatail").click(function () {
	    $("#a1").html("");
	    $(".masker").hide();
	    $("#msg_content").val("");
	    $('#video_detail').hide();
	});
    create_commont_list();
    var PageInfo={"login_user_amount":0};
        $(function(){
        	$('#Score').raty({
                path: base+'/resources/images/',
                half: true,
                size: 33,
                readOnly: true,
                score: '${babyInfo.score}',
                starHalf: 'star-half-big.png',
                starOff: 'star-off-big.png',
                starOn:'star-on-big.png',

            });
            $('.dian_zan').raty({
                path: base+'/resources/images/',
                half: true,
                size: 33,
                score: '${babyInfo.score}',
                starHalf: 'star-half-big.png',
                starOff: 'star-off-big.png',
                starOn: 'star-on-big.png',

            });


            jQuery.fn.center = function () {
                this.css("position", "absolute");
                this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
                this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
                return this;
            }
            $("#give").click(function () {
            	var flag = check_user_role();
            	if(!flag)return;
                $(".masker").height($(document).height()).fadeIn();
                $(".gift_list").center().fadeIn();
            });
            $(".closeBtn_1").click(function() {
                cl();
            });
            var gb = $(".masker");
            var bgb=$(".closeBtn_1");
            var msgb = $("input[name=guanbi]");
            var zhuwei = $("input[name=zhuwei]");
            var daiyan = $("input[name=daiyan]");
            var reset = $("input[name=re_set]");
            bgb.click(function () {
                cl();
            });
            msgb.click(function () {
            	layer.closeAll();
            	cl();
            });
            zhuwei.click(function () {
                cl();
            });
            gb.click(function () {
                cl();
            });

            $(".toshe").click(function () {
                $(".masker").height($(document).height()).fadeIn();
                $(".masker").fadeIn();
                $(".baby_zan").center().fadeIn();

            });
            daiyan.click(function() {
            	$.ajaxSec({
    				type: 'POST',
    				url: base+"/babyIn/validRule",
    				success: function(data){
    					if(data.state=='error'){
    						layer.msg(data.message.error[0],{icon:2});
    					}else{
    						 $(".masker").height($(document).height()).fadeIn();
   			                 $(".masker").fadeIn();
   			                 $(".baby_daiyan").center().fadeIn();
    					}
    				},
    				error: $.ajaxError
    			});	
               
            })

            zhuwei.click(function () {
            	$.ajaxSec({
    				type: 'POST',
    				url: base+"/babyCheer/validRule",
    				success: function(data){
    					if(data.state=='error'){
    						layer.msg(data.message.error[0],{icon:2});
    					}else{
    						 $(".masker").height($(document).height()).fadeIn();
   			                 $(".masker").fadeIn();
   			                 $(".baby_zhuwei").center().fadeIn();
    					}
    				},
    				error: $.ajaxError
    			});	
            });

            function bb_zan() {
                $(".masker").height($(document).height()).fadeIn();
                $(".masker").fadeIn();
                $(".baby_zan").center().show();
            }

            //未进行评分弹出评分窗口
            if('${is_pj}'=="false"){
	            bb_zan();
            }

            reset.click(function (parameters) {
                $('.dian_zan').raty({
                    path: base+'/resources/images/',
                    half: true,
                    size: 33,
                    score: 0,
                    starHalf: 'star-half-big.png',
                    starOff: 'star-off-big.png',
                    starOn: 'star-on-big.png',

                });
            });
            
          $(".exitbtn").mouseover(function() {
                $(".dy_day").show();
            }).mouseout(function() {
                $(".dy_day").hide();
            });  
           
          (function () {
              var $frame = $('#baby_moive');
              var $wrap = $frame.parent();

              // Call Sly on frame
              $frame.sly({
                  horizontal: 1,
                  itemNav: 'forceCentered',
                  smart: 1,
                  activateOn: 'click',
                  mouseDragging: 1,
                  touchDragging: 1,
                  releaseSwing: 1,
                  startAt: 0,
                  scrollBar: $wrap.find('.scrollbar'),
                  scrollBy: 1,
                  pagesBar: $wrap.find('.pages'),
                  activatePageOn: 'click',
                  speed: 300,
                  elasticBounds: 1,
                  easing: 'easeOutExpo',
                  dragHandle: 1,
                  dynamicHandle: 1,
                  clickBar: 1,

                  // Cycling
                  cycleBy: 'pages',
                  cycleInterval: 1000,
                  pauseOnHover: 1,
                  startPaused: 1,

                  prev: $wrap.find('.bb_prev'),
                  next: $wrap.find('.bb_next')

              });
          }());
          
        });
        
        
        var update_user_amount=function(){ 
     		$.ajax({
        		type : "POST",
        		url : "${ctx}/user/getUserAmount",
        		data : {},
        		dataType : "json",
        		contentType : "application/json",
        		success : function(items) {
        			if(items.real_amount){
        				PageInfo.login_user_amount=items.real_amount;
        			}
        		},
        		error : function(msg) {
        			if (msg.statusText != "abort") {
        				
        			}
        		}
        	});
        }
        var sumbit_Give=function(p_code,cv,cp){ 
        	var cwidth = '60%';
        	if(PageInfo.login_user_amount>10000000){
        		cwidth = '80%'
        	}
        	var cmsg = '<p class="f16 text-white ms" style="width:'+cwidth+'">扣除宇币：'+cp+'个</p>';
        	cmsg+='<p class="f16 text-white ms" style="width:'+cwidth+'">可用宇币：'+PageInfo.login_user_amount+'个　<a style="color:#eb6100;" href="'+base+'/account/recharge" target="_blank" class="f12">充值</a></p>';
        	yrt.confirm(cmsg, {
        	    btn: ['确认赠送','取消'], //按钮
        	    title : '赠礼确认',
        	    shade: false
			}, function(){
	        	var postdata='{"p_code":"'+p_code+'","rec_user_id":"${baby_user_id}","price":"'+cp +'","charm_value":"'+cv+'"}'
	        	$.ajax({
	        		type : "POST",
	        		url : "${ctx}/baby/buyGift",
	        		data : postdata,
	        		dataType : "json",
	        		contentType : "application/json",
	        		success : function(data) {
		    			if(data.state==0){
		    				yrt.msg("礼物赠送成功",{icon: 1});
		    			}else{
		    				yrt.msg(data.message,{icon: 0});
		    			}
		    			update_user_amount();
		    			getReceiveGiftList();
	        		},
	        		error : function(msg) {
	        			if (msg.statusText != "abort") {
	        				
	        			}
	        		}
	        	});
			}, function(){});
        	
        };
     	var load_Gift_List=function(){ 
     		$.ajax({
        		type : "POST",
        		url : "${ctx}/baby/getGiftList",
        		data : {},
        		dataType : "json",
        		contentType : "application/json",
        		success : function(items) {
        			$("#gift_ul").empty();
        			for(i in items){
        				addToGift(items[i]);
        			}
	    			update_user_amount();
        		},
        		error : function(msg) {
        			if (msg.statusText != "abort") {
        				
        			}
        		}
        	});
        };
        
        var addToGift = function(o){
        	var msg = [];
        	msg.push('<li><dl><dt><div class="gift_info"><img src="${ctx}/'+o.image_src+'" title="'+o.p_name+'"/></div></dt>');
        	msg.push('<dd><span>魅力值</span><span class="text-orange">+'+o.charm_value+'</span></dd>');
            msg.push('<dd><span class="text-orange">'+o.price+'</span><span class="ml10">宇币</span></dd>');
            msg.push('<dd><input type="button" name="name" onclick="sumbit_Give(\''+o.p_code+'\','+o.charm_value+','+o.price+')" value="赠送" class="invi_btn mt5" /></dd></dl></li>');
       
    		$("#gift_ul").append(msg.join(''));
        };
        
        var getReceiveGiftList=function(){ 
     		$.ajax({
        		type : "POST",
        		url : "${ctx}/baby/getReceiveGiftList/${baby_user_id}",
        		data : {},
        		dataType : "json",
        		contentType : "application/json",
        		success : function(items) {
        			$("#gift_rec").empty();
        			var msg = [];
        			var _sum = 0;
        			for(i in items){
        				var o=items[i];
        				_sum+=o.quantity;
	        			msg.push('<li class=""><div class="gift_info"><img src="${ctx}/'+o.image_src+'" title="'+o.p_name+'"/><span class="nums">'+o.quantity+'</span>');
	        			msg.push('</div></li>');
        			}
        			msg.push('<div class="clearit"></div>');
        			$("#gift_rec").append('<li><dl class="bb mt10"><dt><span class="f16 ms">收到礼物</span></dt><dd><span id="gift_sum">共'+_sum+'件</span></dd></dl></li>');
        			$("#gift_rec").append(msg.join(''));
        		},
        		error : function(msg) {
        			if (msg.statusText != "abort") {
        				
        			}
        		}
        	});
        };
        load_Gift_List(); 
        getReceiveGiftList();
    </script>
</body>
</html>