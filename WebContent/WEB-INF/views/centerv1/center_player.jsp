<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="new_player">
    <!--能力展示-->
    <div id="center_player_info_temp" style="display: none;">
    <div class="title">
        <span class="text-white f16 ms t">球员能力</span>
        <div class="pull-right mr20">
        	<c:if test="${isme=='1'}">
            <a id="player_info_btn" href="javascript:center_player_edit()" class="new_btn_l" style="color: white;">编辑</a>
            </c:if>
        </div>
        <div class="clearit"></div>
    </div>
    <table class="ability">
        <tr>
            <td class="w115"><span>身&emsp;&emsp;高 /</span></td>
            <td><span class="text-white">{{height}} CM</span></td>
            <td class="w115"><span>体&emsp;&emsp;重 /</span></td>
            <td><span class="text-white">{{weight}} KG</span></td>
            <td class="w115"><span>&emsp;惯用脚 /</span></td>
            <td><span class="text-white" data-id="cfoot"></span></td>
        </tr>
        <tr>
            <td class="w115"><span>场上位置 /</span></td>
            <td><span class="text-white">{{position}}</span></td>
            <td class="w115"><span>类&emsp;&emsp;型 /</span></td>
            <td><span class="text-white">{{type}}</span></td>
            <td class="w115"><span>擅长赛制 /</span></td>
            <td><span class="text-white" data-id="ball_format"></span></td>
        </tr>
        <tr>
            <td class="w115"><span>特长能力 /</span></td>
            <td><span class="text-white">{{tags}}</span></td>
            <td class="w115"><span>我的号码 /</span></td>
            <td><span class="text-white" data-id="love_num"></span></td>
        </tr>
    </table>
    </div>
    <form id="update_player_form" action="${ctx}/player/saveOrUpdateInfo" method="post">
    <div id="center_player_info">
    </div>
    <!--点赞-->
    <div id="center_ability_tools" class="point_like">
        <span class="text-white f20 ms ml35">综合能力<span class="ml20" id="player_ability_score"></span></span>
        <a onclick="player_praise(1,this)" data-id="goodbtn" flag="1" title="认可" class="text-white like ml20" style="cursor: pointer;">0</a>
        <a onclick="player_praise(2,this)" data-id="badbtn" flag="1" title="不认可" class="text-white d_like ml10" style="cursor: pointer;">0</a>
        <span class="text-white ms ml15 f16 fw" data-id="appr" title="获得认可，提升认可度">认可度：<span class="ms percent" data-id="approve" title="认可度根据左侧的认可数和不认可数得出。请点击左侧拇指图标给予认可。"></span></span>
    </div>

    <div id="center_player_ability" class="inability">
        <table class="abil">
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
	                   <input type="hidden" name="speed" value=""/>
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
	                   <input type="hidden" name="power" value=""/>
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
	                   <input type="hidden" name="balance" value=""/>
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
	                   <input type="hidden" name="respond_ability" value=""/>
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
	                   <input type="hidden" name="explosive" value=""/>
                        <div class="clearit"></div>
                    </div>
                </td>
            </tr>
            
        </table>
        <table class="abil ml50">
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
	                   <input type="hidden" name="physical" value=""/>
                        <div class="clearit"></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="bar_progress">
                        <span class="pull-left f12 text-white">控&emsp;&emsp;球</span>
                        <div data-type="edit" class="scale_panel">
	                       <div class="scale" id="ball_ability_bar">
	                           <div data-value="ball_ability"></div>
	                           <span id="ball_ability_btn" data-abtn style=""></span>
	                       </div>
	                   	</div>
	                   <span id="ball_ability_title" data-id="fenshu" data-name="ball_ability" class="result">0</span>
	                   <input type="hidden" name="ball_ability" value=""/>
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
	                   <input type="hidden" name="pass_ability" value=""/>
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
	                   <input type="hidden" name="shot" value=""/>
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
	                   <input type="hidden" name="tack_ability" value=""/>
                        <div class="clearit"></div>
                    </div>
                </td>
            </tr>
            
        </table>
        <table class="abil ml50">
            
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
	                   <input type="hidden" name="header" value=""/>
                        <div class="clearit"></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="bar_progress">
                        <span class="pull-left f12 text-white">&emsp;定位球</span>
                        <div data-type="edit" class="scale_panel">
	                       <div class="scale" id="free_kick_bar">
	                           <div data-value="free_kick"></div>
	                           <span id="free_kick_btn" data-abtn style=""></span>
	                       </div>
	                   	</div>
	                   <span id="free_kick_title" data-id="fenshu" data-name="free_kick" class="result">0</span>
	                   <input type="hidden" name="free_kick" value=""/>
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
	                   <input type="hidden" name="goal" value=""/>
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
	                   <input type="hidden" name="insight" value=""/>
                        <div class="clearit"></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="bar_progress">
                        <span class="pull-left f12 text-white">团队协作</span>
                        <div data-type="edit" class="scale_panel">
	                       <div class="scale" id="fill_bar">
	                           <div data-value="fill"></div>
	                           <span id="fill_btn" data-abtn style=""></span>
	                       </div>
	                   	</div>
	                   <span id="fill_title" data-id="fenshu" data-name="fill" class="result">0</span>
	                   <input type="hidden" name="fill" value=""/>
                        <div class="clearit"></div>
                    </div>
                </td>
            </tr>
        </table>
        <div class="clearit"></div>
    </div>
    </form>
    <div id="center_player_career_hobby">
    </div>
</div>
