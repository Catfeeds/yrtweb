<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>赛季管理</a></li>
		<li><a>赛季管理信息</a></li>
		<li><a>${leagueCfg.year}|<yt:areaName code="${leagueCfg.area_code}"/>|<yt:dict2Name nodeKey="season" key="${leagueCfg.season}"/></a></li>
	</ul>
	<hr>
</div>
	<!-- 市场管理 -->
	<div class="box">
		<div class="box-header">
			<h2>
			<i class="fa fa-tasks"></i>
			<span class="break"></span>
				市场管理
			</h2>
		</div>
		<div class="box-content">	
			<div class="row">
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/auction/listCfg?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-gear"></i>
						<p>竞拍市场配置</p>
						<!-- <span class="notification">7</span> -->
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/auction/listAuction?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-gavel"></i>
						<p>竞拍市场球员</p>
					</a>
				</div>	
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/market/listCfg?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-gear"></i>
						<p>交易市场配置</p>
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/market/listMarket?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-group"></i>
						<p>交易市场球员</p>
						<!-- <span class="notification">7</span> -->
					</a>
				</div>
			</div><!--/row-->
		</div>	
	</div>
	
	<!-- 报名管理 -->
	<div class="box">
		<div class="box-header">
			<h2>
			<i class="fa fa-tasks"></i>
			<span class="break"></span>
				报名管理
			</h2>
		</div>
		<div class="box-content">	
			<div class="row">
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/league/listSign?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-male"></i>
						<p>报名列表</p>
						<!-- <span class="notification">7</span> -->
					</a>
				</div>
				<%-- <div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/sign/showSign?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-laptop"></i>
						<p>后台报名录入</p>
					</a>
				</div>	 --%>
			</div><!--/row-->
		</div>	
	</div>
	<div class="box">
		<div class="box-header">
			<h2>
			<i class="fa fa-tasks"></i>
			<span class="break"></span>
				数据统计
			</h2>
		</div>
		<div class="box-content">	
			<div class="row">
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/auction/toStatistics?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-table"></i>
						<p>竞拍统计</p>
						<!-- <span class="notification">7</span> -->
					</a>
				</div>
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/market/toStatistics?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-table"></i>
						<p>转会统计</p>
					</a>
				</div>	
				<div class="col-sm-2 col-md-1">
					<a class="quick-button span1" onclick="ListPage.enter({context:'#content',url:'/admin/teamloan/toStatistics?cfg_id=${leagueCfg.id}',searchForm:'#searchForm'});" style="cursor: pointer;">
						<i class="fa fa-table"></i>
						<p>租借统计</p>
					</a>
				</div>	
			</div><!--/row-->
		</div>	
	</div>
	<div>
		<a class="btn btn-success" onclick="ListPage.enter({context:'#content',url:'/admin/league/cfgList',searchForm:'#searchForm'});" style="cursor: pointer;">
			<i class="fa">返回</i>                                     
		</a>
	</div>
