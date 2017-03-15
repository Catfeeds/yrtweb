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
		<li><a href="">联赛个人统计数据</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="update_statistics('是否更个人统计数据?','${ctx}/admin/leagueStatistics/updateStatistics',{league_id:'${league_id}'})" 
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
							<label>排行榜: 
								<select id="s_chart" name="chart">
									<option value="">全部</option>	
									<option value="1">助攻榜</option>
									<option value="2">红黄榜</option>
								</select>
								<script type="text/javascript">$("#s_chart").val('${params.chart}');</script>
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
							  <th>联赛</th>
							  <th>球员姓名</th>
							  <th>昵称</th>
							  <th>俱乐部</th>
							  <th>进球</th>
							  <th>射门</th>
							  <th>射正</th>
							  <th>射偏</th>
							  <th>助攻</th>
							  <th>抢断</th>
							  <th>解围</th>
							  <th>补救</th>
							  <th>犯规</th>
							  <th>红牌</th>
							  <th>黄牌</th>
							  <th>双黄牌</th>
							  <th>助攻排序</th>
							  <th>红牌排序</th>
							  <th>黄牌排序</th>
							  <th>双黄牌排序</th>
							  <th>更新时间</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="data">
						<tr>
							<td>${data.lname}</td>
							<td>${data.username}</td>
							<td>${data.usernick}</td>
							<td>${data.tname}</td>
							<td>${data.jinqiu_num}</td>
							<td>${data.shemen_num}</td>
							<td>${data.shezheng_num}</td>
							<td>${data.shepian_num}</td>
							<td>${data.zhugong_num}</td>
							<td>${data.qiangduan_num}</td>
							<td>${data.jiewei_num}</td>
							<td>${data.pujiu_num}</td>
							<td>${data.fangui_num}</td>
							<td>${data.hongpai_num}</td>
							<td>${data.huangpai_num}</td>
							<td>${empty data.shuanghuang_num?0:data.shuanghuang_num}</td>
							<td>${data.zg_sort}</td>
							<td>${data.hop_sort}</td>
							<td>${data.hup_sort}</td>
							<td>${data.shup_sort}</td>
							<td>${data.create_time}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/leagueStatistics/formJsp','#leagueStatisticsEditForm','${ctx}/admin/leagueStatistics/saveOrUpdate','${data.id}')">
									<i class="fa fa-edit "> 编辑排序</i>  
								</a>
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

function update_statistics(msg,url,params){
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
