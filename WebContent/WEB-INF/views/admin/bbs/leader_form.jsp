<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="leaderForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${leaderForm.id}"/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">板块</span>
					<span class="form-control">
						${bbsPlate.name}
						<input type="hidden" name="plate_id" value="${bbsPlate.id}"/>
					</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">版主</span>
					<c:choose>
						<c:when test="${!empty leaderForm.user_id}">
							<span class="form-control" style="width: 87%;"><yt:userName id='${leaderForm.user_id}'></yt:userName></span>
						</c:when>
						<c:otherwise>
							<input type="text" id="user_name" name="user_name" value="" class="form-control" readonly="readonly"  style="width: 87%;"/>
						</c:otherwise>
					</c:choose>
					<a class="btn btn-primary" onclick="select_user();">选择</a>
					<input type="hidden" id="user_id" name="user_id" value="${leaderForm.user_id}" class="form-control"/>
				</div>	
			</div>		
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">任职期限</span>
					<span class="form-control">
					<input name="duty_time" class="form-control ui_timepicker" valid="require" value="<fmt:formatDate value='${leaderForm.duty_time}' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">板块备注</span>
					<span class="form-control">
					<textarea name="remark" class="form-control">${leaderForm.remark}</textarea>
				</div>	
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">确认</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->

<script type="text/javascript">
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
	
	var iframePInfo;
	function select_user(iid,tid){
		iframePInfo = layer.open({
		    type: 2,
		    title: '选择版主',
		    shadeClose: true,
		    shade: [0],
		    area: ['1330px', '640px'],
		    content: base+'/admin/bbs/userDialog' //iframe的url
		}); 
	}
	
	function changeUser(value,name){
		$("#user_id").val(value);
		$("#user_name").val(name);
		layer.close(iframePInfo);
	}
	
</script>