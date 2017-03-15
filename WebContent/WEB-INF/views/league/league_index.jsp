<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>联赛首页</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<link href="${ctx}/resources/sliderengine/amazingslider-1.css" rel="stylesheet" />
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<c:set var="currentPage" value="LEAGUEINDEX"/>
</head>
<body>
<div class="warp">
	<div class="masker"></div>
		<input type="hidden" id="league_id" value="${league_id}"/>
         <!--头部-->
         <%@ include file="../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <div class="wrapper" style="margin-top: 80px;">
        	<!--视频详情    start-->
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
			<!--视频详情	end-->        
            <div class="league_tools">
                <ul>
                    <li><a href="javascript:void(0);" class="jiaoyi ms" onclick="javascript:window.location='${ctx}/league/choosePage'">球员交易</a></li>
                    <c:if test="${flag }">
	                    <li><a href="${ctx}/myleague/index?league_id=1" class="liansai ms">我的联赛</a></li>
                    </c:if>
                    <div class="clearit"></div>
                </ul>
                <div class="clearit"></div>
            </div>
            <div class="league_match">
            	<a href="${ctx}/league/eventRecords?league_id=${league_id}" class="more">全部赛程</a>
                <div class="league_title">
                    <span class="ms f18">联赛预告</span>
                </div>
                <div id="event_forecast" class="day_of_play">
                    <ul data-id="pdate" class="day">
                    </ul>
                    <div class="concrete">
                        <div class="timeinfo">
                            <ul data-id="ptime" id="time">
                            </ul>
                        </div>
                        <div data-id="pdata" class="clash">
                            
                        </div>
                    </div>
                </div>
                <div class="league_info">
                    <div class="league_l">
                        <div class="league_pic">
                            <a href="${ctx}/indexIvList?type=imagelist" class="more" style="top:-16px;">更多</a>
                            <div class="league_title">
                                <span class="ms f18">联赛图片</span>
                            </div>
                            <div style="min-height: 297px;">
                            <div id="amazingslider-wrapper-1" style="display:block;position:relative;max-width:580px;padding-left:0px; padding-right:80px;margin:5px auto 0px;">
                                <div id="amazingslider-1" style="display:block;position:relative;margin:0 auto;">
                              		  <!-- 联赛图片区域 -->
                                </div>
                            </div>
                            </div>
                            <div class="ranking" style="width: 340px;float: left;">
                                <div class="integral_list">
                                    <div class="league_title" style="position: relative;">
                                        <a href="${ctx}/league/integralList?league_id=${league_id}" class="more">更多</a>
                                        <span class="ms f18">积分榜</span>
                                    </div>
                                    <div class="i_list">
                                        <ul>
                                        	<c:choose>
                                        		<c:when test="${!empty groups }">
                                        			<c:forEach items="${groups}" var="item" varStatus="num">
				                                         <li class="f16 ms <c:if test="${num.index eq 0 }">active</c:if>" dataAttr="${item.id}" onclick="loadIntegral(this,'${item.id}')">${item.name }</li>
                                        			</c:forEach>
                                        		</c:when>
                                        	</c:choose>
                                            <div class="clearit"></div>
                                        </ul>

                                    </div>
                                    <div class="l_fenge"></div>
                                    <div style="min-height: 130px;">
	                                    <table class="jifen">
		                                    <tbody id="jifenArea">
		                                    	<!-- 积分榜数据 -->
		                                    </tbody>    
	                                    </table>
                                    </div>
                                </div>
                                <div class="integral_list">
                                    <div class="league_title" style="position: relative;">
                                        <a href="${ctx}/league/scorerRank?league_id=${league_id}" class="more" id="more">更多</a>
                                        <a href="${ctx}/league/toCard?league_id=${league_id}" class="more" id="more2">更多</a>
                                        <span class="ms f18" style="cursor: pointer;" onclick="loadScorer()" id="ss">射手榜</span>
                                        <span class="ms f18 ml10">|</span>
                                        <span class="ms f18 ml10" style="cursor: pointer;" onclick="loadCard()" id="hh">红黄榜</span>
                                    </div>
									<div style="min-height: 130px;">
	                                    <table class="jifen">
	                                        <tbody id="scorerArea">
	                                        	<!-- 射手榜数据 -->
	                                        </tbody>
	                                    </table>
									</div>
                                </div>
                            </div>
                            <div class="league_news">
                                <div class="league_title" style="position: relative;margin-top: 10px;">
                                    <a href="${ctx}/news?model_id=${league_id}" class="more">更多</a>
                                    <span class="ms f18">联赛新闻</span>
                                </div>
                                <dl id="newsArea">
                                	<!-- 新闻展示区域 -->
                                </dl>
                            </div>
                            <div class="clearit"></div>

                        </div>
                    </div>
                    <div class="league_r">
                        <div class="league_title" style="position: relative;">
                            <a href="${ctx}/indexIvList?type=videolist" class="more" style="top:-25px;">更多</a>
                            <span class="ms f18">联赛视频</span>
                        </div>
                       <div id="iv_area">
                        <img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: relative;width: 40px;height: 40px;left: 145px;margin-top: 45px;">
                        <!-- 赛事视频区域 -->
                       </div>
                    </div>
                    <div class="clearit"></div>
                </div>
                <div class="worth">
                 
                    <div class="league_title">
                        <span class="text-white f18 ms">身价榜</span>
                    </div>
                    <style>
                    </style>
                    <div class="exh_area">
                        <ul class="high">
                            <li class="active" onclick="loadPriceSlave(this,'1')">累计最高</li>
                            <li onclick="loadPriceSlave(this,'2')">单次最高</li>
                            <div class="clearit"></div>
                        </ul>
                        <div class="l_fenge"></div>
                        <div class="tostart">
                         <button class="btn toStart" style="display: none;">toStart</button>
                                                    <span class="s_prev"></span>
                            <span class="s_next"></span>
                            <div class="frame" id="worther">
                            	<!-- 球员身价展示区域 -->
                            	<ul id="slavePlayer">
                            	
                            	</ul>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
   
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/js/plugins.js"></script>
    <script src="${ctx}/resources/js/sly.js"></script>
    <script src="${ctx}/resources/sliderengine/amazingslider.js"></script>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
	<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
	<script src="${ctx}/resources/js/own/index_new.js"></script>
    <script type="text/javascript">
    //赛程比赛切换效果
    function match(id) {
            var $frame = $(id);
            var $wrap = $frame.parent();
            $frame.sly({
                horizontal: 1,
                itemNav: 'smart',
                smart: 4,
                activateMiddle: 1,
                touchDragging: 1,
                releaseSwing: 1,
                startAt: 0,
                scrollBy: 1,
                speed: 300,
                elasticBounds: 1,
                easing: 'easeOutExpo',
                dragHandle: 1,
                dynamicHandle: 1,
                clickBar: 2,
                prev: $wrap.find('.lea_prev'),
                next: $wrap.find('.lea_next')
            });
            
        };

        function frame(id) {
            var $frame = $(id);
            var $wrap = $frame.parent();
            $frame.sly({
                horizontal: 1,
                itemNav: 'forceCentered',
                smart: 0,
                activateMiddle: 1,
                touchDragging: 1,
                releaseSwing: 1,
                startAt: 0,
                scrollBy: 1,
                speed: 300,
                elasticBounds: 1,
                easing: 'easeOutExpo',
                dragHandle: 1,
                dynamicHandle: 1,
                clickBar: 1,
                prev: $wrap.find('.s_prev'),
                next: $wrap.find('.s_next')
            });
            $wrap.find('.toStart').on('click', function () {
                var item = $(".tostart").data('item');
                $frame.sly('toStart', item);
            });
        };
        
        $(function(){
        	//初始化赛程记录数据
        	//loadEventRecord($(".match_time ul li:first"));
        	//比赛预告
        	loadEventForecast();
        	//初始化联赛图片
        	loadLeaguePhotos();
        	//初始联赛视频
        	loadImageVideos();
        	//初始化新闻信息
        	loadNews();
        	//初始化积分榜
        	loadIntegral($(".i_list ul li:first"),$(".i_list ul li:first").attr("dataAttr"));
        	//初始射手榜数据
        	loadScorer();
        	//初始化球员累计身价榜
        	priceSlaveAdd();
        })
        var forecast_datas = null;
       	var load_html = '<img alt="数据加载中" loading src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 480px;margin-top:-30px;">';
        function loadEventForecast(){
        	$.ajax({
        		type:"POST",
        		url:base+"/league/queryEventForecast",
        		dataType:"JSON",
        		data:{"league_id":$("#league_id").val()},
        		beforeSend:function(data){
        			$("#event_forecast").append(load_html);
        		},
        		success:function(data){
        			if(data.state=='success'){
        				if(data.data==null){
        					$("#event_forecast").empty().append('<div style="color: red;width:100%;text-align:center;">暂无联赛预告数据...</div>');
        				}else{
	        				forecast_datas = data.data.forecasts;
	        				create_forecast_date();
        				}
        			}else{
        				$("#event_forecast").empty().append('<div style="color: red;width:100%;text-align:center;">暂无联赛预告数据...</div>');
        			}
        			$("#event_forecast").find('[loading]').remove();
        		}
        	});
        }
        
        function create_forecast_date(){
        	var model = $("#event_forecast");
        	var mdate = model.find("[data-id=pdate]");
        	var date_list = forecast_datas.date_list;
        	mdate.empty();
        	var no1_date = '';
        	for (var i in date_list) {
        		if(i==0){
        			no1_date = date_list[i].pdate;
        			mdate.append('<li val="'+date_list[i].pdate+'" class="active">'+date_list[i].pdate+'</li>');
        		}else{
	        		mdate.append('<li val="'+date_list[i].pdate+'" class="">'+date_list[i].pdate+'</li>');
        		}
			}
        	mdate.append('<div class="clearit"></div>');
        	create_forecast_time(no1_date);
        }
        var interval;
        function create_forecast_time(pdate){
        	var model = $("#event_forecast");
        	var mtime = model.find("[data-id=ptime]");
        	var date_list = forecast_datas.date_list;
        	mtime.empty();
        	var no1_time = '';
        	for (var i in date_list) {
        		var pd = date_list[i].pdate;
        		if(pdate==pd){
        			var ts = date_list[i].ptimes;
        			for(var j in ts){
        				if(j==0){
        					no1_time = ts[j];
        					mtime.append('<li valdate="'+pdate+'" valtime="'+ts[j]+'" index="'+(parseInt(j)+1)+'" class="active">'+ts[j]+'</li>');
        				}else{
        					mtime.append('<li valdate="'+pdate+'" valtime="'+ts[j]+'" index="'+(parseInt(j)+1)+'" class="">'+ts[j]+'</li>');
        				}
        			}
        		}
			}
        	mtime.append('<div class="clearit"></div>');
        	var adayli = $(".day li");
            var atimeli = $(".timeinfo li");
            var tlen = atimeli.length;

            adayli.each(function () {
                $(this).mouseover(function () {
                	if(!$(this).hasClass("active")){
                    	$(this).addClass("active").siblings().removeClass("active");
                    	var val = $(this).attr("val");
                    	create_forecast_time(val);
                	}
                });
            });

            atimeli.each(function () {
                $(this).mouseover(function () {
                	if(!$(this).hasClass("active")){
                    	$(this).addClass("active").siblings().removeClass("active");
                    	var valdate = $(this).attr("valdate");
                    	var valtime = $(this).attr("valtime");
                    	create_forecast_data(valdate,valtime);
                    	var num = $(this).attr("index");
                        i = num;
                        return i;
                	}
                });
            });
            var i = 0;
            function autoSelect() {
                $("#time li").eq(i).trigger("mouseover");
                i++;
                if (i > tlen) {
                    i = 0;
                }
            }
            if(interval){
            	clearInterval(interval);
            }
            interval = setInterval(autoSelect, 3000);
        	create_forecast_data(pdate,no1_time);
        }
        
        function create_forecast_data(pdate,ptime){
        	var model = $("#event_forecast");
        	var mdata = model.find("[data-id=pdata]");
        	var maps = forecast_datas.forecasts;
        	var key = pdate+"_"+ptime;
        	var datas = maps[key];
        	mdata.empty();
        	for(var i in datas){
        		var html = '<table class="tab'+(parseInt(i)+1)+'"><tr><td valign="top"><div class="response"><dl>';
        		html+='<dt><img src="'+ossPath+datas[i].mlogo+'" alt="" class="l_logo" style="cursor: pointer;" onclick="window.open(\'${ctx}/team/tdetail/'+datas[i].m_teaminfo_id+'.html\')"/></dt>';
        		html+='<dd><span class="f14 text-white ms" style="cursor: pointer;" onclick="window.open(\'${ctx}/team/tdetail/'+datas[i].m_teaminfo_id+'.html\')">'+datas[i].mname+'</span></dd>';
        		html+='</dl></div></td><td valign="top" class="two"><dl>';
        		html+='<dt><img src="${ctx}/resources/images/l_vs.png" alt="Alternate Text" /></dt>';
        		html+='<dd><span class="text-white ms">'+datas[i].position+'</span></dd>';
        		html+='</dl></td><td valign="top"><div class="response"><dl>';
        		html+='<dt><img src="'+ossPath+datas[i].glogo+'" alt="" class="l_logo" style="cursor: pointer;" onclick="window.open(\'${ctx}/team/tdetail/'+datas[i].g_teaminfo_id+'.html\')"/></dt>';
        		html+='<dd><span class="f14 text-white ms" style="cursor: pointer;" onclick="window.open(\'${ctx}/team/tdetail/'+datas[i].g_teaminfo_id+'.html\')">'+datas[i].gname+'</span></dd>';
        		html+='</dl></div></td></tr></table>';
        		mdata.append(html);
        	}
        	mdata.append('<div class="clearit"></div>');
        }
        
        //载入赛程记录
        function loadEventRecord(dom){
        	var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 434px;margin-top: 35px;">';
        	var play_time = $(dom).text();
        	$(dom).addClass("active").siblings().removeClass("active");
        	$.ajax({
        		type:"POST",
        		url:base+"/league/event",
        		dataType:"HTML",
        		data:{"play_time":play_time,"league_id":$("#league_id").val()},
        		beforeSend:function(data){
        			$("#eventRecords").empty();
        			$("#eventRecords").append(tempHtml);
        		},
        		success:function(data){
        			$("#eventRecords").empty();
        			$("#eventRecords").append(data);
        			match("#match");
        		}
        	});
        }
        
        //载入联赛图片
        function loadLeaguePhotos(){
        	var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 316px;margin-top: 128px;">';
        	$.ajax({
        		type:"POST",
        		url:base+"/league/images",
        		data:{"league_id":$("#league_id").val(),if_show:'1'},
        		dataType:"HTML",
        		beforeSend:function(){
        			$("#amazingslider-1").empty();
        			$("#amazingslider-1").append(tempHtml);
        		},
        		success:function(data){
        			$("#amazingslider-1").empty();
        			$("#amazingslider-1").append(data);
        		}
        	});
        }
        
      //赛程视频
    	function loadImageVideos(){
    		$.ajax({
    			type:"POST",
    			url:base+"/league/ivs",
    			data:{"league_id":$("#league_id").val(),if_show:'1'},
    			dataType:"HTML",
    			success:function(data){
    				$("#iv_area").empty();
    				$("#iv_area").append(data);
    			}
    		});
    	}

      //载入新闻信息
      function loadNews(){
    	  var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 490px;margin-top: 128px;">';
      	$.ajax({
      		type:"POST",
      		url:base+"/league/news",
      		data:{"league_id":$("#league_id").val()},
      		dataType:"HTML",
      		beforeSend:function(){
      			$("#newsArea").empty();
      			$("#newsArea").append(tempHtml);
      		},
      		success:function(data){
      			$("#newsArea").empty();
      			$("#newsArea").append(data);
      		}
      	});
      }
      
      //积分榜数据
      function loadIntegral(dom,group_id){
	      $(dom).addClass("active").siblings().removeClass("active");
    	  var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 150px;margin-top: 90px;">';
        	$.ajax({
        		type:"POST",
        		url:base+"/league/integral",
        		data:{"league_id":$("#league_id").val(),"group_id":group_id,"pageSize":"4"},
        		dataType:"HTML",
        		beforeSend:function(){
        			$("#jifenArea").empty();
        			$("#jifenArea").append(tempHtml);
        		},
        		success:function(data){
        			$("#jifenArea").empty();
        			$("#jifenArea").append(data);
        		}
        	});
      }
      
      //射手榜数据
        function loadScorer(){
    	  var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 150px;margin-top: 70px;">';
        	$.ajax({
        		type:"POST",
        		url:base+"/league/scorer",
        		data:{"league_id":$("#league_id").val(),"pageSize":"4"},
        		dataType:"HTML",
        		beforeSend:function(){
        			$("#scorerArea").empty();
        			$("#scorerArea").append(tempHtml);
        		},
        		success:function(data){
        			$("#scorerArea").empty();
        			$("#scorerArea").append(data);
        			$("#more").show();
        			$("#more2").hide();
        			$("#ss").css("color","#fff");
        			$("#hh").css("color","#999");
        		}
        	});
      }
      //红黄榜数据
        function loadCard(){
    	  var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 150px;margin-top: 70px;">';
        	$.ajax({
        		type:"POST",
        		url:base+"/league/cardList?random"+Math.random(),
        		data:{league_id:$("#league_id").val(),"pageSize":"4"},
        		dataType:"HTML",
        		beforeSend:function(){
        			$("#scorerArea").empty();
        			$("#scorerArea").append(tempHtml);
        		},
        		success:function(data){
        			$("#scorerArea").empty();
        			$("#scorerArea").append(data);
        			$("#more2").show();
        			$("#more").hide();
        			$("#ss").css("color","#999");
        			$("#hh").css("color","#fff");
        		}
        	});
      }
      
      //宝贝榜数据
        function loadUserCard(){
    	  var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 150px;margin-top: 70px;">';
        	$.ajax({
        		type:"POST",
        		url:base+"/league/userCard?random"+Math.random(),
        		data:{"pageSize":"4"},
        		dataType:"HTML",
        		beforeSend:function(){
        			$("#scorerArea").empty();
        			$("#scorerArea").append(tempHtml);
        		},
        		success:function(data){
        			$("#scorerArea").empty();
        			$("#scorerArea").append(data);
        		}
        	});
      }
      
      
      //身价榜累计最高
      function priceSlaveAdd(){
    	  var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 476px;margin-top: 48px;">';
      	$.ajax({
      		type:"POST",
      		url:base+"/league/slaveAdd?random="+Math.random(),
      		data:{"league_id":$("#league_id").val(),"pageSize":"10"},
      		dataType:"HTML",
      		beforeSend:function(){
      			$("#slavePlayer").empty();
      			$("#slavePlayer").append(tempHtml);
      		},
      		success:function(data){
      			$("#slavePlayer").empty();
      			$("#slavePlayer").append(data);
      			frame('#worther');
      		}
      	});
      }
      
      //身家榜单次最高
      function priceSlaveSingle(){
    	  var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 476px;margin-top: 48px;">';
        	$.ajax({
        		type:"POST",
        		url:base+"/league/slaveSingle?random="+Math.random(),
        		data:{"league_id":$("#league_id").val(),"pageSize":"10"},
        		dataType:"HTML",
        		beforeSend:function(){
        			$("#slavePlayer").empty();
        			$("#slavePlayer").append(tempHtml);
        		},
        		success:function(data){
        			$("#slavePlayer").empty();
        			$("#slavePlayer").append(data);
        			frame('#worther');
        		}
        	});
      }
      
      function loadPriceSlave(dom,num){
    	  $(dom).addClass("active").siblings().removeClass("active");
    	  if(num==1){
    		  $(".toStart").trigger("click");
        	  priceSlaveAdd();
    	  }else if(num==2){
    		  $(".toStart").trigger("click");
    		  priceSlaveSingle();
    	  }
      }
      
      
      
        $(".closeVideoDeatail").click(function () {
            $("#a1").html("");
            $(".masker").hide();
            $("#msg_content").val("");
            $('#video_detail').hide();
        });
        create_commont_list();
    </script>
</body>
</html>
