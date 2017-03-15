<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="main_info">
    <div id="playerInfoTemp" style="width: 378px;float: left;display: none;">
    	<div class="theMain ml10 clearfix">
            <span class="fw text-white pull-left ml15">球员属性</span>
        </div>
        <div class="clearit"></div>
        <!--展示框-->
        <table class="theMain_1" style="margin: 46px auto;">
         <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">身　　高：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10">{{height}}　CM</span>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">体　　重：</span>
                </td>
                <td class="w158">
                  <span class="f12 ml10">{{weight}}　KG</span> 
                </td>
            </tr>
             <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">场上位置：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10">{{position}}</span>
                </td>
            </tr>
             <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">类　　型：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10">{{type}}</span>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">百米成绩：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10" data-id="results"></span>
                </td>
            </tr>
             <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">特长能力：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10">{{tags}}</span>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">职业状态：</span>
                </td>
                <td class="w158">
                    <span data-id="pro_status" class="f12 ml10"></span>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">惯 用 脚：</span>
                </td>
                <td class="w158">
                    <span data-id="cfoot" class="f12 ml10"></span>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">&emsp;常踢赛制：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10" data-id="ball_format"></span>
                </td>
            </tr>
             <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">组队邀请：</span>
                </td>
                <td class="w158">
                    <span data-id="invitat_team" class="f12 ml10"></span>
                </td>
            </tr>
           
           
           <!--  <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">颠球数：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10">{{bou_count}}</span>
                </td>
            </tr>
            <tr>
                <td class="w140">
                    <span class="text-gray-s_81 f12">跑动距离(m)：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10">{{distance}}</span>
                </td>
            </tr> -->
            
            <!-- <tr>
                <td class="w140"> 
                    <span class="text-gray-s_81 f12">球员模版：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10">{{player_temp}}</span>
                </td>
            </tr> 
            <tr>
                <td class="w140"> 
                    <span class="text-gray-s_81 f12">伤 病 史：</span>
                </td>
                <td class="w158">
                    <span class="f12 ml10">{{injured_area}}</span>
                </td>
            </tr>-->
           
           
           
            
        </table>
    </div>
    <form id="editInfo" action="${ctx}/player/saveOrUpdateInfo" method="post">
    <input type="hidden" id="edit_state" value="1"/>
    <div id="playerInfo" style="width: 378px;float: left;">
        
    </div>
    <div id="playerability" style="width: 378px;float: left;">
        <div class="theMain ml10 clearfix">
            <span class="fw text-white pull-left ml25">　</span> <span id="player_ability" onclick="update_player_info(this)" class="yt_editer text-white pull-right"></span>
        </div>
        <div class="clearit"></div>
       <%--  <form id="editAbility" action="${ctx}/player/updateAbility" method="post"> --%>
        <input type="hidden" data-id="bou_count" name="bou_count" value=""/>
        <table class="the_ability" style="line-height: 20px;">
            <tr>
                <th colspan="2">
                <div class="ru f20 ms">
                <span class="pull-left mt10 f18" data-id="score"></span>
                <div class="goodbad">
                    <ul>
                        <li>
                            <dl>
                                <dt><span class="good" flag="1" title="赞" onclick="do_praise(1,this)" style="cursor: pointer;" data-id="goodbtn"></span></dt>
                                <dd><span class="f12 song" data-id="good">0</span></dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="ml20">
                                <dt><span class="bad" flag="1" title="踩" onclick="do_praise(2,this)" style="cursor: pointer;" data-id="badbtn"></span></dt>
                                <dd><span class="f12 song" data-id="bad">0</span></dd>
                            </dl>
                        </li>
                        <div class="clearit"></div>
                    </ul>
                </div>
                <div class="clearit"></div>
                </div>
                </th>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;速&emsp;&emsp;度</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="speed_bar">
                           <div data-value="speed"></div>
                           <span id="speed_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="speed_title" data-id="fenshu" data-name="speed" class="result">0</span>
                   <input type="hidden" name="speed" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;力&emsp;&emsp;量</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="power_bar">
                           <div data-value="power"></div>
                           <span id="power_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="power_title" data-id="fenshu" data-name="power" class="result">0</span>
                   <input type="hidden" name="power" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;爆 发 力</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="explosive_bar">
                           <div data-value="explosive"></div>
                           <span id="explosive_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="explosive_title" data-id="fenshu" data-name="explosive" class="result">0</span>
                   <input type="hidden" name="explosive" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;协 调 性</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="balance_bar">
                           <div data-value="balance"></div>
                           <span id="balance_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="balance_title" data-id="fenshu" data-name="balance" class="result">0</span>
                   <input type="hidden" name="balance" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;反 应 性</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="respond_ability_bar">
                           <div data-value="respond_ability"></div>
                           <span id="respond_ability_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="respond_ability_title" data-id="fenshu" data-name="respond_ability" class="result">0</span>
                   <input type="hidden" name="respond_ability" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;体&emsp;&emsp;力</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="physical_bar">
                           <div data-value="physical"></div>
                           <span id="physical_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="physical_title" data-id="fenshu" data-name="physical" class="result">0</span>
                   <input type="hidden" name="physical" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;传&emsp;&emsp;球</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="pass_ability_bar">
                           <div data-value="pass_ability"></div>
                           <span id="pass_ability_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="pass_ability_title" data-id="fenshu" data-name="pass_ability" class="result">0</span>
                   <input type="hidden" name="pass_ability" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;控&emsp;&emsp;球</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="ball_ability_bar">
                           <div data-value="ball_ability"></div>
                           <span id="ball_ability_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="ball_ability_title" data-id="fenshu" data-name="ball_ability" class="result">0</span>
                   <input type="hidden" name="ball_ability" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;射&emsp;&emsp;门</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="shot_bar">
                           <div data-value="shot"></div>
                           <span id="shot_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="shot_title" data-id="fenshu" data-name="shot" class="result">0</span>
                   <input type="hidden" name="shot" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;抢&emsp;&emsp;断</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="tack_ability_bar">
                           <div data-value="tack_ability"></div>
                           <span id="tack_ability_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="tack_ability_title" data-id="fenshu" data-name="tack_ability" class="result">0</span>
                   <input type="hidden" name="tack_ability" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;头&emsp;&emsp;球</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="header_bar">
                           <div data-value="header"></div>
                           <span id="header_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="header_title" data-id="fenshu" data-name="header" class="result">0</span>
                   <input type="hidden" name="header" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;洞 察 力</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="insight_bar">
                           <div data-value="insight"></div>
                           <span id="insight_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="insight_title" data-id="fenshu" data-name="insight" class="result">0</span>
                   <input type="hidden" name="insight" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;团队协作</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="fill_bar">
                           <div data-value="fill"></div>
                           <span id="fill_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="fill_title" data-id="fenshu" data-name="fill" class="result">0</span>
                   <input type="hidden" name="fill" value=""/>
                </td>
            </tr>
            <!-- <tr>
                <td>
                    <span class="pull-left f12">&emsp;进攻能力</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="attack_bar">
                           <div data-value="attack"></div>
                           <span id="attack_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="attack_title" data-id="fenshu" data-name="attack" class="result">0</span>
                   <input type="hidden" name="attack" value=""/>
                </td>
            </tr> -->
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;定 位 球</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="free_kick_bar">
                           <div data-value="free_kick"></div>
                           <span id="free_kick_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="free_kick_title" data-id="fenshu" data-name="free_kick" class="result">0</span>
                   <input type="hidden" name="free_kick" value=""/>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="pull-left f12">&emsp;守门能力</span>
                    <div data-type="edit" class="scale_panel">
                       <div class="scale" id="goal_bar">
                           <div data-value="goal"></div>
                           <span id="goal_btn" data-abtn style=""></span>
                       </div>
                   	</div>
                   <span id="goal_title" data-id="fenshu" data-name="goal" class="result">0</span>
                   <input type="hidden" name="goal" value=""/>
                </td>
            </tr>
        </table>
        </form>
    </div>
    <div class="clearit"></div>
     <div style="position: relative; width: 745px;margin: 0 auto;padding-bottom:3px; border-bottom: 1px solid #333; ">
	    <div data-type='career' class="career_tab active">
	        <span>足球生涯</span> 
	    </div>
	    <!-- <div data-type='honor' class="career_tab rongyu">
	    </div>-->
	    <div data-type='hobby' class="career_tab">
	        <span>个人爱好</span> 
	    </div>
	    <!--<div data-type='other' class="career_tab qita">
	    </div>-->
	    <!-- <span class="pull-right yt_edit  mt10"></span> -->
	    <div class="clearit"></div>
	</div>
	<div id="player_more">
	<!--职业生涯层-->
    <%@ include file="player-career.jsp" %>
    <!--荣誉层-->
	<%-- <%@ include file="player-honor.jsp" %> --%>
	<!--爱好层-->
	<%@ include file="player-hobby.jsp" %>
	<!--其他层-->
	<%-- <%@ include file="player-other.jsp" %> --%>
	</div>
	<!--图片和视频-->
    <%@ include file="player-imgvideo.jsp" %>
    <!-- <div class="yqy">
        <span class="ml20 f20 ms">我的经纪人</span>
    </div>
    <table id=player_agent class="manage">
        <tr>
            <td class="r_no"><span class="ml30" data-id="usernick"></span></td>
            <td class="r_no l_no"><span>经纪人</span></td>
            <td class="l_no"><input type="button" data-btn onclick="terminated()" value="解约" class="jybtn">
            			     <input type="hidden" id="agent_id" value="" class="jybtn">	
            </td>
        </tr>
    </table> -->
    <div class="yqy">
        <span class="ml20 f20 ms">现役俱乐部</span>
        <input type="hidden" id="teaminfo_id" data-id="id" value=""/>
    </div>
    <table id="player_team" class="manage">
        <tr>
            <td class="r_no"><span class="ml30" data-id="usernick"></span></td>
            <td class="r_no l_no"><span>俱乐部</span></td>
            <td class="l_no"><input type="button" data-btn onclick="quitTeam()" value="退出" class="jybtn"></td>
        </tr>
    </table>
