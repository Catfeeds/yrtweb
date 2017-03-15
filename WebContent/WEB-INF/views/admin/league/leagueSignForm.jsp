<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>赛季管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li><a>报名审核</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="signForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${signForm.id}"/>
			<input type="hidden" name="s_id" value="${leagueCfg.id}"/>
			<fieldset class="col-sm-12">	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">头像</span>
					<img class="img-thumbnail" alt="照片" src="${el:headPath()}${signForm.image_src}" style="height: 300px;width: 500px;"/>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员昵称</span>
					<span class="form-control">${signForm.usernick}</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球员名称</span>
					<span class="form-control">${signForm.username}</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">身份证</span>
					<span class="form-control">${signForm.idCard}</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">性别</span>
					<span class="form-control"><yt:dict2Name nodeKey="sex" key="${signForm.sex}"></yt:dict2Name></span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">生日</span>
					<span class="form-control"><fmt:formatDate value="${signForm.birth_date}" pattern="yyyy-MM-dd hh:MM:ss" /></span>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联系电话</span>
					<span class="form-control">${signForm.mobile}</span>				
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">身高</span>
					<span class="form-control">${signForm.height}CM</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">体重</span>
					<span class="form-control">${signForm.weight}KG</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">擅长位置</span>
					<span class="form-control">
					<c:forEach items="${fn:split(signForm.position,',')}" var="pos" end="0">
						<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
				  	</c:forEach>	
				  	</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">惯用脚</span>
					<span class="form-control">
						<yt:dict2Name nodeKey="cfoot" key="${signForm.cfoot}"></yt:dict2Name>
					</span>	
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">球衣号码</span>
					<span class="form-control">${signForm.love_num}</span>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">报名时间</span>
					<span class="form-control"><fmt:formatDate value="${signForm.create_time}" pattern="yyyy-MM-dd" /></span>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">审核状态</span>
						<yt:dictSelect name="status" nodeKey="ls_status" value="${signForm.status}" clazz="form-control"></yt:dictSelect>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">原因</span>
						<input type="text" name="reason" value="" class="form-control">
				</div>
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
