<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>赛季管理</a></li>
		<li><a>赛季分类管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="leagueCfgForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" id="id" value="${leagueCfgForm.id}"/>
			<%-- <input type="hidden" name="if_balance" id="if_balance" value="${leagueCfgForm.if_balance}"/> --%>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4" style="position: relative;">
					<span class="input-group-addon">年份</span>
					<input type="text" id="year" name="year" value="${leagueCfgForm.year}" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4" style="position: relative;">
					<span class="input-group-addon">赛季</span>
					<yt:dictSelect name="season" nodeKey="season"  required="require"  clazz="form-control" value="${leagueCfgForm.season}"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4" style="position: relative;">
					<span class="input-group-addon">区域</span>
					<input type="hidden" id="area_code" name="area_code" value="${leagueCfgForm.area_code}" valid="require len(1,60)" class="form-control" >
					<input type="text" id="area_name" name="area_name" value="<yt:areaName code="${leagueCfgForm.area_code}" clazz="form-control"/>" class="form-control" onclick="showTree(event);">
					<div id="select_tree" style="display:none;position:absolute;z-index: 20;background: #fff;border: 1px solid #979797;"></div>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">报名开始时间</span>
					<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${leagueCfgForm.s_starttime}' pattern='yyyy-MM-dd HH:mm:ss' />" name="s_starttime" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">报名结束时间</span>
					<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${leagueCfgForm.s_endtime}' pattern='yyyy-MM-dd HH:mm:ss' />" name="s_endtime" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">赛季状态</span>
					<yt:dictSelect name="status" nodeKey="l_status" value="${leagueCfgForm.status}" required="require" clazz="form-control"></yt:dictSelect>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">赛季封面</span>
					<div id="league_image_src" valid="requireUpload">
                 		<c:if test="${!empty leagueCfgForm.image_src}">
               			<div class="fileUploader-item">
                  			<img src="${el:headPath()}${leagueCfgForm.image_src}">
                  			<input type="hidden" name="image_src" value="${leagueCfgForm.image_src}">
               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否显示</span>
					<yt:dictSelect name="if_show" nodeKey="status" value="${leagueCfgForm.if_show}" required="require" clazz="form-control"></yt:dictSelect>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">排序</span>
					<input type="text" id="sort" name="sort" value="${leagueCfgForm.sort}" class="form-control">	
				</div>	
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
			<c:if test="${!empty leagueCfgForm.id}">
				<c:choose>
					<c:when test="${leagueCfgForm.if_balance eq 1}">
						<a class="btn btn-danger">已结算</a>
					</c:when>
					<c:otherwise>
						<a class="btn btn-danger" onclick="balanceSeason();">赛季球员结算</a>
					</c:otherwise>
				</c:choose>
			</c:if>		
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script src="${ctx}/resources/fileupload/webuploader/webuploader.js"></script>
<script src="${ctx}/resources/fileupload/fileUploader.js"></script>

<script type="text/javascript">
	var zTree;
	$(function(){
		$("#select_tree").append('<ul id="areaTree" class="ztree"></ul>');
		console.log($("#select_tree").val());
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
					onClick: OnClickCheck
				}
				
			};
		zTree = $.fn.zTree.init($("#areaTree"), setting);	
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
	
	function OnClickCheck(event, treeId, treeNode){
		$("#area_name").val(treeNode.area_name);
		$("#area_code").val(treeNode.area_code);
		$("#select_tree").hide();
	}

	function showTree(event){
		var e = window.event || event;
		var e = window.event || event;
        if (e.stopPropagation) {
            e.stopPropagation();
        } else {
            e.cancelBubble = true;
        }
        $("#select_tree").show();
	}
	$("#area_name").click=showTree;
	
	$("#select_tree").click(function (event) {
          var e = window.event || event;
          if (e.stopPropagation) {
              e.stopPropagation();
          } else {
              e.cancelBubble = true;
          }
    });
    document.onclick = function () {
                $("#select_tree").hide();
    };
	
	$(".ui_timepicker").datetimepicker({
	    //showOn: "button",
	    //buttonImage: "./css/images/icon_calendar.gif",
	    //buttonImageOnly: true,
	    showSecond: true,
	    timeFormat: 'hh:mm:ss',
	    stepHour: 1,
	    stepMinute: 1,
	    stepSecond: 1
	});
	var uploadeOptsDress = {
			uploaderType: 'imgUploader',
			itemWidth: 80,
			itemHeight: 80,
			fileNumLimit: 1,
			fileSingleSizeLimit: 2*1024*1024, /*1M*/
			fileVal: 'file',
			server: base+'/imageVideo/uploadFile?filetype=picture',
			toolbar:{
				del: true
			}
		};
$('#league_image_src').fileUploader($.extend({},uploadeOptsDress,{inputName:'image_src'}));
	
	//赛季结算
	function balanceSeason(){
		$.ajax({
			type:"POST",
			url:base+"/admin/league/balanceSeason",
			data:{"id":$("#id").val()},
			dataType:"json",
			success:function(data){
				if(data.state=='error'){
					layer.msg(data.message.error[0],{icon:2});
				}else{
					layer.msg(data.message.success[0],{icon:1});
					ListPage.enter({context:'#content',url:'${ctx}/admin/league/cfgList',searchForm:'#cfgForm'});
				}
			}
		});
	}


</script>