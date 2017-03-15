<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">球员管理</a></li>
		<li><a href="">球员列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>用户帐号: <input type="text" name="username" value="${params.username}"></label>
							<label>用户姓名: <input type="text" name="name" value="${params.name}"></label>
							<!-- <label>是否妖人: 
								<select id="if_daji" name="if_daji">
									<option value="">全部</option>
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
								<script type="text/javascript">$("#if_daji").val('${params.if_daji}');</script>
							</label> -->
							<label>认证级别: 
								<select id="level" name="level">
									<option value="">全部</option>
									<option value="0">0级</option>
									<option value="1">1级</option>
									<option value="2">2级</option>
									<option value="3">3级</option>
								</select>
								<script type="text/javascript">$("#level").val('${params.level}');</script>
							</label>
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>用户帐号</th>
							  <th>用户昵称</th>
							  <th>用户姓名</th>
							  <th>所属俱乐部</th>
							  <!-- <th>是否妖人</th> -->
							  <th>认证级别</th>
							  <th>创建时间</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="player">
						<tr>
							<td>${empty player.phone ? player.email : player.phone}</td>
							<td>${player.usernick}</td>
							<td>${player.username}</td>
							<td><yt:id2NameDB beanId="teamInfoService" id="${player.teaminfo_id}"></yt:id2NameDB></td>
							<%-- <td>
								<c:if test="${player.if_daji eq 1}">
								<span style="color: red;">妖人</span>
								</c:if>
							</td> --%>
							<td>${player.level}级</td>
							<td>${player.create_time}</td>
							<td>
								<sec:authorize ifAnyGranted="${resources['/admin/player/updatePlayerLevel']}">
								<a class="btn btn-info" onclick="update_level('${player.id}','${empty player.phone ? player.email : player.phone}','${player.level}')">
									<i class="fa fa-search-plus"> 认证</i>  
								</a>
								</sec:authorize>
							</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->

<div id="update_level" class="row" style="display: none;width: 100%;height: 100%;margin-left: 0px;margin-right: 0px;">	
	<div class="col-lg-12">
		<div class="box">
			<form id="update_level_form" action="${ctx}/admin/player/updatePlayerLevel" method="post" class="form-horizontal">
			<input type="hidden" id="player_id" name="id" value=""/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">用户帐号</span>
					<input type="text" id="player_username" value="" class="form-control" style="width: 220px;" readonly="readonly">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">认证级别</span>
					<select class="form-control" id="player_level" name="level" style="width: 220px;" >
						<option value="0">0级</option>
						<option value="1">1级</option>
						<option value="2">2级</option>
						<option value="3">3级</option>
					</select>
				</div>	
			</div>
			<div class="form-actions" style="padding: 19px 125px 20px;">
			<a class="btn btn-primary" onclick="ListPage.submit();update_level_cancel();">保存</a>
			<a class="btn" onclick="update_level_cancel()">关闭</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div>
<script type="text/javascript">
var html = $("#update_level").get(0).outerHTML;
var model = $(html);
model.show();
model.attr("id","update_level_1");
model.find("#update_level_form").attr("id","update_level_form_1");
model.find("#player_id").attr("id","player_id_1");
model.find("#player_username").attr("id","player_username_1");
model.find("#player_level").attr("id","player_level_1");
var open_index;
function update_level(pid,username,level){
	open_index = layer.open({
	    type: 1,
	    skin: 'layui-layer-rim', //加上边框
	    area: ['420px', '244px'], //宽高
	    content: model.get(0).outerHTML
	});
	$("#player_id_1").val(pid);
	$("#player_username_1").val(username);
	$("#player_level_1").val(level);
	ListPage.formid='#update_level_form_1';
}

function update_level_cancel(){
	layer.close(open_index);
}
</script>
