<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛管理</a></li>
		<li><a>联赛管理</a></li>
		<li><a>激活码编辑</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="activeForm" method="post" class="form-horizontal">
			<fieldset class="col-sm-12">
			<input type="hidden" name="league_id" value="${league_id}"/>	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员邀请码单价</span>
					<input type="text" id="init_price" name="init_price" value=""
					 valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">俱乐部初始资金</span>
					<input type="text" id="init_capital" name="init_capital" value=""
					 valid="require number" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员激活码数量</span>
					<input type="text" id="code_count" name="code_count" value=""
					 valid="require" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否可用租借</span>
					<select class="form-control" name="if_loan">
						<option value="0">不可用</option>
						<option value="1">可用</option>
					</select>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否可用定向转会</span>
					<select class="form-control" name="if_transfer">
						<option value="0">不可用</option>
						<option value="1">可用</option>
					</select>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否可以带人</span>
					<select class="form-control" name="p_status">
						<option value="1">可以</option>
						<option value="0">不可</option>
					</select>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">批量生成个数</span>
					<input type="text" id="code_num" name="code_num" value="" valid="require" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">有效日期</span>
					<input type="text" class="form-control ui_timepicker" 
						value="" name="end_time" data-date-format="yyyy-MM-dd HH:mm:ss">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">邀请码key</span>
					<input type="text" class="form-control" value="" name="key_id" valid="require">
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
</script>