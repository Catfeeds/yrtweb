<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/admin/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/resources/admin/css/font-awesome.min.css" rel="stylesheet">
<link href="${ctx}/resources/admin/css/jquery-ui-1.10.3.custom.min.css" rel="stylesheet">
<link href="${ctx}/resources/admin/css/fullcalendar.css" rel="stylesheet">	
<link href="${ctx}/resources/admin/css/jquery.gritter.css" rel="stylesheet">	
<link href="${ctx}/resources/admin/css/style.min.css" rel="stylesheet">
<link href="${ctx}/resources/layer/skin/layer.css" rel="stylesheet">
<div class="container">
		<div class="row">
			<div class="form-group">
				<form id="formdata">
					<input type="hidden" name="league_id" value="${league_id}"/>
					<div class="col-sm-10" id="content" style="min-height: 360px;">
						<label for="timepicker1" class="control-label"></label>
						<div class="controls row">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-jpy">工资标准</i></span>
								<input type="text" name="salary" placeholder="请输入宇拓币金额" valid="require" value="" class="form-control">
							</div>	
						</div>
						<div class="controls row">
							<div class="form-actions">
							  <button class="btn btn-primary" type="button" onclick="saveSalaryBalance()">保存</button>
							</div>
						</div>	
					</div>
				</form>
			</div>	
		</div>
</div>	
<script src="${ctx}/resources/admin/js/jquery-2.0.3.min.js"></script>	
<script src="${ctx}/resources/js/base.js"></script>
<script src="${ctx}/resources/layer/layer.js"></script>
<script src="${ctx}/resources/js/yt.ext.js"></script>
<script src="${ctx}/resources/js/yt.core.js"></script>
<script src="${ctx}/resources/js/validation.js"></script>
<script>
	function saveSalaryBalance(){
		$.ajax({
			context:$("#formdata"),
			url:base+"/admin/league/saveSalaryBalance",
			data:$("#formdata").serialize(),
			dataType:"json",
			success:function(data){
				if(data.state=="success"){
					 window.parent.updatesalary(data.data.data.salary);
				}
			}
		});
	}
</script>
