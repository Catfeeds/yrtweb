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
        var score = $("#player_ability_score").text();
        $("#player_ability_score").text((parseInt(score)+(parseInt(pos)-parseInt(oldval))));
        inp.val(pos);
    }
}


$(function(){
	//load_center_player();
	player_info();
})

//是否球员
function player_info(){
	var othUserId = $("#oth_user_id").val();
	var params = $.param({othUserId:othUserId});
	$.ajax({
		type:'POST',
		url: base+'/player/hasPlayer',
		data: params,
		cache: false,
		dataType:'json',
		success: function(result){
			render_info(result);
		},
		error: $.ajaxError
	});
}

function render_info(data){
	var info = $("#new_player");
	if(data.state=="success"){
		info.find("[data-id=activate]").remove();
		if(data.data.isme){
			info.find("[data-id=playerBtn]").remove();
		}else{
			info.find("[data-id=playerBtn]").show();
		}
		load_center_player();
	}else{
		info.find("[data-id=playerBtn]").remove();
		if(data.data.isme){
			info.find("[data-id=activate]").show();
			info.attr("onclick","player_activation()");
		}else{
			//info.find("[data-id=activate]").remove();
			info.find("[data-id=activate]").attr("onclick","").text("未激活");
		}
	}
	info.find('.functionality').show();
}

/**
 * 球员激活按钮
 */
function player_activation(){
	$.ajaxSec({
		type: 'POST',
		url: base+'/center/hasBaby',
		cache: false,
		success: function(result){
			if (result.state=='success') {
				yrt.confirm('　　　激活球员，放飞梦想', {
				    btn: ['确定','取消'], //按钮
				    shade: true, //不显示遮罩
				    cwidth:'46%'
				}, function(){
					var index = yrt.msg('加载中', {icon: 16,time: 0});
					load_center_player();
				}, function(){});
            }else{
            	layer.msg('抱歉，足球宝贝暂不能激活球员信息',{icon: 2});
            }
		},
		error: $.ajaxError
	});
}

//加载球员页面
function load_center_player(){
	$.loadSec("#center_player",base+"/center/playerInfo",{oth_user_id:$("#oth_user_id").val()},function(){
		create_player_model();
		center_player_data();
		center_player_career_hobby('career');
	});
}

function center_player_edit(){
	$.loadSec("#center_player_info",base+"/player/updatePlayer",{type:'info'},function(){
		$("#center_ability_tools").find("[data-id=goodbtn]").hide();
		$("#center_ability_tools").find("[data-id=badbtn]").hide();
		$("#center_ability_tools").find("[data-id=appr]").hide();
		set_player_ability(playerinfo.datas,true);
	});
}
function center_player_career_hobby(type){
	$.loadSec("#center_player_career_hobby",base+"/player/updatePlayer",{type:type,oth_user_id:$("#oth_user_id").val()},function(){
		if(type=='career'){
			center_team();
		}
	});
}

function center_team(){
	$.post(base+'/player/team',{oth_user_id:$("#oth_user_id").val()},function(result){
		var player_team = $("#center_team")
		if(result.state=='success'){
			if(!result.data.isme){
				player_team.find('[data-btn]').remove();
			}
			$('#center_team_id').val(result.data.data.id);
			player_team.find('[data-id=usernick]').text(result.data.data.name).attr("onclick","window.open('"+base+"/team/detail/"+result.data.data.user_id+".html')");
		}else{
			if(!result.data.isme){
				player_team.find('[data-id=usernick]').parent().empty().html('<h3 style="width: 790px;" class="text-center f18 ms">Ta还没有加入任何俱乐部</h3>');
			}else{
				player_team.find('[data-id=usernick]').text('暂无效力俱乐部');
				player_team.find('[data-id=usernick]').parent().append('<a onclick="input_activeCode()" class="new_btn_l ml10">使用激活码加入俱乐部</a><a class="new_btn_l ml10" href="'+base+'/team/list">前往寻找俱乐部</a>').append('<a class="new_btn_l ml10" href="'+base+'/team/info">自由创建俱乐部</a>');
			}
			player_team.find('[data-btn]').remove();
		}
	});
}

