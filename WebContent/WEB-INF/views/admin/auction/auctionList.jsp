<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">赛季管理</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
		<li><a href="">市场球员</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a style="cursor: pointer;" title="返回" onclick="ListPage.enter({context:'#content',url:'/admin/league/leagueCfgOpt?id=${leagueCfg.id}',searchForm:'#searchForm'});" ><span>返回</span></a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<%-- <label>球员昵称: <input type="text" name="usernick" value="${params.usernick}"></label> --%>
							<label>球员姓名: <input type="text" name="username" value="${params.username}"></label>
							<label>竞拍轮次:${turn_count}
										<select name="turn_num">
											<option value="">请选择</option>	
											<c:forEach begin="0" end="${turn_count}" varStatus="i">	
										 		<option value="${i.index}" <c:if test="${params.turn_num eq i.index}">selected="selected"</c:if>>${i.index}</option>
										 	</c:forEach>	
										 </select> 
							</label>
							<label>是否上架: <yt:dictSelect name="if_up" nodeKey="status" value="${params.if_up}"></yt:dictSelect></label>
							<a onclick="ListPage.search()" class="btn btn-info">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn btn-info">
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
							  <th>球员</th>
							  <th>初始竞拍价</th>
							  <th>得拍价</th>
							  <th>得拍者</th>
							  <th>到期时间</th>
							  <th>竞拍轮次</th>
							  <th>是否选中</th>
							  <th>是否流拍</th>
							  <th>是否上架</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="auction">
						<tr>
							<td style="line-height: 30px;">
								${auction.user_name}
								<c:if test="${not empty auction.level && auction.level ne 0}">
									<span class="label label-warning">妖</span>
								</c:if>
							</td>
							<td style="line-height: 30px;">${auction.init_price}</td>
							<td style="line-height: 30px;">${auction.bid_price}</td>
							<td style="line-height: 30px;"><yt:id2NameDB beanId="teamInfoService" id="${auction.bidder}"></yt:id2NameDB></td>
							<td style="line-height: 30px;"><fmt:formatDate value="${auction.end_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td style="line-height: 30px;">${auction.turn_num}</td>
							<td style="line-height: 30px;">
								<yt:dict2Name nodeKey="status" key="${auction.status}"></yt:dict2Name>
							</td>
							<td style="line-height: 30px;">
								<yt:dict2Name nodeKey="status" key="${auction.if_sold}"></yt:dict2Name>
							</td>
							<td style="line-height: 30px;">
								<yt:dict2Name nodeKey="status" key="${auction.if_up}"></yt:dict2Name>
							</td>
							<td style="line-height: 30px;">
								<a class="btn btn-info" title="编辑" onclick="ListPage.form('${ctx}/admin/auction/auctionForm?id=${auction.id}','#auctionForm','${ctx}/admin/auction/saveAuction','${auction.id}')">
									<i class="fa fa-credit-card"> 编辑</i> 
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
