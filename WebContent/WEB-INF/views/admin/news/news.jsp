<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛信息管理</a></li>
		<li><a href="">新闻管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/news/formJsp','#newsEditForm','${ctx}/admin/news/saveOrUpdate')"
				 	style="cursor: pointer;">添加新闻</a><span class="break"></span></h2>
				<%-- <div class="box-icon">
					<a href="table.html#" class="btn-setting"><i class="fa fa-wrench"></i></a>
					<a href="table.html#" class="btn-minimize"><i class="fa fa-chevron-up"></i></a>
					<a href="table.html#" class="btn-close"><i class="fa fa-times"></i></a>
				</div> --%>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>联赛标题: <input type="text" name="title" value="${params.title}"></label>
							<label>是否发布: 
								<select id="s_n_state" name="n_state">
									<option value="">全部</option>	
									<option value="USER">发布</option>
									<option value="PLAYER">未发布</option>
								</select>
								<script type="text/javascript">$("#s_n_state").val('${params.n_state}');</script>
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
							  <th>新闻ID</th>
							  <th>标题</th>
							  <th>类型</th>
							  <th>关联联赛</th>
							  <th>是否突出</th>
							  <th>是否发布</th>
							  <th>排序</th>
							  <th>创建时间</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="news">
						<tr>
							<td>${news.id}</td>
							<td>${news.title}</td>
							<td>
								<yt:dict2Name nodeKey="m_new" key="${news.type}"></yt:dict2Name>
							</td>
							<td>
								<yt:id2NameDB beanId="leagueService" id="${news.model_id}"/>
							</td>
							<td>
								<c:if test="${news.is_special=='0'}">
								否
								</c:if>
								<c:if test="${news.is_special=='1'}">
								是
								</c:if>
							</td>
							<td>
								<c:if test="${news.n_state=='0'}">
								<span style="color: red;">否</span>
								</c:if>
								<c:if test="${news.n_state=='1'}">
								<span style="color: green;">是</span>
								</c:if>
							</td>
							<td>${news.show_num}</td>
							<td>${news.create_time}</td>
							<td>
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/news/formJsp','#newsEditForm','${ctx}/admin/news/saveOrUpdate','${news.id}')">
									<i class="fa fa-edit "> 编辑</i>  
								</a>
								<c:if test="${news.n_state=='0'}">
								<a class="btn btn-info" title="发布<yt:dict2Name nodeKey="m_new" key="${news.type}"></yt:dict2Name>" 
								onclick="ListPage.confirm('是否发布这篇<yt:dict2Name nodeKey="m_new" key="${news.type}"></yt:dict2Name>？','${ctx}/admin/news/editState',{id:'${news.id}',n_state:1})">
									<i class="fa fa-check-circle"> 发布<yt:dict2Name nodeKey="m_new" key="${news.type}"></yt:dict2Name></i> 
								</a>
								</c:if>
								<c:if test="${news.n_state=='1'}">
								<a class="btn btn-danger" title="取消发布" onclick="ListPage.confirm('是否取消这篇<yt:dict2Name nodeKey="m_new" key="${news.type}"></yt:dict2Name>？','${ctx}/admin/news/editState',{id:'${news.id}',n_state:0})">
									<i class="fa fa-times-circle-o"> 取消发布</i> 
								</a>
								</c:if>
								<a class="btn btn-info" title="预览" onclick="window.open('${ctx}/news/${news.id}')">
									<i class="fa fa-toggle-right"> 预览</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/news/delete','${news.id}')">
									<i class="fa fa-trash-o "> 删除</i> 
								</a>
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
