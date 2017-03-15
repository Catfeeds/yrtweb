<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>赛季管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li>数据列表</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="signForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${adminSignForm.id}"/>
			<input type="hidden" name="s_id" value="${leagueCfg.id}"/>
			<fieldset class="col-sm-12">	
			<%-- <div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联赛名称</span>
					 <select name="leagues_id" class="form-control">
					 	<c:forEach items="${list}" var="league">
							<option value="${league.id}" <c:if test="${adminSignForm.leagues_id eq league.id}">selected="true"</c:if>>${league.name}
					    </c:forEach>
					 </select>
				</div>	
			</div> --%>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">手机号</span>
					<input type="text" name="mobile" value="${adminSignForm.mobile}" valid="require mobile" class="form-control">
				</div>	
			</div>
			<div class="form-group">	
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">用户名称</span>
					<input type="text" name="username" value="${adminSignForm.username}" valid="require len(1,30)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">身份证</span>
					<input type="text" name="idcard" value="${adminSignForm.idcard}" valid="require len(1,18)" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否交费</span>
					<yt:dictSelect name="if_pay" nodeKey="status" value="${adminSignForm.if_pay}"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">录入方式</span>
					<yt:dictSelect name="input_type" nodeKey="input_type" value="${adminSignForm.username}"></yt:dictSelect>
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
</script>