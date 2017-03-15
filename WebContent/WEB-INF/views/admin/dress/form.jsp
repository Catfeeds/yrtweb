<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>皮肤管理</a></li>
		<li><a>编辑皮肤</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="dresEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${dres.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">模板名称</span>
					<input type="text" name="name" value="${dres.name}" valid="require len(1,60)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">模板路径</span>
					<input type="text" name="css_src" value="${dres.css_src}" valid="require len(1,60)" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">永久价格</span>
					<input type="text" name="money" value="${dres.money}" valid="number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">月价格(单价/月)</span>
					<input type="text" name="price_month" value="${dres.price_month}" valid="number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">模板封面</span>
					<div id="dress_img_src" valid="requireUpload">
                 		<c:if test="${!empty dres.img_src}">
               			<div class="fileUploader-item">
                  			<img src="${filePath}/${dres.img_src}">
                  			<input type="hidden" name="img_src" value="${dres.img_src}">
               			</div>
             			</c:if>
                   	</div>
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
<script src="${ctx }/resources/fileupload/webuploader/webuploader.js"></script>
<script src="${ctx }/resources/fileupload/fileUploader.js"></script>
<script type="text/javascript">
	var uploadeOptsDress = {
		uploaderType: 'imgUploader',
		itemWidth: 80,
		itemHeight: 80,
		fileNumLimit: 1,
		fileSingleSizeLimit: 2*1024*1024, /*1M*/
		fileVal: 'file',
		server: base+'/imageVideo/uploadFile?filetype=dress_picture',
		toolbar:{
			del: true
		}
	};
	$('#dress_img_src').fileUploader($.extend({},uploadeOptsDress,{inputName:'img_src'}));
</script>