</div>
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
        $(this.title).parent().find("input[type=hidden]").val(pos);
    }
}

//new scale('btn', 'bar', 'title');


$(".career_tab").click(function () {
    $(this).addClass("active").siblings().removeClass("active");
    hideTab();
    var type = $(this).attr("data-type");
    showTab(type);
});

function hideTab(){
	$('#player_more').find("[date=tab]").hide();
}
function showTab(type){
	$('#player_more').find("[data-control=player_"+type+"]").show();
	if(type=='hobby'){
		expand_hobby();
	}
	if(type=="other"){
		expand_other();
	}
	if(type=="honor"){
		expand_honor();
	}
}

function do_praise(state,dom){
	if($("#edit_state").val()==0){
		layer.msg("请先保存球员属性",{icon: 2});
		return;
	}
	var flag = $(dom).attr("flag");
	if(flag==1){
		$(dom).attr("flag",0);
  		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/player/praise',
			data: {p_user_id:$("#oth_user_id").val(),p_state: state},
			success: function(data){
				if(data.state == 'success'){
					var str = state==1?'赞':'踩';
					var type = state==1?'good':'bad';
					var pras = $("#playerability").find("[data-id="+type+"]");
					pras.text(data.data.praiseCount);
					if(data.data.flag==1){
						$(dom).attr('title','取消点'+str);
					}else{
						$(dom).attr('title',str);
					}
				}else{
					layer.msg("操作失败",{icon: 2});
				}
				$(dom).attr("flag",1);
			},
			error: $.ajaxError
		});
	}
}

