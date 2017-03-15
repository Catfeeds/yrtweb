<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="select_player()" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 确认选择</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<input type="hidden" name="teaminfo_id" value="${params.teaminfo_id}">
						<input type="hidden" name="cfg_id" value="${params.cfg_id}">
						<input type="hidden" id="ps_id" name="ps_id" value="${params.ps_id}">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>昵称: <input type="text" name="usernick" value="${params.usernick}"></label>
							<label>姓名: <input type="text" name="username" value="${params.username}"></label>
							<label>帐号: <input type="text" name="phone" value="${params.phone}"></label>
							<label>是否租借: 
								<select id="if_loan" name="if_loan">
									<option value="">全部</option>	
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
								<script type="text/javascript">$("#if_loan").val('${params.if_loan}');</script>
							</label>
							&nbsp;&nbsp;&nbsp;&nbsp;
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
				<table id="iv_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
						  	  <th>选择</th>
							  <th>姓名</th>
							  <th>昵称</th>
							  <th>帐号</th>
							  <th>当前俱乐部</th>
							  <th>出租俱乐部</th>
							  <th>年龄</th>
							  <th>身高</th>                                          
							  <th>体重</th>                                          
							  <th>能力</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="data">
						<tr onclick="selectThis(this)">
							<td>
							<input style="width: 20px;" value="${data.user_id}" name="pid" type="radio" class="">
							</td>
							<td data-value="username">${data.username}</td>
							<td data-value="usernick">${data.usernick}</td>
							<td>${empty data.phone?data.email:data.phone}</td>
							<td>${data.buy_teaminfo}</td>
							<td>${data.loan_teaminfo}</td>
							<td>${data.age}</td>
							<td>${data.height}</td>
							<td>${data.weight}</td>
							<td>${data.score}</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">
function selectThis(dom){
	var id = $(dom).find("[name=pid]").attr("checked", true);
}
function select_player(){
	$("#iv_table").find('input[type=radio]').each(function(){
		if(this.checked){
			haveCheck = true;
			var uname = $(this).parent().parent().find("[data-value=username]").text();
			var unick = $(this).parent().parent().find("[data-value=usernick]").text();
			window.parent.changeTeamPlayer($("#ps_id").val(),this.value,uname,unick);
		}
	});
	
	if(!haveCheck){
		layer.msg('请选择球员',{icon: 2});
	}
}

</script>