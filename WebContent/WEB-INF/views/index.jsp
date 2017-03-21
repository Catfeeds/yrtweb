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
			<link rel="stylesheet" href="${ctx}/resources/css/videoList.css">
			
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
								  <c:if test="${!empty eventRecordList}">
								    <c:forEach items="${eventRecordList}" var="eventRecord">
								    <li style="color: white">
				    					<span class="icon-football" style="color: #ADFF2F">&nbsp;&nbsp;</span><span class="nt-title-span">${eventRecord.m_team_name}&nbsp;&nbsp;${eventRecord.m_score}:${eventRecord.g_score}&nbsp;&nbsp;${eventRecord.g_team_name}</span>
				    				</li>
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
					
				<div class="row" id="playerdiv1">
					  <!--// FOOTBALL TEAM //-->
					  <c:forEach items="${playerList1}" var="player1">
						  	<div class="col-md-3 col-sm-6" style="height: 370px;">
							  	<div class="playercart1">
							  		<div class="playercart2" ></div>
							  		 <div class="playercart3">${player1.username}</div>
							  		 
							  		  <div class="circle_bot">  
									    </div>  
									    <div class="circle_mid">  
													<img alt="" src="${headpath}${player1.head_icon}">
									    </div>  
									     <div class="playercart4" >  
										     <div><span>${player1.age}</span>&nbsp;&nbsp;岁</div>
										     <div><span>${player1.height}</span>&nbsp;&nbsp;CM</div>
										     <div><span>${player1.weight}</span>&nbsp;&nbsp;KG</div>
									    </div> 
									     <div class="playercart5" >  
										     <div>传&nbsp;&nbsp;<span>${player1.pass_ability}</span>&nbsp;&nbsp;&nbsp;&nbsp;力&nbsp;&nbsp;<span>${player1.power}</span></div>
										     <div>射&nbsp;&nbsp;<span>${player1.shot}</span>&nbsp;&nbsp;&nbsp;&nbsp;头&nbsp;&nbsp;<span>${player1.header}</span></div>
										     <div>速&nbsp;&nbsp;<span>${player1.speed}</span>&nbsp;&nbsp;&nbsp;&nbsp;爆&nbsp;&nbsp;<span>${player1.explosive}</span></div>
									    </div> 
									     <div class="playercart6" style="">  
										     <div>身价&nbsp;&nbsp;<span>${player1.current_price}</span>&nbsp;&nbsp;宇币</div>
									    </div> 
									      <div  style="height: 35px;">  
									     	
									     	
									    </div> 
									     <div class="playercart7" >  
									     	
									     	<div class="playercart8" ><span>&nbsp;&nbsp;&nbsp;&nbsp;妖人</span></div>
									     	<div class="playercart9" ><span>&nbsp;&nbsp;&nbsp;&nbsp;${player1.position}</span></div>
									    </div> 
							  	</div>
							</div>
						</c:forEach>
			
					  </div>
					  
					  <div class="row" id="playerdiv2" style="display: none;">
					  <!--// FOOTBALL TEAM //-->
					  	<c:forEach items="${playerList2}" var="player2">
						  	<div class="col-md-3 col-sm-6" style="height: 370px;">
							  	<div class="playercart1">
							  		<div class="playercart2" ></div>
							  		 <div class="playercart3">${player2.username}</div>
							  		 
							  		  <div class="circle_bot">  
									    </div>  
									    <div class="circle_mid">  
													<img alt="" src="${headpath}${player2.head_icon}">
									    </div>  
									     <div class="playercart4" >  
										     <div><span>${player2.age}</span>&nbsp;&nbsp;岁</div>
										     <div><span>${player2.height}</span>&nbsp;&nbsp;CM</div>
										     <div><span>${player2.weight}</span>&nbsp;&nbsp;KG</div>
									    </div> 
									     <div class="playercart5" >  
										     <div>传&nbsp;&nbsp;<span>${player2.pass_ability}</span>&nbsp;&nbsp;&nbsp;&nbsp;力&nbsp;&nbsp;<span>${player2.power}</span></div>
										     <div>射&nbsp;&nbsp;<span>${player2.shot}</span>&nbsp;&nbsp;&nbsp;&nbsp;头&nbsp;&nbsp;<span>${player2.header}</span></div>
										     <div>速&nbsp;&nbsp;<span>${player2.speed}</span>&nbsp;&nbsp;&nbsp;&nbsp;爆&nbsp;&nbsp;<span>${player2.explosive}</span></div>
									    </div> 
									     <div class="playercart6" style="">  
										     <div>身价&nbsp;&nbsp;<span>${player2.current_price}</span>&nbsp;&nbsp;宇币</div>
									    </div> 
									      <div  style="height: 35px;">  
									     	
									     	
									    </div> 
									     <div class="playercart7" >  
									     	
									     	<div class="playercart8" ><span>&nbsp;&nbsp;&nbsp;&nbsp;妖人</span></div>
									     	<div class="playercart9" ><span>&nbsp;&nbsp;&nbsp;&nbsp;${player2.position}</span></div>
									    </div> 
							  	</div>
							</div>
						</c:forEach>
			
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
						  <h4>精彩<span>图片</span></h4>
						</div>
						<div class="ftb-bx-slider">
						  <ul class="bxslider">
							  <c:forEach items="${imageList}" var="image">
								  <li>
									  <div class="ftb-post-thumb">
										<img src="${headpath }${image.f_src}" alt="">
										<div class="text">
										  <h6>${image.title}</h6>
										  <a class="btn-4" href="${ctx}/indexIvList?type=imagelist">更多</a>
										</div>
									  </div>
									</li>
							  </c:forEach>
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
						
						
						<c:forEach items="${videoList}" var="video" begin="0">
							<div class="ftb-post-thumb">
							
							  <a onclick='show_video("${headpath}${video.f_src}","${video.create_timeS}","${video.id}","${video.role_type}")'><img src="${headpath}${video.v_cover}" alt=""></a>
							  <a class="spb-play" onclick='show_video("${headpath}${video.f_src}","${video.create_timeS}","${video.id}","${video.role_type}")'><i class="fa fa-play-circle"></i></a>
							  <div class="text">
								<h6>${video.title}</h6>
							  </div>
							</div>
					    			
				    	</c:forEach>
				    	
				    	  <div class="video_detail" id="video_detail" style="display: none;">
                	<div class="closeVideoDeatail"></div>
                	<!-- <div class="videoTitle">
                		<span class="text-white f20">广州俱乐部VS杭州俱乐部</span>
                	</div> -->
                	<div class="commentIcon">
                		<span>
                			<a class="goodComment" flag="1" title="赞" data-id="goodbtn" onclick="do_praise(1,this,'video')" style="cursor: pointer;"></a>
                		</span>
                		<span class="text-white ml20" data-id="good">0</span>
                		<span class="ml15">
                			<a class="badComment" flag="1" title="踩" data-id="badbtn" onclick="do_praise(2,this,'video')" style="cursor: pointer;"></a>
                		</span>
                		<span class="text-white ml25" data-id="bad">0</span>
                	</div>
                	<div id="a1" class="videoplay pull-left">
                	</div>
                	<div class="comment pull-left">
                		
                		<div class="load">
                			<a id="load_more"></a>
                		</div>
                		<div id="commentList" class="commentBox">
	                		<div id="commentModel" class="ml10 mt10" style="display: none;">
	                			<div class="pull-left">
	                				<img src="${el:headPath()}{{head_icon}}" class="other"/>
	                			</div>
	                			<div class="pull-left ml15">
	                				<p>
	                					<span class="text-gray" style="cursor: pointer;" data-id="usernick"></span>
	                					<span data-id="create_time" class="text-gray ml10"></span>
	                				</p>
	                				<p class="text-white mt5 w225">{{content}}</p>
	                			</div>
	                			<div class="clearfix"></div>
	                		</div>
                		</div>
                		<form id="commentsForm" errorType="2" action="${ctx}/imageVideo/saveComments">
          				<input type="hidden" id="iv_id" name="iv_id" value=""/>
          				<input type="hidden" id="roleType" name="roleType" value=""/>
                		<div class="publishComment">
                			<img src="${el:headPath()}${user_img}" class="publishHead"/>
                			<textarea valid="require len(0,200)" data-text="评论" id="msg_content" name="content"></textarea>
                			<input type="button" onclick="send_comments()" value="发表" class="publisBtn"/>
                		</div>
                		</form>
                	</div>
                </div>
						
					
						<!--// POST //-->
					  </div>
					  <!--// BLOG SLIDER //-->
					  <div class="col-md-4">
						<!--// HEADING 6 //-->
						<div class="heading6">
						  <h4>最新<span>新闻</span></h4>
						</div>
						<!--// HEADING 6 //-->
						<!--// RATING TABLE //-->
						<ul class="ftb-rating-table">
						  <c:forEach items="${indexNewsList}" var="news"  varStatus="status">
								<li>
									<div class="ftb-position">
									  ${status.index+1} 
									</div>
									<div class="ftb-team-name">
									  <a href="javascript:window.location='${ctx}/news/${news.id}'"> ${news.title}</a>
									</div>
									
							  	</li>
		                  </c:forEach>
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
			<script src="${ctx}/resources/new/js/jquery-ui.js"></script>
			<script src="${ctx}/resources/new/js/waypoints-min.js"></script>
			<script src='${ctx}/resources/new/js/fullcalendar.min.js'></script>
			<!--CUSTOM JavaScript-->
			
			<script src="${ctx}/resources/js/yt.ext.js"></script>
			<script src="${ctx}/resources/new/slick/slick.min.js"></script>
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
				window.setInterval(function(){ 
					if($("#playerdiv1").is(":hidden")){
				        $("#playerdiv1").show(1000);    //如果元素为隐藏,则将它显现
					}else{
					       $("#playerdiv1").hide(1000);     //如果元素为显现,则将其隐藏
					}
					if($("#playerdiv2").is(":hidden")){
				        $("#playerdiv2").show(1000);    //如果元素为隐藏,则将它显现
					}else{
					       $("#playerdiv2").hide(1000);     //如果元素为显现,则将其隐藏
					}
				}, 5000); //5s进行一次循环
			</script>
			
			
		<!--以下都播放视频部分copy 的js代码，参考的videolist.jsp整合有问题-->
			
		<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
		<script src="${ctx}/resources/layer/layer.js"></script>
		<script src="${ctx}/resources/js/base.js"></script>
		<script src="${ctx}/resources/js/validation.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/yt.ext.js"></script>
		<script src="${ctx}/resources/js/jQuery.md5.js"></script>
		<script type="text/javascript" src="${ctx }/resources/fileupload/webuploader/webuploader.js"></script>
		<script type="text/javascript" src="${ctx }/resources/fileupload/fileUploader.js"></script>
		<script src="${ctx}/resources/js/own/playeropt.js"></script>
					
		<script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
		<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
		<script src="${ctx}/resources/ckplayer/ckplayer.js"></script>
		<script type="text/javascript">


			//鼠标悬浮
			function showBtn(dom){
				$(dom).children().find(".video_play").css("display","block");
			}
			
			//鼠标移开
			function hideBtn(){
				$(".video_play").css("display","none");
			}
			
			$(".closeVideoDeatail").click(function () {
			    $("#a1").html("");
			    $(".masker").hide();
			    $("#msg_content").val("");
			    $('#video_detail').hide();
			});
			
			var commontList = new List({
				url:'${ctx}/imageVideo/queryVideoComments',
				sendData:{
					currentPage:1,
					pageSize :10
			      },
			   	listDataModel:$('#commentModel').get(0).outerHTML,
			   	listContainer:'#commentList',
			   	dynamicVMHandler:function(one){
			   		var vm = $(commontList.options.listDataModel);
			   		vm.css('display','block');
			   		var nick = one.usernick;
			   		if(nick&&nick.length>5){
			   			nick = nick.substring(0,4);
			   			vm.find('[data-id=usernick]').text(nick+"**").attr("title",one.usernick);
			   		}else{
			   			vm.find('[data-id=usernick]').text(one.usernick);
			   		}
			   		if(one.create_time){
			   			gap(one.create_time,vm.find('[data-id=create_time]'));
			   			//vm.find('[data-id=create_time]').text(Filter.formatDate(one.create_time,'yyyy-MM-dd hh:mm:ss'));
			   		}
			   		return vm.get(0).outerHTML;
			   	}
			});
			
			function queryComments(vid,rtype){
				$("#iv_id").val(vid);
				$("#roleType").val(rtype);
				commontList.options.sendData = {
					currentPage:1,
					pageSize :10,
					id:vid,
					type:rtype
				}
				commontList.loadListData().done(function(data){
					isPageEnd(data.data.page);
					commontList.renderList(data.data.page.items,'reloaded','desc');
					$(".commentBox").scrollTop($(".commentBox")[0].scrollHeight);
				});
			}
			
			function loadMore(btn){
				commontList.options.sendData.currentPage++;
				commontList.loadListData().done(function(data){
					isPageEnd(data.data.page);
					if(data.data.page.items&&data.data.page.items.length!=0){
						commontList.renderList(data.data.page.items,'prepend');
					}else{
						$(btn).removeAttr("onclick").text("没有更多了");
					}
				});
			}
			
			function isPageEnd(page){
				if(page.currentPage*page.pageSize>page.totalCount){
					$('#load_more').removeAttr("onclick").text("没有更多了");
				}else{
					$('#load_more').attr("onclick","loadMore(this)").text("加载更多");
				}
			}
			
			function save_click_count(vid,type){
				$.post(base+'/imageVideo/updateClickCount',{iv_id:vid,roleType:type},function (data){
					if(data.data.praiseCount){
						$(".commentIcon").find("[data-id=good]").text(data.data.praiseCount.praise);
						$(".commentIcon").find("[data-id=bad]").text(data.data.praiseCount.cai);
					}
					if(data.data.ispra){
						$(".goodComment").attr("title","取消点赞")
					}else if(data.data.iscai){
						$(".badComment").attr("title","取消点踩")
					}
				});
			}
			
			function show_video(video,ctime,vid,type){
				if(check_create_time(ctime,15)){
					layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
					return;
				}
				var flashvars = {
			        f: filePath+'/'+video,
			        c: 0,
			        b: 1
			    };
			    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1', 'ckplayer_a1', '662', '522', false, flashvars);
			    $(".masker").height($(document).height()).fadeIn();
				$(".masker").show();
				$("#video_detail").show();
				queryComments(vid,type);
				//save_click_count(vid,type);
			}
			function resHandler(result){
				if(result.state=='success'){
					$("#msg_content").val("");
					queryComments($("#iv_id").val(),$("#roleType").val());
				}else{
					layer.msg("发送失败",{icon: 2});
				}
			}
			function send_comments(){
				$.ajaxSubmit('#commentsForm','#commentsForm',resHandler,not_login)
			}
			var gap = function(date,div){
			    var now = new Date;
			    var that = new Date (date);
			    var ms = Math.floor((now-that)/1000/60/60);
			    var fz = Math.floor((now - that)/1000/60);
			    if (ms > 24 && ms < 48){
			        div.text ('昨天 ' + that.toLocaleTimeString ());
			    }
			    else if (ms > 48){
			        div.text (Filter.formatDate(date,'yyyy-MM-dd hh:mm:ss'));
			    }
			    else{
			    	if(fz>=60){
			        	div.text(ms + ' 小时前');
			    	}else if(fz>0&&fz<60){
			    		div.text(fz + ' 分钟前');
			    	}else{
			    		//div.text("刚刚");
			    	}
			    }
			}
			
			function do_praise(state,dom){
				var flag = $(dom).attr("flag");
				if(flag==1){
					$(dom).attr("flag",0);
			  		$.ajaxSec({
						type: 'POST',
						url: '${ctx}/imageVideo/praise',
						data: {iv_id:$("#iv_id").val(),p_state: state,p_type:$("#roleType").val()},
						success: function(data){
							if(data.state == 'success'){
								var str = state==1?'赞':'踩';
								var type = state==1?'good':'bad';
								var pras = $(".commentIcon").find("[data-id="+type+"]");
								pras.text(data.data.praiseCount);
								if(data.data.flag==1){
									$(dom).attr('title','取消点'+str);
								}else{
									$(dom).attr('title',str);
								}
							}else{
								layer.msg("操作失败",{icon: 2});
							}
							$(dom).attr("flag",1);
						},
						error: $.ajaxError
					},not_login);
				}
			}
			function not_login(){
				$("#a1").html("");
			    $(".masker").hide();
			    $("#msg_content").val("");
			    $('#video_detail').hide();
			}
			</script> 
		</body>
	</html>