<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">上传文件管理</a></li>
		<li><a href=""> 视频管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="videoForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>上传用户id: <input type="text" name="user_id" value="${params.user_id}"></label>
							<label>角色类型: 
								<select id="s_role_type" name="role_type">
									<option value="">请选择</option>	
									<option value="USER">球迷</option>
									<option value="PLAYER">球员</option>
									<option value="TEAM">俱乐部</option>
									<option value="BABY">宝贝</option>
									<option value="LEAGUE">联赛</option>
								</select>
								<script type="text/javascript">$("#s_role_type").val('${params.role_type}');</script>
							</label>
							<label>是否可用: 
								<select id="s_f_status" name="f_status">
									<option value="">请选择</option>	
									<option value="0">不可用</option>	
									<option value="1">可用</option>	
								</select>
								<script type="text/javascript">$("#s_f_status").val("${!empty params.f_status?params.f_status:''}");</script>
							</label>
							<input type="hidden" name="type" value="video"/>
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
							  <th>id</th>
							  <th>标题</th>
							  <th>上传人</th>
							  <th>角色类型</th>
							  <th>上传路径</th>
							  <th>点赞数</th>
							  <th>文件大小</th> 
							  <th>创建时间</th>
							  <th>描述</th>
							  <th>状态</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="video">
						<tr>
							<td>${video.id}</td>
							<td>${video.title}</td>
							<td>${video.ivname}</td>
							<td>
								<c:choose>
									<c:when test="${video.role_type eq 'USER'}">球迷</c:when>
									<c:when test="${video.role_type eq 'PLAYER'}">球员</c:when>
									<c:when test="${video.role_type eq 'TEAM'}">俱乐部</c:when>
									<c:when test="${video.role_type eq 'BABY'}">宝贝</c:when>
									<c:when test="${video.role_type eq 'LEAGUE'}">联赛</c:when>
								</c:choose>  
							</td>
							<td><img src="${el:filePath(video.v_cover,video.to_oss)}" style="width: 60px;height: 60px;cursor: pointer;" onclick="showImage(this)"/></td>
							<td>${video.praise_count}</td>
							<td>${video.f_size}</td>
							<td><fmt:formatDate value="${video.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${video.describle}</td>
							<td>
								<c:choose>
									<c:when test="${video.f_status eq 0}">不可用</c:when>
									<c:when test="${video.f_status eq 1}">可用</c:when>
								</c:choose>  
							</td>
							<td>
								<a class="btn btn-success" title="编辑" onclick="ListPage.form('${ctx}/admin/file/toVideo','#videoEditForm','${ctx}/admin/file/updateFile','${video.id}')">
									<i class="fa fa-edit"></i> 
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
