<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">接口管理</a></li>
		<li><a href="">统计球员详情</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header" style="text-align: center;">
				<span class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">
				<c:if test="${params.team_status eq '1'}">主队：</c:if>
				<c:if test="${params.team_status eq '2'}">客队：</c:if>
				</span>
				<yt:id2NameDB beanId="teamInfoService" id="${params.teaminfo_id}"></yt:id2NameDB>
				</span>
			</div>
			<div class="box-content">
				<div class="row">
				</div>
				<!-- <hr style="margin:2px;height:1px"> -->
				<form id="quan_player_form" method="post" class="form-horizontal">
				<table id="league_players_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th style="width: 70px;text-align: center;">球衣号码</th>
							  <th style="width: 134px;text-align: center;">全网姓名</th>
							  <th style="width: 200px;text-align: center;">姓名</th>
							  <th style="width: 134px;text-align: center;">场上位置</th>
							  <th style="width: 106px;text-align: center;">参赛时长</th>
							  <th style="text-align: center;">射门</th>
							  <th style="text-align: center;">射正</th>
							  <th style="text-align: center;">射偏</th>
							  <th style="text-align: center;">进球</th>
							  <th style="text-align: center;">乌龙</th>
							  <th style="text-align: center;">助攻</th>
							  <th style="text-align: center;">抢断</th>
							  <th style="text-align: center;">解围</th>
							  <th style="text-align: center;">补救</th>
							  <th style="text-align: center;">犯规</th>
							  <th style="text-align: center;">红牌</th>
							  <th style="text-align: center;">黄牌</th>
							  <th style="text-align: center;">关联</th>
							  <th style="text-align: center;">进球详情</th>
						  </tr>
					  </thead>   
					  <tbody>
					  <c:forEach items="${players}" var="ps" varStatus="status">
					  	<tr>
					  		<td>
					  		<input type="hidden" name="players[${status.index}].id" value="${ps.id}"/>
					  		<input type="hidden" name="players[${status.index}].player_id" value="${ps.player_id}"/>
					  		<input type="hidden" name="players[${status.index}].q_match_id" value="${ps.q_match_id}"/>
					  		<input type="hidden" name="players[${status.index}].team_id" value="${ps.team_id}"/>
					  		<input type="hidden" name="players[${status.index}].teaminfo_id" value="${ps.teaminfo_id}"/>
					  		<input type="hidden" id="rel_${ps.id}" name="players[${status.index}].rel_palyer_id" value="${ps.rel_palyer_id}"/>
					  		<input type="hidden" name="players[${status.index}].team_status" value="${ps.team_status}"/>
					  		<input type="hidden" name="players[${status.index}].lanjie_num" value="${ps.lanjie_num}"/>
					  		<input type="text" name="players[${status.index}].number" value="${ps.number}" valid="number" class="form-control">
					  		</td>
					  		<td>
					  		<input ret="iname" ps="${ps.id}" type="text" name="players[${status.index}].name" value="${ps.name}" readonly="readonly" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" id="rel_name_${ps.id}" value="${ps.username}" readonly="readonly" style="width: 120px;display:inline" class="form-control"> <a class="btn btn-primary" onclick="ListPage.dialog('选择球员','${ctx}/admin/interface/queryPlayerDatas',{ps_id:'${ps.id}',teaminfo_id:'${ps.teaminfo_id}',cfg_id:'${league.s_id}'})">选择</a>
					  		</td>
					  		<td>
					  		<yt:dictSelect name="players[${status.index}].position" nodeKey="p_position" value="${ps.position}" clazz="form-control"></yt:dictSelect>
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].durtime" value="${ps.durtime}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].shemen_num" valid="number" value="${ps.shemen_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].shezheng_num" valid="number" value="${ps.shezheng_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].shepian_num" valid="number" value="${ps.shepian_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].jinqiu_num" valid="number" value="${ps.jinqiu_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].wulong_num" valid="number" value="${ps.wulong_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].zhugong_num" valid="number" value="${ps.zhugong_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].qiangduan_num" valid="number" value="${ps.qiangduan_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].jiewei_num" valid="number" value="${ps.jiewei_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].pujiu_num" valid="number" value="${ps.pujiu_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].fangui_num" valid="number" value="${ps.fangui_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].hongpai_num" valid="number" value="${ps.hongpai_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].huangpai_num" valid="number" value="${ps.huangpai_num}" class="form-control">
					  		</td>
					  		<td>
					  		<input type="text" name="players[${status.index}].shuanghuang_num" valid="number" value="${ps.shuanghuang_num}" class="form-control">
					  		</td>
					  		<td>
					  			<c:if test="${ps.jinqiu_num > 0}">
					  			<c:choose>
					  				<c:when test="${ps.if_guanlian eq '1'}">
					  				是
					  				</c:when>
					  				<c:otherwise>
					  				<span style="color: red;">否</span>
					  				</c:otherwise>
					  			</c:choose>
					  			</c:if>
					  		</td>
					  		<td>
					  		<input type="button" onclick="update_score_list('${ps.id}','${ps.q_match_id}','${ps.username}')" class="btn btn-info" value="编辑"/>
					  		</td>
					  	</tr>
					  	</c:forEach>
					  </tbody>
				 </table>  
				 <div class="row" style="text-align: center;">
				 	<input type="button" onclick="auto_match()" class="btn btn-success" value="自动匹配"/>
				 	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					<input type="button" onclick="update_players()" class="btn btn-info" value="保存"/>
					&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					<input type="button" onclick="ListPage.form('${ctx}/admin/interface/matchForm?id=${params.q_match_id}','#matchForm','${ctx}/admin/interface/saveQMatchInfo','${params.q_match_id}')" class="btn" value="返回"/>
				 </div>
				 </form>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">

