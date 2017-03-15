<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
<link href="${ctx}/resources/css/master.css" rel="stylesheet" />
<div class="nav">
    <div class="naver">
        <ul class="new_naver">
                    <li style="margin-left: 0;">
                         <c:choose>
           			         <c:when test="${currentPage eq 'INDEX' }">
           			           <div class="m_div active">
		                          <a href="${ctx}/" class="new_c active">首页</a>
		                       </div>
           			         </c:when>
           			         <c:otherwise>
           			           <div class="m_div">
                    	          <a href="${ctx}/" class="new_c">首页</a>  
                    	        </div>   
           			         </c:otherwise>
           		         </c:choose>
                    </li>
                    <li>
                    	<c:choose>
          			        <c:when test="${currentPage eq 'PRODUCT' }">
          			        <div class="m_div active">
          			  	        <a href="${ctx}/shop/index" class="new_c active">宇币夺宝</a>
          			  	         </div>   
          			      </c:when>
          			       <c:otherwise>
          			       <div class="m_div">
                        		<a href="${ctx}/shop/index" class="new_c">宇币夺宝</a>
                        		 </div>   
          			     </c:otherwise>
        		        </c:choose>
                    </li>
                    <li>
                        <div class="m_div">
                        <c:choose>
           			        <c:when test="${currentPage eq 'LEAGUEINDEX' }">
           			        
		                        <a href="${ctx}/league/index" class="new_c active" >联赛<i class="ac"></i></a>
		                    
           			        </c:when>
           			        <c:otherwise>
           			       
           				        <a href="${ctx}/league/index" class="new_c">联赛<i class="ac"></i></a>
           				   
           			        </c:otherwise>
           		        </c:choose>
                    
                        <div class="l_menu">
                            <a href="javascript:window.location='${ctx}/league/selectArea'" class="sss ss_0">赛事报名</a>
                            <a href="javascript:window.location='${ctx}/league/turnTeamChoose'" class="sss ss_1">转会交易</a>
                    		<a href="javascript:window.location='${ctx}/league/toAuction'" class="sss ss_2">球员竞拍</a>
                   			<a href="javascript:window.location='${ctx}/league/toLeague'" class="sss ss_3">赛事选择</a>
                   		    <a href="javascript:window.location='${ctx}/record/toRecord'" class="sss ss_4">赛事数据</a>
                        </div>
                        <div class="ss_0_cs" id="bm_id">
                           
                        </div>
                        <div class="ss_1_cs" id="zh_id">
                           
                        </div>
                        <div class="ss_2_cs" id="jp_id">
                           
                        </div>
                        <div class="ss_3_cs" id="ss_id">
                           
                        </div>
                        <div class="ss_4_cs" id="sj_id">
                           
                        </div>
                         </div>
                    </li>
                    <li> 
                    <div class="m_div">
                        <a href="${ctx}/team/list" class="new_c">俱乐部<i class="ac"></i></a>
                         <div class="my_culb">
                             <!--  <a href="#" class="y_1"></a> -->
                 	          <c:choose>
              			          <c:when test="${currentPage eq 'TEAMDETAIL' }">
              				      <a href="${ctx}/team/guide" class="sss active">我的俱乐部</a>
              			      </c:when>
              			      <c:otherwise>
              				      <a href="${ctx}/team/guide" class="sss">我的俱乐部</a>
              			     </c:otherwise>
              		         </c:choose>
                        </div>
                        </div>
                    </li>
                    <li>
                       <div class="m_div">
                         <a href="${ctx}/player/searchPlayer" class="new_c">球员库</a>
                          </div>
                    </li>
                    <li>
                         <c:choose>
          			         <c:when test="${currentPage eq 'BBS' }">
          			          <div class="m_div active">
		          	            <a href="${ctx}/bbs/list?plate_id=1nO7UrefT7nD2ffffd1" class="new_c active">论坛</a>
		          	          </div>
          			     </c:when>
          			     <c:otherwise>
          			         <div class="m_div">
                  		        <a href="${ctx}/bbs/list?plate_id=1nO7UrefT7nD2ffffd1" class="new_c">论坛</a> 
                  		        </div>           
          			     </c:otherwise>
          		         </c:choose>
                    </li>
                    <li>
                        <c:choose>
           			       <c:when test="${currentPage eq 'BABYINDEX' }">
           			       <div class="m_div active">
           				      <a href="${ctx}/babyIhome/index" class="new_c active">足球宝贝</a>
           				       </div>   
           			    </c:when>
           			    <c:otherwise>
           			     <div class="m_div">
           				      <a href="${ctx}/babyIhome/index" class="new_c">足球宝贝</a>
           				       </div>   
           			    </c:otherwise>
           		        </c:choose>
                        <div class="my_baby">
                           <c:if test="${!empty session_baby_id}">
                    	        <a href="${ctx}/baby/base/baby/${session_baby_id}" class="sss">我是宝贝</a>
                           </c:if>	
                        </div>
                       
                    </li>
                    <li>
                         <c:choose>
          			        <c:when test="${currentPage eq 'CENTER' }">
          			         <div class="m_div active">
          			  	        <a href="${ctx}/center" class="new_c active">个人中心</a>
          			  	         </div>   
          			      </c:when>
          			       <c:otherwise>
          			          <div class="m_div">
          				         <a href="${ctx}/center" class="new_c">个人中心</a>
          				      </div>   
          			     </c:otherwise>
          		          </c:choose>
                    </li>
                    <div class="clearit"></div>
                </ul>
    </div>
