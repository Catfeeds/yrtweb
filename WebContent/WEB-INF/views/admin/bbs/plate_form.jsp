<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="plateForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${plateForm.id}"/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">板块分类</span>
					<span class="form-control"><yt:dict2Name nodeKey="p_plate_type" key="${type}"></yt:dict2Name></span>
					<input type="hidden" name="type" value="${type}"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">板块名称</span>
					<input type="text" name="name" value="${plateForm.name}" class="form-control"/>
				</div>	
			</div>		
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">选择图标</span>
                  	<input type="text" name="image_url" value="${plateForm.image_url}" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">附件上限(M)</span>
					<input type="text" name="rar_max" value="${plateForm.rar_max}" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">板块备注</span>
					<span class="form-control">
					<textarea name="remark" class="form-control">${plateForm.remark}</textarea>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否展示</span>
					<yt:dictSelect name="if_show" nodeKey="status" value="${plateForm.if_show}" clazz="form-control"></yt:dictSelect>
				</div>	
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">确认</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->