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
						<input type="hidden" id="select_type" name="stype" value="${params.stype}">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>昵称: <input type="text" name="usernick" value="${params.usernick}"></label>
							<label>电话: <input type="text" name="phone" value="${params.phone}"></label>
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
							  <th>昵称</th>
							  <th>手机号</th>
							  <th>星座</th>
							  <th>身高</th>
							  <th>体重</th>                                          
							  <th>胸围</th>                                          
							  <th>臀围</th>                                          
							  <th>腰围</th>                                          
							  <th>评分</th>    
							  <th>图片</th>    
							  <th>创建时间</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="data">
						<tr>
							<td>
							<c:choose>
								<c:when test="${empty params.stype || params.stype=='1'}">
								<input style="width: 20px;" value="${data.id}" name="bid" type="radio" class="">
								</c:when>
								<c:otherwise>
									<input style="width: 20px;" value="${data.id}" name="bid" type="checkbox" class="">
								</c:otherwise>
							</c:choose>
							</td>
							<td>${data.usernick}</td>
							<td>${data.phone}</td>
							<td>${data.constellation}</td>
							<td>${data.height}</td>
							<td>${data.weight}</td>
							<td>${data.chest}</td>
							<td>${data.hip}</td>
							<td>${data.waist}</td>
							<td>${data.score}</td>
							<td><img src="${filePath}/${data.f_src}" style="width: 60px;height: 60px;cursor: pointer;" onclick="showImage(this)"/></td>
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

</script>