<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--爱好层-->
<div data-control="player_hobby" date="tab" style="display: none;">
	<div id="hobbyEdit" class="career_1" style="display: none;">
		<form id="hobbyEditFrom" action="${ctx}/player/saveOrUpdateHobby" method="post">
		<input type="hidden" name="id" value="{{id}}"/>
		<table class="carer_info">
	      	<tr>
	              <td colspan="3"></td>
	              <td align="right"><span id="hobbyEditBtn" onclick="$.ajaxSubmit('#hobbyEditFrom','#hobbyEditFrom',hobbyFormHandler)" class="pull-right yt_saver"></span></td>
	          </tr>
	          <tr>
	              <td><span class="text-gray-s_81">喜欢的足球明星：</span><input type="text" name="stars" value="{{stars}}" /></td>
	              <td><span class="text-gray-s_81">最想效力的球队：</span><input type="text" name="teams" value="{{teams}}" valid="len(0,200)" /></td>
	          </tr>
	          <tr>
	              <td><span class="text-gray-s_81">喜爱的运动品牌：</span><input type="text" name="brands" value="{{brands}}" valid="len(0,100)" /></td>
	              <td><span class="text-gray-s_81">喜欢的运动饮料：</span><input type="text" name="drink" value="{{drink}}" valid="len(0,100)" /></td>
	          </tr>
	    </table>
	    </form>
    </div>
	<div id="hobbyModelTemp" class="career_1" style="display: none;">
        <table class="carer_info">
        	<tr>
                <td colspan="3"></td>
                <td align="right"><span data-btn onclick="edit_hobby('{{id}}')" class="pull-right yt_editer"></span></td>
            </tr>
            <tr>
                <td><span class="text-gray-s_81">喜欢的足球明星：</span><span class="text-white">{{stars}}</span></td>
                <td><span class="text-gray-s_81">最想效力的球队：</span><span class="text-white">{{teams}}</span></td>
            </tr>
            <tr>
                <td><span class="text-gray-s_81">喜爱的球衣品牌：</span><span class="text-white">{{brands}}</span></td>
                <td><span class="text-gray-s_81">喜欢的运动饮料：</span><span class="text-white">{{drink}}</span></td>
            </tr>
        </table>
    </div>
    <div id="hobbyModel" class="career_1">
    </div>
</div>
<script type="text/javascript">
var player_hobby;
function expand_hobby(){
	player_hobby = new Vmodel({url:base+'/player/info',sendData:{oth_user_id:$("#oth_user_id").val(),type:'hobby'},modelContainer:"#hobbyModel",modelTemp:$('#hobbyModelTemp').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
		var vm = $(player_hobby.options.modelTemp);
		vm.css('display','block');
		return vm.get(0).innerHTML;
	}});
	player_hobby.loadData().done(function(data){
		if(data.state=='success'&&data.data.data){
			player_hobby.renderModel(data.data.data,'reloaded');
		}else{
			if(data.data.isme){
				edit_hobby();
			}
		}
		if(!data.data.isme){
			$("#hobbyModel").find('[data-btn]').remove();
		}
	});
}

var p_hobby = $('#hobbyEdit').eq(0).get(0).innerHTML;

function edit_hobby(hid){
	if(hid){
		var player_hobby_edit = new Vmodel({url:base+'/player/getPlayer',sendData:{id:hid,type:'hobby'},modelContainer:"#hobbyModel",modelTemp:$('#hobbyEdit').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
			var vm = $(player_hobby_edit.options.modelTemp);
			vm.css('display','block');
			vm.find("form").attr("id","hobbyEditFrom_0");
			vm.find("#hobbyEditBtn").attr("onclick","$.ajaxSubmit('#hobbyEditFrom_0','#hobbyEditFrom_0',hobbyFormHandler)");
			return vm.get(0).innerHTML;
		}});
		player_hobby_edit.loadData().done(function(data){
			if(data.state=='success'&&data.data.data){
				player_hobby_edit.renderModel(data.data.data,'reloaded');
			}else{
				layer.msg("加载失败",{icon: 2});
			}
		});
	}else{
		p_hobby = $(p_hobby).css('display','block').get(0).outerHTML;
		$(p_hobby).find("input").each(function(){
			var name = $(this).attr("name");
			p_hobby = p_hobby.replaceAll('{{'+name+'}}','');
		});
		var nmodel = $(p_hobby);
		nmodel.attr("id","hobbyEditFrom_0");
		nmodel.find("#hobbyEditBtn").attr("onclick","$.ajaxSubmit('#hobbyEditFrom_0','#hobbyEditFrom_0',hobbyFormHandler)");
		$("#hobbyModel").empty().append(nmodel);
	}
}

function hobbyFormHandler(result){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		player_hobby.renderModel(result.data.data,'reloaded');
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}
</script>
