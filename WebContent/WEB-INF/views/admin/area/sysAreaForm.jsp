<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<%@include file="../common/taglibs.jsp" %>
<style>
   body{
      background: #fff !important;
   }
</style>
<div class="container">
	
	
		<h2>保存区域节点</h2>
	
	
	<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="sysAreaForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${sysAreaForm.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">区域名称</span>
					<input type="text" name="area_name" class="form-control" value="${sysAreaForm.area_name}">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">区域代码</span>
					<input type="text" name="area_code" class="form-control" value="${sysAreaForm.area_code}">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">父区域代码</span>
					<c:choose>
						<c:when test="${empty sysAreaForm.parent_code}">
							<input type="text" name="parent_code" class="form-control" value="${area_code}">
						</c:when>
						<c:otherwise>
							<input type="text" name="parent_code" class="form-control" value="${sysAreaForm.parent_code}">
						</c:otherwise>
					</c:choose>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">首字母（大写）</span>
					<input type="text" name="first_letter" class="form-control" value="${sysAreaForm.first_letter}">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">区域级别</span>
					<c:choose>
						<c:when test="${sysAreaForm.area_level eq 0}">
							<input type="text" name="area_level" class="form-control" value="${area_level+1}">
						</c:when>
						<c:otherwise>
							<input type="text" name="area_level" class="form-control" value="${sysAreaForm.area_level}">
						</c:otherwise>
					</c:choose>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否叶子节点</span>
					<yt:dictSelect name="leaf" nodeKey="status" value="${sysAreaForm.leaf}" clazz="form-control"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">排序</span>
					<input type="text" name="area_sort" class="form-control" value="${sysAreaForm.area_sort}">
				</div>	
			</div>
			<div class="form-actions">
				<a class="btn btn-primary" onclick="saveChildNode()">保存</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
</div>

<script type="text/javascript">
	function saveChildNode(){
		var jsonData = $("#sysAreaForm").serializeObject();
		$.ajaxSec({
				type : 'POST',
				url : base+"/admin/area/saveSysArea",
				data : jsonData,
				dataType:"json",
				cache : false,
				success : function(result) {
					console.log(result);
					if(result.state=='error'){
						layer.msg(result.message.error[0],{icon:2});
					}else{
						layer.msg(result.message.success[0],{icon:1},function(){
							window.parent.refreshCurrentNode();
						});
					}
				},
				error : $.ajaxError
			});
	}
</script>
