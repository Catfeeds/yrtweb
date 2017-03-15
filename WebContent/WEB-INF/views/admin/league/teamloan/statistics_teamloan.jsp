<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">赛季管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li><a href="">租借统计</a></li>
	</ul>
	<hr>
</div>
<c:forEach items="${data_list}" var="data">
<div class="box">
		<div class="box-header">
			<h2>
			<i class="fa fa-tasks"></i>
			<span class="break"></span>
				${data.league.name}
			</h2>
		</div>
		<div class="box-content">	
			<table class="table table-bordered table-striped">
				<tr>
					<td>轮次</td>
					<td>租借人数</td>
					<td>操作</td>
				</tr>
				<c:forEach items="${data.data}" var="detail">	
					<tr>
						<td>${detail.turn_num}</td>
						<td>${detail.z_count}</td>
						<td>
							<a onclick="toExcel('${detail.turn_num}');" class="btn">
								<i class="fa fa-download"> 导出</i>                                        
							</a>
						</td>
					</tr>
				</c:forEach>	
			</table>
		</div>	
	</div>
</c:forEach>
<a class="btn btn-success" onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueCfgOpt?id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
	<i class="fa">返回</i>                                     
</a>

<script type="text/javascript">
//导出excel
function toExcel(num){
	window.location.href = base+"/admin/teamloan/excel?s_id=${leagueCfg.id}"
							+"&turn_num="+num;  
}
</script>

