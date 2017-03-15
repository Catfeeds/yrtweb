<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>用户管理</a></li>
		<li><a>推荐球员</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="userForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${re.id}"/>
			<input type="hidden" name="user_id" value="${re.user_id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">用户名称</span>
					<input class="form-control disabled" id="username" type="text" 
						placeholder="<yt:id2NameDB beanId='userService' id='${re.user_id}'></yt:id2NameDB>"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">提交时间</span>
					<input class="form-control disabled" type="text" placeholder="<fmt:formatDate value='${re.create_time}' pattern='yyyy-MM-dd HH:mm:ss' />">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否显示</span>
					<yt:dict2Name nodeKey="status" key="${re.if_up}" clazz="form-control"></yt:dict2Name> 	
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">排序</span>
						<div class="controls">
						  	<input class="form-control" id="re_sort" type="text" placeholder="${re.re_sort}">
						</div>
				</div>
			</div>
			<div class="form-actions">
				<c:if test="${empty ifShow}">
					<a class="btn btn-primary" onclick="ListPage.submit()">提交</a>
				</c:if>
				<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
