<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="select_eventrecord()" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 确认选择</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<input type="hidden" id="select_type" value="1">
						<input type="hidden" name="league_id" value="${params.league_id}"/>
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>俱乐部: <input type="text" name="teaminfo_name" value="${params.teaminfo_name}"></label>
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
				<table id="eventrecord_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
						  	  <th>选择</th>
						  	  <th>联赛记录ID</th>
							  <th>联赛ID</th>
							  <th>主场俱乐部ID</th>
							  <th>主队名称</th>
							  <th>客场俱乐部ID</th>
							  <th>客队名称</th>
							  <th>比赛时间</th>
							  <th>比赛赛制</th>
							  <th>比赛地址</th>
							  <th>第几轮</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="data">
						<tr>
							<td>
							<c:choose>
								<c:when test="${empty params.stype || params.stype=='1'}">
								<input style="width: 20px;" value="${data.id}" name="pid" type="radio" class="">
								</c:when>
								<c:otherwise>
									<input style="width: 20px;" value="${data.id}" name="pid" type="checkbox" class="">
								</c:otherwise>
							</c:choose>
							</td>
							<td id="eventrecordId">${data.id}</td>
							<td>${data.league_id}</td>
							<td>${data.m_teaminfo_id}</td>
							<td>${data.mname}</td>
							<td>${data.g_teaminfo_id}</td>
							<td>${data.gname}</td>
							<td>${data.play_time}</td>
							<td>${data.ball_format}</td>
							<td>${data.position}</td>
							<td>${data.rounds}</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<style>
.showvdo {
    position: relative;
}

#playSWF {
    position: absolute;
    width: 20px;
    height: 20px;
    right: 0px;
    top: -18px;
    cursor: pointer;
}
</style>
<div id="showVideo" ><img id="playSWF" src="${ctx}/resources/images/close.png"/><div id="a1" class="showvdo"></div></div>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">

</script>