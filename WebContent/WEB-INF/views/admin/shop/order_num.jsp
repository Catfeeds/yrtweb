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
						<input type="hidden" id="data_sn" name="data_sn" value="${params.data_sn}">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>夺宝号码: <input type="text" name="order_num" value="${params.order_num}"></label>
							<label>订单号码: <input type="text" name="order_sn" value="${params.order_sn}"></label>
							<label>是否使用: 
								<select id="s_if_use" name="if_use" onchange="ListPage.search()">
									<option value="">全部</option>
									<option value="1">使用</option>
									<option value="2">未使用</option>
								</select>
								<script type="text/javascript">$("#s_if_use").val('${params.if_use}');</script>
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
							  <th>夺宝号码</th>
							  <th>排序</th>
							  <th>订单号码</th>
							  <th>是否使用</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="p">
						<tr>
							<td>${p.data_sn}</td>
							<td>${p.order_num}</td>
							<td>${p.order_num_mark}</td>
							<td>${p.order_sn}</td>
							<td>${p.if_use=='1'?'是':'否'}</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
