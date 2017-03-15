<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--职业生涯层-->
<div data-control="player_career" date="tab">
	<div id="careerEdit" class="career_1" style="display: none;">
		<form id="careerEditFrom_" action="${ctx}/player/saveOrUpdateCareer" method="post" secMsg="请先完成球员信息">
		<input type="hidden" name="id" value="{{id}}"/>
		<input type="hidden" id="state" value="0"/>
        <table class="carer_info">
            <tr>
                <td colspan="2">
                	<span class="text-gray-s_81">效力时间：</span><input type="text" id="start_date_{{id}}" name="start_date" value="{{start_date}}" valid="require number" class="fen2" /><span class="ms text-success ml10">-</span>
					<input type="text" name="end_date" value="{{end_date}}" error-msg="结束年不能小于开始年" valid="require number better2num(#start_date_{{id}})" class="fen2" />
					<span class="ms text-success ml10">年</span>
				</td>
                <td align="right" colspan="2"><span id="careerEditBtn" onclick="$.ajaxSubmit('#careerEditFrom_','#careerEditFrom_',careerFormHandler)" class="yt_saver_s"></span><span id="careerCalBtn" onclick="cancelEdit();" class="yt_cancel ml10"></span></td>
            </tr>
            <tr>
                <td><span class="text-gray-s_81">效力俱乐部：</span><input type="text" name="played_team" value="{{played_team}}" valid="require len(1,40)" class="fen2" /></td>
                <td><span class="text-gray-s_81">参赛场数：</span><input type="text" name="played_count" value="{{played_count}}" valid="require number" class="fen2" /></td>
                <td><span class="text-gray-s_81">&emsp;&emsp;进球数：</span><input type="text" name="goal_count" value="{{goal_count}}" valid="require number" class="fen2" /></td>
            </tr>
             <tr>
                
                <td colspan="3"><span class="text-gray-s_81">受伤部位：</span><input type="text" name="injured_area" value="{{injured_area}}" valid="len(0,100)" class="fen2" /></td>
               
            </tr>
            <tr>
                
                <td colspan="3"><span class="text-gray-s_81">所获荣誉：</span><input type="text" name="honor_desc" value="{{honor_desc}}" valid="len(0,200)" class="fen2" style="width: 580px;"/></td>
                
            </tr>
        </table>
        </form>
    </div>
    <div id="careerModel" class="career_1" style="display: none;">
        <table class="carer_info">
            <tr>
                <td colspan="2"><span class="text-gray-s_81">效力时间：</span><span class="ms text-success">{{start_date}}</span><span class="ms text-success ml10">-</span><span class="ms text-success ml10">{{end_date}}年</span></td>
                <td align="right"><span onclick="deleteCareer('${ctx}/player/deleteCareer','{{id}}')" data-btn title="删除" class="yt_del pull-right ml10"></span><span data-btn onclick="editCareer('{{id}}')" class="pull-right yt_editer"></span></td>
            </tr>
            <tr>
                <td><span class="text-gray-s_81">效力俱乐部：</span><span class="text-white">{{played_team}}</span></td>
                <td><span class="text-gray-s_81">参赛场数：</span><span class="text-white">{{played_count}}</span></td>
                <td><span class="text-gray-s_81">进球数：</span><span class="text-white">{{goal_count}}</span></td>
            </tr>
             <tr>
                
                <td colspan="3"><span class="text-gray-s_81">受伤部位：</span><span class="text-white">{{injured_area}}</span></td>
               
            </tr>
            <tr>
                
                <td colspan="3"><span class="text-gray-s_81">所获荣誉：</span><span class="text-white">{{honor_desc}}</span></td>
               
            </tr>
        </table>
    </div>
    <div id="careerList">
    </div>
    <input type="button" data-button value="" onclick="addNext(this)" class="pull-right yt_add ms f16" />
    <div class="clearit"></div>
</div>
<script type="text/javascript">
var careerList = new List({url:base+'/player/info',sendData:{oth_user_id:$("#oth_user_id").val(),type:'career'},listDataModel:$('#careerModel').get(0).outerHTML,listContainer:'#careerList',
	dynamicVMHandler:function(one){
	var vm = $(careerList.options.listDataModel);
   	vm.css('display','block');
   	vm.attr("id","careerModel_"+one.id);
   	return vm.get(0).outerHTML;
}});