function input_activeCode(){
	if(!check_user_role())return;
	$.ajaxSec({
		type: 'POST',
		url: base+"/center/checkCertTrue",
		success: function(data){
			if(data.state=='error'){
				if(data.message){
					layer.msg(data.message.error[0],{icon:2});
				}else{
					yrt.confirm('只有已通过实名认证的用户可参赛，请先进行实名认证！', {
					    btn: ['前往实名认证','取消'],
					    cwidth:'92%'
					}, function(){
					    location.href=base+'/certificat/IDinfo';
					}, function(){});
				}
			}else{
				$(".makser").height($(document).height()).fadeIn();
				$("#active_code").val("");
			    $(".invitation_code").center().fadeIn();
			}
		},
		error: $.ajaxError
	});
}
function close_activeCode() {
    $(".makser").fadeOut();
    $(".invitation_code").fadeOut();
}

function activeCodeTeam(){
	if(!check_user_role())return;
	var code = $("#active_code").val();
	if(!code){
		layer.msg('邀请码不能为空！',{icon:2});
	}
	$.ajaxSec({
		type: 'POST',
		url: base+"/league/activeCodeForTeam",
		data: {"code_str":$("#active_code").val()},
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				yrt.confirm('该邀请码所属俱乐部为('+data.data.data.area+'赛区)（'+data.data.data.team.name+'），是否确认加入？？', {
				    btn: ['确定','取消'], //按钮
				    shade: false, //不显示遮罩
				    cwidth:'90%'
				}, function(){
					activeCode(code);
				}, function(){
					close_activeCode();
				});
			}
		},
		error: $.ajaxError
	});	
}

function activeCode(code){
	if(!check_user_role())return;
	$.ajaxSec({
		type: 'POST',
		url: base+"/league/activePlayerCode",
		data: {"code_str":code},
		success: function(data){
			if(data.state=='error'){
				yrt.msg(result.message.error[0],{icon: 2});
			}else{
				yrt.msg('激活成功！',{icon:1});
				location.reload();
			}
		},
		error: $.ajaxError
	});	
}

/**
 * 退队
 */
