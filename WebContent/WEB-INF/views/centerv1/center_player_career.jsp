<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="title">
    <a href="javascript:center_player_career_hobby('career')" class="f16 ms ml20 active">足球生涯</a>
    <a class="f16 ms ml10">|</a>
    <a href="javascript:center_player_career_hobby('hobby')" class="f16 ms ml10 new_love">个人爱好</a>
    <div class="clearit"></div>
</div>
<!--足球生涯-->
<div id="football_career">
	<input type="hidden" id="center_team_id" value=""/>
	<table id="center_team" class="career">
		<tr>
            <td class="w95 f_dashed"><span>现效力俱乐部：</span></td>
            <td colspan="5" class="f_dashed"><span style="cursor: pointer;" data-id="usernick"></span><!-- <a data-btn href="javascript:quitTeam()" class="new_btn_l ml10">退出</a> --></td>
        </tr>
	</table>
	<div id="player_career_edit" style="display: none;">
	<div class="f_solid"></div>
	<form id="careerEditFrom_" action="${ctx}/player/saveOrUpdateCareer" method="post" secMsg="请先完成并激活球员信息">
	<input type="hidden" name="id" value="{{id}}"/>
	<input type="hidden" id="state" value="0"/>
	<table class="career">
        <tr>
            <td colspan="6">
                <select id="start_date_{{id}}" name="start_date">
                	<c:forEach var="i" begin="1970" end="${nowYear}">
                    <option value="${i}">${i}</option>
                    </c:forEach>
                </select>&ensp;年至
                <select id="end_date_{{id}}" name="end_date" error-msg="结束年不能小于开始年" valid="require number better2num(#start_date_{{id}})">
                    <c:forEach var="j" begin="1970" end="${nowYear}">
                    <option value="${j}">${j}</option>
                    </c:forEach>
                </select>&ensp;年
            </td>
        </tr>
        <tr>
            <td class="w95">
                <span>曾效力俱乐部：</span>
            </td>
            <td class="w230">
                <input type="text" name="played_team" value="{{played_team}}" valid="require len(1,40)" />
            </td>
            <td class="w95">
                <span>参赛场数：</span>
            </td>
            <td>
                <input type="text" name="played_count" value="{{played_count}}" valid="require number" />&ensp;场
            </td>
            <td class="w95">
                <span>进球数：</span>
            </td>
            <td>
                <input type="text" name="goal_count" value="{{goal_count}}" valid="require number" />&ensp;个
            </td>
        </tr>
        <tr>
            <td class="w95"><span>&emsp;&emsp;所获荣誉：</span></td>
            <td colspan="5" class="add_rongyu">
                <input type="text" id="honor_desc_{{id}}" name="honor_desc" value="" valid="len(0,200)" class="rongyu" />
                <a href="javascript:void(0)" class="new_add ml10" id="add_honor_{{id}}"></a>
                <a onclick="remove_honor(this)" style="cursor: pointer;display: none;" class="remove_honor ml10" id="remove_honor"></a>
            </td>
        </tr>
        <tr>
            <td class="w95"><span>&emsp;&emsp;重大伤病：</span></td>
            <td><input type="text" name="injured_area" value="{{injured_area}}" valid="len(0,100)" /></td>
        </tr>
    </table>
    </form>
    </div>
    <div id="player_career_model" style="display: none;">
    <table class="career">
        <tr>
            <td colspan="6">
                <span class="year">{{start_date}}&ensp;-&ensp;{{end_date}}年</span>
                <a data-btn href="javascript:delete_career('${ctx}/player/deleteCareer','{{id}}')" class="pull-right text-gray-s_999 mr10">删除</a>
                <a data-btn href="javascript:edit_career('{{id}}')" class="pull-right text-gray-s_999 mr10">编辑</a>
            </td>
        </tr>
        <tr>
            <td class="w95">
                <span>曾效力俱乐部：</span>
            </td>
            <td class="w230">
                <span class="text-white">{{played_team}}</span>
            </td>
            <td class="w95">
                <span>参赛场数：</span>
            </td>
            <td class="w230">
                <span class="text-white">{{played_count}}场</span>
            </td>
            <td class="w95">
                <span>进球数：</span>
            </td>
            <td class="w230">
                <span class="text-white">{{goal_count}}个</span>
            </td>
        </tr>
        <tr>
            <td class="w95"><span>&emsp;&emsp;所获荣誉：</span></td>
            <td colspan="5"><span class="text-white" data-id="honor_desc"></span></td>
        </tr>
        <tr>
            <td class="w95"><span>&emsp;&emsp;重大伤病：</span></td>
            <td><span class="text-white">{{injured_area}}</span></td>
        </tr>
    </table>
    </div>
    <div id="player_career_list">
    </div>
    <div class="f_dashed_b"></div>
    <div id="player_career_btn" class="btn_div_b">
        <input type="button" id="player_career_add_next" value=" + 保存并添加" class="new_btn_l mr10" style="display: none;"/>
        <input type="button" id="player_career_add" onclick="addNext(this)" value=" + 添加" class="new_btn_l mr10" style="display: none;"/>
        <input type="button" id="player_career_cancel" onclick="load_player_careers()" value="取消" class="new_btn_g mr10" style="display: none;" />
    </div>
