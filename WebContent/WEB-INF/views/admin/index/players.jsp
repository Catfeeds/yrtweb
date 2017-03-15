<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>首页管理</a></li>
		<li><a>视频管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="add_index_video()" style="cursor: pointer;">添加球员栏位</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>昵称</th>
							  <th>手机号</th>
							  <th>场上位置</th>
							  <th>年龄</th>
							  <th>身高</th>                                          
							  <th>体重</th>                                          
							  <th>能力</th>                                          
							  <th>当前身价</th>                                          
							  <th>排序</th> 
							  <th>创建时间</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="data" varStatus="num">
						<tr>
							<td>${data.usernick}</td>
							<td>${data.phone}</td>
							<td>${data.position}</td>
							<td>${data.age}</td>
							<td>${data.height}</td>
							<td>${data.weight}</td>
							<td>${data.score}</td>
							<td>${data.current_price}</td>
							<td>${num.index+1}</td>
							<td>
								<fmt:formatDate value="${data.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td>
								<a class="btn btn-info" title="" onclick="select_player_info('${data.iid}')">
									<i class="fa fa-search-plus"> 选择球员</i> 
								</a>
								<a class="btn btn-danger" title="" onclick="ListPage.remove('${ctx}/admin/index/deleteField','${data.iid}')">
									<i class="fa fa-trash-o "> 删除栏位</i> 
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

function add_index_video(){
	layer.confirm('是否确认添加首页球员栏位？', {
	    btn: ['是','否'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/admin/index/addField',
			data: {type:'player'},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					layer.msg("添加成功",{icon: 1});
					ListPage.enter();
                } else {
                	layer.msg("添加失败",{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

var iframePInfo;
function select_player_info(iid){
	iframePInfo = layer.open({
	    type: 2,
	    title: '选择球员',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/index/dialog?id='+iid+'&type=player' //iframe的url
	}); 
}

function changePlayer(iid,bid){
	if(iid&&bid){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/admin/index/addFieldValue',
			data: {id:iid,oth_id:bid,type:'player'},
			cache: false,
			success: function(result){
				layer.close(iframePInfo);
				if (result.state=='success') {
					layer.msg("添加成功",{icon: 1});
					ListPage.enter();
                } else {
                	layer.msg("添加失败",{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}
}
</script>

