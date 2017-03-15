<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>赛程编辑</a></li>
		<li><a>${league.name}</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<c:forEach items="${listGroup}" var="group">
				<table class="table table-bordered form-group table-striped">	
					<caption>${group.name}</caption>
					<thead>
				      <tr>
				         <th>比赛轮次</th>	
				         <th>主队名称</th>
				         <th>客队名称</th>
				         <th>比赛时间</th>
				         <th>比赛地点</th>
				         <th>比赛赛制(人制)</th>
				         <th>比赛状态</th>
				         <th class="col-sm-2">操作</th>
				      </tr>
				   </thead>
				   <tbody>
				   	  <c:forEach items="${events}" var="event">
					   	  <c:if test="${group.id eq event.group_id}">	
						      <tr>
						         <td>${event.rounds}</td>
						         <td>${event.m_team_name}</td>
						         <td>${event.g_team_name}</td>
						         <td><fmt:formatDate value="${event.play_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						         <td>${event.position}</td>
						         <td>${event.ball_format}</td>
						         <td><span 
						         	<c:choose>	
						         		<c:when test="${event.status eq 1}">
						         			style="color: red;"
						         		</c:when>
						         		<c:when test="${event.status eq 2}">
						         			style="color: blue;"
						         		</c:when>
						         		<c:otherwise></c:otherwise>	
						         	</c:choose> >
						         	<yt:dict2Name nodeKey="l_status" key="${event.status}"></yt:dict2Name>
						         </span>
						         </td>
						         <td>
						         	<input type="button" name="edit" class="btn btn-info" onclick="ListPage.form('${ctx}/admin/eventRecord/formJsp?league_id=${league.id}&id=${event.id}&flag=true','#_itemEditForm','${ctx}/admin/eventRecord/saveOrUpdate')" value="编辑"/>
						         	<input type="button" name="del" class="btn btn-danger" onclick="ListPage.remove('${ctx}/admin/eventRecord/delete','${event.id}')" value="删除"/>	
						         </td>
						      </tr>
					   	  </c:if>	
				   	  </c:forEach> 	
				   </tbody>
				</table>
			</c:forEach>
			<c:choose>
				<c:when test="${!empty listGroup}">
					<form id="_itemEditForm" method="post" class="form-horizontal">
						<input type="hidden" name="id" value="${_item.id}"/>
						<div class="form-actions">
							<a class="btn btn-success" onclick="ListPage.form('${ctx}/admin/eventRecord/formJsp?league_id=${league.id}','#_itemEditForm','${ctx}/admin/eventRecord/saveOrUpdate')">新增</a>
							<a class="btn btn-success" onclick="ListPage.form('${ctx}/admin/eventRecord/formBathcJsp?league_id=${league.id}','#_itemEditForm','${ctx}/admin/eventRecord/uploadFile')">批量导入</a>
							<a class="btn" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/league/leagueOpt?id=${league.id}',searchForm:'#searchForm'});">返回</a>
						</div>
					</form>
				</c:when>
				<c:otherwise>
					暂无联赛分组信息，请前往联赛分组菜单进行联赛分组！
				</c:otherwise>
			</c:choose>
		</div>
	</div><!--/col-->
</div><!--/row-->
