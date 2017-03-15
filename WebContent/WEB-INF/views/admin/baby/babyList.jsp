<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!-- 后台足球宝贝列表 -->
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">足球宝贝列表</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2>
				<i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>宝贝昵称: <input type="text" name="usernick" value="${params.usernick}"></label>
							<label>手机号: <input type="text" name="phone" value="${params.phone}"></label>
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
							  <th>序号</th>
							  <th>用户昵称</th>
							  <th>手机号</th>
							  <th>星座</th>
							  <th>身高</th>
							  <th>体重</th>                                          
							  <th>胸围</th>                                          
							  <th>臀围</th>                                          
							  <th>腰围</th>                                          
							  <th>评分</th>                                          
							  <th title="宝贝首页是否推荐">是否推荐</th>                                          
							  <th>当前排序</th>                                          
							  <th>创建时间</th>    
							  <th>是否屏蔽</th>                                       
							  <th>排序</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="data" varStatus="num">
						<tr>
							<td>${num.index+1}</td>
							<td>${data.usernick}</td>
							<td>${data.phone}</td>
							<td>${data.constellation}</td>
							<td>${data.height}</td>
							<td>${data.weight}</td>
							<td>${data.chest}</td>
							<td>${data.hip}</td>
							<td>${data.waist}</td>
							<td>${data.score}</td>
							<td>
								<c:if test="${data.is_index eq '1'}">推荐</c:if>
								<c:if test="${data.is_index eq '0'}">不推荐</c:if>
							</td>
							<td>
								${data.show_num}
							</td>
							<td>
								<fmt:formatDate value="${data.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td>
								<yt:dict2Name nodeKey="status" key="${data.if_del}"></yt:dict2Name>
							</td>
							<td>
								<c:if test="${data.is_index eq '1'}">
									<span style="cursor: pointer;" class="fa fa-eye" title="不推荐" onclick="updateIndexShow('${data.id}',0)"></span>
								</c:if>
								<c:if test="${data.is_index eq '0'}">
									<span style="cursor: pointer;color: blue;" class="fa fa-eye" title="推荐" onclick="updateIndexShow('${data.id}',1)"></span>
								</c:if>
								<span style="cursor: pointer;" onclick="modifyShowNum('${data.id}','${data.usernick}','${data.show_num}')">
									排序
								</span>
							</td>
							<td>
								<c:choose>
									<c:when test="${data.if_del eq 0}">
										<a class="btn btn-info" title="屏蔽" onclick="setDel('${data.id}',1)">
											<i class="fa fa-credit-card"> 屏蔽</i> 
										</a>	
									</c:when>
									<c:otherwise>
										<a class="btn btn-info" title="取消屏蔽" onclick="setDel('${data.id}',0)">
											<i class="fa fa-credit-card"> 取消</i> 
										</a>
									</c:otherwise>
								</c:choose>
								
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
<script>
	//更新是否在首页显示、排序
	function updateIndexShow(baby_id,is_index){
		$.ajax({
			type:"POST",
			url:base+"/admin/fbaby/updateBabyInfo?random="+Math.random(),
			data:{"baby_id":baby_id,"is_index":is_index},
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
					layer.msg(data.message.success[0],{icon:1});
					setTimeout(function(){
						ListPage.enter();
					},1000);
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
			}
			
		});
	}
	
	function modifyShowNum(baby_id,usernick,show_num){
		var html="<form id='showNumForm'><table class='table'><input type='hidden' name='baby_id' value='"+baby_id+"'/>";
			html+="<tr><td>用户昵称:</td><td>"+usernick+"</td></tr>";
			html+="<tr><td>当前排序:</td>";
			html+="<td><input type='text' class='form-control' name='show_num' value='"+show_num+"'/>";
			html+="</td></tr>";
			html+="<tr><td colspan='2'><input type='button' class='btn btn-primary' value='提交' onclick='updateShowNum()'/></td></tr>";
			html+="</table></form>";
		//页面层
		layer.open({
		    type: 1,
		    skin: 'layui-layer-rim', //加上边框
		    area: ['420px', '240px'], //宽高
		    content: html
		});
	}
	
	function updateShowNum(){
		$.ajax({
			type:"POST",
			url:base+"/admin/fbaby/updateBabyInfo?random="+Math.random(),
			data:$("#showNumForm").serialize(),
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
					layer.msg(data.message.success[0],{icon:1});
					setTimeout(function(){
						ListPage.enter();
						layer.closeAll(); //关闭信息框
					},1000);
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
			}
		});
	}
	
	/**是否屏蔽*/
	function setDel(id,if_del){
		if(id == ''){
			 layer.msg("id不能为空",{icon: 2});
			 return;
		 }
		 $.ajaxSec({
				type: 'POST',
				url: base+'/admin/fbaby/setIfDel',
				data: {id: id,if_del:if_del},
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