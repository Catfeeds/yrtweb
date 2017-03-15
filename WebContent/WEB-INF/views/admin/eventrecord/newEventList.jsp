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
<div class="col-sm-12">
	<div class="box">
		<div class="box-header">
			<h2><i class="fa fa-th"></i> 赛程</h2>
		</div>
		<div class="box-content">
			<ul class="nav tab-menu nav-tabs" id="myTab">
				<c:forEach begin="1" end="${rounds}" varStatus="i">
					<li <c:if test="${i.index == 1}">class="active"</c:if>><a href="#${i.index}">${i.index}</a></li>
				</c:forEach>
			</ul>
			<div id="myTabContent" class="tab-content">
				<c:forEach items="${turnList}" var="t" varStatus="i">
					<div class="tab-pane <c:if test="${i.index == 0}">active</c:if>" id="${i.index+1}">
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
						   	  <c:forEach items="${t}" var="event">
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
						   	  </c:forEach> 	
						   </tbody>
						</table>	
					</div>
				</c:forEach>	
			</div>
		</div>
	</div>
	<div class="form-actions">
		<a class="btn btn-success" onclick="ListPage.form('${ctx}/admin/eventRecord/formJsp?league_id=${league.id}','#_itemEditForm','${ctx}/admin/eventRecord/saveOrUpdate')">新增</a>
		<a class="btn btn-success" onclick="ListPage.form('${ctx}/admin/eventRecord/formBathcJsp?league_id=${league.id}','#_itemEditForm','${ctx}/admin/eventRecord/uploadFile')">批量导入</a>
		<a class="btn" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/league/leagueOpt?id=${league.id}',searchForm:'#searchForm'});">返回</a>
	</div>
</div><!--/col-->
</div><!--/row-->
<script type="text/javascript">
	$('#myTab a:first').tab('show');
	$('#myTab a').click(function (e) {
	  e.preventDefault();
	  console.log( $(this));
	  $(this).tab('show');
	});			
	/* function events(i){
		$(".tab-pane").removeClass("active");
		$("#"+i).addClass("active");
	} */
</script>
