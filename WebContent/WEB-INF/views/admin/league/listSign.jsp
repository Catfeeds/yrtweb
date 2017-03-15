<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>赛季管理</li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li>报名列表</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2>
					<i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
					<a style="cursor: pointer;" title="批量审批" onclick="checkOK();"><span>批量审批</span></a><span class="break"></span>
					<a style="cursor: pointer;" title="返回" onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueCfgOpt?id=${leagueCfg.id}',searchForm:'#searchForm'});" ><span>返回</span></a><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
							<div class="dataTables_filter" id="DataTables_Table_0_filter">
								<label>审核状态: 
									<yt:dictSelect name="status" nodeKey="ls_status" value="${params.status}"></yt:dictSelect>
								</label>
								<label>昵称 ： <input type="text" name="usernick" value="${params.usernick}"></label>
								<label>姓名 ： <input type="text" name="username" value="${params.username}"></label>
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
						  	  <th><input type="checkbox" id="all_btn" value=""/></th>	
							  <th>球员昵称</th>
							  <th>球员名称</th>
							  <th>报名时间</th>
							  <th>审核状态</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="sign" varStatus="i">
						<tr>
							<td><input type="checkbox" name="id_c" value="${sign.id}"/></td>	
							<td>${sign.usernick}</td>
							<td>${sign.username}</td>
							<td><fmt:formatDate value="${sign.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<yt:dict2Name nodeKey="ls_status" key="${sign.status}"></yt:dict2Name>
							</td>
							<td>
								<a class="btn btn-info" title="审核" onclick="ListPage.form('${ctx}/admin/league/signForm','#signForm','${ctx}/admin/league/updateSign','${sign.id}')">
									报名审核
								</a>
								<a class="btn btn-info" title="审核" onclick="checkAudit('${sign.user_id}')">
									身份证审核
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

	<script>
		function checkAudit(user_id){
			$.ajax({
				type:'post',
				url:base+'/admin/audit/ifAudit',
				data:{"user_id":user_id},
				dataType:'json',
				success:function(data){
					if(data.state=='success'){
						ListPage.form('${ctx}/admin/audit/userAuditById?type=idcard','#userForm','${ctx}/admin/audit/playerAuditResult',user_id);
					}else{
						layer.msg(data.message.error[0],{icon:2});
						return false;
					}			
				}
			});
		}
		
		$("#all_btn").bind("click", function () {
			if($(this).attr("checked")){
				$("[name='id_c']:checkbox").attr("checked", true);
			}else{
				$("[name='id_c']:checkbox").attr("checked", false);
			}
        });
		
		function checkOK(){
			layer.confirm('是否处理选中记录？', {
			    btn: ['是','否'], //按钮
			    shade: false //不显示遮罩
			}, function(index){
				var ids = "";
				$("[name='id_c']:checkbox").each(function(){
					if($(this).attr("checked")){
						ids = ids + $(this).val() + ",";
					}
				});
				$.ajax({
					type:'post',
					url:base+'/admin/league/batchUpdateSign',
					data:{"ids":ids},
					dataType:'json',
					success:function(data){
						layer.close(index);
						if(data.state=='success'){
							ListPage.paginate(ListPage.currentPage);
						}else{
							layer.msg(data.message.error[0],{icon:2});
							return false;
						}			
					}
				});
			}, function(){});
		}
	</script>
