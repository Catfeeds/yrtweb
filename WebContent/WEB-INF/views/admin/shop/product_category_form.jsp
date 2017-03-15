<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">产品管理</a></li>
		<li><a href="">分类管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="categoryEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="category_id" value="${category.category_id}"/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">上级分类</span>
					<input type="hidden" id="parent_id" name="parent_id" value="${category.parent_id}"/>
					<input id="parent_name" name="parent_name" type="text" value="${parent_name}" onkeyup="clean_input(this)" class="form-control">
					<div id="select_tree" style="display:none;position:absolute;background:#fff none repeat scroll 0 0;border:1px solid #e5e5e5;cursor:pointer;z-index:5;"></div>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">分类名称</span>
					<input type="text" name="category_name" value="${category.category_name}" valid="require len(1,20)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">分类头像</span>
					<div id="category_header_img">
                 		<c:if test="${!empty category.category_header}">
               			<div class="fileUploader-item">
                  			<img src="${el:headPath()}${category.category_header}">
                  			<input type="hidden" name="category_header" value="${category.category_header}">
               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">分类排序</span>
					<input type="text" name="category_sort" value="${empty category.category_sort?0:category.category_sort}" valid="require number" class="form-control">
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

var upload_category_header = {
	uploaderType: 'imgUploader',
	itemWidth: 80,
	itemHeight: 80,
	fileNumLimit: 1,
	fileSingleSizeLimit: 2*1024*1024, /*1M*/
	fileVal: 'file',
	server: base+'/imageVideo/uploadFile?filetype=product_picture',
	toolbar:{
		del: true
	}
};
$('#category_header_img').fileUploader($.extend({},upload_category_header,{inputName:'category_header'}));

ListPage.select_tree("#select_tree",{
	url:'${ctx}/admin/shop/queryCategorys',
	params:{currentId:'${category.category_id}'},
	name:'category_name',
	idKey:'category_id',
	pIdKey:'parent_id',
	input_id:'parent_name'
},function(e,tid,treeNode){
	$("#parent_id").val(treeNode.category_id);
	$("#parent_name").val(treeNode.category_name);
	$("#select_tree").hide();
});

function clean_input(dom){
	$(dom).val('');
	$("#parent_id").val('');
}

$(function(){
	
})
</script>