<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛管理</a></li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league_id}','#leagueForm','/admin/league/saveLeague','${league_id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league_id}"></yt:id2NameDB>
			</a>
		</li>	
		<li><a href="">激活码列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/league/activeForm?league_id=${league_id}','#activeForm','${ctx}/admin/league/saveCodeActive')" 
					style="cursor: pointer;">生成邀请码</a><span class="break"></span></h2>
				<h2><a onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" style="cursor: pointer;">返回 </a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>是否可用 ：
								<select name="status">
									<option value="">--请选择--</option>
									<option value="1" <c:if test="${params.status eq 1}">selected</c:if>>可用</option>
									<option value="2" <c:if test="${params.status eq 2}">selected</c:if>>不可用</option>
								</select>
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
							  <th>俱乐部激活码</th>
							  <th>使用俱乐部</th>
							  <th>俱乐部初始资金</th>
							  <th>球员邀请码单价</th>
							  <th>球员邀请码数量</th>
							  <th>是否可用租借</th>
							  <th>是否可用定向转会</th>
							  <th>俱乐部使用期限</th>
							  <th>生成时间</th>
							  <th>是否允许带人</th>
							  <th>状态</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${datas}" var="data">
						<tr>
							<td>${data.code_str}</td>
							<td>${data.tname}</td>
							<td>${data.init_capital}</td>
							<td>${data.init_price}</td>
							<td>${data.code_count}</td>
							<td>
								<c:choose>
									<c:when test="${data.if_loan eq 1}">可用</c:when>
									<c:otherwise>不可用</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${data.if_transfer eq 1}">可用</c:when>
									<c:otherwise>不可用</c:otherwise>
								</c:choose>
							</td>
							<th><fmt:formatDate value="${data.end_time}" pattern="yyyy-MM-dd HH:mm:ss"/></th>
							<th><fmt:formatDate value="${data.create_time}" pattern="yyyy-MM-dd"/></th>
							<td>
								<c:choose>
									<c:when test="${data.p_status eq 1}">是</c:when>
									<c:when test="${data.p_status eq 0}">否</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${data.status eq 1}">未使用</c:when>
									<c:when test="${data.status eq 2}">已使用</c:when>
								</c:choose>
							</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/league/toActiveCodePage?id=${data.id}','#activeForm','${ctx}/admin/league/updateActiveCode','${data.id}')">
									<i class="fa fa-gear"> 编辑</i> 
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
