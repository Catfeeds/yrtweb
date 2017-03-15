<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="select_iv()" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 确认选择</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<input type="hidden" id="select_type" name="stype" value="${stype}">
						<input type="hidden" name="tid" value="${params.tid}">
						<input type="hidden" name="lid" value="${params.lid}">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>昵称: <input type="text" name="usernick" value="${params.usernick}"></label>
							<label>姓名: <input type="text" name="username" value="${params.username}"></label>
							<label>电话: <input type="text" name="phone" value="${params.phone}"></label>
							<label>俱乐部: <input type="text" name="tname" value="${params.tname}"></label>
							&nbsp;&nbsp;&nbsp;&nbsp;
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
				<table id="iv_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
						  	  <th>选择</th>
							  <th>姓名</th>
							  <th>昵称</th>
							  <th>手机号</th>
							  <th>场上位置</th>
							  <th>年龄</th>
							  <th>身高</th>                                          
							  <th>体重</th>                                          
							  <th>能力</th>                                          
							  <th>当前身价</th>                                          
							  <th>俱乐部</th>  
							  <th>进球数</th> 
							  <th>创建时间</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="data">
						<tr onclick="selectThis(this)">
							<td>
							<c:choose>
								<c:when test="${empty params.stype || params.stype=='1'}">
								<input style="width: 20px;" value="${data.user_id}" name="pid" type="radio" class="">
								</c:when>
								<c:otherwise>
									<input style="width: 20px;" value="${data.user_id}" name="pid" type="checkbox" class="">
								</c:otherwise>
							</c:choose>
							</td>
							<td data-value="username">${data.username}</td>
							<td data-value="usernick">${data.usernick}</td>
							<td>${data.phone}</td>
							<td>${data.position}</td>
							<td>${data.age}</td>
							<td>${data.height}</td>
							<td>${data.weight}</td>
							<td>${data.score}</td>
							<td>${data.current_price}</td>
							<td style="color: green;">${data.name}</td>
							<td data-value="jinqiu_num">${empty data.jinqiu_num?0:data.jinqiu_num}</td>
							<td>
								<fmt:formatDate value="${data.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
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
<style>
.showvdo {
    position: relative;
}

#playSWF {
    position: absolute;
    width: 20px;
    height: 20px;
    right: 0px;
    top: -18px;
    cursor: pointer;
}
</style>
<div id="showVideo" ><img id="playSWF" src="${ctx}/resources/images/close.png"/><div id="a1" class="showvdo"></div></div>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">
function selectThis(dom){
	var id = $(dom).find("[name=pid]").attr("checked", true);
}
</script>