<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>轮播管理</a></li>
		<li><a>编辑轮播</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="indexBannerForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${banner.id}"/>
			<fieldset class="col-sm-12">	
			<%-- <div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">轮播标题</span>
					<input type="text" name="name" value="${banner.title}" valid="len(0,500)" class="form-control">
				</div>	
			</div> --%>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">轮播图片</span>
					<div id="index_img_src" valid="requireUpload">
                 		<c:if test="${!empty banner.img_src}">
               			<div class="fileUploader-item">
                  			<img src="${el:headPath()}${banner.img_src}">
                  			<input type="hidden" name="img_src" value="${banner.img_src}">
               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">图片链接</span>
					<input type="text" name="img_path" value="${banner.img_path}" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">图片排序</span>
					<input type="text" name="sort" value="${empty banner.sort?0:banner.sort}" valid="number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">新开窗口</span>
					<input style="width: 20px;" value="0" type="radio" name="if_blank" <c:if test="${banner.if_blank!=1 || (empty banner.if_blank)}">checked="checked"</c:if> class="form-control">否
					<input style="width: 20px;" value="1" type="radio" name="if_blank" <c:if test="${banner.if_blank==1 && (!empty banner.if_blank)}">checked="checked"</c:if> class="form-control">是
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否使用</span>
					<input style="width: 20px;" value="0" type="radio" name="if_use" <c:if test="${banner.if_use!=1 || (empty banner.if_use)}">checked="checked"</c:if> class="form-control">否
					<input style="width: 20px;" value="1" type="radio" name="if_use" <c:if test="${banner.if_use==1 && (!empty banner.if_use)}">checked="checked"</c:if> class="form-control">是
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
var uploadeOptsIndex = {
	uploaderType: 'imgUploader',
	itemWidth: 80,
	itemHeight: 80,
	fileNumLimit: 1,
	fileSingleSizeLimit: 2*1024*1024, /*1M*/
	fileVal: 'file',
	server: base+'/imageVideo/uploadFile?filetype=picture_index_banner',
	toolbar:{
		del: true
	}
};
$('#index_img_src').fileUploader($.extend({},uploadeOptsIndex,{inputName:'img_src'}));
</script>
