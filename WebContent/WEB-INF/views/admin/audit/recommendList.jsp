<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">用户管理</a></li>
		<li><a href="">推荐球员列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="select_player_info()"  style="cursor: pointer ;"> 添加球员</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>
								昵称: 
								<input type="text" name="usernick" value=""/> 		
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
						  	  <th>用户姓名</th>
							  <th>用户昵称</th>
							  <th>用户邮箱</th>
							  <th>用户电话</th>
							  <th>创建时间</th>
							  <th>是否显示</th>
							  <th>排序</th>	
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  <c:forEach items="${page.items}" var="re" varStatus="i">
							<tr>
								<td>${re.username}</td>
								<td>${re.usernick}</td>
								<td>${re.email}</td>
								<td>${re.phone}</td>
								<td><fmt:formatDate value="${re.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><yt:dictSelect name="if_up" id="if_up${i.index}" nodeKey="status" value="${re.if_up}"></yt:dictSelect></td>
								<td><input type="text" id="re_sort${i.index}" value="${re.re_sort}" class="form-control"></td>
								<td>
									<a class="btn btn-info" title="保存" onclick="updateRePlayer('${i.index}','${re.id}')">
										<i class="fa fa-credit-card"> 保存</i> 
									</a>
									<a class="btn btn-danger" title="删除" onclick="delRePlayer('${re.id}');">
										<i class="fa fa-trash-o"> 删除</i> 
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
	var iframeUserInfo;
	function select_player_info(){
		iframeUserInfo = layer.open({
		    type: 2,
		    title: '选择球员',
		    shadeClose: true,
		    shade: [0],
		    area: ['1330px', '640px'],
		    content: base+'/admin/audit/userDialog' //iframe的url
		}); 
	}
	
	function saveRePlayer(uids,username){
		$.ajaxSec({
			type: 'POST',
			url: base+'/admin/audit/savePlayerRecommendation',
			data: {userIds: uids},
			success: function(data){
				if (data.state=='success') {
					layer.close(iframeUserInfo);
					layer.msg("保存成功",{icon: 1});
					ListPage.paginate(ListPage.currentPage);
				}else{
					if(result.message&&result.message.error[0]){
						layer.msg(result.message.error[0],{icon: 2});
					}else{
						layer.msg("保存失败",{icon: 2});
					}
				}
			},
			error: $.ajaxError
		});
	}
	
	function updateRePlayer(i,id){
		$.ajaxSec({
			type: 'POST',
			url: base+'/admin/audit/updatePlayerRecommendation',
			data: {id: id,if_up:$("#if_up"+i).val(),re_sort:$("#re_sort"+i).val()},
			success: function(data){
				if (data.state=='success') {
					layer.close(iframeUserInfo);
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
	
	function delRePlayer(id){
		$.ajaxSec({
			type: 'POST',
			url: base+'/admin/audit/deletePlayerRecommendation',
			data: {id: id},
			success: function(data){
				if (data.state=='success') {
					layer.msg("删除成功",{icon: 1});
					ListPage.paginate(ListPage.currentPage);
				}else{
					if(data.message&&data.message.error[0]){
						layer.msg(result.message.error[0],{icon: 2});
					}else{
						layer.msg("删除失败",{icon: 2});
					}
				}
			},
			error: $.ajaxError
		});
	}
	
</script>


