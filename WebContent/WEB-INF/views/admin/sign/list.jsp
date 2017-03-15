<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li>报名人员</li>
		<c:choose>
			<c:when test="${not empty leagueCfg}">
				<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
			</c:when>
			<c:otherwise>
				<li>${signCfg.title}</li>
			</c:otherwise>
		</c:choose>	
		<li>数据列表</li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
					<%-- <span onclick="ListPage.form('${ctx}/admin/sign/signForm?cfg_id=${leagueCfg.id}','#signForm','${ctx}/admin/sign/saveSign')"
					 class="label label-primary" style="cursor: pointer;padding: 8px 12px;">
					<span style="font-size: 14px;">+</span>添加</span> --%>
					${signCfg.title}	
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>手机号 ： <input type="text" name="mobile" value=""></label>
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">	
								<i class="fa">重置</i>                                        
							</a>	
							<%-- <a class="btn btn-success" onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueCfgOpt?id=${league_id}',searchForm:'#searchForm'});" style="cursor: pointer;">
								<i class="fa">返回</i>                                     
							</a> --%>
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>手机号</th>
							  <c:if test="${not empty leagueCfg}">
								  <th>联赛</th>
								  <th>身份证号</th>
							  </c:if>
							  <th>录入名称</th>
							  <th>填写渠道</th>
							  <th>创建时间</th>
							  <!-- <th>操作</th>   -->                                        
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="sign">
							<tr>
								<td>${sign.mobile}</td>
								<c:if test="${flag eq true}">
									<td>${sign.name}</td>
									<td>${sign.idcard}</td>
							  	</c:if>
								<td>${sign.username}</td>
								<td>
									<yt:dict2Name nodeKey="input_type" key="${sign.input_type}"></yt:dict2Name>
								</td>
								<td><fmt:formatDate value="${sign.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<%-- <td>
									<a class="btn btn-success" title="编辑" onclick="ListPage.form('${ctx}/admin/sign/signForm?cfg_id=${leagueCfg.id}','#signForm','${ctx}/admin/sign/','${sign.id}')">
										<i class="fa fa-credit-card"></i> 
									</a>
								</td>  --%>                                      
							</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
