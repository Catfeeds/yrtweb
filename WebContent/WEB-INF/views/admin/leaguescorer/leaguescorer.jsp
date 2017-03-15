<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛信息管理</a></li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league_id}','#leagueForm','/admin/league/saveLeague','${league_id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league_id}"></yt:id2NameDB>
			</a>
		</li>	
		<li><a href="">联赛射手榜管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="update_scorer('是否更新射手榜?','${ctx}/admin/leagueScorer/updateScorer',{league_id:'${league_id}'})" 
					style="cursor: pointer;">更新</a><span class="break"></span></h2>
				<h2><a onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" 
					style="cursor: pointer;">返回</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>球员名称: <input type="text" name="username" value="${params.username}"></label>
							<label>分组: 
								<select id="s_group" name="group_id">
									<option value="">全部</option>
									<c:forEach items="${groups}" var="g">
										<option value="${g.id}">${g.name}</option>
									</c:forEach>	
								</select>
								<script type="text/javascript">$("#s_group").val('${params.group_id}');</script>
							</label>
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
							
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>联赛ID</th>
							  <th>联赛</th>
							  <th>分组</th>
							  <th>球员姓名</th>
							  <th>昵称</th>
							  <th>俱乐部</th>
							  <th>总射门次数</th>
							  <th>总射正次数</th>
							  <th>总进球数</th>
							  <th>上场次数</th>
							  <th>排序</th>
							  <th>创建时间</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="scorer">
						<tr>
							<td>${scorer.id}</td>
							<td>${scorer.lname}</td>
							<td>${scorer.gname}</td>
							<td>${scorer.username}</td>
							<td>${scorer.usernick}</td>
							<td>${scorer.tname}</td>
							<td>${scorer.shemen_num}</td>
							<td>${scorer.shezheng_num}</td>
							<td>${scorer.goal}</td>
							<td>${scorer.shangchang_num}</td>
							<td>${scorer.s_sort}</td>
							<td>${scorer.create_time}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/leagueScorer/formJsp','#leagueScorerEditForm','${ctx}/admin/leagueScorer/saveOrUpdate','${scorer.id}')">
									<i class="fa fa-edit "> 编辑排序</i>  
								</a>
								<%-- <a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/leagueScorer/delete','${scorer.id}')">
									<i class="fa fa-trash-o "> 删除</i> 
								</a> --%>
								<%-- <a class="btn btn-success" onclick="player_list('${scorer.league_id}','${scorer.user_id}')">
									<i class="fa"> 进球详情</i> 
								</a> --%>
							</td>                                       
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">
var iframeJinQiu;
function player_list(lid,uid){
	iframeJinQiu = layer.open({
	    type: 2,
	    title: '球员进球详情',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/interface/playerJinQiu?league_id='+lid+'&rel_palyer_id='+uid //iframe的url
	}); 
}
var league_id = $("#s_league").val();
if(league_id){
	get_groups("#s_league");
}

function get_groups(dom){
	var lid = $(dom).val();
	var gid = '${params.group_id}';
	$.post(base+'/admin/leagueScorer/queryLeagueGroups',{league_id:lid},function(data){
		var groups = data.data.groups;
		$("#s_group").empty().append('<option value="">全部</option>	');
		if(groups.length>0){
			for(var i in groups){
				$("#s_group").append('<option value="'+groups[i].id+'">'+groups[i].name+'</option>	');
			}
		}
		if(gid){
			$("#s_group").val(gid);
		}
	});
}

function update_scorer(msg,url,params){
	layer.confirm(msg, {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		var lay = layer.load(1);
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: params,
			cache: false,
			success: function(result){
				layer.close(lay);
				if (result.state=='success') {
					layer.msg("操作成功",{icon: 1});
					ListPage.paginate(ListPage.currentPage);
                } else {
                	layer.msg("操作失败",{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

</script>