function praise_count(obj){
	var sdiv = $("#playerability");
	var good = obj.praise;
	var bad = obj.cai;
	if(parseInt(good)>=10000){
		sdiv.find("[data-id=good]").text(Math.round((good/10000)*100)/100+'万');
	}else{
		sdiv.find("[data-id=good]").text(good);
	}
	if(parseInt(bad)>=10000){
		sdiv.find("[data-id=bad]").text(Math.round((bad/10000)*100)/100+'万');
	}else{
		sdiv.find("[data-id=bad]").text(bad);
	}
}

var playerinfo = new Vmodel({url:base+'/player/info',sendData:{oth_user_id:$("#oth_user_id").val(),type:'info'},modelContainer:'#playerInfo',modelTemp:$('#playerInfoTemp').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
	var vm = $(playerinfo.options.modelTemp);
	vm.css('display','block');
	if(one.pro_status==1){
		vm.find('[data-id=pro_status]').text("职业");
	}else{
		vm.find('[data-id=pro_status]').text("非职业");
	}
	if(one.invitat_team){
		vm.find('[data-id=invitat_team]').text("是");
	}else{
		vm.find('[data-id=invitat_team]').text("否");
	}
	if(one.ball_format==7){
		vm.find('[data-id=ball_format]').text("7/8/9人制");
	}else{
		vm.find('[data-id=ball_format]').text(one.ball_format+"人制");
	}
	if(one.cfoot){
		if(one.cfoot=='lfoot'){
			vm.find('[data-id=cfoot]').text("左脚");
		}else if(one.cfoot=='rfoot'){
			vm.find('[data-id=cfoot]').text("右脚");
		}else if(one.cfoot=='lrfoot'){
			vm.find('[data-id=cfoot]').text("均衡");
		}
	}
	if(one.results){
		vm.find('[data-id=results]').text(one.results+"  s");
	}
	//设置能力值
	set_player_ability(one);
	return vm.get(0).innerHTML;
}});
playerinfo.loadData().done(function(data){
	if(data.state=='success'&&data.data.data){
		playerinfo.renderModel(data.data.data,'reloaded');
		praise_count(data.data.praiseCount);
	}else{
		//update_player_nfo();
		update_player_info('#player_ability');
	}
	if(data.data.ispra){
		$("#playerability").find("[data-id=goodbtn]").attr("title","取消认可");
	}
	if(data.data.iscai){
		$("#playerability").find("[data-id=badbtn]").attr("title","取消不认可");
	}
	if(!data.data.isme){
		$("#playerInfo").find('[data-btn]').remove();
		$("#player_ability").remove();
	}
});

