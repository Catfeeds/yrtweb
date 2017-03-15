<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>用户管理</a></li>
		<li><a>编辑用户后台角色</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="userRoleForm" method="post" class="form-horizontal">
			<input type="hidden" name="userId" value="${user.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">用户昵称</span>
					<input type="text" value="${user.usernick}" readonly="readonly" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">用户手机</span>
					<input type="text" value="${user.phone}" readonly="readonly" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">用户邮箱</span>
					<input type="text" value="${user.email}" readonly="readonly" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div id="check_user_role" class="input-group date col-sm-4">
					<span class="input-group-addon">后台权限</span>
					<c:forEach items="${roles}" var="role">
						<c:set var="flag" value="0" />
						<c:forEach items="${userRoles}" var="ur">
							<c:if test="${ur.role_id==role.role_id}">
								<c:set var="flag" value="1" />
							</c:if>
						</c:forEach>
						<c:choose>
							<c:when test="${flag==1}">
								<input style="width: 20px;" id="role_${role.role_id}" value="${role.role_id}" onchange="change_role(this)" checked="checked" type="checkbox" name="roles" class="form-control">${role.role_name}
							</c:when>
							<c:otherwise>
								<input style="width: 20px;" id="role_${role.role_id}" value="${role.role_id}" onchange="change_role(this)" type="checkbox" name="roles" class="form-control">${role.role_name}
							</c:otherwise>
						</c:choose>
					</c:forEach>
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
<script>
function change_role(dom){
	if(dom.checked){
		if(dom.value!=$("#role_1").val()){
			if($("#role_1").get(0).checked){
				layer.msg("你已经是超级管理员",{icon: 2});
				dom.checked = false;
			}
		}else{
			$("#check_user_role").find("input[type=checkbox]").each(function(){
				if(this.value!=1){
					this.checked =false;
				}
			});
		}
	}
}
</script>
