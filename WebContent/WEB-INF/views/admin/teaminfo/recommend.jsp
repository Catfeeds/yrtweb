<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">俱乐部管理</a></li>
		<li><a href="">俱乐部列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="select_team_info()"  style="cursor: pointer; ">添加俱乐部</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>俱乐部名称: <input type="text" name="name" value="${params.name}"></label>
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
							<script type="text/javascript">$("#query_parent_id").val('${params.is_exist}')</script>
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>俱乐部ID</th>
							  <th>管理者Id</th>
							  <th>管理者昵称</th>
							  <th>俱乐部名称</th>
							  <th>俱乐部城市</th>
							  <th>是否开启对战邀请</th>
							  <th>是否解散</th>
							  <th>创建时间</th>
							  <th>排序</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="team">
						<tr>
							<td>${team.id}</td>
							<td>${team.user_id}</td>
							<td>${team.usernick}</td>
							<td>${team.name}</td>
							<td>${team.province} ${team.city}</td>
							<td>
								<c:if test="${team.is_pk=='0'}">不开启</c:if>
								<c:if test="${team.is_pk=='1'}"><span style="color: green;">开启</span></c:if>
							</td>
							<td>
								<c:if test="${team.is_exist=='0'}">解散</c:if>
								<c:if test="${team.is_exist=='1'}"><span style="color: green;">存在</span></c:if>
							</td>
							<td>${team.create_time}</td>
							<td>
							<input type="text" onblur="change_re_sort(this,'${team.rid}')" oldvalue="${team.re_sort}" value="${team.re_sort}" class="form-control">
							</td>
							<td>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/teamInfo/deleteRecommendation','${team.rid}')">
									<i class="fa fa-trash-o "> 删除</i> 
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

function change_re_sort(dom,rid){
	var old = $(dom).attr("oldvalue");
	var ne = $(dom).val();
	if(ne){
		if(new RegExp('[^0-9\.]').test(ne)) {
			layer.msg("只能输入数值",{icon: 2});
			$(dom).val(old);
			return;
        }
		if(old!=ne){
			$.ajaxSec({
				type: 'POST',
				url: base+'/admin/teamInfo/updateRecommendation',
				data: {id:rid,re_sort:ne},
				cache: false,
				success: function(result){
					if (result.state=='success') {
						ListPage.paginate(ListPage.currentPage);
	                } else {
	                	layer.msg("操作失败",{icon: 2});
	                }
				},
				error: $.ajaxError
			});
		}
	}else{
		$(dom).val('0');
	}
}

var iframeTeamInfo;
function select_team_info(){
	iframeTeamInfo = layer.open({
	    type: 2,
	    title: '选择俱乐部',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/teamInfo/recDialog' //iframe的url
	}); 
}

function saveRecommend(tids){
	$.ajaxSec({
		type: 'POST',
		url: base+'/admin/teamInfo/saveRecommendation',
		data: {teamIds: tids},
		success: function(data){
			if (data.state=='success') {
				layer.close(iframeTeamInfo);
				layer.msg("保存成功",{icon: 1});
				ListPage.paginate(ListPage.currentPage);
			}else{
				if(data.message&&data.message.error[0]){
					layer.msg(result.message.error[0],{icon: 2});
				}else{
					layer.msg("保存失败",{icon: 2});
				}
			}
		},
		error: $.ajaxError
	});
}

</script>
