<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a onclick="ListPage.enter({context:'#content',url:'/admin/interface/leagueCount',searchForm:'#searchForm'});" style="cursor: pointer;">接口管理</a></li>
		<c:if test="${not empty league_id}">
			<li>
				<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league_id}','#leagueForm','/admin/league/saveLeague','${league_id}')" style="cursor: pointer;">
					<yt:id2NameDB beanId="leagueService" id="${league_id}"></yt:id2NameDB>
				</a>
			</li>	
		</c:if>	
		<li>全网接口管理</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<c:if test="${not empty league_id}">
					<h2><a onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" 
					style="cursor: pointer;">返回</a><span class="break"></span></h2>
				</c:if>
			</div>
			<div class="box-content">
				<div class="row">
					 <div class="col-lg-12">
						<form id="searchForm">
							<div class="dataTables_filter" id="DataTables_Table_0_filter">
								<label>接口赛事ID: <input type="text" name="matchId" value="${params.match_id}"></label>
								<select name="league_id" id="league_id">
									<option value="">全部</option>
									<c:forEach items="${leagueList}" var="league">
										<c:if test="${league.id eq league_id}">
											<option value="${league.id}" selected="selected">${league.name}</option>
										</c:if>
										<c:if test="${league.id ne league_id}">
											<option value="${league.id}">${league.name}</option>
										</c:if>
									</c:forEach>
								</select>	
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
				<!-- <hr style="margin:2px;height:1px"> -->
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
						  	   <th style="text-align: center;">联赛名称</th>
							  <th style="width: 6%;text-align: center;">比赛ID</th>
							  <th style="width: 8%;text-align: center;">比赛日期</th>
							  <th style="text-align: center;width: 18%;">主队</th>
							  <th style="text-align: center;width: 18%;">客队</th>
							  <th style="text-align: center;width: 6%;">审核状态</th>
							  <th style="text-align: center;width: 6%;">发布状态</th>
							  <th style="text-align: center;width: 6%;">接口请求次数</th>
							  <th style="text-align: center;width: 23%;">操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  <c:forEach items="${page.items}" var="match" varStatus="index">
					      <tr>
						  	  <td style="text-align: center;line-height: 38px;">
								<yt:id2NameDB beanId="leagueService" id="${match.league_id}"></yt:id2NameDB>	
						      </td>
						  	  <td style="text-align: center;line-height: 38px;">${match.match_id }</td>
						  	  <td style="text-align: center;line-height: 38px;">
						  	       <fmt:formatDate value="${match.date_time}" pattern="yyyy-MM-dd HH:mm"/>
						  	  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		       <yt:id2NameDB beanId="teamInfoService" id="${match.h_team_id}" clazz="f12"></yt:id2NameDB>
					  		  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		       <yt:id2NameDB beanId="teamInfoService" id="${match.v_team_id}" clazz="f12"></yt:id2NameDB>
					  		  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		      <c:choose>
					  		          <c:when test="${match.review_status == 1}">
					  		                                                     未审核
					  		          </c:when>
					  		          <c:otherwise>
					  		                                                    已审核
					  		          </c:otherwise>
					  		      </c:choose>
					  		       
					  		  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		        <c:choose>
					  		          <c:when test="${match.status == 1}">
					  		                                                     未发布
					  		          </c:when>
					  		           <c:when test="${match.status == 2}">
					  		                                                     已发布
					  		          </c:when>
					  		          <c:otherwise>
					  		                                                    已作废
					  		          </c:otherwise>
					  		      </c:choose>
					  		  </td>
					  		  <td style="text-align: center;line-height: 38px;">${match.invokeCount}</td>
					  		  <td style="text-align: center;">
					  		    <input type="button" name="notice" class="btn btn-info" style="margin-top: 4px;" value="编辑数据" onclick="ListPage.form('${ctx}/admin/interface/matchForm','#matchForm','${ctx}/admin/interface/saveQMatchInfo','${match.id}')"/>
					  		    <input type="button" name="notice" class="btn btn-success" value="发布统计" onclick="publishDatas('${match.id}',${match.status})"/>	
					  		    <input type="button" name="notice" class="btn btn-warning" value="获取数据" onclick="getMatchInfoDatas('${match.match_id}')"/>	
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

<script type="text/javascript">
     /*
      *获取数据
      */
     function getMatchInfoDatas(matchId){
    	 if(matchId == ''){
    		 layer.msg("接口联赛id不能为空",{icon: 2});
    		 return;
    	 }
    	 if($('#league_id').val() == ''){
    		 layer.msg("请选择联赛获取数据",{icon: 2});
    		 return;
    	 }
    	 $.ajaxSec({
    				type: 'POST',
    				url: base+'/admin/interface/getMatchInfoAndToAddByMatchId',
    				data: {matchId: matchId,league_id:$('#league_id').val()},
    				success: function(data){
    				if (data.state=='success') {
    					layer.msg("获取接口赛事数据成功",{icon: 1});
    					ListPage.paginate(ListPage.currentPage);
    				}else{
    					layer.msg("获取接口赛事数据失败-接口ID无效",{icon: 2});
    					ListPage.paginate(ListPage.currentPage);
    				}
    			},
    			error: $.ajaxError
    		});
     }
     /**发布数据*/
     function publishDatas(id,publishStatus){
    	 if(publishStatus == 2){
    		 layer.msg("该数据已发布",{icon: 2});
    		 return;
    	 }
    	 if(id == ''){
    		 layer.msg("接口联赛id不能为空",{icon: 2});
    		 return;
    	 }
    	 var ifPublish = confirm("你确定要发布数据");
    	 if(ifPublish){
    		 $.ajaxSec({
 				type: 'POST',
 				url: base+'/admin/interface/publishQMatchInfo',
 				data: {id: id},
 				success: function(data){
 					if (data.state=='success') {
 						layer.msg("数据发布成功",{icon: 1});
 						ListPage.paginate(ListPage.currentPage);
 					}else{
 						layer.msg(data.message.error[0],{icon: 2});
 						ListPage.paginate(ListPage.currentPage);
 					}
 			    },
 			   error: $.ajaxError
 		  });
    	 }else{
    		 return;
    	 }
    	 
     }
</script>
