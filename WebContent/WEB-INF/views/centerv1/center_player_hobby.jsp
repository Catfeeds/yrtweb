<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="title">
    <a href="javascript:center_player_career_hobby('career')" class="f16 ms ml20 ">足球生涯</a>
    <a class="f16 ms ml10">|</a>
    <a href="javascript:center_player_career_hobby('hobby')" class="f16 ms ml10 new_love active">个人爱好</a>
    <div class="pull-right mr15">
        <a id="bobby_btn_edit" href="javascript:load_player_hobby('edit')" style="display: none;color:#fff;" class="new_btn_l">编辑</a>
        <a id="bobby_btn_save" href="javascript:$.ajaxSubmit('#hobbyEditFrom_0','#hobbyEditFrom_0',hobby_handler)" style="display: none;color:#fff;" class="new_btn_l" >保存</a>  <a id="bobby_btn_cancel" href="javascript:center_player_career_hobby('hobby')" style="display: none;color:#fff;" class="new_btn_l">取消</a>
    </div>
    <div class="clearit"></div>
</div>
<!--个人爱好-->
<div class="hobby">
    <table id="player_hobby_temp" style="display: none;" class="hobby_tab">
        <tr>
            <td class="w120">
                <span>
                    &emsp;&emsp;喜爱的球队：
                </span>
            </td>
            <td class="w240">
                <span>
                    {{teams}}
                </span>
            </td>
            <td class="w120">
                <span>
                    &emsp;&emsp;喜爱的球星：
                </span>
            </td>
            <td class="w240">
                <span>
                    {{stars}}
                </span>
            </td>
        </tr>
        <tr>
            <td class="w120">
                <span>
                    喜爱的运动品牌：
                </span>
            </td>
            <td data-id="brands">
            </td>
            <td class="w120">
                <span>
                    喜爱的运动饮料：
                </span>
            </td>
            <td data-id="drink">
            </td>
        </tr>
    </table>

	<div id="player_hobby_edit" style="display: none;">
	<form id="hobbyEditFrom" action="${ctx}/player/saveOrUpdateHobby" method="post"  secMsg="请先完成并激活球员信息">
	<input type="hidden" name="id" value="{{id}}"/>
    <table class="hobby_tab_edit">
        <tr>
            <td class="w120">
                <span>
                    &emsp;&emsp;喜爱的球队：
                </span>
            </td>
            <td class="w240">
                <input type="text" name="teams" value="{{teams}}" valid="len(0,200)"/>
            </td>
            <td class="w120">
                <span>
                    &emsp;&emsp;喜爱的球星：
                </span>
            </td>
            <td class="w240">
                <input type="text" name="stars" value="{{stars}}" valid="len(0,200)"/>
            </td>
        </tr>
        <tr>
            <td class="w120" valign="top">
                <span>
                    喜爱的运动品牌：
                </span>
            </td>
            <td data-id="brands" class="w240" valign="top">
                <input type="text" name="brands" value="{{brands}}" valid="len(0,100)" class="brand" /><a style="cursor: pointer;" onclick="" class="new_add ml10" id="add_brand"></a>
            </td>
            <td class="w120" valign="top">
                <span>
                    喜爱的运动饮料：
                </span>
            </td>
            <td data-id="drink" class="w240">
                <input type="text" name="drink" value="{{drink}}" valid="len(0,100)" class="drinks" /><a style="cursor: pointer;" class="new_add ml10" id="add_drinks"></a>
            </td>
        </tr>
    </table>
    </form>
    </div>
    <div id="player_hobby_model">
    </div>
</div>
<script type="text/javascript">
var player_hobby;
function expand_hobby(type){
	player_hobby = new Vmodel({url:base+'/player/info',sendData:{oth_user_id:$("#oth_user_id").val(),type:'hobby'},modelContainer:"#player_hobby_model",modelTemp:$('#player_hobby_'+type).eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
		var vm = $(player_hobby.options.modelTemp);
		vm.css('display','block');
		if(one&&one.brands){
			var bs = one.brands.split(",");
			var bd = vm.find("[data-id=brands]");
			for (var i = 0; i < bs.length; i++) {
				if(bs[i]){
					if(type=='edit'){
						if(i==0) bd.empty();
						bd.append('<input type="text" name="brands" value="'+bs[i]+'" valid="len(0,100)" class="brand mt5">');
					}else{
						vm.find("[data-id=brands]").append("<p>"+bs[i]+"</p>");
					}
				}
			}
			if(type=='edit'){
				bd.append('<a style="cursor: pointer;" onclick="" class="new_add ml10" id="add_brand"></a>');
			}
		}
		if(one&&one.drink){
			var ds = one.drink.split(",");
			var dk = vm.find("[data-id=drink]");
			for (var i = 0; i < ds.length; i++) {
				if(ds[i]){
					if(type=='edit'){
						if(i==0) dk.empty();
						dk.append('<input type="text" name="drink" value="'+ds[i]+'" valid="len(0,100)" class="drinks mt5" >');
					}else{
						vm.find("[data-id=drink]").append("<p>"+ds[i]+"</p>");
					}
				}
			}
			if(type=='edit'){
				dk.append('<a style="cursor: pointer;" class="new_add ml10" id="add_drinks"></a>');
			}
		}
		if(type=='edit'){
			vm.find("form").attr("id","hobbyEditFrom_0");
			var did = one&&one.length>0?one.id:0;
			vm.find("#add_brand").attr("id",'add_brand_'+did).attr("onclick","add_brand('"+did+"')");
			vm.find("#add_drinks").attr("id",'add_drinks_'+did).attr("onclick","add_drinks('"+did+"')");
			return vm.get(0).innerHTML;
		}else{
			return vm.get(0).outerHTML;
		}
	},
	afterRenderList:function(c,v,d){
	}});
}
function load_player_hobby(type){
	expand_hobby(type);
	player_hobby.loadData().done(function(data){
		if(data.state=='success'&&data.data.data&&type!='edit'){
			player_hobby.renderModel(data.data.data,'reloaded');
			$("#bobby_btn_edit").show();
		}else{
			if(data.data.isme){
				if(type=='edit'){
					player_hobby.renderModel(data.data.data,'reloaded');
					$("#bobby_btn_edit").remove();
					$("#bobby_btn_save").show();
					$("#bobby_btn_cancel").show();
				}else{
					load_player_hobby('edit');
				}
			}
		}
		if(!data.data.isme){
			$("#bobby_btn_edit").remove();
		}
	});
}

function add_brand(did){
	var s1 = '<input type="text" name="brands" value="" valid="len(0,100)" class="brand mt5">';
	if ($("#add_brand_"+did).parent().find(".brand").length >= 3) {
        return false;
    } else {
        $("#add_brand_"+did).before(s1);
    }
}
function add_drinks(did){
	var s2 = '<input type="text" name="drink" value="" valid="len(0,100)" class="drinks mt5" >';
	if ($("#add_drinks_"+did).parent().find(".drinks").length >= 3) {
        return false;
    } else {
        $("#add_drinks_"+did).before(s2);
    }
}
function hobby_handler(result){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		center_player_career_hobby('hobby')
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}

$(function(){
	load_player_hobby('temp');
})
</script>