function update_players(){
	var lay = layer.load(1);
	$.ajaxSec({
		context:$("#quan_player_form"),
		type: 'POST',
		url: '/admin/interface/updateUserData',
		data: $("#quan_player_form").serializeObjects(),
		cache: false,
		success: function(result){
			layer.close(lay);
			if(result.state=='success'){
				layer.msg("操作成功",{icon: 1});
			}else{
				layer.msg("操作失败",{icon: 2});
			}
		},
		error: $.ajaxError
	});
}

var iframeScoreInfo;
function update_score_list(pid,mid,pname){
	iframeScoreInfo = layer.open({
	    type: 2,
	    title: pname+' 进球详情',
	    shadeClose: true,
	    shade: [0],
	    area: ['400px', '440px'],
	    content: base+'/admin/interface/scoreDialog?pid='+pid+'&mid='+mid //iframe的url
	}); 
}

function closeScoreInfo(){
	layer.close(iframeScoreInfo);
}

var iframePInfo;
function select_team_player(iid,tid){
	iframePInfo = layer.open({
	    type: 2,
	    title: '选择球员',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/index/dialog?id='+iid+'&tid='+tid+'&type=teamplayer' //iframe的url
	}); 
}

function changeTeamPlayer(iid,pid,uname){
	$("#rel_"+iid).val(pid);
	$("#rel_name_"+iid).val(uname);
	layer.closeAll();
	//layer.close(iframePInfo);
	//layer.msg("编辑成功",{icon: 1});
}


function auto_match(){
	var load = layer.load(1,{shade:[0.4,'#fff']});
	$.post(base+"/admin/interface/queryPlayersByJson",{teaminfo_id:'${params.teaminfo_id}',cfg_id:'${league.s_id}'},function(result){
	    var players = result.data.page.items;
	    var table = $("#league_players_table");
		var trs = table.find("tr");
		trs.each(function(j){
			var iobj = $(this).find('[ret=iname]');
			var iname = iobj.val();
			var ps_id = iobj.attr("ps");
			var n = 0;
			var rel_id = '';
			var rel_name = '';
		    for(i in players){
		    	var pname = players[i].username;
		    	if(iname == pname){
		    		rel_id = players[i].user_id;
		    		rel_name = pname;
		    		n++;
		    	}
		    }
		    if(n==1){
		    	$("#rel_"+ps_id).val(rel_id);
		    	$("#rel_name_"+ps_id).val(rel_name);
		    }
		})
		layer.close(load);
	});
}


</script>
