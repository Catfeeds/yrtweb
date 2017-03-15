<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛管理</a></li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${activeCode.league_id}','#leagueForm','/admin/league/saveLeague','${activeCode.league_id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${activeCode.league_id}"></yt:id2NameDB>
			</a>
		<li><a>激活码编辑</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="activeForm" method="post" class="form-horizontal">
				<fieldset class="col-sm-12">
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">球员邀请码单价</span>
							<input type="hidden" id="id" name="id" value="${activeCode.id}"/>
							<input type="text" id="init_price" name="init_price" value="${activeCode.init_price}"
							 valid="require number" class="form-control">
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">俱乐部初始资金</span>
							<input type="text" id="init_capital" name="init_capital" value="${activeCode.init_capital}"
							 valid="require number" class="form-control">
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">是否可用租借</span>
							<select class="form-control" name="if_loan">
								<option value="1" <c:if test="${activeCode.if_loan eq 1}">selected</c:if>>可用</option>
								<option value="0" <c:if test="${activeCode.if_loan eq 0}">selected</c:if>>不可用</option>
							</select>
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">是否可用定向转会</span>
							<select class="form-control" name="if_transfer">
								<option value="1" <c:if test="${activeCode.if_transfer eq 1}">selected</c:if>>可用</option>
								<option value="0" <c:if test="${activeCode.if_transfer eq 0}">selected</c:if>>不可用</option>
							</select>
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">有效日期</span>
							<input type="text" class="form-control ui_timepicker" 
								value="<fmt:formatDate value='${activeCode.end_time}' pattern='yyyy-MM-dd HH:mm:ss' />" name="end_time" data-date-format="yyyy-mm-dd HH:mm:ss">
						</div>	
					</div>
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">是否允许带人</span>
							<select class="form-control" name="p_status">
								<option value="1" <c:if test="${activeCode.p_status eq 1}">selected</c:if>>是</option>
								<option value="0" <c:if test="${activeCode.p_status eq 0}">selected</c:if>>否</option>
							</select>
						</div>	
					</div>	
					<div class="form-group">
						<div class="input-group date col-sm-4">
							<span class="input-group-addon">状态</span>
							<select class="form-control" name="status">
								<option value="1" <c:if test="${activeCode.status eq 1}">selected</c:if>>未使用</option>
								<option value="2" <c:if test="${activeCode.status eq 2}">selected</c:if>>已使用</option>
							</select>
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