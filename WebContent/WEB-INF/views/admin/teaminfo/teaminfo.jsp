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
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>俱乐部名称: <input type="text" name="name" value="${params.name}"></label>
							<label>是否解散: 
							<select id="query_parent_id" name="is_exist">
							<option value="">全部</option>
							<option value="0">解散</option>
							<option value="1">存在</option>
							</select></label>&nbsp;&nbsp;&nbsp;&nbsp;
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
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
