<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>角色管理</a></li>
		<li><a>图片管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="imageEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${imageForm.id}"/>
			<input type="hidden" name="type" value="image"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">标题</span>
					<input class="form-control disabled" id="disabledInput" type="text" placeholder="${imageForm.title}" disabled="">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">提交时间</span>
					<input class="form-control disabled" id="disabledInput" type="text" placeholder="<fmt:formatDate value='${imageForm.create_time}' pattern='yyyy-MM-dd HH:mm:ss' />" disabled="">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">图片</span>
					<img class="img-thumbnail"  alt="图片" src="${el:filePath(imageForm.f_src,imageForm.to_oss)}" style="width: 100px;height: 100px;cursor: pointer;" onclick="showImage(this)"/>	
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">路径</span>
					<input class="form-control disabled" id="disabledInput" type="text" placeholder="${imageForm.f_src}" disabled="">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">图片大小</span>
					<input class="form-control disabled" id="disabledInput" type="text" placeholder="${imageForm.f_size}" disabled="">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">点赞数</span>
					<input class="form-control disabled" id="disabledInput" type="text" placeholder="${imageForm.praise_count}" disabled="">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否可用</span>
					<div class="controls">
					  <select name="f_status" class="form-control">
						<option>请选择
						<option value="0" <c:if test="${imageForm.f_status eq 0}">selected="true"</c:if>>不可用
						<option value="1" <c:if test="${imageForm.f_status eq 1}">selected="true"</c:if>>可用
					  </select>
					</div>
				</div>
			</div>
			<div class="form-actions">
				<a class="btn btn-primary" onclick="ListPage.submit()">提交</a>
				<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
