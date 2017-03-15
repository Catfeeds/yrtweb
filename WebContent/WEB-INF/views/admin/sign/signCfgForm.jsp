<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>报名管理</li>
		<li>报名设置</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="signCfgForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${adminSignCfgForm.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">报名主题</span>
					<input type="text" name="title" value="${adminSignCfgForm.title}" valid="require" class="form-control">
				</div>	
			</div>
			
			<div class="form-group">	
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">开始时间</span>
						<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${adminSignCfgForm.start_time}' pattern='yyyy-MM-dd HH:mm:ss' />" name="start_time" data-date-format="yyyy-mm-dd HH:mm:ss">
				</div>	
			</div>
			
			<div class="form-group">	
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">结束时间</span>
						<input type="text" class="form-control ui_timepicker" 
						value="<fmt:formatDate value='${adminSignCfgForm.end_time}' pattern='yyyy-MM-dd HH:mm:ss' />" name="end_time" data-date-format="yyyy-mm-dd HH:mm:ss">
				
				</div>	
			</div>
			
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">报名描述</span>
					<textarea name="description" class="form-control">${adminSignCfgForm.description}</textarea>
				</div>
			</div>
			
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span id="upload_msg" class="input-group-addon">海报图片（默认1张）</span>
					<div id="img_src" valid="requireUpload">
						<c:if test="${ not empty adminSignCfgForm.images}">
							<c:forEach items="${fn:split(adminSignCfgForm.images,',')}" var="img">
	  							<div class="fileUploader-item">
		               				<img src="${filePath}/${img}">
		                  			<input type="hidden" name="images" value="${img}">
	               				</div>
	  						</c:forEach>
                   		</c:if>
                   	</div>
				</div>
			</div>
			
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">海报数量</span>
					<input type="text" id="img_num" value="${fn:length(fn:split(adminSignCfgForm.images,','))}" class="form-control" onblur="initPlugin();">
				</div>
			</div>
			
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否放开</span>
					<yt:dictSelect name="if_show" nodeKey="status" value="${adminSignCfgForm.if_show}" required="require" clazz="form-control"></yt:dictSelect>
				</div>
			</div>
			
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">url关键字</span>
					<input type="text" id="keyword" name="keyword" value="${adminSignCfgForm.keyword}" valid="require" class="form-control" onblur="checkKey();">
				</div>
			</div>
			
			<div class="form-group">
				<div class="input-group date col-sm-4" style="position: relative;">
					<span class="input-group-addon">赛季报名（非赛季不选）</span>
					<c:choose>
						<c:when test="${empty adminSignCfgForm.s_id}">
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
										<c:when test="${adminSignCfgForm.s_id eq cfgForm.id}">
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
			
			
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submitByMore()">保存</a>
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
	$(function(){
		createPlugin(1); //默认1张
	})
		
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
	function initPlugin(){
		$("#img_src").empty().attr("cs-data-uid","");	
		var num = $("#img_num").val();
		if(num == ""){
			createPlugin(1);
		}else{
			createPlugin(num);
		}
	}
	
	function createPlugin(num){
		var uploadeOptsImg = {
				uploaderType: 'imgUploader',
				itemWidth: 80,
				itemHeight: 80,
				fileNumLimit: num,
				fileSingleSizeLimit: 2*1024*1024, /*1M*/
				fileVal: 'file',
				multiple:true,
				server: base+'/imageVideo/uploadFile?filetype=picture',
				toolbar:{
					del: true
				}
			};
			$('#img_src').fileUploader($.extend({},uploadeOptsImg,{inputName:'images'}));
	}
	
	function checkKey(){
		var keyword = $("#keyword").val();
		$.ajax({
			type:'post',
			url:base+'/admin/sign/keyword',
			data:{"keyword":keyword},
			dataType:'json',
			success:function(data){
				if(data.state=='success'){
				}else{
					layer.msg(data.message.error[0],{icon:2});
					$("#keyword").val("");
				}			
			}
		});
		
	}
	
</script>