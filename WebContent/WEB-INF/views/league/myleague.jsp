<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>我的联赛</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<style type="text/css">
.list li a{
	color: #666;
}
#showVideo{
	z-index: 99;
}
.showvdo {
     position: relative;
 }

 #playSWF {
     position: absolute;
     width: 20px;
     height: 20px;
     right: 0px;
     top: -18px;
     cursor: pointer;
     z-index: 9999;
 }
</style>
</head>
<body>
<input type="hidden" id="teaminfo_id" value="${teamMap.id}"/>
<input type="hidden" id="league_id" value="${league_id}"/>
 <div class="warp">
 	<div class="masker"></div>
         <!--头部-->
         <%@ include file="../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
            <div class="my_league">
                <div class="l_trailer" style="">
                    <div class="l_title" style="position: relative;">
                       <!--  <a href="#" class="more"></a> -->
                        <span class="ms f18">赛事预告</span>
                    </div>
                    <div class="playing_area">
                    	<c:choose>
                    		<c:when test="${empty data}"><font style="color: red;margin-left: 10px;">暂无数据...</font></c:when>
                    		<c:otherwise>
                    		 <ul>
	                            <li>
	                                <dl>
	                                    <dt>
	                                        <img class="zhuchang" src="${el:headPath()}${data.m_logo}" onerror="this.src='${ctx}/resources/images/zhu.png'" onclick="javascript:window.location='/team/tdetail/${data.m_teaminfo_id}'"/>
	                                    </dt>
	                                    <dd><a href="${ctx}/team/tdetail/${data.m_teaminfo_id}" class="text-white"><span>${data.m_team_name}</span></a></dd>
	                                    <!--  <dd><span>俱乐部</span></dd> -->
	                                </dl>
	                            </li>
	                            <li>
	                                <dl>
	                                    <dt>
	                                        <img src="${ctx}/resources/images/vsImg.png" style="width: 122px;height: 53px;margin-top: 10px;" />
	                                    </dt>
	                                </dl>
	                            </li>
	                            <li>
	                                <dl>
	                                    <dt>
	                                        <img class="kechang" src="${el:headPath()}${data.g_logo}" onerror="this.src='${ctx}/resources/images/zhu.png'" onclick="javascript:window.location='/team/tdetail/${data.g_teaminfo_id}'"/>
	                                    </dt>
	                                    <dd><a href="${ctx}/team/tdetail/${data.g_teaminfo_id}" class="text-white"><span>${data.g_team_name}</span></a></dd>
	                                   <!--  <dd><span>俱乐部</span></dd> -->
	                                </dl>
	                            </li>
	                            <div class="clearit"></div>
	                        </ul>
	                        <ul class="l_b_info">
	                            <li>
	                                <dl>
	                                    <dt>
	                                        <span>
	                                        	<fmt:formatDate value="${data.play_time}" pattern="yyyy-MM-dd"/>
	                                        </span>
	                                    </dt>
	                                    <dd>
	                                    	<span>
	                                    		<fmt:formatDate value="${data.play_time}" pattern="HH:mm"/>
	                                    	</span>
	                                   	</dd>
	                                </dl>
	                            </li>
	                            <li>
	                                <dl class="bian">
	                                    <dt>
	                                        <span>${data.position}</span>
	                                    </dt>
	                                    <!-- <dd><span>7号馆</span></dd> -->
	                                </dl>
	                            </li>
	                            <li>
	                                <dl class="mt10">
	                                    <dt>
	                                        <span>${data.ball_format }人制</span>
	                                    </dt>
	                                </dl>
	                            </li>
	                            <div class="clearit"></div>
	                        </ul>
                    		</c:otherwise>
                    	</c:choose>
                    </div>
                </div>

                <div class="l_news">
                    <div class="l_title" style="position: relative;">
                        <a href="${ctx}/news" class="more"></a>
                        <span class="ms f18">新闻</span>
                    </div>
                    <dl>
                    	<c:choose>
                    		<c:when test="${!empty news.items}">
                    			<c:forEach items="${news.items}" var="item">
	                    		  <dd><a href="${ctx}/news/${item.id}.html" target="_blank">
	                    		  <c:choose>
						            	<c:when test="${!empty item.title&&fn:length(item.title)>20}">
						            	${fn:substring(item.title, 0, 16)}...
						            	</c:when>
						            	<c:otherwise>
						            	${empty item.title?'':item.title}
						            	</c:otherwise>
						            </c:choose>
	                    		  </a></dd>
                    			</c:forEach>
                    		</c:when>
                    		<c:otherwise>
                    			<dd><font style="color: red;">暂无相关新闻</font></dd>
                    		</c:otherwise>
                    	</c:choose>
                    </dl>
                </div>
                <div class="l_club">
                    <div class="l_title" style="position: relative;">
                        <!-- <a href="#" class="more"></a> -->
                        <span class="ms f18">俱乐部</span>
                    </div>
                    <div class="club_info">
                        <div class="logo">
                            <img src="${el:headPath()}${teamMap.logo}" alt="俱乐部头像" />
                        </div>
                        <div class="club_r">
                            <dl>
                                <dt><span class="f16 fw ms jlb">${teamMap.name }</span></dt>
                                <dd class="mt15">
                                    <ul class="zhanji">
                                        <li><span class="s">胜</span><span class="ml10 text-white">${teamMap.win_count}</span></li>
                                        <li><span class="p">平</span><span class="ml10 text-white">${teamMap.draw_count}</span></li>
                                        <li><span class="f">负</span><span class="ml10 text-white">${teamMap.loss_count}</span></li>
                                        <div class="clearit"></div>
                                    </ul>
                                </dd>
                                <dd class="mt15" style="text-align: left;margin-left: 10px;">
                                    
                                        
	                                        <span class="jf">联赛积分<span class="ml10">
	                                        		<c:choose>
	                                        			<c:when test="${!empty teamIntegral.sum_integral}">
	                                        				${teamIntegral.sum_integral}
	                                        			</c:when>
	                                        			<c:otherwise>
	                                        				0
	                                        			</c:otherwise>
	                                        		</c:choose>
	                                       		</span>
	                                        </span>
                                       <span class="js ml10">净胜球<span class="ml10">${teamIntegral.in_ball-teamIntegral.lose_ball }</span></span>
                                </dd>
                            </dl>
                        </div>
                        <div class="clearit"></div>
                    </div>
                     <div id="news">
                        <ul class="list">
                        	<c:choose>
                        		<c:when test="${!empty dynamics.items }">
                        			<c:forEach items="${dynamics.items}" var="item">
			                            <li>
			                                <a href="javasript:void(0)" class="text-gray-s_666">${item.text}</a>
			                            </li>
                        			</c:forEach>
                        		</c:when>
                        		<c:otherwise>
                        			<li>
                        				<font style="color: red;">暂无数据...</font>
                        			</li>
                        		</c:otherwise>
                        	</c:choose>
                        </ul> 
                    </div>
                </div>
                <div class="clearit"></div>

                <div class="my_schedule">
                    <div class="l_title" style="position: relative;">
                        <span class="ms f18">我的赛程</span>
                    </div>
                    <table>
                        <tr>
                            <th style="width: 5%"><span>轮次</span></th>
                            <th><span>时间</span></th>
                            <th><span>主队</span></th>
                            <th style="width: 5%"><span>比分</span></th>
                            <th><span>客队</span></th>
                            <th><span>场地</span></th>
                            <th style="width: 5%"><span>统计</span></th>
                        </tr>
                        <tbody id="myleague_datas">
                       	 <!-- 我的赛程记录 -->
                       	 	<tr>
                       	 		<td colspan="7">
                       	 			<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: relative;width: 40px;height: 40px;left: 310px;margin-top: 12px;">
                       	 		</td>
                       	 	</tr>
                        </tbody>
                    </table>
                </div>
                <div class="league_r" style="width: 330px;margin-top: 20px;">
                    <div class="l_title" style="position: relative;">
                        <%-- <a href="${ctx}/indexIvList?type=videolist" class="more"></a> --%>
                        <span class="ms f18">赛事视频</span>
                    </div>
                    <div id="iv_area">
                        <img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: relative;width: 40px;height: 40px;left: 145px;margin-top: 45px;">
                        <!-- 赛事视频区域 -->
                    </div>
                </div>
                <div class="clearit"></div>
                <div class="wonderful_pic mt20">
                    <div class="l_title" style="position: relative;">
                        <%-- <a href="${ctx}/indexIvList?type=imagelist" class="more"></a> --%>
                        <span class="ms f18">精彩图片</span>
                    </div>
                    <div class="pic_area" id="pic_area">
                       <img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: relative;width: 40px;height: 40px;left: 145px;margin-top: 45px;">
                        <!-- 精彩图片区域 -->
                    </div>
                </div>

                <div class="club_member mt20">
                    <div class="l_title">
                        <ul class="role">
                            <li class="active" onclick="loadData(this,'shooter')">射手榜</li>
                            <li onclick="loadData(this,'stage')">出场榜</li>
                            <li onclick="loadData(this,'front')">前场</li>
                            <li onclick="loadData(this,'midfield')">中场</li>
                            <li onclick="loadData(this,'back')">后场</li>
                            <li onclick="loadData(this,'gate')">守门员</li>
                            <li onclick="loadData(this,'baby')">宝贝</li>
                            <div class="clearit"></div>
                        </ul>
                        <span class="ms f18">俱乐部成员</span>
                    </div>
                    <style>

                    </style>
                    <div class="role_pic" id="team_role">
                        <!-- 俱乐部成员信息 -->
                    </div>
                </div>
                <div class="clearit"></div>
            </div>
        </div>
    </div>
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
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
	<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
    <script src="${ctx}/resources/js/own/index_new.js"></script>
    <script type="text/javascript">
    	$(function(){
    		 setInterval('autoScroll("#news")', 4000);
             $("#news .list a").each(function () {
                 var maxwidth = 25;
                 if ($(this).text().length > maxwidth) {
                     $(this).text($(this).text().substring(0, maxwidth));
                     $(this).html($(this).html() + '…');
                 }
             });
    		
    		loadmyleagueDatas();
    		loadImageVideos();
    		loadImages();
    		//俱乐部成员：射手榜信息
    		loadData("","shooter");
    		
    		layer.config({
    		    extend: '/extend/layer.ext.js'
    		});
    	});
    	
    	 //新闻滚动功能
        function autoScroll(obj) {
            $(obj).find(".list").animate({
                marginTop: "-25px"
            }, 500, function () {
                $(this).css({ marginTop: "0" }).find("li:first").appendTo(this);
            });
        }
    	
    	//我的赛程
    	function loadmyleagueDatas(){
    		$.ajax({
    			type:"POST",
    			url:base+"/myleague/history",
    			data:{"league_id":$("#league_id").val()},
    			dataType:"HTML",
    			success:function(data){
    				$("#myleague_datas").empty();
    				$("#myleague_datas").append(data);
    			}
    		});
    	};
    	//赛程视频
    	function loadImageVideos(){
    		$.ajax({
    			type:"POST",
    			url:base+"/myleague/ivs",
    			data:{"league_id":$("#league_id").val()},
    			dataType:"HTML",
    			success:function(data){
    				$("#iv_area").empty();
    				$("#iv_area").append(data);
    			}
    		});
    	}
    	//精彩图片
    	function loadImages(){
    		$.ajax({
    			type:"POST",
    			url:base+"/myleague/images",
    			data:{"league_id":$("#league_id").val()},
    			dataType:"HTML",
    			success:function(data){
    				$("#pic_area").empty();
    				$("#pic_area").append(data);
    				layer.ready(function(){
    			        layer.photos({
    			            photos: '#pic_area'
    			        });
    			    });
    			}
    		});
    	}
    	
    	//加载俱乐部成员信息
    	function loadData(dom,pageName){
    		var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 280px;margin-top: 60px;">';
    		$(dom).addClass("active").siblings().removeClass("active");
    		$.ajax({
    			type:"POST",
    			url:base+"/myleague/teamInfo/"+pageName,
    			data:{"teaminfo_id":$("#teaminfo_id").val(),league_id:$("#league_id").val()},
    			dataType:"HTML",
    			beforeSend:function(){
    				$("#team_role").empty();
    				$("#team_role").append(tempHtml);
    			},
    			success:function(data){
    				$("#team_role").empty();
    				$("#team_role").append(data);
    				$("#team_role").find("#baby").show();
    				$($(".role_ranking")).each(function () {
        	            $(this).mouseover(function () {
        	                $(this).find(".role_info").show();
        	            }).mouseout(function () {
        	                $(this).find(".role_info").hide();
        	            });
        	        });
    			}
    		});
    		
    	}
    	
    	

        $(".closeVideoDeatail").click(function () {
            $("#a1").html("");
            $(".masker").hide();
            $("#msg_content").val("");
            $('#video_detail').hide();
        });
      
        //123
        
        create_commont_list();
    </script>
</body>
</html>
