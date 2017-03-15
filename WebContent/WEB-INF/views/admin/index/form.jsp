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
			<form id="indexEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${indm.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">图片标题</span>
					<input type="text" name="name" value="${indm.name}" valid="len(0,60)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">首页图片</span>
					<div id="index_img_src" valid="requireUpload">
                 		<c:if test="${!empty indm.images_url}">
               			<div class="fileUploader-item">
                  			<img src="${filePath}/${indm.images_url}">
                  			<input type="hidden" name="images_url" value="${indm.images_url}">
               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">图片链接</span>
					<input type="text" name="url" value="${indm.url}" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">图片排序</span>
					<input type="text" name="order_num" value="${indm.order_num}" valid="number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否显示</span>
					<input style="width: 20px;" value="1" type="radio" name="is_show" <c:if test="${indm.is_show==1 || (empty indm.is_show)}">checked="checked"</c:if> class="form-control">是
					<input style="width: 20px;" value="0" type="radio" name="is_show" <c:if test="${indm.is_show!=1 && (!empty indm.is_show)}">checked="checked"</c:if> class="form-control">否
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4" style="width: 60%;">
					<span class="input-group-addon">文本内容</span>
					<textarea id="index_content" name="context" style="width:100%;height:200px">${indm.context}</textarea>
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
if(ue){
	ue.destroy();
}
var ue = UE.getEditor('index_content');
var uploadeOptsIndex = {
	uploaderType: 'imgUploader',
	itemWidth: 80,
	itemHeight: 80,
	fileNumLimit: 1,
	fileSingleSizeLimit: 2*1024*1024, /*1M*/
	fileVal: 'file',
	server: base+'/imageVideo/uploadFile?filetype=index',
	toolbar:{
		del: true
	}
};
$('#index_img_src').fileUploader($.extend({},uploadeOptsIndex,{inputName:'images_url'}));
</script>
