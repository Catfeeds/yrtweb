<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">系统管理</a></li>
		<li><a href="">审核管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="certificaForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>审核状态: 
								<select name="status">
									<option value="" <c:if test="${empty params.status}">selected</c:if>>请选择</option>	
									<option value="1" <c:if test="${params.status eq 1}">selected</c:if>>已认证</option>
									<option value="2" <c:if test="${params.status eq 2}">selected</c:if>>认证中</option>
									<option value="3" <c:if test="${params.status eq 3}">selected</c:if>>认证失败</option>
								</select>
							</label>
							<label>
								昵称: 
								<input type="text" name="usernick" value=""/> 		
							</label>
							<label>
								姓名: 
								<input type="text" name="username" value=""/> 		
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
							  <th>提交时间</th>
							  <th>认证类型</th>
							  <th>描述</th>
							  <th>审核时间</th>
							  <th>认证状态</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="certification">
						<tr>
							<td>${certification.name}</td>
							<td><fmt:formatDate value="${certification.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><c:choose>
									<c:when test=" ${certification.type eq 'professional'}">职业球员认证</c:when>
									<c:otherwise>身份证认证</c:otherwise>
								</c:choose>  
							</td>
							<td>${certification.descripe}</td>
							<td><fmt:formatDate value="${certification.audit_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:choose>
									<c:when test="${certification.status eq 1}">已认证</c:when>
									<c:when test="${certification.status eq 2}">认证中</c:when>
									<c:when test="${certification.status eq 3}">认证失败</c:when>
								</c:choose>  
							</td>
							<td>
								<a class="btn btn-info" title="审核" onclick="ListPage.form('${ctx}/admin/audit/userAudit?type=${params.type}','#userForm','${ctx}/admin/audit/playerAuditResult','${certification.id}')">
									<i class="fa fa-credit-card"> 审核</i> 
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
