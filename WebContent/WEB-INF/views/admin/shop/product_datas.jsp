<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<input type="hidden" id="product_id" name="product_id" value="${params.product_id}">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>中奖用户: <input type="text" name="name" value="${params.name}"></label>
							<label>用户帐号: <input type="text" name="username" value="${params.username}"></label>
							<label>轮次排序: 
								<select id="s_n_group_by" name="group_by" onchange="ListPage.search()">
									<option value="desc">倒序</option>
									<option value="asc">正序</option>
								</select>
								<script type="text/javascript">$("#s_n_group_by").val('${params.group_by}');</script>
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
				<table id="product_list_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>商品期号</th>
							  <th>产品标题</th>
							  <th>当前轮次</th>
							  <th>夺宝单价</th>
							  <th>夺宝总价</th>
							  <th>夺宝总需人次</th>
							  <th>当前夺宝人次</th>
							  <th>商品状态</th>
							  <th>开始时间</th>
							  <th>结束时间</th>
							  <th>中奖号码</th>
							  <th>中奖用户</th>
							  <th>用户帐号</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="p">
						<tr>
							<td>${p.data_sn}</td>
							<td><a title="${p.product_title}">${fn:substring(p.product_title, 0, 5)}...</a></td>
							<td>${p.data_turn}</td>
							<td>${p.data_single_price}</td>
							<td>${p.data_total_price}</td>
							<td>${p.data_total_count}</td>
							<td>${p.data_count}</td>
							<td>
								<c:if test="${p.data_status=='1'}">
								<span style="color: red;">等待</span>
								</c:if>
								<c:if test="${p.data_status=='2'}">
								<span style="color: green;">进行中</span>
								</c:if>
								<c:if test="${p.data_status=='3'}">
								<span style="color: orange;">待揭晓</span>
								</c:if>
								<c:if test="${p.data_status=='4'}">
								<span style="color: black;">已结束</span>
								</c:if>
							</td>
							<td>${p.data_start_time}</td>
							<td>${p.data_finish_time}</td>
							<td>${p.data_win_num}</td>
							<td>${empty p.username?p.usernick:p.username}</td>
							<td>${empty p.phone?p.email:p.phone}</td>
							<td>
								<c:if test="${empty p.data_start_time}">
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/shop/product/deleteProductData','${p.data_id}')">
									<i class="fa fa-trash-o "></i> 
								</a>
								</c:if>
								<c:if test="${!empty p.data_start_time}">
								<a class="btn btn-info" title="开奖号码" onclick="ListPage.dialog('开奖号码','${ctx}/admin/shop/product/queryOrderNums',{data_sn:'${p.data_sn}'},1000,600)">
									<i class="fa fa-list"></i> 
								</a>
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
