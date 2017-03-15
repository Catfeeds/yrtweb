<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="select_eventrecord()" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 确认选择</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<input type="hidden" id="select_type" name="type" value="${params.type}">
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
				<table id="eventrecord_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
						  	  <th>选择</th>
						  	  <th>联赛记录ID</th>
							  <th>联赛ID</th>
							  <th>主场俱乐部ID</th>
							  <th>主队名称</th>
							  <th>客场俱乐部ID</th>
							  <th>客队名称</th>
							  <th>比赛时间</th>
							  <th>比赛赛制</th>
							  <th>比赛地址</th>
							  <th>第几轮</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="_item">
						<tr>
							<td>
							<c:choose>
								<c:when test="${empty params.type || params.type=='1'}">
								<input style="width: 20px;" value="${_item.id}" name="itemId" type="radio" class="">
								</c:when>
								<c:otherwise>
									<input style="width: 20px;" value="${_item.id}" name="itemId" type="checkbox" class="">
								</c:otherwise>
							</c:choose>
							</td>
							<td id="eventrecordId">${_item.id}</td>
							<td>${_item.league_id}</td>
							<td>${_item.m_teaminfo_id}</td>
							<td>${_item.m_team_name}</td>
							<td>${_item.g_teaminfo_id}</td>
							<td>${_item.g_team_name}</td>
							<td>${_item.play_time}</td>
							<td>${_item.ball_format}</td>
							<td>${_item.position}</td>
							<td>${_item.rounds}</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
