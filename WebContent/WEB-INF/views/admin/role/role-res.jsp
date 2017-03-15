<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>角色管理</a></li>
		<li><a>编辑角色</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="roleResForm" method="post" class="form-horizontal">
			<input type="hidden" name="role_id" value="${role.role_id}"/>
			<input type="hidden" id="resids" name="resids" value="${resIds}"/> 
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">角色名称</span>
					<input type="text" value="${role.role_name}" readonly="readonly" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">角色资源	</span>
					<ul id="resTree" class="ztree"></ul>
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
<SCRIPT type="text/javascript">
var setting = {
	view: {
		showIcon: false
	},
	check: {
		enable: true
	},
	data: {
		key: {
			name: "res_name"
		},
		simpleData: {
			enable: true,
			idKey: "res_id",
			pIdKey: "res_parentid"
		}
	},
	callback: {
		onCheck: onCheck
	}
};
function onCheck(e, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("resTree"),
	nodes = zTree.getCheckedNodes(true);
	var resIds = "";
	if(nodes&&nodes.length>0){
		for (var i = 0; i < nodes.length; i++) {
			var node = nodes[i];
			if(node){
				resIds+=node.res_id+",";
			}
		}
	}
	if(resIds){
		resIds = resIds.substring(0,resIds.lastIndexOf(","));
	}
	$("#resids").val(resIds);
}
ListPage.extTree(setting,"#resTree",{url:"${ctx}/admin/role/queryResources"},"#resids");
</SCRIPT>
