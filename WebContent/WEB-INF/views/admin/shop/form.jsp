<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">系统管理</a></li>
		<li><a href="">产品维护</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="editForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${o.id}"/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品名称</span>
					<input type="text" name="p_name" value="${o.p_name}" valid="require len(1,20)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品代码</span>
					<input type="text" name="p_code" value="${o.p_code}" valid="require len(1,20)" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">产品价格(宇币)</span>
					<input type="text" name="p_price" value="${o.p_price}" valid="require len(1,20)" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">提升魅力值</span>
					<input type="text" name="charm_value" value="${o.charm_value}" valid="require len(1,20)" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">图片路径</span>
					<input type="text" name="image_src" value="${o.image_src}" valid="require len(1,200)" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否上架</span>
					<select class="form-control" id="status" name="status" >
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
					<script type="text/javascript">$("#status").val('${empty o.status?0:o.status}')</script>
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
