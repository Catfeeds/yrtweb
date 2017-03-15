<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>资源管理</a></li>
		<li><a>编辑资源</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="resourcesEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="flag" value="${flag}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">上级资源</span>
					<input type="hidden" id="res_parentid" name="res_parentid" value="${resources.res_parentid}"/>
					<input id="parent_name" name="parent_name" type="text" value="${parent_name}" onkeyup="clean_input(this)" class="form-control">
					<div id="select_tree" style="display:none;position:absolute;background:#fff none repeat scroll 0 0;border:1px solid #e5e5e5;cursor:pointer;z-index:5;"></div>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">资源 ID &nbsp;</span>
					<input type="text" id="res_id" name="res_id" value="${resources.res_id}" valid="require" readonly="readonly" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">资源名称</span>
					<input type="text" name="res_name" value="${resources.res_name}" valid="require" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">资源URL</span>
					<input type="text" name="res_url" value="${resources.res_url}" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">资源序号</span>
					<input type="text" id="res_sort" name="res_sort" value="${resources.res_sort}" readonly="readonly" class="form-control">
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
<script type="text/javascript">

function changeParent(dom){
	var pval = $(dom).val();
	setIdSort(pval);
}

function setIdSort(pval){
	$.ajaxSec({
		type: 'POST',
		url: '${ctx}/admin/resources/getLastRes',
		data: {pval:pval},
		success: function(result){
			if(result.data.res){
				$("#res_id").val(parseInt(result.data.res.res_id)+1);
				$("#res_sort").val(parseInt(result.data.res.res_sort)+1);
			}else{
				$("#res_id").val(pval+"001");
				$("#res_sort").val(1);
			}
		},
		error: $.ajaxError
	});
}

ListPage.select_tree("#select_tree",{
	url:'${ctx}/admin/role/queryResources',
	name:'res_name',
	idKey:'res_id',
	pIdKey:'res_parentid',
	input_id:'parent_name'
},function(e,tid,treeNode){
$("#res_parentid").val(treeNode.res_id);
$("#parent_name").val(treeNode.res_name);
$("#select_tree").hide();
setIdSort(treeNode.res_id);
});

function clean_input(dom){
	$(dom).val('');
}

$(function(){
	var rid = $("#res_id").val();
	if(rid){
		$("#parent_name").attr("disabled","disabled");
	}else{
		setIdSort('');
	}
})
</script>
