<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<style type="text/css">
   #rMenu{
      position: absolute;
      background: #fff;
      border: 1px solid #CCC3C3;
      visibility:hidden;
   }
   #rMenu ul{
      padding: 5px 5px 0 5px !important;
   }
   #rMenu ul li{
       list-style-type: none;
       font-size: 12px;
       line-height: 24px;
       cursor: pointer;
   }
   .blue{
     color:#4AB4E8;
   }
   .recolor{
      color:#646464;
   }
</style>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>区域管理</a></li>
		<li><a>区域界面</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			区域
			<ul id='areaTree' class="ztree">
        	</ul>
		</div>
	</div><!--/col-->
</div><!--/row-->
<div id="rMenu">
	<ul>
	<li id="m_add" onclick="addTreeNode();">增加区域</li>
	<li id="m_edit" onclick="editTreeNode();">编辑区域</li>
	<li id="m_del" onclick="removeTreeNode();">删除区域</li>
	</ul>
</div>



<script type="text/javascript">
var zTree, rMenu;
var setting = {
		async: {
			enable : true,
			url : base+"/admin/area/sysAreaTree",
			autoParam : ["area_code"],
			dataFilter : filter
		},		
		view:{
			showTitle:true, //是否显示标题
			showLine:true
		},
		check:{
			enable:false//是否显示checkbox Or Radio
		},
		data:{
			key:{
				name:"area_name" //节点属性名称
			}
		},
		callback:{
			onRightClick: OnRightClick
		}
		
	};
$(function(){
	zTree = $.fn.zTree.init($("#areaTree"), setting);	
	rMenu = $("#rMenu");
});

function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	for (var i=0, l=childNodes.length; i<l; i++) {
		childNodes[i].area_name = childNodes[i].area_name.replace(/\.n/g, '.');
		//判断是否叶子节点
		if(childNodes[i].leaf == 0){
			childNodes[i].isParent = true;
		}else{
			childNodes[i].isParent = false;
		}
			
	}
	return childNodes;
}

//右键操作
function OnRightClick(event, treeId, treeNode) {
	if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
		zTree.cancelSelectedNode();
		showRMenu("root", event.clientX, event.clientY);
	} else if (treeNode && !treeNode.noR) {
		zTree.selectNode(treeNode);
		showRMenu("node", event.clientX-280, event.clientY-58);
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
	rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});

	$("body").bind("mousedown", onBodyMouseDown);
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
	rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});

	$("body").bind("mousedown", onBodyMouseDown);
}
function hideRMenu() {
	if (rMenu) rMenu.css({"visibility": "hidden"});
	$("body").unbind("mousedown", onBodyMouseDown);
}
function onBodyMouseDown(event){
	if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
		rMenu.css({"visibility" : "hidden"});
	}
}

//添加区域面板
var iframeTeamInfo;
function addTreeNode(){
	var nodes = zTree.getSelectedNodes();
	console.log(nodes[0].area_code);
	iframeTeamInfo = layer.open({
	    type: 2,
	    title: '保存节点信息',
	    shadeClose: true,
	    shade: [0],
	    area: ['600px', '720px'],
	    content: base+'/admin/area/toAddTreePage?area_code=' + nodes[0].area_code //iframe的url
	}); 
}
//编辑区域面板
function editTreeNode(){
	var nodes = zTree.getSelectedNodes();
	console.log(nodes[0].area_code);
	iframeTeamInfo = layer.open({
	    type: 2,
	    title: '编辑节点信息',
	    shadeClose: true,
	    shade: [0],
	    area: ['600px', '720px'],
	    content: base+'/admin/area/toAddTreePage?opt=edit&area_code=' + nodes[0].area_code //iframe的url
	}); 
}
//删除区域
function removeTreeNode(){
	var nodes = zTree.getSelectedNodes();
	$.ajaxSec({
		type : 'POST',
		url : base+"/admin/area/delSysArea",
		data : {area_code:nodes[0].area_code},
		dataType:"json",
		cache : false,
		success : function(result) {
			console.log(result);
			if(result.state=='error'){
				layer.msg(result.message.error[0],{icon:2});
			}else{
				layer.msg(result.message.success[0],{icon:1},function(){
					zTree.removeNode(nodes[0]);
				});
			}
		},
		error : $.ajaxError
	});
}

//刷新当前节点
function refreshCurrentNode(){
	layer.close(iframeTeamInfo);
	var nodes = zTree.getSelectedNodes();
	console.log(nodes[0]);
	if (nodes.length>0) {
		zTree.reAsyncChildNodes(nodes[0], "refresh");
	}
}


$("#rMenu li").mouseover(function() {
    $(this).addClass("blue").siblings().removeClass("blue");
});



</script>