function update_player_info(dom){
	$(".scale").css("background","url("+base+"/resources/images/red.gif) repeat-x 0 100%");
	update_player_nfo();
	changeEdit(dom);
	$("#edit_state").val(0);
}

function update_player_nfo(){
	$.loadSec('#playerInfo',base+'/player/editPlayer',{type:'info'},function(){});
}

function changeEdit(dom){
	$(dom).attr("onclick","save_player_info(this)");
	//$(dom).attr("title","保存");
	$(dom).attr("class","pull-right text-white yt_saver");
	set_player_ability(playerinfo.datas,true);
}

function save_player_info(dom){
	var pos = $("#p_position").val();
	if(pos&&pos.length>0){
		$.ajaxSubmit('#editInfo','#editInfo',reloadInfo);
	}else{
		var tipsIndex = layer.tips('请选择场上位置!',"#p_position_chosen",{
        	tips: [2, '#c00']
        });
	}
}

function edit_ability(dom){
	$.ajaxSubmit('#editAbility','#editAbility',reloadAbility)
}

function reloadAbility(result){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		playerinfo.renderModel(result.data.data.data,'reloaded');
		praise_count(result.data.data.praiseCount);
		$("#player_ability").attr("onclick","update_player_info(this)");
		$("#player_ability").attr("class","yt_editer text-white pull-right");
		$(".scale").css("background","none");
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}


function set_player_ability(data,flag){
	var abil = $("#playerability");
	abil.find('[data-id=score]').text("综合能力值："+(data?data.score:750));
	abil.find('[data-id=bou_count]').val(data?data.bou_count:0);
	abil.find('[data-id=fenshu]').each(function(){
		if(flag){
			abil.find('[data-abtn]').show();
		}else{
			abil.find('[data-abtn]').hide();
		}
		var name = $(this).attr("data-name");
		var val = 50;
		if(data&&data[name]){
			val = data[name];
		}
		$(this).text(val);
		abil.find('[data-value='+name+']').css("width",(150*(parseFloat(val)/100)));
		$('#'+name+'_btn').css("left",(150*(parseFloat(val)/100)-8)+'px');
		$('#'+name+'_title').parent().find("input[type=hidden]").val(val);
		new scale(name+'_btn', name+'_bar', name+'_title');
	})
}

/**
 * 球员申请解约
 */
function terminated(){
	layer.confirm('是否申请与当前经纪人解约？', {
	    btn: ['是','否'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/player/terminated',
			data: {"agent_id":$("#agent_id").val()},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					layer.msg("申请已发送,请等待经纪人确认",{icon: 1});
                } else {
                	layer.msg(result.message.error[0],{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

/**
 * 退队
 */
function quitTeam(){
	layer.confirm('是否退出当前球队？', {
	    btn: ['是','否'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/player/quitTeam',
			data: {"teaminfo_id":$("#teaminfo_id").val()},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					load_player_team();
					layer.msg("退出成功",{icon: 1});
                } else {
                	layer.msg("退出失败,"+result.message.error[0],{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

function load_player_agent(){
	$.post(base+'/player/agent',{oth_user_id:$("#oth_user_id").val()},function(result){
		var player_agent = $("#player_agent")
		if(result.state=='success'){
			player_agent.find('[data-id=usernick]').text(result.data.data.usernick);
			$("#agent_id").val(result.data.data.id);
			if(!result.data.isme){
				$("#player_agent").find('[data-btn]').remove();
			}
		}else{
			player_agent.find("tr").empty().append("<td style='text-align: center;'>无经纪人</td>");
		}
	});
}
function load_player_team(){
	$.post(base+'/player/team',{oth_user_id:$("#oth_user_id").val()},function(result){
		var player_team = $("#player_team")
		if(result.state=='success'){
			if(!result.data.isme){
				$("#player_team").find('[data-btn]').remove();
			}
			$('#teaminfo_id').val(result.data.data.id);
			player_team.find('[data-id=usernick]').html('<a style="color:white;" href="'+base+'/team/detail/'+result.data.data.user_id+'.html">'+result.data.data.name+'</a>');
		}else{
			player_team.find("tr").empty().append("<td style='text-align: center;'>当前未加入任何俱乐部</td>");
		}
	});
}
$(function(){
	//load_player_agent();
	load_player_team();
})

 $("td[data-id='fenshu']").css({"text-align":"right"});
</script>