</div>
<script type="text/javascript">
var careerList = new List({url:base+'/player/info',sendData:{oth_user_id:$("#oth_user_id").val(),type:'career'},listDataModel:$('#player_career_model').get(0).outerHTML,listContainer:'#player_career_list',
	dynamicVMHandler:function(one){
	var vm = $(careerList.options.listDataModel);
   	vm.css('display','block');
   	vm.attr("id","player_career_model_"+one.id);
   	if(one.honor_desc){
   		var hd = one.honor_desc.replace(new RegExp(',','gm'),'、');
   		vm.find("[data-id=honor_desc]").text(hd);
   	}
   	return vm.get(0).outerHTML+'<div id="f_solid_'+one.id+'" class="f_solid"></div>';
},
afterRenderList:function(c,v,d){
	if(d&&d.length>0){
		$("#f_solid_"+d[d.length-1].id).remove();
	}
}});

function load_player_careers(ifnext){
	layer.closeAll();
	careerList.loadListData().done(function(data){
		if(data.state=='success'&&data.data.data.length>0){
			if(data.data.data.length>=5){
				$('#player_career_btn').remove();
			}
			careerList.renderList(data.data.data,'reloaded');
			$('#player_career_add').val(" + 继续添加").attr("onclick","addNext(this)").show();
			$('#player_career_add_next').hide();
			$('#player_career_cancel').hide();
			if(ifnext){
				if(data.data.data.length>=5){
					layer.msg("最多只能添加 5 个职业生涯",{icon: 2});
				}else{
					addNext();
				}
			}
		}else{
			if(data.data.isme){
				$('#player_career_add').hide();
				$('#player_career_add_next').hide();
				$('#player_career_cancel').hide();
				$("#player_career_list").empty().append('<div class="no_data"><a class="new_btn_l" onclick="addNext(true)" style="cursor: pointer;">录入我的足球生涯</a></div>');
			}else{
				$("#player_career_list").empty().append('<div style="height: 200px; line-height: 200px;" class="no_data"><span class="f16 text-gray-s_999 ms">该用户尚未填写自己的足球生涯，<span class="new_btn_l f12" onclick="inviteUpload('+"'${c_user.usernick}'"+','+"'${c_user.id}'"+',2)">邀请</span>Ta完善自己的足球生涯吧</span></div>');
			}
		}
		if(!data.data.isme){
			$("#player_career_btn").remove();
			$("#player_career_list").find("[data-btn]").remove();
		}
	});	
}

/*增加*/
var mealsNum = $("#player_career_list").find('.career').size()-1;
var p_career = $('#player_career_edit').eq(0).get(0).outerHTML;