function quitTeam(){
	yrt.confirm('是否退出当前球队？', {
	    btn: ['是','否'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/player/quitTeam',
			data: {"teaminfo_id":$("#center_team_id").val()},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					center_team();
					yrt.msg("退出成功",{icon: 1});
                } else {
                	yrt.msg("退出失败,"+result.message.error[0],{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

var playerinfo;
function create_player_model(){
	playerinfo = new Vmodel({url:base+'/player/info',sendData:{oth_user_id:$("#oth_user_id").val(),type:'info'},modelContainer:'#center_player_info',modelTemp:$('#center_player_info_temp').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
		var vm = $(playerinfo.options.modelTemp);
		vm.css('display','block');
		if(one.ball_format){
			if(one.ball_format==7){
				vm.find('[data-id=ball_format]').text("7/8/9人制");
			}else{
				vm.find('[data-id=ball_format]').text(one.ball_format+"人制");
			}
		}
		if(one.cfoot){
			if(one.cfoot=='lfoot'){
				vm.find('[data-id=cfoot]').text("左脚");
			}else if(one.cfoot=='rfoot'){
				vm.find('[data-id=cfoot]').text("右脚");
			}else if(one.cfoot=='lrfoot'){
				vm.find('[data-id=cfoot]').text("不限");
			}
		}
		if(one.love_num){
			vm.find('[data-id=love_num]').text(one.love_num+"  号");
		}
		return vm.get(0).innerHTML;
	},
	afterRenderList:function(c,v,d){
		set_player_ability(d,false);
		$("#center_ability_tools").find("[data-id=goodbtn]").show();
		$("#center_ability_tools").find("[data-id=badbtn]").show();
		$("#center_ability_tools").find("[data-id=appr]").show();
	}});
}

function center_player_data(){
	playerinfo.loadData().done(function(data){
		if(data.state=='success'&&data.data.data){
			playerinfo.renderModel(data.data.data,'reloaded');
			praise_count(data.data.praiseCount);
		}else{
			update_player_info('#center_player_ability');
		}
		if(data.data.ispra){
			$("#center_ability_tools").find("[data-id=goodbtn]").attr("title","取消认可");
		}
		if(data.data.iscai){
			$("#center_ability_tools").find("[data-id=badbtn]").attr("title","取消不认可");
		}
	});
}

function update_player_info(){
	center_player_edit();
}

function player_praise(state,dom){
	var flag = $(dom).attr("flag");
	if(flag==1){
		$(dom).attr("flag",0);
  		$.ajaxSec({
			type: 'POST',
			url: base + '/player/praise',
			data: {p_user_id:$("#oth_user_id").val(),p_state: state},
			success: function(data){
				if(data.state == 'success'){
					var str = state==1?'认可':'不认可';
					$(dom).text(data.data.praiseCount);
					if(data.data.flag==1){
						$(dom).attr('title','取消'+str);
					}else{
						$(dom).attr('title',str);
					}
					var good  = $("#center_ability_tools").find("[data-id=goodbtn]").text();
					var bad = $("#center_ability_tools").find("[data-id=badbtn]").text();
					var obj = {praise:good,cai:bad};
					praise_count(obj);
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
	var sdiv = $("#center_ability_tools");
	var good = obj.praise;
	var bad = obj.cai;
	if(parseInt(good)>=10000){
		sdiv.find("[data-id=goodbtn]").text(Math.round((good/10000)*100)/100+'万');
	}else{
		sdiv.find("[data-id=goodbtn]").text(good);
	}
	if(parseInt(bad)>=10000){
		sdiv.find("[data-id=badbtn]").text(Math.round((bad/10000)*100)/100+'万');
	}else{
		sdiv.find("[data-id=badbtn]").text(bad);
	}
	var ap = 100;
	if(parseInt(bad)){
		ap = Math.round((parseInt(good)/(parseInt(good)+parseInt(bad)))*100);
	}
	sdiv.find("[data-id=approve]").text(ap+"%");
}


function set_player_ability(data,flag){
	var abil = $("#center_player_ability");
	$("#player_ability_score").text((data?data.score:750));
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
		$('#'+name+'_btn').css("left",(150*(parseFloat(val)/100))+'px');
		$('#'+name+'_title').parent().find("input[type=hidden]").val(val);
		new scale(name+'_btn', name+'_bar', name+'_title');
	})
}

function reloadInfo(result){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		$("#new_player").find("[data-id=activate]").remove();
		center_player_data();
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}

function save_player_info(){
	var pos = $("#p_position").val();
	if(pos&&pos.length>0){
		$.ajaxSubmit('#update_player_form','#update_player_form',reloadInfo);
	}else{
		var tipsIndex = layer.tips('请选择场上位置!',"#p_position_chosen",{
        	tips: [2, '#c00']
        });
	}
}

function trialHide(){
	$('.trial').find("input[type=text]").val("");
	$('.trial').find("textarea").val("");
	$('.trial').hide();
}

//试训弹窗
function trialShow(){
	trialHide();
	var othUserId = $("#oth_user_id").val();
	var params = $.param({othUserId:othUserId});
	$.ajaxSec({
		type:'POST',
		url: base+'/player/inviteTrial',
		data: params,
		cache: false,
		dataType:'json',
		success: function(result){
			if(result.data.errorMsg){
				layer.msg(result.data.errorMsg,{icon: 2});
			}else{
				$('.trial').find("[data-id=usernick]").text(result.data.userNick);
				$('.trial').center().show();
			}
		},
		error: $.ajaxError
	});
}
//试训保存回调
function trialFormHandler(result){
	if(result.data&&result.data.errorMsg){
		layer.msg(result.data.errorMsg,{icon: 2});
	}else{
		layer.msg("邀请发送成功",{icon: 1});
		trialHide();
	}
}

function inviteTTPA(){
	var playerId = $("#oth_user_id").val();
	var params = $.param({playerId:playerId});
	yrt.confirm('确定要邀请该球员加入球队吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: true, //不显示遮罩
	    cwidth:'80%'
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/player/teamByPlayer',
			data: params,
			success: function(result){
				if(result.state=='success'){
					yrt.msg("邀请发送成功",{icon: 1});
				}else{
					yrt.msg(result.message.error[0],{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}
