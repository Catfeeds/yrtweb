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
<style>
#fix_image{
   width: 176px;
   height: 245px;
   display: table-cell;
   text-align: center;
   vertical-align: middle;
}
#fix_image img{
    display: inline-block;
    vertical-align: middle;
}
</style>
</head>
<body>
	<div class="warp">
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
                	<c:choose>
                		<c:when test="${leagueSign.status==3}">
                    <ul style="margin-left: 148px;">
                		</c:when>
                		<c:otherwise>
              		<ul>
                		</c:otherwise>
                	</c:choose>
                        <li class="actived"><span>1、报名须知</span></li>
                        <li class=""><span>2、填写资料</span></li>
                        <c:choose>
		                	<c:when test="${leagueSign.status==1}">
		                		<li class=""><span>3、等待审核</span></li>
		                        <!-- <li class="active"><span>4、支付报名费</span></li> -->
		                        <li class=""><span>4、参赛方式</span></li>
		                        <li class=""><span>5、完成</span></li>
		                	</c:when>
		                	<c:when test="${leagueSign.status==2}">
		                		<li class="active"><span>3、等待审核</span></li>
		                        <!-- <li class=""><span>4、支付报名费</span></li> -->
		                        <li class=""><span>4、参赛方式</span></li>
		                        <li class=""><span>5、完成</span></li>
		                	</c:when>
		                	<c:when test="${leagueSign.status==3}">
				                <li class="active"><span>3、审核未通过</span></li>
		                	</c:when>
		                </c:choose>
                        <div class="clearit"></div>
                    </ul>
                </div>
                <div class="clearit"></div>
                <div class="reg_area">
                    <div id="league_image" class="reg_l">
                    	<div id="fix_image">
                    	<img src="${el:headPath()}${leagueSign.image_src}" alt="" style="width: 176px;height: 245px;" />
                    	</div>
                    </div>
                    <div class="reg_r" style="float: left;">
                        <table>
                            <tr>
                                <td class="r"><span class="f14 ms text-white">真实姓名</span></td>
                                <td>
                                    <span class="text-white f12 ml20">${certification.name}</span>
                                </td>
                                <td class="r"><span class="f14 ms text-white">身份证号</span></td>
                                <td>
                                    <span class="text-white f12 ml20">${certification.id_card}</span>
                                </td>
                            </tr>
                            <tr>
                            	<td class="r"><span class="f14 ms text-white">出生日期</span></td>
                                <td>
                                    <span class="text-white f12 ml20"><fmt:formatDate pattern="yyyy-MM-dd" value="${leagueSign.birth_date}" /></span>
                                </td>
                                <td class="r"><span class="f14 ms text-white">联系电话</span></td>
                                <td>
                                    <span class="text-white f12 ml20">${leagueSign.mobile}</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="r"><span class="f14 ms text-white">身&emsp;&emsp;高</span></td>
                                <td>
                                    <span class="text-white f12 ml20">${leagueSign.height}CM</span>
                                </td>
                                <td class="r"><span class="f14 ms text-white">体&emsp;&emsp;重</span></td>
                                <td>
                                    <span class="text-white f12 ml20">${leagueSign.weight}KG</span>

                                </td>
                            </tr>
                            <tr>
                                <td class="r"><span class="f14 ms text-white">场上位置</span></td>
                                <td>
                                    <span class="text-white f12 ml20">${leagueSign.position}</span>
                                </td>
                                <td class="r"><span class="f14 ms text-white">惯&nbsp;&nbsp;用&nbsp;脚</span></td>
                                <td>
                                    <span class="text-white f12 ml20">
                                    <c:choose>
                                    	<c:when test="${leagueSign.cfoot=='lfoot'}">
                                    	左脚
                                    	</c:when>
                                    	<c:otherwise>
                                    	右脚
                                    	</c:otherwise>
                                    </c:choose>
                                    </span>

                                </td>
                            </tr>
                             <tr>
                                <td class="r"><span class="f14 ms text-white">球衣号码</span></td>
                                <td>
                                	<c:choose>
                                		<c:when test="${!empty leagueSign }">
                                			<c:forEach items="${leagueSign.love_num}" var="nums">
                                				<div class="chosen">${nums }</div>
                                			</c:forEach>
                                		</c:when>
                                	</c:choose>
                                </td>
                                <td class="r"><span class="f14 ms text-white">性&emsp;&emsp;别</span></td>
                                <td>
                                    <span class="text-white f12 ml20">
                                    <c:choose>
                                    	<c:when test="${leagueSign.sex==1}">
                                    	男
                                    	</c:when>
                                    	<c:otherwise>
                                    	女
                                    	</c:otherwise>
                                    </c:choose>
                                    </span>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div class="clearit"></div>
                </div>
                <style>
                </style>
                <div class="reg_id">
                    <h3 class="text-white ms f16">身份证正反两面</h3>
                    <ul>
                        <li id="card_image_z" msg="正"><img style="width: 300px;height: 182px;" src="${el:headPath()}${fn:substring(certification.img_src,0, fn:indexOf(certification.img_src, ','))}" alt="" /></li>
                        <li id="card_image_f" msg="反"><img style="width: 300px;height: 182px;" src="${el:headPath()}${fn:substring(certification.img_src,fn:indexOf(certification.img_src, ',')+1, fn:length(certification.img_src))}" alt="" /></li>
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
                <c:if test="${leagueSign.status==3}">
                <div style="width: 790px;padding: 15px; margin: 20px auto;border: 1px dashed #666;color: #fff;">
                    <dl>
                        <dt><span class="f16 ms">未通过原因</span></dt>
                        <dd class="mt10"><span>${leagueSign.reason}</span></dd>
                    </dl>
                </div>
                </c:if>
                <div style="width:600px;margin: 40px auto 0;text-align: center; ">
                	<c:if test="${leagueSign.status!=1}">
                    <input type="button" flag="1" id="repeat_sign_btn" onclick="repeat_sign(this)" value="修改资料" class="btn_l f18 ms" />
                	</c:if>
                    <input type="button" onclick="cancel_reg('${leagueSign.id}')" value="取消报名" class="btn_g f18 ms" style="margin-left: 80px;"/>
                </div>
            </div>
            </form>
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/admin/js/jquery.chosen.min.js"></script>
    <script src="${ctx}/resources/fileupload/webuploader/webuploader.js"></script>
	<script src="${ctx}/resources/fileupload/fileUploader.js"></script>
