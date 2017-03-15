<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">论坛管理</a></li>
		<li><a href="">版主管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2>
					<i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
					<span onclick="ListPage.form('${ctx}/admin/bbs/leaderForm?plate_id=${plate_id}','#leaderForm','${ctx}/admin/bbs/saveOrUpdateLeader')" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 添加版主</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					 <div class="col-lg-12">
						<form id="searchForm">
							<div class="dataTables_filter" id="DataTables_Table_0_filter">
								<label>版主名称: 
									<input type="text" name="username" value=""/>
									<script type="text/javascript">$("#status").val('${params.status}');</script>
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
				<!-- <hr style="margin:2px;height:1px"> -->
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th style="text-align: center;">板块</th>
							  <th style="text-align: center;">版主名称</th>
							  <th style="text-align: center;">任职时间</th>
							  <th style="text-align: center;">操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
						  <c:forEach items="${leaders}" var="leader">
						      <tr>
							  	  <td style="text-align: center;line-height: 38px;">
							  	  	${leader.name}
							  	  </td>
						  		  <td style="text-align: center;line-height: 38px;">
						  		     <yt:userName id="${leader.user_id}"/>
						  		  </td>
						  		  <td style="text-align: center;line-height: 38px;">
						  		     <fmt:formatDate value="${leader.duty_time}" pattern="yyyy-MM-dd HH:mm:ss" />
						  		  </td>
						  		  <td style="text-align: center;line-height: 38px;">
							  	  	<input type="button" name="add_btn" class="btn btn-info" value="编辑"
						   						onclick="ListPage.form('${ctx}/admin/bbs/leaderForm?plate_id=${plate_id}','#leaderForm','${ctx}/admin/bbs/saveOrUpdateLeader','${leader.id}')"/>
									<input type="button" name="del_btn" class="btn btn-danger" value="删除"
				   						onclick="ListPage.remove('${ctx}/admin/bbs/deleteLeader','${leader.id}')"/>
							  	  </td>
						  	  </tr>
						  </c:forEach>
					  </tbody>
				 </table>  
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">

</script>
