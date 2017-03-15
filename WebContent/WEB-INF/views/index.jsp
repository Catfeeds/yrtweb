<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<html>
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
							  <li><a href="#">help desk</a></li>
							  <li><a href="#">live score</a></li>
								<li>
									<!-- Large modal -->
									<a type="button" class="btn btn-primary" data-toggle="modal" data-target=".media01">Login</a>

									<div class="modal fade bs-example-modal-lg media01" tabindex="-1" role="login" aria-labelledby="login">
									  <div class="modal-dialog modal-lg" role="document">
										<div class="modal-content">
											<div class="kode_modal_body">
												<a href="#"><i class="fa fa-user"></i></a>
												<h2>member  login</h2>
												<form>
													<div class="kode_modal_field">
														<input type="text" placeholder="username" required>
													</div>
													<div class="kode_modal_field">
														<input type="text" placeholder="password" required>
													</div>
													<div class="kode_model_btn">
														<button>login</button>
														<a href="#">forget password?</a>
													</div>
												</form>
											</div>
										</div>
									  </div>
									</div>
								</li>
								<li>
									<!-- Large modal -->
									<a type="button" class="btn btn-primary" data-toggle="modal" data-target=".media02">Register</a>
									
									<div class="modal fade bs-example-modal-lg media02" tabindex="-1" role="Register" aria-labelledby="Register">
									  <div class="modal-dialog modal-lg" role="document">
										<div class="modal-content">
											<div class="kode_modal_body">
												<a href="#"><i class="fa fa-user"></i></a>
												<h2>Register</h2>
												<form>
													<div class="kode_modal_field">
														<input type="text" placeholder="username" required>
													</div>
													<div class="kode_modal_field">
														<input type="text" placeholder="password" required>
													</div>
													<div class="kode_modal_field">
														<input type="text" placeholder="confirm password" required>
													</div>
													<div class="kode_model_btn">
														<button>register</button>
														<a href="#">member  login</a>
													</div>
												</form>
											</div>
										</div>
									  </div>
									</div>
									
								</li>
							  <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
							  <li><a id="ftb_btn_link" ><i class="fa fa-search"></i></a></li>
							</ul>
						  <div id="show-class"><form><input type="text" placeholder="your key word"></form></div>
						  <ul class="social-style3">
							  <li><a href="#"><i class="fa fa-facebook"></i></a></li>
							  <li><a href="#"><i class="fa fa-twitter"></i></a></li>
							  <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
							  <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
						  </ul>
					  </div>
					</div>
				  </div>
				</div>
				<div class="logo-wrap2">
				  <div class="container">
					<div class="logo logo-3">
					  <a href="#"><img src="${ctx}/resources/new/images/logo2.png" alt=""></a>
					</div>
					<!--// SPB TICKER //-->
					<div class="spb-ticker spb-ticker2">
					  <span>New:</span>
					  <ul class="top_slider_bxslider">
						<li>
						  <div class="ticker-dec">
							<a href="#">春季联赛即将开幕，本网站、微信公众号、新浪微博均可报名哦！</a>
						  </div>
						</li>
						<li>
						  <div class="ticker-dec">
							<a href="#">春季联赛即将开幕，本网站、微信公众号、新浪微博均可报名哦！</a>
						  </div>
						</li>
					  </ul>
					</div>
					<!--// SPB TICKER //-->
				  </div>
				</div>

				<div class="nav4">
				  <div class="container">
					<ul class="kode_nave">
						<li><a href="#">首  页</a>

						</li>
						<li><a href="${ctx}/resources/new/about-us.html">宇币夺宝</a></li>
						<li><a href="${ctx}/resources/new/fixtures.html">联   赛</a>
							<ul>
								<li><a href="${ctx}/resources/new/result.html">赛事报名</a></li>
								 <li><a href="${ctx}/resources/new/tickets.html">转会交易</a></li>
								  <li><a href="${ctx}/resources/new/ticket-single.html">球员竞拍 </a></li>
							</ul>	  
						</li>
						<li><a href="#">俱乐部</a>

						</li>
						<li><a href="${ctx}/resources/new/shop.html">球员库</a></li>
						<li><a href="${ctx}/resources/new/blog.html">个人中心</a>

						</li>
						<li><a href="${ctx}/resources/new/contact-us.html">联系我们</a></li>
					</ul>
					<!--DL Menu Start-->
					<div id="kode-responsive-navigation" class="dl-menuwrapper">
					<button class="dl-trigger">Open Menu</button>
						<ul class="dl-menu">
							<li class="active"><a class="active" href="#">Home</a>
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
							<li class="menu-item kode-parent-menu"><a href="#">Team & Player</a>
								<ul class="dl-submenu">
									<li><a href="${ctx}/resources/new/our-team.html">our team</a></li>
									<li><a href="${ctx}/resources/new/our-team-2.html">our team 2</a></li>
									<li><a href="${ctx}/resources/new/single-player.html">single player</a></li>
									<li><a href="${ctx}/resources/new/single-player-sidebar.html">single player sidebar</a></li>
								</ul>
							</li>
							<li class="menu-item kode-parent-menu"><a href="${ctx}/resources/new/shop.html">shop</a></li>
							<li class="menu-item kode-parent-menu"><a href="#">blog</a>
								<ul class="dl-submenu">
									<li><a href="${ctx}/resources/new/blog.html">blog</a></li>
									<li><a href="${ctx}/resources/new/blog2.html">blog 02</a></li>
									<li><a href="${ctx}/resources/new/blog-detail.html">blog detail</a></li>
									<li><a href="${ctx}/resources/new/blog-sidebar.html">blog sidebar</a></li>
								</ul>
							</li>
							<li class="menu-item kode-parent-menu"><a href="#">page</a>
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
					<div class="ticket-wrap">
					  <a class="book-now" href="${ctx}/resources/new/tickets.html"><i class="fa fa-info"></i>此处改成翻板式消息提醒--带类型</a>
					  <div class="lung-link">
					  <!--  
						<a href="#">en</a>
						<a href="#">fr</a>
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
							<p><a class="btn-4" href="#">马上报名<i class="fa fa-angle-right"></i></a></p>
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
							<p><a class="btn-4" href="#">马上报名<i class="fa fa-angle-right"></i></a></p>
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
							<p><a class="btn-4" href="#">马上报名<i class="fa fa-angle-left"></i></a></p>
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
							  <h5><a href="#">Iceland</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="#">Poland</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag6.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="#">England</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag2.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="#">Germany</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag3.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="#">Turkey</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag4.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="#">Africa</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag5.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="#">Iceland</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="#">Poland</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag6.png" alt=""></a>
							</div>
						  </div>
					  </div>
					<!--// SLIDER ITEM //-->
					<!--// SLIDER ITEM //-->
					  <div class="ft-match-dec">
						  <span>23 June 2016</span>
						  <div class="ft-match-teams">
							<div class="ft-team-1">
							  <h5><a href="#">Iceland</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag.png" alt=""></a>
							</div>
							<span>21 : 00</span>
							<div class="ft-team-1 ft-team-2">
							  <h5><a href="#">Poland</a></h5>
							  <a href="#"><img src="${ctx}/resources/new/images/flag.png" alt=""></a>
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
					  <div class="col-md-3 col-sm-3">
					  <a href="#">
						<div class="counterup-dec">
						  <span class="icon-football"></span>
						  <div class="text">
							<h3 class="word-count">250</h3>
							<p>场比赛</p>
						  </div>
						</div>
						</a>
					  </div>
					  <!--// COUNTER //-->
					  <!--// COUNTER //-->
					  <div class="col-md-3 col-sm-3">
					  	<a href="#">
						<div class="counterup-dec">
						  <span class="icon-soccer"></span>
						  <div class="text" >
							<h3 class="word-count">18</h3>
							<p>家俱乐部</p>
						  </div>
						</div>
						</a>
					  </div>
					  <!--// COUNTER //-->
					  <div class="col-md-3 col-sm-3">
					  	<a href="#">
						<div class="counterup-dec">
						  <span class="icon-symbol"></span>
						  <div class="text">
							<h3 class="word-count">128</h3>
							<p>明星球员</p>
						  </div>
						</div>
						</a>
					  </div>
					  <!--// COUNTER //-->
					  <!--// COUNTER //-->
					  <div class="col-md-3 col-sm-3">
					  	<a href="#">
						<div class="counterup-dec">
						  <span class="icon-cup"></span>
						  <div class="text">
							<h3 class="word-count">78</h3>
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
					<div class="row">
					  <!--// FOOTBALL TEAM //-->
					  <div class="col-md-3 col-sm-6">
						<div class="ftb-team-thumb">
						  <figure><img src="${ctx}/resources/new/extra-images/ftb-teamone.png" alt=""></figure>
						  <div class="ftb-team-dec">
							<span>07</span>
							<div class="text">
							  <a href="#">Leo Adam</a>
							  <p>Defender</p>
							</div>
							<a class="arrow-iconbtn" href="#"><i class="fa fa-arrow-right "></i></a>
						  </div>
						</div>
					  </div>
					  <!--// FOOTBALL TEAM //-->
					  <!--// FOOTBALL TEAM //-->
					  <div class="col-md-3 col-sm-6">
						<div class="ftb-team-thumb">
						  <figure><img src="${ctx}/resources/new/extra-images/ftb-teamtwo.png" alt=""></figure>
						  <div class="ftb-team-dec">
							<span>07</span>
							<div class="text">
							  <a href="#">Leo Adam</a>
							  <p>Defender</p>
							</div>
							<a class="arrow-iconbtn" href="#"><i class="fa fa-arrow-right "></i></a>
						  </div>
						</div>
					  </div>
					  <!--// FOOTBALL TEAM //-->
					  <!--// FOOTBALL TEAM //-->
					  <div class="col-md-3 col-sm-6">
						<div class="ftb-team-thumb">
						  <figure><img src="${ctx}/resources/new/extra-images/ftb-three.png" alt=""></figure>
						  <div class="ftb-team-dec">
							<span>07</span>
							<div class="text">
							  <a href="#">Leo Adam</a>
							  <p>Defender</p>
							</div>
							<a class="arrow-iconbtn" href="#"><i class="fa fa-arrow-right "></i></a>
						  </div>
						</div>
					  </div>
					  <!--// FOOTBALL TEAM //-->
					  <!--// FOOTBALL TEAM //-->
					  <div class="col-md-3 col-sm-6">
						<div class="ftb-team-thumb">
						  <figure><img src="${ctx}/resources/new/extra-images/ftb-teamfour.png" alt=""></figure>
						  <div class="ftb-team-dec">
							<span>07</span>
							<div class="text">
							  <a href="#">Leo Adam</a>
							  <p>Defender</p>
							</div>
							<a class="arrow-iconbtn" href="#"><i class="fa fa-arrow-right "></i></a>
						  </div>
						</div>
					  </div>
					  <!--// FOOTBALL TEAM //-->
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
								<a href="#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider.jpg" alt=""></a>
								<div class="text">
								  <h6>成都史上最佳球员</h6>
								  <a class="btn-4" href="#">Read More</a>
								</div>
							  </div>
							</li>
							<li>
							  <div class="ftb-post-thumb">
								<a href="#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider.jpg" alt=""></a>
								<div class="text">
								  <h6>成都史上最佳球员</h6>
								  <a class="btn-4" href="#">Read More</a>
								</div>
							  </div>
							</li>
							<li>
							  <div class="ftb-post-thumb">
								<a href="#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider.jpg" alt=""></a>
								<div class="text">
								  <h6>成都史上最佳球员</h6>
								  <a class="btn-4" href="#">Read More</a>
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
						  <a href="#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider2.jpg" alt=""></a>
						  <a class="spb-play" href="#"><i class="fa fa-play-circle"></i></a>
						  <div class="text">
							<h6>Highlights OF Euro Cup 2nd Mtach</h6>
						  </div>
						</div>
						<!--// POST //-->
						<!--// POST //-->
						<div class="ftb-post-thumb">
						  <a href="#"><img src="${ctx}/resources/new/extra-images/ftb-post-slider3.jpg" alt=""></a>
						  <a class="spb-play" href="#"><i class="fa fa-play-circle"></i></a>
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
							  <a href="#">Lore Ipsum Dolor</a>
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
							  <a href="#">Lore Ipsum Dolor</a>
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
							  <a href="#">Lore Ipsum Dolor</a>
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
							  <a href="#">Lore Ipsum Dolor</a>
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
							  <a href="#">Lore Ipsum Dolor</a>
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
							  <a href="#">Lore Ipsum Dolor</a>
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
		  <footer class="football-footer">
			<div class="container">
			  <div class="row">
				<!--// TEXT WIDGET //-->
				<div class="col-md-4">
				  <div class="widget spb-widget spb-text-widget">
					<div class="ft-logo">
					  <a href="#"><img src="${ctx}/resources/new/images/logo2.png" alt=""></a>
					</div>
					<p>Copyright © 2017-2018 成都宇任拓</p>
					<p>蜀ICP备14020910号-2</p>
					<ul class="spb-social2">
					  <li><a href="#"> <i class="fa fa-facebook"></i></a></li>
					  <li><a href="#"> <i class="fa fa-twitter"></i></a></li>
					  <li><a href="#"> <i class="fa fa-linkedin"></i></a></li>
					  <li><a href="#"> <i class="fa fa-rss"></i></a></li>
					  <li><a href="#"> <i class="fa fa-google-plus"></i></a></li>
					  <li><a href="#"> <i class="fa fa-linkedin"></i></a></li>
					</ul>
				  </div>
				</div>
				<!--// TEXT WIDGET //-->
				<!--// POPULAR WIDGET //-->
				<div class="col-md-4">
				  <div class="widget spb-widget spb-popular">
					<h4>夺宝指南</h4>
					<div class="spb-popular-dec">
					  <figure>
						<img src="${ctx}/resources/new/extra-images/popular-ft1.jpg" alt="">
						<a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/popular-ft1.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
					  </figure>
					  <div class="text">
						<a href="#">Lorem ipsum dolor amet, conse-ctetur adipiscing elit. Donec st.</a>
						<ul class="spb-meta2">
						  <li><a href="#"><i class="fa fa-heart"></i>13 like</a></li>
						  <li><a href="#"><i class="fa fa-comment"></i>14 comment</a></li>
						</ul>
					  </div>
					</div>
					<div class="spb-popular-dec">
					  <figure>
						<img src="${ctx}/resources/new/extra-images/popular-ft2.jpg" alt="">
						<a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/popular-ft2.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
					  </figure>
					  <div class="text">
						<a href="#">Lorem ipsum dolor amet, conse-ctetur adipiscing elit. Donec st.</a>
						<ul class="spb-meta2">
						  <li><a href="#"><i class="fa fa-heart"></i>13 like</a></li>
						  <li><a href="#"><i class="fa fa-comment"></i>14 comment</a></li>
						</ul>
					  </div>
					</div>
					<div class="spb-popular-dec">
					  <figure>
						<img src="${ctx}/resources/new/extra-images/popular-ft3.jpg" alt="">
						<a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/popular-ft3.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
					  </figure>
					  <div class="text">
						<a href="#">Lorem ipsum dolor amet, conse-ctetur adipiscing elit. Donec st.</a>
						<ul class="spb-meta2">
						  <li><a href="#"><i class="fa fa-heart"></i>13 like</a></li>
						  <li><a href="#"><i class="fa fa-comment"></i>14 comment</a></li>
						</ul>
					  </div>
					</div>
				  </div>
				</div>
				<!--// POPULAR WIDGET //-->
				<!--// FLICKER WIDGET //-->
				<div class="col-md-4">
				  <div class="widget spb-widget spb-flicker">
					<h4>Flicker Widgets</h4>
					<ul>
					  <li>
						  <a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/flicker-ft1.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
						  <img src="${ctx}/resources/new/extra-images/flicker-ft1.jpg" alt="">
					  </li>
					  <li>
						  <a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/flicker-ft2.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
						  <img src="${ctx}/resources/new/extra-images/flicker-ft2.jpg" alt="">
					  </li>
					  <li>
						  <a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/flicker-ft3.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
						  <img src="${ctx}/resources/new/extra-images/flicker-ft3.jpg" alt="">
					  </li>
					  <li>
						  <a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/flicker-ft4.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
						  <img src="${ctx}/resources/new/extra-images/flicker-ft4.jpg" alt="">
					  </li>
					  <li>
						  <a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/flicker-ft5.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
						  <img src="${ctx}/resources/new/extra-images/flicker-ft5.jpg" alt="">
					  </li>
					  <li>
						  <a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/flicker-ft6.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
						  <img src="${ctx}/resources/new/extra-images/flicker-ft6.jpg" alt="">
					  </li>
					  <li>
						  <a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/flicker-ft7.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
						  <img src="${ctx}/resources/new/extra-images/flicker-ft7.jpg" alt="">
					  </li>
					  <li>
						  <a data-rel="prettyPhoto[]" href="${ctx}/resources/new/extra-images/flicker-ft8.jpg" class="spb-play"><i class="fa fa-plus"></i></a>
						  <img src="${ctx}/resources/new/extra-images/flicker-ft8.jpg" alt="">
					  </li>
					</ul>
					<a class="spb-btn3" href="#">Load More</a>
				  </div>
				</div>
				<!--// FLICKER WIDGET //-->
			  </div>
			  <!--// COPY RIGHT //-->
			  <div class="spb-copyright">

				<p>All Rights Reserved</p>
				<a id="kode-topbtn" href="#"><i class="fa fa-angle-double-up"></i></a>
			  </div>
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
					<p class="kode-submit"><a href="#">Lost Your Password</a> <input class="thbg-colortwo" type="submit" value="Sign in"></p>
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
					  <p class="kode-submit"><a href="#">Lost Your Password</a> <input class="thbg-colortwo" type="submit" value="Sign Up"></p>
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
		</body>
	</html>