careerList.loadListData().done(function(data){
	if(data.state=='success'&&data.data.data.length>0){
		if(data.data.data.length>=5){
			$('#player_more').find("[data-control=player_career]").find("[data-button]").remove();
		}
		careerList.renderList(data.data.data,'reloaded');
	}else{
		if(data.data.isme){
			//addNext();
			$('#player_more').find("[data-control=player_career]").find("[data-button]").removeClass("yt_add").addClass("yt_add_0");
		}
	}
	if(!data.data.isme){
		$("#careerList").find('[data-btn]').remove();
		$('#player_more').find("[data-control=player_career]").find("[data-button]").remove();
	}
	//careerList.renderList(data.data.data,'reloade_resetScroll');
});

function careerFormHandler(result){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		if(result.data.data.length>=5){
			$('#player_more').find("[data-control=player_career]").find("[data-button]").remove();
		}
		careerList.renderList(result.data.data,'reloaded');
		$('#player_more').find("[data-control=player_career]").find("[data-button]").removeClass("yt_add_0").addClass("yt_add");
		$('#player_more').find("[data-control=player_career]").find("[data-button]").attr("onclick",'addNext(this)');
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}

function cancelAdd(num){
	$("#careerEditFrom_"+num).parent().remove();
}

/*增加*/
var mealsNum = $("#careerList").find('.career_1').size()-1;
var p_career = $('#careerEdit').eq(0).get(0).outerHTML;

function addNext(dom){
	$('#player_more').find("[data-control=player_career]").find("[data-button]").removeClass("yt_add_0").addClass("yt_add");
	
	p_career = $(p_career).css('display','block').get(0).outerHTML;
	var flag = true;
	$("#careerList").find("input[id='state']").each(function(){
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
	nmodel.find("#careerEditBtn").attr("onclick","$.ajaxSubmit('#careerEditFrom_"+mealsNum+"','#careerEditFrom_"+mealsNum+"',careerFormHandler)");
	$("#careerList").append(nmodel);
}

function editCareer(cid){
	var flag = true;
	$("#careerList").find("input[id='state']").each(function(){
		if($(this).val()==0){
			flag = false;
			return;
		}
	});
	if(!flag){
		layer.msg("请先保存当前所添加的足球生涯!",{icon: 2});
		return;
	}
	var model = $("#careerModel_"+cid);
	var player_career = new Vmodel({url:base+'/player/getPlayer',sendData:{id:cid,type:'career'},modelContainer:"#careerModel_"+cid,modelTemp:$('#careerEdit').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
		var vm = $(player_career.options.modelTemp);
		vm.css('display','block');
		vm.find("form").attr("id","careerEditFrom_0");
		vm.find("#careerEditBtn").attr("onclick","$.ajaxSubmit('#careerEditFrom_0','#careerEditFrom_0',careerFormHandler)");
		return vm.get(0).innerHTML;
	}});
	player_career.loadData().done(function(data){
		if(data.state=='success'&&data.data.data){
			player_career.renderModel(data.data.data,'reloaded');
		}else{
			layer.msg("加载失败",{icon: 2});
		}
	});
}


function cancelEdit(){
	careerList.loadListData().done(function(data){
		if(data.state=='success'){
			if(data.data.data.length>=5){
				$('#player_more').find("[data-control=player_career]").find("[data-button]").remove();
			}else if(data.data.data.length==0){
				$('#player_more').find("[data-control=player_career]").find("[data-button]").removeClass("yt_add").addClass("yt_add_0");
			}
			careerList.renderList(data.data.data,'reloaded');
		}
	});
}
function deleteCareer(url,cid){
	layer.confirm('确定要删除这条足球生涯吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: cid},
			success: function(result){
				if(result.state=='success'){
					layer.msg("删除成功",{icon: 1});
					if(result.data.data.length>=5){
						$('#player_more').find("[data-control=player_career]").find("[data-button]").remove();
					}
					careerList.renderList(result.data.data,'reloaded');
				}else{
					layer.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}
</script>
