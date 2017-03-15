<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑分组</a></li>
		<li><a>${league.name}</a></li>
	</ul>
	<hr>
</div>
<div class="row">		
	<div class="col-lg-12">
		<div class="box">
			<form id="groupsEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="league_id" id="league_id" value="${league.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<c:if test="${empty tList}">
					<h2>暂无联赛俱乐部报名！</h2>
				</c:if>
				<table class="table table-bordered form-group table-striped">
					<caption>联赛俱乐部</caption>
					<tr>
						<th>俱乐部ID</th>
						<th>俱乐部名称</th>
						<th>选择分组</th>
					</tr>	
					<c:forEach items="${tList}" var="team" varStatus="i"> 
						<tr>
							<td>${team.teaminfo_id}</td>
							<td>${team.name}</td>
							<td>
								<c:choose>
									<c:when test="${empty team.group_id}">
										<select id="${team.teaminfo_id}" name="group_id">
											<option value="">请选择</option>
											<c:forEach items="${gList}" var="group">
												<option value="${group.id}">${group.name}</option>
											</c:forEach>
										</select>
									</c:when>	
									<c:otherwise>	
										<select id="${team.teaminfo_id}" name="group_id" disabled="disabled">
											<option value="">请选择</option>
											<c:forEach items="${gList}" var="group">
												<option value="${group.id}" <c:if test="${team.group_id eq group.id}">selected</c:if>>${group.name}</option>
											</c:forEach>
										</select>
									</c:otherwise>
								</c:choose>
								<input type="button" name="edit" class="btn btn-primary" value="编辑" onclick="enSel('${team.teaminfo_id}','${i.index}');"/>
								<input type="button" id="${i.index}" name="save" class="btn btn-success" value="保存" onclick="saveGroup('${team.teaminfo_id}','${i.index}');" disabled="disabled"/>
							</td>
						</tr>					
					</c:forEach>
				</table>
			</div>	
			<div class="form-actions">
				<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">
	function enSel(dom,i){
		$("#"+dom).attr("disabled",false);
		$("#"+i).attr("disabled",false);
	}
	//保存分组
	function saveGroup(dom,i){
		var group_id = $("#"+dom).val();
		if(group_id == ''){
			layer.msg("请选择联赛分组！",{icon:2});
			return false;
		}
		
		   $.ajaxSec({
				type: 'POST',	
				url: base+"/admin/leagueGroup/editGroup",
				data:{"teaminfo_id":dom,"group_id":$("#"+dom).val(),"league_id":$("#league_id").val()},
				dataType:"json",
				success: function(data){
					if(data.state=='error'){
						layer.msg(data.message.error[0],{icon:2});
					}else{
						layer.msg(data.message.success[0],{icon:1});	
						$("#"+dom).attr("disabled",true);
						$("#"+i).attr("disabled",true);
					}
				},
				error: $.ajaxError
			});
		
	}
</script>