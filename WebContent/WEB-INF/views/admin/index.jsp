<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>宇任拓管理系统</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="${ctx}/resources/admin/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/font-awesome.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/jquery-ui-1.10.3.custom.min.css" rel="stylesheet">
	<link href="${ctx}/resources/admin/css/fullcalendar.css" rel="stylesheet">	
	<link href="${ctx}/resources/admin/css/jquery.gritter.css" rel="stylesheet">	
	<link href="${ctx}/resources/admin/css/style.min.css" rel="stylesheet">
	<link href="${ctx}/resources/layer/skin/layer.css" rel="stylesheet">
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="http://localhost:8888/bootstrap/perfectum2/img/favicon.ico">
	<!-- end: Favicon -->
	
	<script src="${ctx}/resources/admin/js/jquery-2.0.3.min.js"></script>
	<script type="text/javascript">
		window.jQuery || document.write("<script src='${ctx}/resources/admin/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
	</script>
	<script src="${ctx}/resources/admin/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${ctx}/resources/admin/js/bootstrap.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.knob.modified.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.pie.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.stack.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.resize.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.flot.time.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.sparkline.min.js"></script>
	<script src="${ctx}/resources/admin/js/fullcalendar.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery.gritter.min.js"></script>
	
	<script src="${ctx}/resources/admin/js/default.min.js"></script>
	<script src="${ctx}/resources/admin/js/core.min.js"></script>
	<script src="${ctx}/resources/layer/layer.js"></script>
	<script src="${ctx}/resources/js/base.js"></script>
	<script src="${ctx}/resources/js/yt.ext.js"></script>
	<script src="${ctx}/resources/js/yt.core.js"></script>
	<script src="${ctx}/resources/js/validation.js"></script>
	
	<script src="${ctx}/resources/ueditor/ueditor.config.js" type="text/javascript"></script>
	<script src="${ctx}/resources/ueditor/ueditor.all.js" type="text/javascript"></script>
	
	<script src="${ctx}/resources/admin/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="${ctx}/resources/admin/js/jquery-ui-timepicker-addon.js"></script>
    <script src="${ctx}/resources/admin/js/jquery-ui-timepicker-zh-CN.js"></script>
    <script src="${ctx}/resources/vmodel/Filter.js"></script>
	
</head>
<body>
	<!-- start: Header -->
	<%@include file="common/header.jsp" %>
	<!-- start: Header -->
		<div class="container">
		<div class="row">
					<!-- start: Main Menu -->
			<div class="col-sm-2 main-menu-span">
				<div class="sidebar-nav nav-collapse collapse navbar-collapse">
					<ul class="nav nav-tabs nav-stacked main-menu">
						<sec:authorize ifAnyGranted="${resources['/admin/menu/league']}">
						<li>
							<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 联赛管理</span></a>
							<ul>
								<sec:authorize ifAnyGranted="${resources['/admin/menu/leagueInfo']}">
								<li>
									<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 联赛信息管理</span></a>
									<ul class="nav nav-tabs nav-stacked main-menu">
										<sec:authorize ifAnyGranted="${resources['/admin/league/cfgList']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/league/cfgList',searchForm:'#cfgForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 赛季分类管理</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/league/listLeague']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/league/listLeague',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 联赛列表</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/menu/interface']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/interface/leagueCount',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 联赛接口</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/area/sysAreaList']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/area/sysAreaList',searchForm:'#sysAreaForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 联赛区域管理</span></a></li>
										</sec:authorize>
									</ul>	
								</li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/menu/sign']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/sign/signCfgList',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 报名功能</span></a></li>
								</sec:authorize>	
							</ul>
						</li>
						</sec:authorize>
						<%-- <sec:authorize ifAnyGranted="${resources['/admin/menu/sign']}">
						<li>
							<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 报名管理</span></a>
							<ul>
								<sec:authorize ifAnyGranted="${resources['/admin/sign/signCfgList']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/sign/signCfgList',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 报名设置</span></a></li>
								</sec:authorize>
							</ul>
						</li>
						</sec:authorize> --%>
						<sec:authorize ifAnyGranted="${resources['/admin/menu/user']}">
						<li>
							<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 用户管理</span></a>
							<ul>
								<sec:authorize ifAnyGranted="${resources['/admin/user']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/user',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 用户列表</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/menu/acount']}">
								<li>
									<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 账户管理</span></a>
									<ul class="nav nav-tabs nav-stacked main-menu">
										<sec:authorize ifAnyGranted="${resources['/admin/account/userAcountDatas']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/account/userAcountDatas',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 用户资金</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/account/payRecord']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/account/payRecord',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 充值记录</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/account/costRecord']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/account/costRecord',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 消费记录</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/account/recordDetail']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/account/recordDetail',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 资金统计</span></a></li>
										</sec:authorize>
									</ul>	
								</li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/menu/player']}">
								<li>
									<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 球员管理</span></a>
									<ul class="nav nav-tabs nav-stacked main-menu">
										<sec:authorize ifAnyGranted="${resources['/admin/audit/recommendList']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/audit/recommendList',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 推荐球员</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/player']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/player',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 妖人列表</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/audit/auditPlayerList']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/audit/auditPlayerList',searchForm:'#certificaForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 职业球员认证</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/audit/auditUserList']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/audit/auditUserList',searchForm:'#certificaForm'},{status:2});"><i class="fa fa-file"></i><span class="hidden-sm"> 身份证认证</span></a></li>
										</sec:authorize>
									</ul>
								</li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/menu/baby']}">
								<li>
									<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 足球宝贝管理</span></a>
									<ul class="nav nav-tabs nav-stacked main-menu">
										<sec:authorize ifAnyGranted="${resources['/admin/fbaby/listdata']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/fbaby/listdata',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 宝贝列表</span></a></li>
										</sec:authorize>
									</ul>
								</li>
								</sec:authorize>
							</ul>
						</li>
						</sec:authorize>
						<sec:authorize ifAnyGranted="${resources['/admin/menu/team']}">
						<li>
							<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 俱乐部管理</span></a>
							<ul>
								<sec:authorize ifAnyGranted="${resources['/admin/teamInfo']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/teamInfo',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 俱乐部列表</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/teamInfo/recommendation']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/teamInfo/recommendation',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 推荐俱乐部</span></a></li>
								</sec:authorize>
							</ul>
						</li>
						</sec:authorize>
						<sec:authorize ifAnyGranted="${resources['/admin/menu/sys']}">
						<li>
							<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 系统管理</span></a>
							<ul>
								<sec:authorize ifAnyGranted="${resources['/admin/news']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/news',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 新闻管理</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/indexImg']}">
								<li>
								<a class="dropmenu" style="cursor: pointer;"><i class="fa fa-folder"></i><span class="hidden-sm"> 首页管理</span></a>
								<ul class="nav nav-tabs nav-stacked main-menu">
									<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/indexBanner',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 轮播管理</span></a></li>
									<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/indexImgs',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 图片管理</span></a></li>
									<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/indexVdos',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 视频管理</span></a></li>
									<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/indexPlayers',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 球员管理</span></a></li>
									<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/indexBabys',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 宝贝管理</span></a></li>
								</ul>
								</li>
								</sec:authorize>
							<%-- 	<sec:authorize ifAnyGranted="${resources['/admin/dressres']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/dressres',searchForm:'#dressresForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 皮肤管理</span></a></li>
								</sec:authorize> --%>
								<sec:authorize ifAnyGranted="${resources['/admin/feedback']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/feedback',searchForm:'#feedbackForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 反馈管理</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/role']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/role',searchForm:'#roleForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 角色管理</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/resources']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/resources',searchForm:'#resourcesForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 资源管理</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/dict/dictList']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/dict/dictList',searchForm:'#dictForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 字典管理</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/schedule/jobList']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/schedule/jobList',searchForm:'#jobForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 任务管理</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/product']}">
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/product',searchForm:'#productForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 产品管理</span></a></li>
								</sec:authorize>
								<sec:authorize ifAnyGranted="${resources['/admin/menu/upload']}">
								<li>
									<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 上传文件管理</span></a>
									<ul class="nav nav-tabs nav-stacked main-menu">
										<sec:authorize ifAnyGranted="${resources['/admin/file/imageList']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/file/imageList',searchForm:'#imageForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 图片上传记录</span></a></li>
										</sec:authorize>
										<sec:authorize ifAnyGranted="${resources['/admin/file/videoList']}">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/file/videoList',searchForm:'#videoForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 视频上传记录</span></a></li>
										</sec:authorize>
									</ul>	
								</li>
								</sec:authorize>
							</ul>	
						</li>
						</sec:authorize>
						
						<sec:authorize ifAnyGranted="${resources['/admin/menu/bbs']}">
						<li>
							<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 论坛管理</span></a>
							<ul>
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/bbs/queryBbsTipsList',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 举报管理</span></a></li>
								<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/bbs/plateList',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 板块管理</span></a></li>
							</ul>	
						</li>
						</sec:authorize>
						<sec:authorize ifAnyGranted="${resources['/admin/menu/product']}">
						<li>
							<a class="dropmenu" href="index.html#"><i class="fa fa-folder"></i><span class="hidden-sm"> 夺宝管理</span></a>
							<ul>
								<li>
									<a class="dropmenu" style="cursor: pointer;"><i class="fa fa-folder"></i><span class="hidden-sm"> 产品管理</span></a>
									<ul class="nav nav-tabs nav-stacked main-menu">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/shop/categorys',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 分类列表</span></a></li>
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/shop/products',searchForm:'#searchForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 产品列表</span></a></li>
									</ul>
								</li>
								<li>
									<a class="dropmenu" style="cursor: pointer;"><i class="fa fa-folder"></i><span class="hidden-sm"> 夺宝订单</span></a>
									<ul class="nav nav-tabs nav-stacked main-menu">
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/shop/orders',searchForm:'#orderForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 所有订单</span></a></li>
										<li><a class="submenu" style="cursor: pointer;" onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/shop/winorders',searchForm:'#orderForm'});"><i class="fa fa-file"></i><span class="hidden-sm"> 中奖订单</span></a></li>
									</ul>
								</li>
							</ul>	
						</li>
						</sec:authorize>
					</ul>
				</div><!--/.well -->
			</div><!--/col-->
			<!-- end: Main Menu -->
			<div id="content" class="col-sm-10">
			<!-- start: Content -->
			</div><!--/#content.span10-->
		</div><!--/fluid-row-->
		<div class="clearfix"></div>
		
		<!-- footer  start-->
		<%@include file="common/footer.jsp" %>
		<!-- footer  end-->
	</div>
</body>
</html>