</div>
<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
    $(function () {
        //动态子菜单
        $(".y_dynamic_menu").mouseover(function () {
            $(".y_dynamic").addClass("active");
            $(".y_dynamic_sub").show();
        }).mouseout(function () {
            $(".y_dynamic").removeClass("active");
            $(".y_dynamic_sub").hide();
        });

        //球员库子菜单
        $(".y_playerbase_menu").mouseover(function () {
            $(".y_playerbase").addClass("active");
            $(".y_playerbase_sub").show();
        }).mouseout(function () {
            $(".y_playerbase").removeClass("active");
            $(".y_playerbase_sub").hide();
        });

        //俱乐部子菜单
        $(".y_club_menu").mouseover(function () {
            $(".y_club").addClass("active");
            $(".y_club_sub").show();
        }).mouseout(function () {
            $(".y_club").removeClass("active");
            $(".y_club_sub").hide();
        });

        //宝贝子菜单
        $(".y_baby_menu").mouseover(function () {
            $(".y_baby").addClass("active");
            $(".y_baby_sub").show();
        }).mouseout(function () {
            $(".y_baby").removeClass("active");
            $(".y_baby_sub").hide();
        });

        //联赛子菜单
        $(".y_league_menu").mouseover(function () {
            $(".y_league").addClass("active");
            $(".y_league_sub").show();
        }).mouseout(function () {
            $(".y_league").removeClass("active");
            $(".y_league_sub").hide();
        });

        //个人中心子菜单
        $(".y_percenter_menu").mouseover(function () {
            $(".y_percenter").addClass("active");
            $(".y_percenter_sub").show();
        }).mouseout(function () {
            $(".y_percenter").removeClass("active");
            $(".y_percenter_sub").hide();
        });

        
        //联赛二级菜单
        $(".y_league_sub .y_0").mouseover(function() {
        	$(".sj_menu").hide();
        	$(".ss_menu").hide();
        	$(".jp_menu").hide();
        	$(".zh_menu").hide();
            $(".bm_menu").show();
        });
        $(".y_league_sub .y_1").mouseover(function() {
        	$(".sj_menu").hide();
        	$(".ss_menu").hide();
        	$(".jp_menu").hide();
        	$(".bm_menu").hide();
            $(".zh_menu").show();
        });
        $(".y_league_sub .y_2").mouseover(function() {
        	$(".sj_menu").hide();
        	$(".ss_menu").hide();
        	$(".jp_menu").hide();
        	$(".zh_menu").hide();
            $(".bm_menu").hide();
        });
        $(".y_league_sub .y_3").mouseover(function() {
        	$(".sj_menu").hide();
        	$(".ss_menu").hide();
        	$(".bm_menu").hide();
            $(".zh_menu").hide();
            $(".jp_menu").show();
        });
        $(".y_league_sub .y_4").mouseover(function() {
        	$(".sj_menu").hide();
        	$(".ss_menu").hide();
        	$(".bm_menu").hide();
            $(".zh_menu").hide();
            $(".jp_menu").hide();
            $(".ss_menu").show();
        });
        $(".y_league_sub .y_5").mouseover(function() {
        	$(".bm_menu").hide();
            $(".zh_menu").hide();
            $(".jp_menu").hide();
            $(".ss_menu").hide();
            $(".sj_menu").show();
        });
    })
    
    //显示联赛子菜单
        $(".new_naver li").eq(2).mouseover(function () {
            $(".my_culb").hide();
            $(".my_baby").hide();
            $(".l_menu").show();
        });

        $(".new_naver li").eq(3).mouseover(function () {
            $(".l_menu").hide();
            $(".my_baby").hide();
            hideMenu();
            $(".my_culb").show();
        });
        $(".new_naver li").eq(6).mouseover(function () {
            $(".l_menu").hide();
            $(".my_baby").show();
            hideMenu();
            $(".my_culb").hide();
        });
        //隐藏子菜单
        function hidethe() {
            $(".l_menu").hide();
            $(".my_baby").hide();
            hideMenu();
            $(".my_culb").hide();
        }
        $(".new_naver li").eq(0).mouseover(function () {
            hidethe();
        });
        $(".new_naver li").eq(1).mouseover(function () {
            hidethe();
        });
        $(".new_naver li").eq(4).mouseover(function () {
            hidethe();
        });
        $(".new_naver li").eq(5).mouseover(function () {
            hidethe();
        });
        $(".new_naver li").eq(7).mouseover(function () {
            hidethe();
        });

        $(".m_div").each(function () {
            $(this).mouseover(function () {
                $(this).addClass("active");
                $(this).find(".new_c").addClass("active");
                $(this).find(".ac").addClass("active");
            }).mouseout(function () {
                $(this).removeClass("active");
                $(this).find(".new_c").removeClass("active");
                $(this).find(".ac").removeClass("active");
            });
        });



        //$(".new_c").eq(1).mouseover(function () {
        //    $(this).find(".ac").addClass("active");
        //}).mouseout(function () {
        //    $(this).find(".ac").removeClass("active");
        //});

        //$(".new_c").eq(2).mouseover(function () {
        //    $(this).find(".ac").addClass("active");
        //}).mouseout(function () {
        //    $(this).find(".ac").removeClass("active");
        //});


        $(document).click(function (e) {
            if (!$(".l_menu").is(':has(' + e.target.localName + ')') && e.target.id != 'l_menu') {
                $(".l_menu").hide();
            }
            if (!$(".my_culb").is(':has(' + e.target.localName + ')') && e.target.id != 'my_culb') {
                $(".my_culb").hide();
            }
            if (!$(".my_baby").is(':has(' + e.target.localName + ')') && e.target.id != 'my_baby') {
                $(".my_baby").hide();
            }
            hideMenu();
        });

        function hideMenu() {
            $(".ss_0_cs").hide();
            $(".ss_1_cs").hide();
            $(".ss_2_cs").hide();
            $(".ss_3_cs").hide();
            $(".ss_4_cs").hide();
        }


        $(".ss_0").mouseover(function () {
            $(".ss_0_cs").show();
            $(".ss_1_cs").hide();
            $(".ss_2_cs").hide();
            $(".ss_3_cs").hide();
            $(".ss_4_cs").hide();
        });
        $(".ss_1").mouseover(function () {
            $(".ss_0_cs").hide();
            $(".ss_1_cs").show();
            $(".ss_2_cs").hide();
            $(".ss_3_cs").hide();
            $(".ss_4_cs").hide();
        });
        $(".ss_2").mouseover(function () {
            $(".ss_0_cs").hide();
            $(".ss_1_cs").hide();
            $(".ss_2_cs").show();
            $(".ss_3_cs").hide();
            $(".ss_4_cs").hide();
        });
        $(".ss_3").mouseover(function () {
            $(".ss_0_cs").hide();
            $(".ss_1_cs").hide();
            $(".ss_2_cs").hide();
            $(".ss_3_cs").show();
            $(".ss_4_cs").hide();
        });
        $(".ss_4").mouseover(function () {
            $(".ss_0_cs").hide();
            $(".ss_1_cs").hide();
            $(".ss_2_cs").hide();
            $(".ss_3_cs").hide();
            $(".ss_4_cs").show();
        });
    
    //加载动态菜单
    function loadLeagueCfgMenu(){
    	$.ajax({
			type: 'GET',
			url: '${ctx}/league/leagueCfgs',
			data: {},
			dataType:"JSON",
			cache: true,
			success: function(data){
				//赛季数据
				for(var i=0;i<data.length;i++){
					$("#bm_id").append("<a class='sss' href='${ctx}/league/identity?cfg_id="+data[i].id+"' class='sub_chengdu'>"+data[i].area_name+"</a>");
					$("#zh_id").append("<a class='sss' href='${ctx}/playerTrade/list?s_id="+data[i].id+"' class='sub_chengdu'>"+data[i].area_name+"</a>");
					$("#jp_id").append("<a class='sss' href='${ctx}/auction/searchList?s_id="+data[i].id+"' class='sub_chengdu'>"+data[i].area_name+"</a>");
				}
			}
    	});	
    }
    
    //加载动态菜单
    function loadLeagueMenu(){
    	$.ajax({
			type: 'GET',
			url: '${ctx}/league/leagues',
			data: {},
			dataType:"JSON",
			cache: true,
			success: function(data){
				//联赛数据
				for(var i=0;i<data.length;i++){
					$("#ss_id").append("<a class='sss' href='${ctx}/league/index?league_id="+data[i].id+"' class='sub_chengdu'>"+data[i].simple_name+"</a>");
					$("#sj_id").append("<a class='sss' href='${ctx}/record/toRecord?league_id="+data[i].id+"' class='sub_chengdu'>"+data[i].simple_name+"</a>");
				} 
			}
    	});	
    }
    loadLeagueMenu();
    loadLeagueCfgMenu();
</script>