<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">论坛管理</a></li>
		<li><a href="">贴子管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<%-- <div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="ListPage.form('${ctx}/admin/news/formJsp','#newsEditForm','${ctx}/admin/news/saveOrUpdate')" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 添加新闻</span>
				</h2>
			</div> --%>
			<div class="box-content">
				<div class="row">
					 <div class="col-lg-12">
						<form id="searchForm">
							<div class="dataTables_filter" id="DataTables_Table_0_filter">
								<label>标题:  
									<input type="text" aria-controls="DataTables_Table_0" name="title" value="${params.title}">
								</label>
								<label>主题作者:  
									<input type="text" aria-controls="DataTables_Table_0" name="usernick" value="${params.usernick}">
								</label>
								<label>是否屏蔽:  
									<select id="show" name="show">
										<option value="">全部</option>	
										<option value="1">是</option>
										<option value="2">否</option>
										<script type="text/javascript">$("#show").val('${params.show}');</script>
									</select>
								</label>
								<label>是否删除:  
									<select id="if_del" name="if_del">
										<option value="1">是</option>
										<option value="2">否</option>
										<script type="text/javascript">$("#if_del").val('${params.if_del}');</script>
									</select>
								</label>
								<label>当前状态: 
									<select id="status" name="status">
										<option value="">全部</option>	
										<option value="UNLOCK">开放</option>
										<option value="LOCK">锁定</option>
										<option value="PICK">精华</option>
										<option value="UNPICK">非精华</option>
									</select>
									<script type="text/javascript">$("#status").val('${params.status}');</script>
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
				<!-- <hr style="margin:2px;height:1px"> -->
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th style="width: 6%;text-align: center;">楼层数</th>
							  <th style="width: 20%;text-align: center;">标题</th>
							  <th style="text-align: center;width: 18%;">发帖用户昵称</th>
							  <th style="text-align: center;width: 18%;">发帖时间</th>
							  <th style="text-align: center;width: 23%;">操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  <c:forEach items="${page.items}" var="note" varStatus="index">
					      <tr>
						  	  <td style="text-align: center;line-height: 38px;">${note.sumFloor+1}</td>
						  	  <td style="text-align: center;line-height: 38px;">
						  	  	${note.title}
						  	  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		     ${note.usernick}
					  		  </td>
					  		  <td style="text-align: center;line-height: 38px;">
					  		      <fmt:formatDate value="${note.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
					  		  </td>
					  		  <td style="text-align: center;">
					  		  <c:if test="${note.if_top == 1 }">
					  		      <input type="button" name="notice" class="btn btn-info" style="margin-top: 4px;" value="取消置顶" onclick="setNoteTop('${note.id}','if_top',2,'${note.plate_id }')"/>
					  		  </c:if>
					  		  <c:if test="${note.if_top == 2 }">
					  		      <input type="button" name="notice" class="btn btn-info" style="margin-top: 4px;" value="置顶" onclick="setNoteTop('${note.id}','if_top',1,'${note.plate_id }')"/>
					  		  </c:if>
					  		  <c:if test="${note.if_pick == 1 }">
					  		      <input type="button" name="notice" class="btn btn-success" style="margin-top: 4px;" value="取消精华" onclick="setNoteTop('${note.id}','if_pick',2,'${note.plate_id }')"/>
					  		  </c:if>
					  		  <c:if test="${note.if_pick == 2 }">
					  		      <input type="button" name="notice" class="btn btn-success" style="margin-top: 4px;" value="精华" onclick="setNoteTop('${note.id}','if_pick',1,'${note.plate_id }')"/>
					  		  </c:if>
					  		  <c:if test="${note.if_lock == 1 }">
					  		      <input type="button" name="notice" class="btn btn-warning" style="margin-top: 4px;" value="解除锁定" onclick="setNoteTop('${note.id}','if_lock',2,'${note.plate_id }')"/>
					  		  </c:if>
					  		  <c:if test="${note.if_lock == 2 }">
					  		      <input type="button" name="notice" class="btn btn-warning" style="margin-top: 4px;" value="锁定" onclick="setNoteTop('${note.id}','if_lock',1,'${note.plate_id }')"/>
					  		  </c:if>
					  		  <c:if test="${note.if_show == 1 }">
					  		      <input type="button" name="notice" class="btn btn-warning" style="margin-top: 4px;" value="屏蔽" onclick="setNoteTop('${note.id}','if_show',2,'${note.plate_id }')"/>
					  		  </c:if>
					  		  <c:if test="${note.if_show == 2 }">
					  		      <input type="button" name="notice" class="btn btn-warning" style="margin-top: 4px;" value="取消屏蔽" onclick="setNoteTop('${note.id}','if_show',1,'${note.plate_id }')"/>
					  		  </c:if> 
					  		  <c:if test="${note.if_del == 2 }">
					  		      <input type="button" name="notice" class="btn btn-large btn-danger" style="margin-top: 4px;" value="删除" onclick="setNoteTop('${note.id}','if_del',1,'${note.plate_id }')"/>
					  		  </c:if> 
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
/**设置帖子置顶*/
function setNoteTop(id,type,status,plate_id){
	if(id == ''){
		 layer.msg("id不能为空",{icon: 2});
		 return;
	 }
	 $.ajaxSec({
			type: 'POST',
			url: base+'/admin/bbs/setNoteIfStatus',
			data: {id: id,type:type,status:status,plate_id:plate_id},
			success: function(data){
				if (data.state=='success') {
					layer.msg("设置成功",{icon: 1});
					ListPage.paginate(ListPage.currentPage);
				}else{
					layer.msg(data.message.error[0],{icon: 2});
					ListPage.paginate(ListPage.currentPage);
				}
		    },
		   error: $.ajaxError
	  });
	
}
</script>
