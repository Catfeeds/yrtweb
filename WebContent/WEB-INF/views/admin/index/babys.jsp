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
				<h2><a onclick="add_index_video()" style="cursor: pointer;"> 添加宝贝栏位</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>昵称</th>
							  <th>手机号</th>
							  <th>星座</th>
							  <th>身高</th>
							  <th>体重</th>                                          
							  <th>胸围</th>                                          
							  <th>臀围</th>                                          
							  <th>腰围</th>                                          
							  <th>评分</th>    
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
							<td>${data.constellation}</td>
							<td>${data.height}</td>
							<td>${data.weight}</td>
							<td>${data.chest}</td>
							<td>${data.hip}</td>
							<td>${data.waist}</td>
							<td>${data.score}</td>
							<td>${num.index+1}</td>
							<td>
								<fmt:formatDate value="${data.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td>
								<a class="btn btn-info" title="" onclick="select_baby_info('${data.iid}')">
									<i class="fa fa-search-plus"> 选择宝贝</i> 
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
	layer.confirm('是否确认添加首页宝贝栏位？', {
	    btn: ['是','否'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/admin/index/addField',
			data: {type:'baby'},
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

var iframeBbInfo;
function select_baby_info(iid){
	iframeBbInfo = layer.open({
	    type: 2,
	    title: '选择宝贝',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/index/dialog?id='+iid+'&type=baby' //iframe的url
	}); 
}

function changeBaby(iid,bid){
	if(iid&&bid){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/admin/index/addFieldValue',
			data: {id:iid,oth_id:bid,type:'baby'},
			cache: false,
			success: function(result){
				layer.close(iframeBbInfo);
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

