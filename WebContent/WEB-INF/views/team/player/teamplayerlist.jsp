<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="../../common/common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>俱乐部成员列表</title>
    <meta name="renderer" content="webkit">
	<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
	<jsp:useBean id="nowDate" class="java.util.Date"/> 
	<c:set var="qc" value="st,lw,rw"/>
	<c:set var="zc" value="cam,lm,rm,cm,cdm"/>
	<c:set var="hc" value="lb,cb,rb"/>
	<c:set var="sm" value="gk"/>
</head>
<body>
	<input type="hidden" id="teaminfo_id" name="teaminfo_id" value="${teaminfo_id}"/> 
    <div class="warp">
        <div class="masker"></div>
        <div class="select_jersey" id="numArea"></div>
        <div class="notice" id="playerArea"></div>
        <!--头部-->
        <%@ include file="../../common/header.jsp" %>       
        <!--导航-->
		<%@ include file="../../common/naver.jsp" %> 

        <div class="wrapper" style="margin-top: 116px;">
            <div class="registration">
                <div class="reg_title">
                    <span class="text-white f16 ms">球员列表</span>
                </div>
                <div class="auction_area">
                    <ul class="a_list">	
						<c:forEach items="${team_players.items}" var="player" varStatus="i">                    	
	                        <li>
	                            <div class="auction_super">
	                                <div class="name ms f24">${player.usernick}</div>
	                                <span class="po ms f14">
	                                	<c:forEach items="${fn:split(player.p_position,',')}" var="pos" end="0">
		                            		<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
		                            	</c:forEach>
	                               	</span>
	                                <!--门将标记-->
	                                <div class="player_cf">
	                                	<c:choose>
	                                		<c:when test="${player.level > 0}">
	                                			 <c:choose>
				                            		<c:when test="${!empty player.p_position}">
						                            	<c:forEach items="${fn:split(player.p_position,',')}" var="pos" end="0">
						                            		<c:choose>	
						                            			<c:when test="${fn:contains(qc, pos)}">
						                            				<img src="${ctx}/resources/images/player_y_fw.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(zc, pos)}">
						                            				<img src="${ctx}/resources/images/player_y_cf.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(hc, pos)}">
						                            				<img src="${ctx}/resources/images/player_y_ga.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(sm, pos)}">
						                            				<img src="${ctx}/resources/images/player_y_gk.png" />
						                            			</c:when>
						                            		</c:choose>
						                            	</c:forEach>
				                            		</c:when>
				                            		<c:otherwise>
						                                <img src="${ctx}/resources/images/player_y_gk.png" />
				                            		</c:otherwise>
				                            	</c:choose>
	                                		</c:when>
	                                		<c:otherwise>
	                                			<c:choose>
				                            		<c:when test="${!empty player.p_position}">
						                            	<c:forEach items="${fn:split(player.p_position,',')}" var="pos" end="0">
						                            		<c:choose>	
						                            			<c:when test="${fn:contains(qc, pos)}">
						                            				<img src="${ctx}/resources/images/player_fw.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(zc, pos)}">
						                            				<img src="${ctx}/resources/images/player_cf.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(hc, pos)}">
						                            				<img src="${ctx}/resources/images/player_ga.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(sm, pos)}">
						                            				<img src="${ctx}/resources/images/player_gk.png" />
						                            			</c:when>
						                            		</c:choose>
						                            	</c:forEach>
				                            		</c:when>
				                            		<c:otherwise>
						                                <img src="${ctx}/resources/images/player_gk.png" />
				                            		</c:otherwise>
				                            	</c:choose>
	                                		</c:otherwise>
	                                	</c:choose>
	                                </div>
	                                <c:choose>
		                                <c:when test="${player.type eq 1}">
		                               		<i class="gl">管</i>
	                               		</c:when>
	                               		<c:when test="${player.type eq 2}">
		                               		<i class="dz">队</i>
	                               		</c:when>
	                                </c:choose>
                                	<c:if test="${!empty player.player_num}">
                               			<span class="i">${player.player_num}</span>
                               		</c:if>
                                	<c:if test="${!empty player.sp_id}">
                               			<span class="ban1"></span>
                               		</c:if>
	                                <div class="cf_forward">
	                                    <img src="${el:headPath()}${player.head_icon}" />
	                                </div>
	                                <dl class="attr">
	                                    <dt><span class="ms"><fmt:formatNumber value="${(nowDate.time-player.borndate.time)/1000/60/60/24/365}" pattern="#0"/> 岁</span></dt>
	                                    <dd><span class="ms">${player.height}CM</span></dd>
	                                    <dd><span class="ms">${player.weight}KG</span></dd>
	                                </dl>
	                                <dl class="quote ms">
	                                    <dt><span>能&emsp;力</span><span class="text-orange ml10">${player.score}</span></dt>
	                                    <dd><span>当前身价</span></dd>
	                                    <dd><span class="text-orange">${player.current_price}</span><span class="ml10">宇币</span></dd>
	                                </dl>
	                                <div class="ability" style="display: none;">
	                                    <table>
	                                        <tr>
		                                        <td><span class="ms">传</span><span class="ms ml5 text-orange">${player.pass_ability}</span></td>
		                                        <td><span class="ms">力</span><span class="ms ml5 text-orange">${player.power}</span></td>
		                                    </tr>
		                                    <tr>
		                                        <td><span class="ms">射</span><span class="ms ml5 text-orange">${player.shot}</span></td>
		                                        <td><span class="ms">头</span><span class="ms ml5 text-orange">${player.header}</span></td>
		                                    </tr>
		                                    <tr>
		                                        <td><span class="ms">速</span><span class="ms ml5 text-orange">${player.speed}</span></td>
		                                        <td><span class="ms">爆</span><span class="ms ml5 text-orange">${player.explosive}</span></td>
		                                    </tr>
	                                    </table>
	                                </div>
	                                <div class="auc_div">
	                                	<if test="${session_user_id ne player.user_id}">
	                                    	<input type="button" name="name" value="私信" class="btn_ll ms" onclick="openMsg('${player.user_id}','${player.usernick}');"/>
	                                    </if>
	                                    <input type="button" name="name" value="" class="setting" />
	                                    <div class="tools_b">
	                                        <dl>
	                                        	<c:if test="${session_user_id eq user_id}">
	                                        		<c:if test="${player.type ne 1}">
			                                            <dd><span onclick="changeRole('1','${player.user_id}');">成为主席</span></dd>
	                                        		</c:if>
	                                        		<c:if test="${player.type eq 3}">	
		                                            	<dd><span onclick="changeRole('2','${player.user_id}');">任命队长</span></dd>
		                                            </c:if>
		                                            <c:if test="${player.type eq 2}">
		                                            	<dd><span onclick="changeRole('3','${player.user_id}');">取消任命</span></dd>
		                                            </c:if>
		                                            <dd><span class="fenpei" onclick="selectNum('${player.user_id}');">分配号码</span></dd>
		                                            <c:if test="${player.type eq 2 || player.type eq 3}">
		                                            	<c:choose>
		                                            		<c:when test="${player.is_sale eq 1}">
		                                            			<dd><span onclick="delSell('${player.id}');">取消挂牌</span></dd>
		                                            		</c:when>
		                                            		<c:otherwise>
			                                            		<dd><span id="guapai" onclick="toSellPage('${player.id}');">挂牌出售</span></dd>
		                                            		</c:otherwise>
		                                           		</c:choose>	
		                                           		<dd><span onclick="kickTeam('${player.user_id}');">踢&emsp;&emsp;出</span></dd>
		                                            	<%-- <dd><span onclick="defriend('${player.user_id}');">拉&emsp;&emsp;黑</span></dd> --%>
		                                            </c:if>	
		                                        </c:if>    	                                        
		                                    </dl>
	                                    </div>
	                                </div>
	                            </div>
	                        </li>
                        </c:forEach>
                        <c:forEach items="${team_loan_players.items}" var="player" varStatus="i">                    	
	                        <li>
	                            <div class="auction_super">
	                                <div class="name ms f24">${player.usernick}</div>
	                                <span class="po ms f14">
	                                	<c:forEach items="${fn:split(player.love_position,',')}" var="pos" end="0">
		                            		<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
		                            	</c:forEach>
	                               	</span>
	                                <!--标记-->
	                                <div class="player_cf">
	                                    <c:choose>
		                            		<c:when test="${!empty player.love_position}">
				                            	<c:forEach items="${fn:split(player.love_position,',')}" var="pos" end="0">
				                            		<c:choose>	
				                            			<c:when test="${fn:contains(qc, pos)}">
				                            				<img src="${ctx}/resources/images/player_fw.png" />
				                            			</c:when>
				                            			<c:when test="${fn:contains(zc, pos)}">
				                            				<img src="${ctx}/resources/images/player_cf.png" />
				                            			</c:when>
				                            			<c:when test="${fn:contains(hc, pos)}">
				                            				<img src="${ctx}/resources/images/player_ga.png" />
				                            			</c:when>
				                            			<c:when test="${fn:contains(sm, pos)}">
				                            				<img src="${ctx}/resources/images/player_gk.png" />
				                            			</c:when>
				                            		</c:choose>
				                            	</c:forEach>
		                            		</c:when>
		                            		<c:otherwise>
				                                <img src="${ctx}/resources/images/player_gk.png" />
		                            		</c:otherwise>
		                            	</c:choose>	
	                                </div>
		                           	<i class="gl">租</i>
                                	<c:if test="${!empty player.player_num}">
                               			<span class="i">${player.player_num}</span>
                               		</c:if>
                                	<c:if test="${!empty player.sp_id}">
                               			<span class="ban1"></span>
                               		</c:if>
	                                <div class="cf_forward">
	                                    <img src="${el:headPath()}${player.head_icon}" />
	                                </div>
	                                <dl class="attr">
	                                    <dt><span class="ms"><fmt:formatNumber value="${(nowDate.time-player.borndate.time)/1000/60/60/24/365}" pattern="#0"/> 岁</span></dt>
	                                    <dd><span class="ms">${player.height}CM</span></dd>
	                                    <dd><span class="ms">${player.weight}KG</span></dd>
	                                </dl>
	                                <dl class="quote ms">
	                                    <dt><span>能&emsp;力</span><span class="text-orange ml10">${player.score}</span></dt>
	                                    <dd><span>当前身价</span></dd>
	                                    <dd><span class="text-orange">${player.current_price}</span><span class="ml10">宇币</span></dd>
	                                </dl>
	                                <div class="ability" style="display: none;">
	                                    <table>
	                                        <tr>
		                                        <td><span class="ms">传</span><span class="ms ml5 text-orange">${player.pass_ability}</span></td>
		                                        <td><span class="ms">力</span><span class="ms ml5 text-orange">${player.power}</span></td>
		                                    </tr>
		                                    <tr>
		                                        <td><span class="ms">射</span><span class="ms ml5 text-orange">${player.shot}</span></td>
		                                        <td><span class="ms">头</span><span class="ms ml5 text-orange">${player.header}</span></td>
		                                    </tr>
		                                    <tr>
		                                        <td><span class="ms">速</span><span class="ms ml5 text-orange">${player.speed}</span></td>
		                                        <td><span class="ms">爆</span><span class="ms ml5 text-orange">${player.explosive}</span></td>
		                                    </tr>
	                                    </table>
	                                </div>
	                                <div class="auc_div">
	                                	<if test="${session_user_id ne player.user_id}">
	                                    	<input type="button" name="name" value="私信" class="btn_ll ms" onclick="openMsg('${player.user_id}','${player.usernick}');"/>
	                                    </if>
	                                    <input type="button" name="name" value="" class="setting" />
	                                    <div class="tools_b">
	                                        <dl>
	                                        	<c:if test="${session_user_id eq user_id}">
		                                            <dd><span class="fenpei" onclick="selectLoanNum('${player.id}');">分配号码</span></dd>
		                                        </c:if>    	                                        
		                                    </dl>
	                                    </div>
	                                </div>
	                            </div>
	                        </li>
                        </c:forEach>
                        <div class="clearit"></div>
                    </ul>
                </div>
            </div>
        </div>
    </div>

	<%@ include file="../../common/footer.jsp" %>  
	<script src="${ctx}/resources/js/own/playeropt.js"></script>
	<script src="${ctx}/resources/js/own/msg.js"></script>
    <script type="text/javascript">
        jQuery.fn.center = function () {
            this.css("position", "absolute");
            this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
            this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
            return this;
        }

        $($(".a_list .auction_super")).each(function () {
            $(this).mouseover(function () {
                $(this).find(".quote").hide();
                $(this).find(".ability").show();
            });
        }).mouseout(function () {
            $(this).find(".quote").show();
            $(this).find(".ability").hide();

        });

        $($(".auction_super .i")).each(function () {
            $(this).mouseover(function () {
                $(this).next(".numbers").show();
            }).mouseout(function () {
                $(this).next(".numbers").hide();
            });
        });

        $($(".setting")).each(function () {
            $(this).click(function () {
                if ($(this).next(".tools_b").is(":visible")) {
                    $(this).next(".tools_b").hide();
                } else {
                    $(this).next(".tools_b").show();
                }
                
            });
        });

        

       /*  $("#guapai").click(function () {
            var h = $(document).height();
            $(".masker").css("height", h).show();
            $(".notice").center().show();
        }); */

        function cl() {
            $(".masker").hide();
            $(".select_jersey").hide();
            $(".notice").hide();
        }

        $("#cannel").click(function () {
            cl();
        });
        $(".closeBtn_1").click(function () {
            cl();
        });
    </script>
</body>
</html>
