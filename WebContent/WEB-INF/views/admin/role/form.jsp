<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>角色管理</a></li>
		<li><a>编辑角色</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="roleEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="role_id" value="${role.role_id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">角色名称</span>
					<input type="text" name="role_name" value="${role.role_name}" valid="require len(1,60)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">角色标识</span>
					<input type="text" name="role_str" value="${role.role_str}" valid="require len(1,60)" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否后台权限</span>
					<input style="width: 20px;" value="0" type="radio" name="role_state" <c:if test="${role.role_state==0 || (empty role.role_state)}">checked="checked"</c:if> class="form-control">否
					<input style="width: 20px;" value="1" type="radio" name="role_state" <c:if test="${role.role_state==1}">checked="checked"</c:if> class="form-control">是
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
