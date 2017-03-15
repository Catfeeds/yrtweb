<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div data-control="player_other" date="tab" style="display: none;">
	<div id="otherEdit" class="career_1" style="display: none;">
		<form id="otherEditFrom" action="${ctx}/player/saveOrUpdateOther" method="post">
		<input type="hidden" name="id" value="{{id}}"/>
        <table class="carer_info">
        	<tr>
	            <td colspan="3"></td>
	            <td align="right"><span title="保存" id="otherEditBtn" onclick="$.ajaxSubmit('#otherEditFrom','#otherEditFrom',otherFormHandler)" class="pull-right yt_save"></span></td>
	        </tr>
            <tr>
                <td><span>&emsp;&emsp;视力：</span><input type="text" name="vision" valid="number" value="{{vision}}" /></td>
                <td><span>&emsp;&emsp;颜值：</span><input type="text" name="level" valid="numberScope(0,100)" value="{{level}}" /></td>
            </tr>
            <tr>
                <td><span>&emsp;&emsp;鞋码：</span><input type="text" name="shoe" valid="number" value="{{shoe}}" /></td>
                <td><span>婚姻状况：</span>
                	<input type="radio" data-id="marriage_0" name="marriage" value="0" />未婚 
                    <input type="radio" data-id="marriage_1" name="marriage" value="1" />已婚 
                </td>
            </tr>
            <tr>
                <td><span>&emsp;&emsp;国籍：</span><input type="text" name="national" value="{{national}}" /></td>
                <td><span>语言能力：</span><input type="text" name="language" value="{{language}}" /></td>
            </tr>

        </table>
        </form>
    </div>
    <div id="otherModelTemp" class="career_1" style="display: none;">
        <table class="carer_info">
        	<tr>
                <td colspan="3"></td>
                <td align="right"><span title="编辑" data-btn onclick="edit_other('{{id}}')" class="pull-right yt_edit"></span></td>
            </tr>
            <tr>
                <td><span>&emsp;&emsp;视力：</span><span>{{vision}}</span></td>
                <td><span>&emsp;&emsp;颜值：</span><span>{{level}}</span></td>
            </tr>
            <tr>
                <td><span>&emsp;&emsp;鞋码：</span><span>{{shoe}}</span></td>
                <td><span>粉丝数量：</span><span>{{fans_count}}</span></td>
            </tr>
            <tr>
                <td><span>&emsp;&emsp;国籍：</span><span>{{national}}</span></td>
                <td><span>身份证号：</span><span>{{idcard}}</span></td>
            </tr>

            <tr>
                <td><span>语言能力：</span><span>{{language}}</span></td>
                <td><span>婚姻状况：</span><span data-id="marriage"></span></td>
            </tr>
        </table>
    </div>
    <div id="otherModel" class="career_1">
    </div>
</div>
<script type="text/javascript">
var player_other;
function expand_other(){
	player_other = new Vmodel({url:base+'/player/info',sendData:{oth_user_id:$("#oth_user_id").val(),type:'other'},modelContainer:"#otherModel",modelTemp:$('#otherModelTemp').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
		var vm = $(player_other.options.modelTemp);
		vm.css('display','block');
		if(one.marriage==1){
			vm.find('[data-id=marriage]').text("已婚");
		}else if(one.marriage==0){
			vm.find('[data-id=marriage]').text("未婚");
		}
		return vm.get(0).innerHTML;
	}});
	player_other.loadData().done(function(data){
		if(data.state=='success'&&data.data.data){
			player_other.renderModel(data.data.data,'reloaded');
		}else{
			if(data.data.isme){
				edit_other();
			}
		}
		if(!data.data.isme){
			$("#otherModel").find('[data-btn]').remove();
		}
	});
}

var p_other = $('#otherEdit').eq(0).get(0).innerHTML;

function edit_other(hid){
	if(hid){
		var player_other_edit = new Vmodel({url:base+'/player/getPlayer',sendData:{id:hid,type:'other'},modelContainer:"#otherModel",modelTemp:$('#otherEdit').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
			var vm = $(player_other_edit.options.modelTemp);
			vm.css('display','block');
			vm.find('[data-id=marriage_'+one.marriage+']').attr('checked','checked');
			vm.find("form").attr("id","otherEditFrom_0");
			vm.find("#otherEditBtn").attr("onclick","$.ajaxSubmit('#otherEditFrom_0','#otherEditFrom_0',otherFormHandler)");
			return vm.get(0).innerHTML;
		}});
		player_other_edit.loadData().done(function(data){
			if(data.state=='success'&&data.data.data){
				player_other_edit.renderModel(data.data.data,'reloaded');
			}else{
				layer.msg("加载失败",{icon: 2});
			}
		});
	}else{
		p_other = $(p_other).css('display','block').get(0).outerHTML;
		$(p_other).find("input").each(function(){
			var name = $(this).attr("name");
			p_other = p_other.replaceAll('{{'+name+'}}','');
		});
		var nmodel = $(p_other);
		nmodel.attr("id","otherEditFrom_0");
		nmodel.find("#otherEditBtn").attr("onclick","$.ajaxSubmit('#otherEditFrom_0','#otherEditFrom_0',otherFormHandler)");
		$("#otherModel").empty().append(nmodel);
	}
}

function otherFormHandler(result){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		player_other.renderModel(result.data.data,'reloaded');
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}
</script>