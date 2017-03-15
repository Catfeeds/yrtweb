<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="tipForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${tip.id}"/>
			<fieldset class="col-sm-12">
		    <div class="form-group">
				<div class="input-group date col-sm-5">
					<span class="input-group-addon">被举报主题：</span>
					<input type="text" value="${tip.title }" style="width: 76%;" class="form-control" readonly="readonly"/>
					<a class="btn btn-success" onclick="javascript:void(window.open('${ctx}/bbs/noteDetails/${tip.note_id}'))" style="margin-left:10px;" target="_blank">查看帖子详情</a>
				</div>	
			</div>	 
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">被举报楼层：</span>
					<input type="text" name="title" value="${tip.floor_num}"  class="form-control" readonly="readonly"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">举&nbsp;&nbsp;报&nbsp;&nbsp;人&nbsp;：</span>
					<span class="form-control"><yt:id2NameDB beanId="userService" id="${tip.user_id}" clazz="f12"></yt:id2NameDB></span>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">举报日期&nbsp;&nbsp;：</span>
					<span class="form-control"><fmt:formatDate value='${tip.create_time}' pattern='yyyy-MM-dd HH:mm:ss' /></span>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">违规描述&nbsp;&nbsp;：</span>
					<span class="form-control">${tip.content }</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">处理状态&nbsp;&nbsp;：</span>
					<select class="form-control" name="status" id="status">
					     <option  <c:if test="${tip.status  == 2 }">selected="selected"</c:if> value="2" >未处理<option>
					     <option  <c:if test="${tip.status  == 1 }">selected="selected"</c:if> value="1">已处理<option>
					</select>
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