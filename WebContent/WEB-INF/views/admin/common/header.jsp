<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="navbar">
	<div class="container">
		<button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".sidebar-nav.nav-collapse">
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="${ctx}/admin"> <img alt="Perfectum Dashboard" src="${ctx}/resources/admin/img/logo20.png"> <span>宇任拓后台管理系统</span></a>
						
		<!-- start: Header Menu -->
		<div class="header-nav">
			<ul class="nav navbar-nav pull-right">
				<!-- start: Message Dropdown -->
				<li class="dropdown hidden-xs">
					<a class="btn dropdown-toggle" data-toggle="dropdown" onclick="location.href=base+'/'" target="_blank">
						<i class="fa fa-home"></i> <span class="label hidden-xs">首页</span>
					</a>
				</li>
				<!-- end: Message Dropdown -->
				<!-- start: User Dropdown -->
				<li class="dropdown hidden-xs">
					<a class="btn dropdown-toggle" data-toggle="dropdown" href="index.html#">
						<i class="fa fa-user"></i>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<!-- <li><a href="index.html#"><i class="fa fa-user"></i> Profile</a></li> -->
						<li><a href="login.html"><i class="fa fa-sign-out"></i> 登出</a></li>
					</ul>
				</li>
				<!-- end: User Dropdown -->
			</ul>
		</div>
		<!-- end: Header Menu -->
		
	</div>
</div>