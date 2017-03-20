<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<html >
		<head>
		<%@ include file="common/common_new.jsp" %>
			<meta charset="utf-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
			<title>宇任拓</title>
			<!--BOOTSTRAP CSS-->
			<link href="${ctx}/resources/new/css/bootstrap.css" rel="stylesheet">
			<!--SLICK SLIDER CSS-->
			<link rel="stylesheet" type="text/css" href="${ctx}/resources/new/slick/slick-theme.css"/>
			<link rel="stylesheet" type="text/css" href="${ctx}/resources/new/slick/slick.css"/>
			<!--BX SLIDER CSS-->
			<link rel="stylesheet" href="${ctx}/resources/new/css/jquery.bxslider.css">
			<!--OWL SLIDER CSS-->
			<link href="${ctx}/resources/new/css/owl.carousel.css" rel="stylesheet">
			<!--FLEX SLIDER CSS-->
			<link href="${ctx}/resources/new/css/flexslider.css" rel="stylesheet">
			<!--component CSS-->
			<link href="${ctx}/resources/new/css/component.css" rel="stylesheet">
			<!--PRETTY PHOTO CSS-->
			<link href="${ctx}/resources/new/css/prettyphoto.css" rel="stylesheet">
			<!--ICONS CSS-->
			<link href="${ctx}/resources/new/css/font-awesome.css" rel="stylesheet">
			<link href="${ctx}/resources/new/svg-icon.css" rel="stylesheet">
			<!--THEME TYPO CSS-->
			<link href="${ctx}/resources/new/css/themetypo.css" rel="stylesheet">
			<link href='${ctx}/resources/new/css/fullcalendar.css' rel='stylesheet' />
			<!--WIDGET CSS-->
			<link rel="stylesheet" href="${ctx}/resources/new/css/widget.css">
			<!--CUSTOM STYLE CSS-->
			<link rel="stylesheet" href="${ctx}/resources/new/style.css">
			<!--component CSS-->
			<link href="${ctx}/resources/new/css/component.css" rel="stylesheet">
			<!--COLOR CSS-->
			<link rel="stylesheet" href="${ctx}/resources/new/css/color.css">
			<!--RESPONCIVE CSS-->
			<link rel="stylesheet" href="${ctx}/resources/new/css/responsive.css">
			<style type="text/css">
			
			#nt-title li {
				font-size: 16px;
			}
			</style>
		</head>
		<body class="kode-football">
			<!--// Wrapper //-->
			<div class="kode-wrapper">
			  <!--// Header //-->
			  <header class="football-header">
				<div class="topbar4">
				  <div class="container">
					<div class="pull-right">
						<div class="login-wraper3">
							<ul class="login-meta">
							
							  <li><input type="text"  /></li>
							  <li style=" padding: 0px 5px;"><a ><i class="fa fa-search">&nbsp;&nbsp;</i></a></li>
								
							<c:choose>
        					<c:when test="${empty session_user_id}">
								  <li style=" padding: 0px 15px;">
								  <a  data-toggle="modal" data-target=".media01"><i class="fa fa-user"> 请登录 |&nbsp;&nbsp; </i></a>
								  		<div class="modal fade bs-example-modal-lg media01" tabindex="-1" role="login" aria-labelledby="login">
										  <div class="modal-dialog modal-lg" role="document">
											<div class="modal-content">
												<div class="kode_modal_body">
													<a href="#"><i class="fa fa-user"></i></a>
													<h2>登录</h2>
													<form id="loginForm" action="${ctx}/doLogin" method="post">
														<div class="kode_modal_field">
															<input type="text" name="username" placeholder="用户名" required>
														</div>
														<div class="kode_modal_field">
															<input type="password" name="password" placeholder="密码" required>
														</div>
														<div class="kode_model_btn">
															<button onclick="$.submitLogin('#loginForm','#loginForm',errorMsg);getCookie();">登录</button>
															<a href="${ctx}/find/way">忘记密码</a>
															<a >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
															<a href="javascript:window.location='${ctx}/register/registerAccount'">注册</a>
														</div>
													</form>
												</div>
											</div>
										  </div>
										</div>
								  <a href="javascript:window.location='${ctx}/register/registerAccount'"><i class="fa fa-user"> 免费注册 </i></a>
								  </li>
							  </c:when>
			        		<c:otherwise>
			        			<li style=" padding: 0px 15px;">
								  <a  href="javascript:window.location='${ctx}/center'"><i class="fa fa-user"> ${session_usernick} |&nbsp;&nbsp; </i></a>
								  <a href="javascript:window.location='${ctx}/loginOut'"><i class="fa fa-user"> [退出]</i></a>
								 </li>
			        		</c:otherwise>
			        	</c:choose>
							  
						</ul>
						  <div id="show-class"><form><input type="text" placeholder="your key word"></form></div>
						  <ul class="social-style3">
								<li><h7>财富</h7><li>
							  <li><a id="amountUser" style="color: #ADFF2F">${real_amount}</a></li>
							  <li><h7>宇币</h7><li>
							  <li><a href="${ctx}/raccount/recharge" style="color: #ADFF2F">充值</a></li>
						  </ul>
					  </div>
					</div>
				  </div>
				</div>
				<div class="logo-wrap2">
				  <div class="container">
					<div class="logo logo-3">
					  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/logo2.png" alt=""></a>
					</div>

				  </div>
				</div>

				<div class="nav4">
				  <div class="container" style="width: 100%">
					<ul class="kode_nave" style="margin-left: 15%">
						<li><a href="${ctx}/">首  页</a>

						</li>
						<li><a href="${ctx}/shop/index">宇币夺宝</a></li>
						<li><a href="${ctx}/league/index" >联   赛</a>
							<ul>
								<li><a href="javascript:window.location='${ctx}/league/selectArea'">赛事报名</a></li>
								 <li><a href="javascript:window.location='${ctx}/league/turnTeamChoose'">转会交易</a></li>
								  <li><a  href="javascript:window.location='${ctx}/league/toAuction'" >球员竞拍 </a></li>
							</ul>	  
						</li>
						<li><a href="${ctx}/team/list">俱乐部</a>

						</li>
						<li><a href="${ctx}/player/searchPlayer">球员库</a></li>
						<li><a href="${ctx}/center">个人中心</a>

						</li>
						<li><a href="${ctx}/about/contact_us">联系我们</a></li>
					</ul>
					<!--DL Menu Start-->
					<div id="kode-responsive-navigation" class="dl-menuwrapper">
					<button class="dl-trigger">Open Menu</button>
						<ul class="dl-menu">
							<li class="active"><a class="active" href="${ctx}/resources/new/#">Home</a>
								<ul class="dl-submenu">	
									<li><a href="${ctx}/resources/new/index.html">home</a></li>
									<li><a href="${ctx}/resources/new/tennis.html">tennis </a></li>
									<li><a href="${ctx}/resources/new/sport-news.html">sport news</a></li>
								</ul>
							</li>
							<li class="menu-item kode-parent-menu"><a href="${ctx}/resources/new/about-us.html">About Us</a></li>
							<li class="menu-item kode-parent-menu"><a href="${ctx}/resources/new/fixtures.html">fixtures</a>
								<ul class="dl-submenu">
									<li><a href="${ctx}/resources/new/result.html">result</a></li>
									<li><a href="${ctx}/resources/new/tickets.html">tickets</a></li>
									<li><a href="${ctx}/resources/new/ticket-single.html">ticket single</a></li>
								</ul>
							</li>
							<li class="menu-item kode-parent-menu"><a href="${ctx}/resources/new/#">Team & Player</a>
								<ul class="dl-submenu">
									<li><a href="${ctx}/resources/new/our-team.html">our team</a></li>
									<li><a href="${ctx}/resources/new/our-team-2.html">our team 2</a></li>
									<li><a href="${ctx}/resources/new/single-player.html">single player</a></li>
									<li><a href="${ctx}/resources/new/single-player-sidebar.html">single player sidebar</a></li>
								</ul>
							</li>
							<li class="menu-item kode-parent-menu"><a href="${ctx}/resources/new/shop.html">shop</a></li>
							<li class="menu-item kode-parent-menu"><a href="${ctx}/resources/new/#">blog</a>
								<ul class="dl-submenu">
									<li><a href="${ctx}/resources/new/blog.html">blog</a></li>
									<li><a href="${ctx}/resources/new/blog2.html">blog 02</a></li>
									<li><a href="${ctx}/resources/new/blog-detail.html">blog detail</a></li>
									<li><a href="${ctx}/resources/new/blog-sidebar.html">blog sidebar</a></li>
								</ul>
							</li>
							<li class="menu-item kode-parent-menu"><a href="${ctx}/resources/new/#">page</a>
								<ul class="dl-submenu">
									<li><a href="${ctx}/resources/new/404.html">404</a></li>
									<li><a href="${ctx}/resources/new/404-2.html">404 02</a></li>
									<li><a href="${ctx}/resources/new/404-3.html">404 03</a></li>
									<li><a href="${ctx}/resources/new/coming-soon.html">coming soon</a></li>
								</ul>
							</li>
							<li><a href="${ctx}/resources/new/contact-us.html">contact Us</a></li>
						</ul>
					</div>
					<!--DL Menu END-->
					<div class="ticket-wrap" style="width: 30%; margin-top: 10px; ">
					  		<div id="nt-title-container" >
			    				<ul id="nt-title" >
			    				<c:if test="${!empty win_users}">
								   <c:forEach items="${win_users}" var="user" begin="0">
					    				<li style="color: white; ">
					    					<span class="icon-cup" style="color: #FF1493">&nbsp;&nbsp;</span><span class="nt-title-span">${user.usernick}夺得${user.product_title}</span>
					    				</li>
				    				</c:forEach>
								  </c:if>
								  <c:if test="${!empty leagueList}">
								    <c:forEach items="${leagueList}" var="league">
								    <li style="color: white">
				    					<span class="icon-football" style="color: #ADFF2F">&nbsp;&nbsp;</span><span class="nt-title-span">战报--比赛赛况信息</span>
				    				</li>
		                            <a href="javascript:;" onclick="load_hot_news(this,'#news_list','','${league.id}')">${league.simple_name}|</a>
		                       		 </c:forEach> 
		                        </c:if>
				    				
				    				<li style="color: white">
				    					<span class="icon-soccer" style="color: #CDCD00">&nbsp;&nbsp;</span><span>转会--球员转会信息</span>
				    				</li>
				    				
			    				</ul>
			    			</div>
					  <div class="lung-link">
					  <!--  
						<a href="${ctx}/resources/new/#">en</a>
						<a href="${ctx}/resources/new/#">fr</a>
						-->
					  </div>
					</div>
				  </div>
				</div>
			  </header>
			  <!--// Header //-->
			  <!--// Main Banner //-->
			  <div id="mainbanner">
				<div class="flexslider">
				  <ul class="slides">
					<li>
					  <!--// THUMB SLIDER START //-->
					  <div class="thumb-slider">
						<img src="${ctx}/resources/new/extra-images/slide4.jpg" alt="" />
						<div class="container">
						  <div class="kode-ft-caption text-left"> 
							<div class="football-caption">      
							  <h7>成都、广州宇任拓联赛</h7><br>
							  <h4>联赛季</h4>
							  <h7>将于2017-4-20开赛</h7><br>
							  <h8>3月15日开始报名，网上报名更优惠哦！</h8>
							</div>
							<div class="clearfix"></div>        
							<p><a class="btn-4" href="${ctx}/resources/new/#">马上报名<i class="fa fa-angle-right"></i></a></p>
							<div class="clearfix"></div>
						  </div>
						</div>
					  </div>
					  <!--// THUMB SLIDER END //-->
					</li>
					<li>
					  <!--// THUMB SLIDER START //-->
					  <div class="thumb-slider">
						<img src="${ctx}/resources/new/extra-images/slide5.jpg" alt="" />
						<div class="container">
						  <div class="kode-ft-caption text-center"> 
							<div class="football-caption">      
							  <h7>成都、广州宇任拓联赛</h7><br>
							  <h4>联赛季</h4>
							  <h7>将于2017-4-20开赛</h7><br>
							  <h8>3月15日开始报名，网上报名更优惠哦！</h8>
							</div>
							<div class="clearfix"></div>        
							<p><a class="btn-4" href="${ctx}/resources/new/#">马上报名<i class="fa fa-angle-right"></i></a></p>
							<div class="clearfix"></div>
						  </div>
						</div>
					  </div>
					  <!--// THUMB SLIDER END //-->
					</li>
					<li>
					  <!--// THUMB SLIDER START //-->
					  <div class="thumb-slider">
						<img src="${ctx}/resources/new/extra-images/slide7.jpg" alt="" />
						<div class="container">
						  <div class="kode-ft-caption text-right"> 
							<div class="football-caption">      
							  <h7>成都、广州宇任拓联赛</h7><br>
							  <h4>联赛季</h4>
							  <h7>将于2017-4-20开赛</h7><br>
							  <h8>3月15日开始报名，网上报名更优惠哦！</h8>
							</div>
							<div class="clearfix"></div>        
							<p><a class="btn-4" href="${ctx}/resources/new/#">马上报名<i class="fa fa-angle-left"></i></a></p>
							<div class="clearfix"></div>
						  </div>
						</div>
					  </div>
					  <!--// THUMB SLIDER END //-->
					</li>
				  </ul>
				</div>
			  </div>
			  <!--// Main Banner //-->
			  <!--// Main Content //-->
			  <div class="kode-content">
				<div class="ft-match-slider">
				  <div class="owl-carousel-3 owl-theme" id="owl-demo6">
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="${ctx}/resources/new/#">Iceland</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="${ctx}/resources/new/#">Poland</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag6.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="${ctx}/resources/new/#">England</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag2.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="${ctx}/resources/new/#">Germany</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag3.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="${ctx}/resources/new/#">Turkey</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag4.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="${ctx}/resources/new/#">Africa</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag5.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="${ctx}/resources/new/#">Iceland</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="${ctx}/resources/new/#">Poland</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag6.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="${ctx}/resources/new/#">Iceland</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="${ctx}/resources/new/#">Poland</a></h5>
							  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/flag.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
				  </div>
				</div>


				<!--// FOOTBALL COUNTER Important statictics START//  加section会形成过多空白-->
				<div class="ftb-counterup ftb-resultbg">
				  <div class="container">
					<!--// HEADING 5 //-->
					<div class="heading5">
					  <h4>Important Statictics</h4>
					</div>
					<!--// HEADING 5 //-->
					<div class="row">
					  <!--// COUNTER //-->
					  <div class="col-md-3 col-sm-3" >
					  <a href="${ctx}/record/toRecord">
						<div class="counterup-dec">
						  <span class="icon-football" ></span>
						  <div class="text">
							<h3 class="word-count" >${leagueRecords}</h3>
							<p >场比赛</p>
						  </div>
						</div>
						</a>
					  </div>
					  <!--// COUNTER //-->
					  <!--// COUNTER //-->
					  <div class="col-md-3 col-sm-3">
					  	<a href="${ctx}/team/list">
						<div class="counterup-dec">
						  <span class="icon-soccer"></span>
						  <div class="text" >
							<h3 class="word-count">${teamRecords}</h3>
							<p>家俱乐部</p>
						  </div>
						</div>
						</a>
					  </div>
					  <!--// COUNTER //-->
					  <div class="col-md-3 col-sm-3">
					  	<a href="${ctx}/player/searchPlayer">
						<div class="counterup-dec">
						  <span class="icon-symbol"></span>
						  <div class="text">
							<h3 class="word-count">${playerRecords}</h3>
							<p>明星球员</p>
						  </div>
						</div>
						</a>
					  </div>
					  <!--// COUNTER //-->
					  <!--// COUNTER //-->
					  <div class="col-md-3 col-sm-3">
					  	<a href="${ctx}/shop/index">
						<div class="counterup-dec">
						  <span class="icon-cup"></span>
						  <div class="text">
							<h3 class="word-count">${productRecords}</h3>
							<p>商品&服务</p>
						  </div>
						</div>
						</a>
					  </div>
					  <!--// COUNTER //-->
					</div>
				  </div>
				</div>

				<!--// FOOTBALL COUNTER Important statictics END//-->


				<!--// 球员库 SECTION //-->
				<section>
				  <div class="container">
					<!--// HEADING 5 //-->
					<div class="heading5 black">
					  <h4>球员  <span>库</span></h4>
					</div>
					<!--// HEADING 5 //-->
					<style>
						.playercart1{
							height: 350px;
							border:2px solid #8A2BE2;
							margin-top: 10px;
							width: 95%;
							border-radius:5px 5px 5px 5px;
						}
						.playercart2{
							width: 180px;
							height: 50px;
							border-top: 50px solid #8A2BE2;
							border-right: 30px solid transparent;
							border-bottom: 30px solid transparent;
							border-left: 30px solid transparent;
							margin-left: 40px
						}
						.playercart3{
							color: white;
							margin-top: -60px;
							margin-left: 100px
						}
						
						.circle_bot{  
						    width: 100px;  
						    height: 100px;  
						    margin: 25px 10px 0 80px;  
						    border-radius: 50%;  
						    border:2px solid #8A2BE2;
						}  
						.circle_mid {  
						    width: 80px;  
						    height: 80px;  
						    margin: -90px 0 0 89px;  
						    border-radius: 50%;
						    border:1px solid #8A2BE2;  
						}  
						.circle_mid img{
						border-radius:5px
						} 
						.playercart4{
							margin-top: -10px;
							margin-left: 10px;
						}
						.playercart4 span{
							color: #8A2BE2
						}
						.playercart5{
							margin-left: 90px;
						}
						.playercart5 span{
							color: #FF0000
						}
						.playercart6{
							margin-left: 90px;
							margin-top: 10px
						}
						.playercart6 span{
							color: #FF0000
						}
						.playercart7{
							width: 100%;
							height: 25px;
						}
						.playercart8{
							float: left;
							display: inline;
							background:#8A2BE2 ;
							width:70px;
							height: 25px
						}
						.playercart9{
							float: right;
							display: inline;
							background:#8A2BE2 ;
							width:70px;
							height: 25px
						}
						.playercart7 span{
							color: white;
						}
						
						
						
						.circle_mid figure div{
						display:inline-block;
						margin:10px auto;
						width:70px;
						height:70px;
						border-radius:100px;
						overflow:hidden;
						-webkit-box-shadow:0 0 3px #ccc;
						box-shadow:0 0 3px #ccc;
						}
						.circle_mid img{
							width:50px;
							min-height:50px; 
							text-align:center;
							margin-left: 15px;
							margin-top: 8px;
						}
						
					</style>
					<div class="row">
					  <!--// FOOTBALL TEAM //-->
					  	<div class="col-md-3 col-sm-6" style="height: 370px;">
						  	<div class="playercart1">
						  		<div class="playercart2" ></div>
						  		 <div class="playercart3">徐祖翼</div>
						  		 
						  		  <div class="circle_bot">  
								    </div>  
								    <div class="circle_mid">  
												<img alt="" src="${ctx}/resources/new/images/touxiang.png">
								    </div>  
								     <div class="playercart4" >  
									     <div><span>19</span>&nbsp;&nbsp;岁</div>
									     <div><span>175</span>&nbsp;&nbsp;CM</div>
									     <div><span>65</span>&nbsp;&nbsp;KG</div>
								    </div> 
								     <div class="playercart5" >  
									     <div>传&nbsp;&nbsp;<span>85</span>&nbsp;&nbsp;&nbsp;&nbsp;力&nbsp;&nbsp;<span>50</span></div>
									     <div>射&nbsp;&nbsp;<span>75</span>&nbsp;&nbsp;&nbsp;&nbsp;头&nbsp;&nbsp;<span>50</span></div>
									     <div>速&nbsp;&nbsp;<span>50</span>&nbsp;&nbsp;&nbsp;&nbsp;爆&nbsp;&nbsp;<span>50</span></div>
								    </div> 
								     <div class="playercart6" style="">  
									     <div>身价&nbsp;&nbsp;<span>70000</span>&nbsp;&nbsp;宇币</div>
								    </div> 
								      <div  style="height: 35px;">  
								     	
								     	
								    </div> 
								     <div class="playercart7" >  
								     	
								     	<div class="playercart8" ><span>&nbsp;&nbsp;&nbsp;&nbsp;妖人</span></div>
								     	<div class="playercart9" ><span>&nbsp;&nbsp;&nbsp;&nbsp;中锋</span></div>
								    </div> 
						  	</div>
						</div>
						<div class="col-md-3 col-sm-6" style="height: 370px;">
						  	<div class="playercart1">
						  		<div class="playercart2" ></div>
						  		 <div class="playercart3">徐祖翼</div>
						  		 
						  		  <div class="circle_bot">  
								    </div>  
								    <div class="circle_mid">  
												<img alt="" src="${ctx}/resources/new/images/touxiang.png">
								    </div>  
								     <div class="playercart4" >  
									     <div><span>19</span>&nbsp;&nbsp;岁</div>
									     <div><span>175</span>&nbsp;&nbsp;CM</div>
									     <div><span>65</span>&nbsp;&nbsp;KG</div>
								    </div> 
								     <div class="playercart5" >  
									     <div>传&nbsp;&nbsp;<span>85</span>&nbsp;&nbsp;&nbsp;&nbsp;力&nbsp;&nbsp;<span>50</span></div>
									     <div>射&nbsp;&nbsp;<span>75</span>&nbsp;&nbsp;&nbsp;&nbsp;头&nbsp;&nbsp;<span>50</span></div>
									     <div>速&nbsp;&nbsp;<span>50</span>&nbsp;&nbsp;&nbsp;&nbsp;爆&nbsp;&nbsp;<span>50</span></div>
								    </div> 
								     <div class="playercart6" style="">  
									     <div>身价&nbsp;&nbsp;<span>70000</span>&nbsp;&nbsp;宇币</div>
								    </div> 
								      <div  style="height: 35px;">  
								     	
								     	
								    </div> 
								     <div class="playercart7" >  
								     	
								     	<div class="playercart8" ><span>&nbsp;&nbsp;&nbsp;&nbsp;妖人</span></div>
								     	<div class="playercart9" ><span>&nbsp;&nbsp;&nbsp;&nbsp;中锋</span></div>
								    </div> 
						  	</div>
					
						</div>
						<div class="col-md-3 col-sm-6" style="height: 370px;">
						  	<div class="playercart1">
						  		<div class="playercart2" ></div>
						  		 <div class="playercart3">徐祖翼</div>
						  		 
						  		  <div class="circle_bot">  
								    </div>  
								    <div class="circle_mid">  
												<img alt="" src="${ctx}/resources/new/images/touxiang.png">
								    </div>  
								     <div class="playercart4" >  
									     <div><span>19</span>&nbsp;&nbsp;岁</div>
									     <div><span>175</span>&nbsp;&nbsp;CM</div>
									     <div><span>65</span>&nbsp;&nbsp;KG</div>
								    </div> 
								     <div class="playercart5" >  
									     <div>传&nbsp;&nbsp;<span>85</span>&nbsp;&nbsp;&nbsp;&nbsp;力&nbsp;&nbsp;<span>50</span></div>
									     <div>射&nbsp;&nbsp;<span>75</span>&nbsp;&nbsp;&nbsp;&nbsp;头&nbsp;&nbsp;<span>50</span></div>
									     <div>速&nbsp;&nbsp;<span>50</span>&nbsp;&nbsp;&nbsp;&nbsp;爆&nbsp;&nbsp;<span>50</span></div>
								    </div> 
								     <div class="playercart6" style="">  
									     <div>身价&nbsp;&nbsp;<span>70000</span>&nbsp;&nbsp;宇币</div>
								    </div> 
								      <div  style="height: 35px;">  
								     	
								     	
								    </div> 
								     <div class="playercart7" >  
								     	
								     	<div class="playercart8" ><span>&nbsp;&nbsp;&nbsp;&nbsp;妖人</span></div>
								     	<div class="playercart9" ><span>&nbsp;&nbsp;&nbsp;&nbsp;中锋</span></div>
								    </div> 
						  	</div>
					
						</div>
						<div class="col-md-3 col-sm-6" style="height: 370px;">
						  	<div class="playercart1">
						  		<div class="playercart2" ></div>
						  		 <div class="playercart3">徐祖翼</div>
						  		 
						  		  <div class="circle_bot">  
								    </div>  
								    <div class="circle_mid">  
												<img alt="" src="${ctx}/resources/new/images/touxiang.png">
								    </div>  
								     <div class="playercart4" >  
									     <div><span>19</span>&nbsp;&nbsp;岁</div>
									     <div><span>175</span>&nbsp;&nbsp;CM</div>
									     <div><span>65</span>&nbsp;&nbsp;KG</div>
								    </div> 
								     <div class="playercart5" >  
									     <div>传&nbsp;&nbsp;<span>85</span>&nbsp;&nbsp;&nbsp;&nbsp;力&nbsp;&nbsp;<span>50</span></div>
									     <div>射&nbsp;&nbsp;<span>75</span>&nbsp;&nbsp;&nbsp;&nbsp;头&nbsp;&nbsp;<span>50</span></div>
									     <div>速&nbsp;&nbsp;<span>50</span>&nbsp;&nbsp;&nbsp;&nbsp;爆&nbsp;&nbsp;<span>50</span></div>
								    </div> 
								     <div class="playercart6" style="">  
									     <div>身价&nbsp;&nbsp;<span>70000</span>&nbsp;&nbsp;宇币</div>
								    </div> 
								      <div  style="height: 35px;">  
								     	
								     	
								    </div> 
								     <div class="playercart7" >  
								     	
								     	<div class="playercart8" ><span>&nbsp;&nbsp;&nbsp;&nbsp;妖人</span></div>
								     	<div class="playercart9" ><span>&nbsp;&nbsp;&nbsp;&nbsp;中锋</span></div>
								    </div> 
						  	</div>
					
						</div>
						
					  </div>
				
					
					 
					</div>
				  </div>
				</section>
				<!--// 球员库 SECTION //-->

				<!--// TENNIS EVENT BG //-->
				<!--// TENNIS EVENT FIXTURE //-->
				<section>
				  <div class="container">
					<div class="row">
					  <!--// BLOG SLIDER //-->
					  <div class="col-md-4">
						<div class="heading6">
						  <h4>最新<span>新闻</span></h4>
						</div>
						<div class="ftb-bx-slider">
						  <ul class="bxslider">
							<li>
							  <div class="ftb-post-thumb">
								<a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider.jpg" alt=""></a>
								<div class="text">
								  <h6>成都史上最佳球员</h6>
								  <a class="btn-4" href="${ctx}/resources/new/#">Read More</a>
								</div>
							  </div>
							</li>
							<li>
							  <div class="ftb-post-thumb">
								<a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider.jpg" alt=""></a>
								<div class="text">
								  <h6>成都史上最佳球员</h6>
								  <a class="btn-4" href="${ctx}/resources/new/#">Read More</a>
								</div>
							  </div>
							</li>
							<li>
							  <div class="ftb-post-thumb">
								<a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider.jpg" alt=""></a>
								<div class="text">
								  <h6>成都史上最佳球员</h6>
								  <a class="btn-4" href="${ctx}/resources/new/#">Read More</a>
								</div>
							  </div>
							</li>
						  </ul>
						</div>
					  </div>
					  <!--// BLOG SLIDER //-->
					  <!--// BLOG SLIDER //-->
					  <div class="col-md-4">
						<!--// HEADING 6 //-->
						<div class="heading6">
						  <h4>最新<span>视频</span></h4>
						</div>
						<!--// HEADING 6 //-->
						<!--// POST //-->
						<div class="ftb-post-thumb">
						  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider2.jpg" alt=""></a>
						  <a class="spb-play" href="${ctx}/resources/new/#"><i class="fa fa-play-circle"></i></a>
						  <div class="text">
							<h6>Highlights OF Euro Cup 2nd Mtach</h6>
						  </div>
						</div>
						
						<!--// POST //-->
						<!--// POST //-->
						<div class="ftb-post-thumb">
						  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider3.jpg" alt=""></a>
						  <a class="spb-play" href="${ctx}/resources/new/#"><i class="fa fa-play-circle"></i></a>
						  <div class="text">
							<h6>A Single Fan In Stadium</h6>
						  </div>
						</div>
						<!--// POST //-->
					  </div>
					  <!--// BLOG SLIDER //-->
					  <div class="col-md-4">
						<!--// HEADING 6 //-->
						<div class="heading6">
						  <h4>俱乐部<span>排名</span></h4>
						</div>
						<!--// HEADING 6 //-->
						<!--// RATING TABLE //-->
						<ul class="ftb-rating-table">
						  <li>
							<div class="ftb-position">
							  1 . 
							</div>
							<div class="ftb-team-name">
							  <img src="${ctx}/resources/new/images/short-logo2.png" alt="">
							  <a href="${ctx}/resources/new/#">Lore Ipsum Dolor</a>
							</div>
							<div class="ftb-team-points">
							  20
							</div>
						  </li>
						  <li>
							<div class="ftb-position">
							  2 . 
							</div>
							<div class="ftb-team-name">
							  <img src="${ctx}/resources/new/images/short-logo3.png" alt="">
							  <a href="${ctx}/resources/new/#">Lore Ipsum Dolor</a>
							</div>
							<div class="ftb-team-points">
							  25
							</div>
						  </li>
						  <li>
							<div class="ftb-position">
							  3 . 
							</div>
							<div class="ftb-team-name">
							  <img src="${ctx}/resources/new/images/short-logo4.png" alt="">
							  <a href="${ctx}/resources/new/#">Lore Ipsum Dolor</a>
							</div>
							<div class="ftb-team-points">
							  30
							</div>
						  </li>
						  <li>
							<div class="ftb-position">
							  4 . 
							</div>
							<div class="ftb-team-name">
							  <img src="${ctx}/resources/new/images/short-logo1.png" alt="">
							  <a href="${ctx}/resources/new/#">Lore Ipsum Dolor</a>
							</div>
							<div class="ftb-team-points">
							  45
							</div>
						  </li>
						  <li>
							<div class="ftb-position">
							  5 . 
							</div>
							<div class="ftb-team-name">
							  <img src="${ctx}/resources/new/images/short-logo6.png" alt="">
							  <a href="${ctx}/resources/new/#">Lore Ipsum Dolor</a>
							</div>
							<div class="ftb-team-points">
							  29
							</div>
						  </li>
						  <li>
							<div class="ftb-position">
							  6 . 
							</div>
							<div class="ftb-team-name">
							  <img src="${ctx}/resources/new/images/short-logo7.png" alt="">
							  <a href="${ctx}/resources/new/#">Lore Ipsum Dolor</a>
							</div>
							<div class="ftb-team-points">
							  03
							</div>
						  </li>
						</ul>
						<!--// RATING TABLE //-->
					  </div>
					  <!--// BLOG SLIDER //-->
					</div>
					<!--// MAIN TABS TABLE //-->
					
					
				  </div>
				</section>





				  </div>
				</div>

			<!--// Main Content //-->
			
		  <!--// Contact Footer //-->
		  <footer class="football-footer" style="height: 250px">
			<div class="container" style="width: 90%;margin-top: 50px">
			  <div class="row">
				<!--// TEXT WIDGET //-->
				<div class="col-md-4">
				  <div class="widget spb-widget spb-text-widget" style="margin-top: -20px;margin-left: 10%">
					<div class="ft-logo">
					  <a href="${ctx}/resources/new/#"><img src="${ctx}/resources/new/images/logo2.png" alt=""></a>
					</div>
					<p>Copyright © 2017-2018 成都宇任拓</p>
					<p>蜀ICP备14020910号-2</p>
				  </div>
				</div>
				<!--// TEXT WIDGET //-->
				<!--// POPULAR WIDGET //-->
				<div class="col-md-4">
				  <div class="widget spb-widget spb-popular" style="display: inline;width: 35%">
					<h4 style="cursor: pointer;" onclick="window.open('${ctx}/about/questions')" >夺宝指南</h4>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/process')" >夺宝流程</p>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/agreement')" >夺宝协议</p>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/doubt')" >常见问题</p>
				 </div>
				  <div class="widget spb-widget spb-popular" style="display: inline;width: 35%">
					<h4 style="cursor: pointer;" onclick="window.open('${ctx}/about/questions')">常见问题</h4>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/questions')">常见问题</p>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/payhelp')">支付帮助</p>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/contact_us')" >联系我们</p>
				 </div>
				  <div class="widget spb-widget spb-popular" style="display: inline;width: 30%">
					<h4 style="cursor: pointer;" onclick="window.open('${ctx}/about/about_us')">关于宇任拓</h4>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/about_us')">关于我们</p>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/cooperation')">商务合作</p>
					<p style="cursor: pointer;font-size: 18px" onclick="window.open('${ctx}/about/join_us')">加入我们</p>
				 </div>
				</div>
				<div class="col-md-4">
				  <div class="widget spb-widget spb-popular " style="display: inline;width: 40%;height: 120px">
					<h4>宇任拓微博</h4>
					<img src="${ctx}/resources/new/images/weibo.png" alt="" style="width: 100px;height: 100px">
				 </div>
				 <div class="widget spb-widget spb-popular" style="display: inline;width: 60%;height: 120px">
					<h4>宇任拓微信</h4>
					<img src="${ctx}/resources/new/images/weixin.png" alt="" style="width: 100px;height: 100px">
				 </div>
				 <div><p style="text-transform:none">联系邮箱：yutuoscore@sina.cn</p></div>
				 
				</div>
				<!--// POPULAR WIDGET //-->
				<!--// FLICKER WIDGET //-->
				<div class="col-md-4" style="float: right;">
				  
				</div>
			 </div>
			  <!--// COPY RIGHT //-->
			  <!--// COPY RIGHT //-->
			</div>
		  </footer>
		  <!--// Contact Footer //-->
		  <!--// Wrapper //-->
		  <!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
			  <div class="modal-content">
				<div class="modal-header thbg-color">
				  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				  <h4 class="modal-title">Login To Your Account</h4>
				</div>
				<div class="modal-body">
				  <form class="kode-loginform">
					<p><span>User Name</span> <input type="text" placeholder="User Name"></p>
					<p><span>Password</span> <input type="password" placeholder="Password"></p>
					<p><label><input type="checkbox"><span>Remember Me</span></label></p>
					<p class="kode-submit"><a href="${ctx}/resources/new/#">Lost Your Password</a> <input class="thbg-colortwo" type="submit" value="Sign in"></p>
				  </form>
				</div>
			  </div>
			</div>
		  </div>
			<!-- Modal -->
		  <div class="modal fade" id="myModalTwo" tabindex="-1" role="dialog" aria-hidden="true">
			  <div class="modal-dialog">
				<div class="modal-content">
				  <div class="modal-header thbg-color">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">Register</h4>
				  </div>
				  <div class="modal-body">
					<form class="kode-loginform">
					  <p><span>Email</span> <input type="text" placeholder="Email"></p>
					  <p><span>Password</span> <input type="password" placeholder="Password"></p>
					  <p><span>Retype Password</span> <input type="password" placeholder="Retype Password"></p>
					  <p><label><input type="checkbox"><span>Remember Me</span></label></p>
					  <p class="kode-submit"><a href="${ctx}/resources/new/#">Lost Your Password</a> <input class="thbg-colortwo" type="submit" value="Sign Up"></p>
					</form>
				  </div>
				</div>
			  </div>
		  </div>
			<!-- jQuery (necessary for JavaScript plugins) -->
			<!--JavaScript-->
			<script src="${ctx}/resources/new/js/jquery.js"></script>
			<!--BOOTSTRAP JavaScript-->
			<script src="${ctx}/resources/new/js/bootstrap.min.js"></script>
			<!--BOOTSTRAP PROGRESS BAR JavaScript-->
			<script src="${ctx}/resources/new/js/bootstrap-progressbar.js"></script>
			<!--FLEX SLIDER JavaScript-->
			<script src="${ctx}/resources/new/js/jquery.flexslider.js"></script>
			<!--OWL SLIDER JavaScript-->
			<script src="${ctx}/resources/new/js/owl.carousel.min.js"></script>
			<!--BX SLIDER JavaScript-->
			<script src="${ctx}/resources/new/js/jquery.bxslider.min.js"></script>
			<!--SLICK SLIDER JavaScript-->
			<script src="${ctx}/resources/new/slick/slick.min.js"></script>
			<script src='${ctx}/resources/new/js/moment.min.js'></script>
			<!--ACCORDIAN JavaScript--> 
			<script src="${ctx}/resources/new/js/jquery.accordion.js"></script>
			<!--PRETTY PHOTO JavaScript-->
			<script src="${ctx}/resources/new/js/jquery.prettyphoto.js"></script>
			<script src="${ctx}/resources/new/js/kode_pp.js"></script>
			<!--Number Count (Waypoints) JavaScript-->
			<script src="${ctx}/resources/new/js/jquery.countdown.js"></script>
			<script src="${ctx}/resources/new/js/jquery.downCount.js"></script>
			<script src="${ctx}/resources/new/js/modernizr.custom.js"></script>
			<script src="${ctx}/resources/new/js/jquery.dlmenu.js"></script>
			<script src="${ctx}/resources/new/js/waypoints-min.js"></script>
			<script src='${ctx}/resources/new/js/fullcalendar.min.js'></script>
			<!--CUSTOM JavaScript-->
			<script src="${ctx}/resources/new/js/functions.js"></script>
			
			<script src='${ctx}/resources/new/js/jquery.newsTicker.min.js'></script>
			<script type="text/javascript">
			var nt_title = $('#nt-title').newsTicker({
                row_height: 20,
                max_rows: 1,
                duration: 3000,
                pauseOnHover: 0
            });
			
		   $(".nt-title-span").each(function () {
	            var maxwidth = 30;
	            if ($(this).text().length > maxwidth) {
	                $(this).text($(this).text().substring(0, maxwidth));
	                $(this).html($(this).html() + '...');
	            }
	        });
			$(".counterup-dec").mousemove(function(e){
				$(this).find("span").css("color","yellow");
				$(this).find("h3").css("color","yellow");
				$(this).find("p").css("color","yellow");
				
			});
			$(".counterup-dec").mouseout(function(e){
				$(this).find("span").css("color","white");
				$(this).find("h3").css("color","white");
				$(this).find("p").css("color","white");
			});
			

			
			</script>
		</body>
	</html>