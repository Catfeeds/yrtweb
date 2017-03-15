<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>角色管理</a></li>
		<li><a>用户审核</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="userForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${userForm.id}"/>
			<input type="hidden" name="type" value="${type}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">用户名称</span>
					<input class="form-control disabled" id="disabledInput" type="text" placeholder="${userForm.name}" disabled="">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">身份证</span>
					<input class="form-control disabled" id="disabledInput" type="text" placeholder="${userForm.id_card}" disabled="">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">提交时间</span>
					<input class="form-control disabled" id="disabledInput" type="text" placeholder="<fmt:formatDate value='${userForm.create_time}' pattern='yyyy-MM-dd HH:mm:ss' />" disabled="">
				</div>
			</div>
			<c:if test="${type eq 'idcard'}">
				<div class="form-group">
					<div class="input-group date col-sm-4">
						<span class="input-group-addon">已上传照片</span>
					</div>
				</div>
				<div class="form-group">
					<div class="box-content col-sm-4" >
						<div class="row">
							<c:set value="${fn:split(userForm.img_src, ',')}" var="img_scr" />
							<c:forEach items="${img_scr}" var="item">
								<div style="margin-bottom:10px" class="col-xs-10">
									<img class="img-thumbnail"  alt="照片" src="${el:headPath()}${item}" style="height: 300px;width: 500px;"/>
								</div>
							</c:forEach>
						</div>
					</div>	
				</div>
			</c:if>
			<c:if test="${type eq 'professional'}">
				<div class="form-group">
					<div class="input-group date col-sm-4">
						<span class="input-group-addon">职业球员照片</span>
					</div>
				</div>
				<div class="form-group">
					<div class="box-content col-sm-4" >
						<div class="row">
							<c:set value="${fn:split(userForm.permit_img_src, ',')}" var="img_scr" />
							<c:forEach items="${img_scr}" var="item">
								<div style="margin-bottom:10px" class="col-xs-10">
									<img class="img-thumbnail"  alt="照片" src="${el:headPath()}${item}" style="height: 300px;width: 500px;"/>
								</div>
							</c:forEach>
						</div>
					</div>	
				</div>
			</c:if>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">认证情况</span>
					<c:choose>
						<c:when test="${!empty ifShow}">
							<c:choose>
								<c:when test="${userForm.status eq 1}"><input class="form-control disabled" id="disabledInput" type="text" placeholder="已认证" disabled=""></c:when>
								<c:when test="${userForm.status eq 2}"><input class="form-control disabled" id="disabledInput" type="text" placeholder="认证中" disabled=""></c:when>
								<c:when test="${userForm.status eq 3}"><input class="form-control disabled" id="disabledInput" type="text" placeholder="认证失败" disabled=""></c:when>
							</c:choose> 
						</c:when>
						<c:otherwise>
							<div class="controls">
							  <select name="status" class="form-control">
								<option>请选择
								<option value="1">认证通过
								<option value="3">认证失败
							  </select>
							</div>
						</c:otherwise>
					</c:choose> 
				</div>
			</div>
			
			
			
			<div class="form-actions">
				<c:if test="${empty ifShow}">
					<a class="btn btn-primary" onclick="ListPage.submit()">提交</a>
				</c:if>
				<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
