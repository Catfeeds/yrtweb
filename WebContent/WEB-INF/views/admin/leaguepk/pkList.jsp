<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛信息管理</a></li>
		<li><a href="${ctx}/admin/eventForecast">赛事预告</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="ListPage.form('${ctx}/admin/Record/formJsp','#_itemEditForm','${ctx}/admin/eventForecast/saveOrUpdate')" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 添加</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>俱乐部名称: <input type="text" name="teaminfo_name" value="${params.teaminfo_name}"></label>
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
							  <th>主队名称	VS 客队名称</th>
							  <th>比分</th>
							  <th>比赛时间</th>
							  <th>比赛赛制</th>
							  <th>第几轮</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="_item">
						<tr>
							<td>${_item.name}</td>
							<td>${_item.m_team_name} VS ${_item.g_team_name}</td>
							<td>
								<c:choose>
									<c:when test="${!empty _item.m_score &&!empty _item.g_score}">
										${_item.m_score}:${_item.g_score} 
									</c:when>
									<c:otherwise>
										暂无比分
									</c:otherwise>
								</c:choose>
							</td>
							<td>${_item.play_time}</td>
							<td>${_item.ball_format}</td>
							<td>${_item.rounds}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/pkRecord/formJsp','#_itemEditForm','${ctx}/admin/pkRecord/saveOrUpdate','${_item.id}')">
									<i class="fa fa-edit"> 编辑</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/pkRecord/delete','${_item.id}')">
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