<script type="text/javascript">
$(function(){
	$(".scale").css("background","none");
	set_player_ability();
	
	fixImageWH('#fix_image');
})

function repeat_sign(){
	location.href=base+"/league/toSign?cfg_id="+$("#cfg_id").val()+"&tag=repeat";
}

function set_player_ability(){
	var abil = $(".reg_ability");
	abil.find('.bar_progress').each(function(){
		//ability.find('[data-abtn]').show();
		abil.find('[data-abtn]').hide();
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
	})
}

function cancel_reg(sid){
	yrt.confirm('是否确认取消报名？', {
	    btn: ['是','否'], //按钮
	    shade: true
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/league/quitLeagueSign',
			data: {"id":sid},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					yrt.msg("取消报名成功",{icon: 1});
					setTimeout(function(){
						location.href=base+"/league/identity?cfg_id="+$("#cfg_id").val();
					},1400);
                } else {
                	if(result.data&&result.data.l_status==1){
                		yrt.msg("取消失败，您已经报名成功！",{icon: 1});
                		setTimeout(function(){
    						location.reload();
    					},1400);
            		}else{
	                	yrt.msg("取消报名失败,"+result.message.error[0],{icon: 2});
            		}
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

function fixImageWH(dom) {
	var parent = $(dom);
	var img = parent.find("img");
    var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
    if (iw / ih > parent.width() / parent.height()) {
        img.css({
            width: '100%',
            height: 'auto'
        });
    } else {
        img.css({
            width: 'auto',
            height: '100%'
        });
    }
}
</script>
</body>
</html>