function addNext(ifno1){
	if(ifno1){
		$(".no_data").remove();
	}
	p_career = $(p_career).css('display','block').get(0).outerHTML;
	var flag = true;
	$("#player_career_list").find("input[id='state']").each(function(){
		if($(this).val()==0){
			flag = false;
			return;
		}
	});
	if(!flag){
		layer.msg("请先保存当前所添加的足球生涯!",{icon: 2});
		return;
	}
	mealsNum++;
	$(p_career).find("input").each(function(){
		var name = $(this).attr("name");
		p_career = p_career.replaceAll('{{'+name+'}}','');
	});
	var nmodel = $(p_career);
	nmodel.find("form").attr("id","careerEditFrom_"+mealsNum);
	$('#player_career_add').val(" + 保存").attr("onclick","$.ajaxSubmit('#careerEditFrom_"+mealsNum+"','#careerEditFrom_"+mealsNum+"',career_handler)").show();
	$('#player_career_add_next').show().attr("onclick","$.ajaxSubmit('#careerEditFrom_"+mealsNum+"','#careerEditFrom_"+mealsNum+"',career_next_handler);");
	$('#player_career_cancel').show();
	$("#player_career_list").append(nmodel);
	var s = '<input type="text" name="honor_desc" value="" valid="len(0,200)" class="rongyu ml10" index="">';
	$("#add_honor_").click(function () {
        if ($(this).parent().find(".rongyu").length >= 5) {
            return false;
        } else {
            $("#add_honor_").before(s);
            $(this).parent().find('.remove_honor').show();
        }
    });
}

function edit_career(cid){
	var flag = true;
	$("#player_career_list").find("input[id='state']").each(function(){
		if($(this).val()==0){
			flag = false;
			return;
		}
	});
	if(!flag){
		layer.msg("请先保存当前所添加的足球生涯!",{icon: 2});
		return;
	}
	var model = $("#player_career_model_"+cid);
	var player_career = new Vmodel({url:base+'/player/getPlayer',sendData:{id:cid,type:'career'},modelContainer:"#player_career_model_"+cid,modelTemp:$('#player_career_edit').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
		var vm = $(player_career.options.modelTemp);
		vm.css('display','block');
		vm.find("form").attr("id","careerEditFrom_0");
		//vm.find("#careerEditBtn").attr("onclick","$.ajaxSubmit('#careerEditFrom_0','#careerEditFrom_0',careerFormHandler)");
		return vm.get(0).innerHTML;
	},
	afterRenderList:function(c,v,d){
		$("#start_date_"+d.id).val(d.start_date);
		$("#end_date_"+d.id).val(d.end_date);
		var s = '<input type="text" name="honor_desc" value="" valid="len(0,200)" class="rongyu ml10" index="">';
		if(d.honor_desc){
			var hds = d.honor_desc.split(",");
			for (var i = 0; i < hds.length; i++) {
				if(i==0){
					$("#honor_desc_"+d.id).val(hds[i]);
				}else{
					if(hds[i]){
						$("#add_honor_"+d.id).before('<input type="text" name="honor_desc" value="'+hds[i]+'" valid="len(0,200)" class="rongyu ml10" index="">');
					}
				}
			}
			if(hds.length>1){
				$("#honor_desc_"+d.id).parent().find('.remove_honor').show();
			}
		}
		$("#add_honor_"+d.id).click(function () {
            if ($(this).parent().find(".rongyu").length >= 5) {
                return false;
            } else {
                $("#add_honor_"+d.id).before(s);
                $(this).parent().find('.remove_honor').show();
            }
        });
		$('#player_career_add').val(" + 保存").attr("onclick","$.ajaxSubmit('#careerEditFrom_0','#careerEditFrom_0',career_handler)").show();
		$('#player_career_add_next').show().attr("onclick","$.ajaxSubmit('#careerEditFrom_0','#careerEditFrom_0',career_next_handler);");
		$('#player_career_cancel').show();
	}});
	player_career.loadData().done(function(data){
		if(data.state=='success'&&data.data.data){
			player_career.renderModel(data.data.data,'reloaded');
		}else{
			layer.msg("加载失败",{icon: 2});
		}
	});
}

function career_handler(result,ifnext){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		load_player_careers(ifnext);
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}
function career_next_handler(result){
	career_handler(result,true);
	
}
function delete_career(url,cid){
	yrt.confirm('确定要删除这条足球生涯吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: true,
	    cwidth:'70%'
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: cid},
			success: function(result){
				if(result.state=='success'){
					yrt.msg("删除成功",{icon: 1});
					/* if(result.data.data.length>=5){
						$('#player_more').find("[data-control=player_career]").find("[data-button]").remove();
					} */
					center_player_career_hobby('career');
				}else{
					yrt.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}
function remove_honor(dom){
	var honors = $(dom).parent().find("input[name=honor_desc]");
	if(honors&&honors.length>1){
		if(honors.length==2){
			$(dom).hide();
		}
		honors[honors.length-1].remove();
	}else{
		$(dom).hide();
	}
}
$(function(){
	load_player_careers();
})
</script>