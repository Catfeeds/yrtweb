<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<link href="${ctx}/resources/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="${ctx}/resources/ztree/js/jquery.ztree.all-3.5.js"></script>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛管理</a></li>
		<li><a>联赛创建</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="leagueForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" id="id" value="${leagueForm.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛名称</span>
					<input type="text" name="name" value="${leagueForm.name}" valid="require len(1,60)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛简称</span>
					<input type="text" name="simple_name" value="${leagueForm.simple_name}" valid="require len(1,40)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛开始时间</span>
					<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${leagueForm.bg_time}' pattern='yyyy-MM-dd HH:mm:ss' />" name="bg_time" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛结束时间</span>
					<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${leagueForm.end_time}' pattern='yyyy-MM-dd HH:mm:ss' />" name="end_time" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛轮数</span>
					<input type="text" name="rounds" value="${leagueForm.rounds}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">俱乐部验证码使用开始时间</span>
					<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${leagueForm.s_starttime}' pattern='yyyy-MM-dd HH:mm:ss' />" name="s_starttime" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">俱乐部验证码使用结束时间</span>
					<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${leagueForm.s_endtime}' pattern='yyyy-MM-dd HH:mm:ss' />" name="s_endtime" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">赛制</span>
					<yt:dictSelect name="ball_format" nodeKey="ball_format" value="${leagueForm.ball_format}" required="require" clazz="form-control"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4" style="position: relative;">
					<span class="input-group-addon">举办城市</span>
					<input type="hidden" id="city" name="city" value="${leagueForm.city}" valid="require len(1,60)" class="form-control" >
					<input type="text" id="area_name" name="area_name" value="<yt:areaName code="${leagueForm.city}" clazz="form-control"/>" class="form-control" onclick="showTree(event);">
					<div id="select_tree" style="display:none;position:absolute;z-index: 20;background: #fff;border: 1px solid #979797;"></div>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4" style="position: relative;">
					<span class="input-group-addon">赛季</span>
					<c:choose>
						<c:when test="${empty leagueForm.s_id}">
							<select name="s_id" class="form-control">
									<option value="">请选择</option>
								<c:forEach items="${cfgList}" var="cfgForm">
									<option value="${cfgForm.id}">${cfgForm.year}|<yt:areaName code="${cfgForm.area_code}"/>|<yt:dict2Name nodeKey="season" key="${cfgForm.season}"/></option>
								</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							<select name="s_id" class="form-control">
								<option value="">请选择</option>
								<c:forEach items="${cfgList}" var="cfgForm">
									<c:choose>
										<c:when test="${leagueForm.s_id eq cfgForm.id}">
											<option value="${cfgForm.id}" selected>${cfgForm.year}|<yt:areaName code="${cfgForm.area_code}"/>|<yt:dict2Name nodeKey="season" key="${cfgForm.season}"/></option>
										</c:when>
										<c:otherwise>
											<option value="${cfgForm.id}">${cfgForm.year}|<yt:areaName code="${cfgForm.area_code}"/>|<yt:dict2Name nodeKey="season" key="${cfgForm.season}"/></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</c:otherwise>
					</c:choose>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛状态</span>
					<yt:dictSelect name="status" nodeKey="l_status" value="${leagueForm.status}" required="require" clazz="form-control"></yt:dictSelect>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否展示</span>
					<yt:dictSelect name="if_show" nodeKey="status" value="${leagueForm.if_show}" required="require" clazz="form-control"></yt:dictSelect>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">海报封面</span>
					<div id="league_image_src" >
                 		<c:if test="${!empty leagueForm.image_src}">
               			<div class="fileUploader-item">
                  			<img src="${el:headPath()}${leagueForm.image_src}">
                  			<input type="hidden" name="image_src" value="${leagueForm.image_src}">
               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">banner封面</span>
					<div id="league_banner_src">
                 		<c:if test="${!empty leagueForm.banner_src}">
               			<div class="fileUploader-item">
                  			<img src="${el:headPath()}${leagueForm.banner_src}">
                  			<input type="hidden" name="banner_src" value="${leagueForm.banner_src}">
               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">背景图</span>
					<div id="league_backgroud_src">
                 		<c:if test="${!empty leagueForm.backgroud_src}">
               			<div class="fileUploader-item">
                  			<img src="${el:headPath()}${leagueForm.backgroud_src}">
                  			<input type="hidden" name="backgroud_src" value="${leagueForm.backgroud_src}">
               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label" for="textarea2">描述</label>
				<div class="controls">
					<textarea id="describle" name="describle" style="width: 100%; overflow: hidden;
					 word-wrap: break-word; resize: horizontal; height: 141px;" rows="6">${leagueForm.describle}</textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">排序</span>
					<input type="text" name="sort" value="${leagueForm.sort}" valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
			<a class="btn btn-danger" onclick="balanceLeagueMsg();">联赛球队结算</a>
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
		$("#city").val(treeNode.area_code);
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
		noCompress:true,
		server: base+'/imageVideo/uploadFile?filetype=picture',
		toolbar:{
			del: true
		}
	};
	$('#league_image_src').fileUploader($.extend({},uploadeOptsDress,{inputName:'image_src'}));
	$('#league_banner_src').fileUploader($.extend({},uploadeOptsDress,{inputName:'banner_src'}));
	$('#league_backgroud_src').fileUploader($.extend({},uploadeOptsDress,{inputName:'backgroud_src'}));
	
	//联赛结算
	function balanceLeagueMsg(){
		$.ajax({
			type:"POST",
			url:base+"/admin/league/balanceLeagueMsg",
			data:{"id":$("#id").val()},
			dataType:"json",
			success:function(data){
				if(data.state=='error'){
					layer.msg(data.message.error[0],{icon:2});
				}else{
					layer.msg(data.message.success[0],{icon:1});
					ListPage.enter({context:'#content',url:'${ctx}/admin/league/listLeague',searchForm:'#searchForm'});
				}
			}
		});
	}
</script>