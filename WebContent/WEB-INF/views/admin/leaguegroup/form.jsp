<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑分组</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="groupsEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${groups.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联&emsp;&emsp;赛</span>
					<select class="form-control" id="league_sel" name="league_id" valid="require">
						<option value=""></option>
						<c:forEach items="${leagues}" var="lg">
						<option value="${lg.id}">${lg.name}</option>
						</c:forEach>
					</select>
					<script type="text/javascript">$("#league_sel").val('${groups.league_id}')</script>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">分组名称</span>
					<input type="text" name="name" value="${groups.name}" valid="require" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">排序</span>
					<input type="text" name="sort" value="${groups.sort}" valid="require" class="form-control">
				</div>
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
