<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑个人统计</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="leagueStatisticsEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${statistics.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联&emsp;&emsp;赛</span>
					<select class="form-control" id="league_sel" name="league_id" disabled="disabled"  valid="require">
						<c:forEach items="${leagues}" var="lg">
						<option value="${lg.id}">${lg.name}</option>
						</c:forEach>
					</select>
					<script type="text/javascript">$("#league_sel").val('${statistics.league_id}')</script>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员姓名</span>
					<input type="text" id="user_name" value="${empty user.username?user.usernick:user.username}" valid="require" readonly="readonly" class="form-control">
					<%-- <input type="text" id="user_name" value="${empty user.username?user.usernick:user.username}" valid="require" readonly="readonly" class="form-control" style="width: 87%;">
					<a class="btn" onclick="select_user()">选择</a> --%>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">助攻排序</span>
					<input type="text" name="zg_sort" value="${empty statistics.zg_sort?0:statistics.zg_sort}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">红牌排序</span>
					<input type="text" name="hop_sort" value="${empty statistics.hop_sort?0:statistics.hop_sort}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">黄牌排序</span>
					<input type="text" name="hup_sort" value="${empty statistics.hup_sort?0:statistics.hup_sort}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">双黄牌排序</span>
					<input type="text" name="shup_sort" value="${empty statistics.shup_sort?0:statistics.shup_sort}" valid="require number" class="form-control">
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
</script>