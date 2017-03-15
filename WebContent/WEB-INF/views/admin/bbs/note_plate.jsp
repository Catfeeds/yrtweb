<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<c:forEach items="${pMap}" var="p">
	<div class="row">
		<div class="col-sm-12">
			<div class="box">
				<div class="box-header">
					<h2>
						<i class="fa fa-th"></i>
						<span class="break"></span><yt:dict2Name nodeKey="p_plate_type" key="${p.key}"></yt:dict2Name>
					</h2>
					<div class="box-icon">
						  <input type="button" name="add_btn" class="btn btn-info" value="添加" style="margin: -7px;"
						   onclick="ListPage.form('${ctx}/admin/bbs/plateForm?type=${p.key}','#plateForm','${ctx}/admin/bbs/saveOrUpdatePlate')"/>
					</div>
				</div>
				<div class="box-content">
					<c:choose>
						<c:when test="${!empty p.value}">
							<table class="table table-bordered form-group table-striped">
								<tr>
									<th>板块名称</th>
									<th>图标</th>
									<th>附件上限(M)</th>
									<th>是否展示</th>
									<th>操作</th>
								</tr>	
								<c:forEach items="${p.value}" var="pl">
									<tr>
										<td>${pl.name}</td>
										<td><img src="${filePath}/${pl.image_url}"/></td>
										<td>${pl.rar_max}</td>
										<td><yt:dict2Name nodeKey="status" key="${pl.if_show}"></yt:dict2Name></td>
										<td>
											<input type="button" name="add_btn" class="btn btn-info" value="编辑"
						   						onclick="ListPage.form('${ctx}/admin/bbs/plateForm?type=${p.key}','#plateForm','${ctx}/admin/bbs/saveOrUpdatePlate','${pl.id}')"/>
											<input type="button" name="del_btn" class="btn btn-danger" value="删除"
						   						onclick="ListPage.remove('${ctx}/admin/bbs/delPlate','${pl.id}')"/>
											<input type="button" name="info_btn" class="btn btn-success" value="版主信息" 
												onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/bbs/leaderList?id=${pl.id}&plate_id=${pl.id}',searchForm:'#searchForm'});"/>
											<input type="button" name="note_btn" class="btn btn-small btn-primary" value="贴子列表" 
												onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/bbs/noteList?plate_id=${pl.id}',searchForm:'#searchForm'});"/>
										</td>
									</tr>	
								</c:forEach>
								<div class="clearfix"></div>
							</table>
						</c:when>
						<c:otherwise>
							暂无板块
						</c:otherwise>
					</c:choose>	
				</div>
			</div>
		</div><!--/col-->
	</div><!--/row-->
</c:forEach>
