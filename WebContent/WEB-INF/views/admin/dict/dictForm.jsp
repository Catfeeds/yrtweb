<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>字典管理</a></li>
		<li><a>字典界面</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="roleResForm" method="post" class="form-horizontal">
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">字典描述</span>
					<input type="text" value="" readonly="readonly" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">系统字典</span>
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

<div id="rMenu">
	<ul>
		<li id="m_add" onclick="addTreeNode();">增加节点</li>
		<li id="m_del" onclick="removeTreeNode();">删除节点</li>
		<li id="m_check" onclick="checkTreeNode(true);">Check节点</li>
		<li id="m_unCheck" onclick="checkTreeNode(false);">unCheck节点</li>
		<li id="m_reset" onclick="resetTree();">恢复zTree</li>
	</ul>
</div>

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
			name: "dict_value_desc"
		},
		simpleData: {
			enable: true,
			idKey: "id",
			pIdKey: "parent_id"
		}
	},
	callback: {
		onCheck: onCheck,
		onRightClick:onRightClick
	}
};
function onCheck(e, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("resTree");
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

function onRightClick(event, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("resTree");
	if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
		zTree.cancelSelectedNode();
		showRMenu("root", event.clientX, event.clientY);
	} else if (treeNode && !treeNode.noR) {
		zTree.selectNode(treeNode);
		showRMenu("node", event.clientX, event.clientY);
	} 
}

function showRMenu(type, x, y) {
	$("#rMenu ul").show();
	if (type=="root") {
		$("#m_del").hide();
		$("#m_check").hide();
		$("#m_unCheck").hide();
	} else {
		$("#m_del").show();
		$("#m_check").show();
		$("#m_unCheck").show();
	}
	$("#rMenu").css({"top":y+"px", "left":x+"px", "visibility":"visible"});

	$("body").bind("mousedown", onBodyMouseDown);
}

function onBodyMouseDown(event){
	if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
		$("#rMenu").css({"visibility" : "hidden"});
	}
}

ListPage.extTree(setting,"#resTree",{url:"${ctx}/admin/dict/dictTree"},"#resids");
</SCRIPT>
