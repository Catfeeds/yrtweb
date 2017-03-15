<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-个人中心</title>
<!--IE 浏览器运行最新的渲染模式下-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<c:set var="now" value="<%=new java.util.Date()%>" />
<link href="${ctx}/resources/css/center.css" rel="stylesheet" />
<link href="${ctx}/resources/js/Canlendar/ccCanlendar.css" rel="stylesheet">
<link href="${ctx}/resources/admin/css/chosen.min.css" rel="stylesheet">
<style type="text/css">
.activation{
	float: left;
	margin-left: 360px;
	margin-top: 31px;
	font-size: 25px;
	cursor: pointer;
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
<c:set var="currentPage" value="CENTER"/>
<body>
 <div id="showVideo"><img id="playSWF" src="${ctx}/resources/images/close.png"/><div id="a1" class="showvdo"></div></div>
 	<div class="trial" style="display: none;">
 		<form id="trialFrom" action="${ctx}/player/saveTrial" method="post">
 		<input type="hidden" name="user_id" value="${oth_user_id}" />
 		<input type="hidden" name="s_user_id" id="s_user_id" value="${session_user_id}" />
        <table>
            <tr>
                <td class="r"><span>试训人：</span></td>
                <td><span data-id="usernick" ></span></td>
            </tr>
            <tr>
                <td class="r"><span>试训时间：</span></td>
                <td><input id="trial_tdate" name="tdate" class="form-control" type="text" value="" valid="require" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="r"><span>试训地点：</span></td>
                <td><input type="text" name="trail_position" valid="require" value="" /></td>
            </tr>
            <tr>
                <td class="r" valign="top"><span>其他：</span></td>
                <td><textarea name="trail_other"></textarea></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="button" onclick="$.ajaxSubmit('#trialFrom','#trialFrom',trialFormHandler)" value="确定" /><input type="button" onclick="trialHide()" value="取消" class="ml65"/>
                </td>
            </tr>
        </table>
        </form>
        <div class="clearit"></div>
    </div>
    <div class="warp">
         <!--头部-->
		 <%@ include file="../common/header.jsp" %>
		 <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <div class="wrapper" style="margin-top: 220px; border: 3px solid rgba(255,255,255,0.2);">
        	<input type="hidden" id="oth_user_id" value="${oth_user_id}"/>
           	<%@ include file="user.jsp" %>
            <div class="p_center">
                <div class="cen_l">

                    <div id="questions">
                        <ul id="questionList" class="foldList clearfix">
                            <li class="" index="1">
                                <div class="player_info" date-index="1" style="cursor: pointer;">
                                	<span data-id="activate" onclick="player_activation()"; id="player_act_btn" class="activation ms text-white" style="display: none;">激&emsp;活</span>
                                	<div data-id="playerBtn" class="pull-right  mt45" style="display: none;">
                                		<sec:authorize ifAnyGranted="${resources.get('/player/inviteTrial')}">
                                        <input type="button" onclick="trialShow()" value="邀请试训" class="invitation_btn ms" />
                                        <input type="button" onclick="inviteTTPA()" value="邀请入队" class="add_playerbtn  ms" />
                                        </sec:authorize>
                                        <%-- <sec:authorize ifAnyGranted="${resources.get('/agent/signByAgent')}">
                                        <input type="button" onclick="inviteATPQ()" value="申请签约" class="signbtn  ms" />
                                        </sec:authorize> --%>
                                    </div>
                                    <div class="clearit"></div>
                                </div>
                                <div id="playerContent" class="foldContent" style="display: block;">
                                </div>
                            </li>
                            <!-- <li class="" index="2">
                            			 <div class="brokers_info"  date-index="1" id="agentDiv">
			                            	
                            			 </div>
                                <div class="foldContent" id="jjr">
									此处展示经纪人信息start
									<div id="jjr_content"></div>
									此处展示经纪人信息end
                                    <div class="clearfix"></div>
                                    <div class="qy_end">
                                        <span class="ms f20 text-white">经纪人已签约球员</span>
                                    </div>
                                    <div id="agent_players">
	                                    
	                                    	已签约球员列表
	                                    
                                    </div>
                                    图片和视频
                                    <div id="agent_img_vdo">
                                    </div>
                                    <div>　</div>
                                </div>
                            </li> -->
                            <li class="" index="3">
                        	<div class="coach_info" date-index="1" id="coachDiv" style="cursor: pointer;">
                           
							</div>                         
                                <div class="foldContent" id="coach">
                                	<!-- 教练员基本信息start -->
                                		<div id="coachInfo"></div>
                                	<!-- 教练员基本信息end -->
                                    <div class="career">
                                        <span class="pull-left ml15 fw text-white ms f16">荣誉</span>
                                        <c:if test="${session_user_id eq oth_user_id}">
                                       	 <span class="pull-right yt_editer" onclick="editCoachHonor()"></span>
                                        </c:if>
                                        <div class="clearit"></div>
                                    </div>
                                    <div class="zs">
                                        <!-- 教练员荣誉start -->
                                        <div id="coachHonors"></div>
                                        <!-- 教练员荣誉end -->
                                    </div>
                                    <div class="career">
                                        <span class="pull-left ml15 fw text-white f16 ms">任职俱乐部</span>
                                        <c:if test="${session_user_id eq oth_user_id}">
                                       	 <span class="pull-right yt_editer" onclick="editCoachCareers()"></span>
                                        </c:if>
                                        <div class="clearit"></div>
                                    </div>
                                    <div class="zs">
                                        <!-- 教练员任职经历start -->
                                        <div id="coachCareers"></div>
                                        <!-- 教练员任职经历end -->
                                    </div>
                                </div>
                            </li>


                        </ul>
                    </div>
                </div>
                <div class="cen_r">
                	
                    <div class="title">
                        <span class="text-white ms ml20">访客记录</span>
                    </div>
                	<div id="sysvisitor">
	                   
                    </div>
                    <div class="title">
                        <span class="text-white ms ml20">已关注</span>
                       
                    </div>
                    <ul class="atten_list" id="sysfollow">
                    </ul>
                    <div class="clearit"></div>
					<%-- <c:if test="${session_user_id eq oth_user_id}">
	                    <div class="title mt20">
	                        <span class="text-white ms ml20">系统消息</span>
	                    </div>
	                    <div class="letter" id="sysmsg">
	                       
	                    </div>
	               </c:if>     --%> 
                </div>
                <div class="clearit"></div>
            </div>
        </div>
    </div>
   <%@ include file="../common/footer.jsp" %>
	<script src="${ctx}/resources/js/jquery.dragsort-0.5.1.min.js"></script>
	<script src="${ctx}/resources/vmodel/Filter.js"></script>
	<script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
	<script src="${ctx}/resources/vmodel/vmodel.js"></script>
	<script src="${ctx}/resources/js/area.js"></script>
	<script src="${ctx}/resources/js/sly.js"></script>
	<script src="${ctx}/resources/js/plugins.js"></script>
	<script src="${ctx}/resources/js/sly.main.js"></script>
	<script src="${ctx}/resources/js/mouse.js"></script>
	<script src="${ctx}/resources/js/Canlendar/ccCanlendar.js"></script>
	<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
	<script src="${ctx}/resources/admin/js/jquery.chosen.min.js"></script>
	<script src="${ctx}/resources/js/own/center.js"></script>
    <script type="text/javascript">
    
    $("#trial_tdate").ccCanlendar({
    	iniValue:false,
    	startYear:1970,
    	hasHourPanel:false,
    	hasMinitePanel:false,
    	autoSetMinLimit:false,
    	showNextMonth:false,
    	minLimit:'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" />'
    });
    jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }
    function showVideo(video){
    	
	}
	var btn = $("#playSWF");
    btn.click(function () {
        $("#showvdo").html("");
        $('#showVideo').hide();
        $(".login_masker").hide();
    });
    $(function () {
    	//发布说说的控件初始化
    	var uploadeOpts1 = {
    		uploaderType: 'imgUploader',
    		itemWidth: 80,
    		itemHeight: 80,
    		fileNumLimit: 4,
    		fileSingleSizeLimit: 2*1024*1024, /*1M*/
    		fileVal: 'file',
    		server: '${ctx}/imageVideo/uploadFile?filetype=picture',
    		toolbar:{
    			del: true
    		}
    	}
    	$('#upl').fileUploader($.extend({},uploadeOpts1,{inputName:'image'}));
    	
    	var uploadeOpts2 = {
    		uploaderType: 'vdoUploader',
    		showVideo:showVideo,
    		itemWidth: 80,
    		itemHeight: 80,
    		fileNumLimit: 1,
    		fileSingleSizeLimit: 30*1024*1024, /*1M*/
    		fileVal: 'file',
    		server: '${ctx}/imageVideo/uploadFile?filetype=video',
    		toolbar:{
    			del: true
    		}
    	}
    	$('#uplv').fileUploader($.extend({},uploadeOpts2,{inputName:'video'}));
        
		$(".arr_l").mouseover(function () {
            $(this).addClass("active");
        }).mouseout(function () {
            $(this).removeClass("active");
        });


        $(".arr_r").mouseover(function () {
            $(this).addClass("active");
        }).mouseout(function () {
            $(this).removeClass("active");
        });

		$.loadSec("#agentDiv",base+"/center/isAgent",{"oth_user_id":'${oth_user_id}'});
		$.loadSec("#coachDiv",base+"/center/isCoach",{"oth_user_id":'${oth_user_id}'},function(){
			var btnClick = $("#coach_act_btn").attr("onclick");
			if(btnClick){
				$(this).attr("onclick","activation_btn('coach','#coach_act_btn')");
			}
		});
		
        
        //取得当前li顺序
        $("#questionList div[date-index=1]").each(function () {
            $(this).click(function () {
                if ($(this).next(".foldContent").is(":visible")) {
                    $(this).next(".foldContent").stop(true).slideUp();
                }
                if ($(this).next(".foldContent").is(":hidden")) {
                    //$(this).next(".foldContent").stop(true).slideDown();
                    
                    //added by gl 点击对应模块时加载对应数据 start
                    var role_type = $(this).attr("class");
                    var p_btn_flag = $(".player_info").find("#player_act_btn").length>0;
                    var a_btn_flag = $("#agentDiv").find("#agent_act_btn").length>0;
                    var c_btn_flag = $("#coachDiv").find("#coach_act_btn").length>0;
                    if(!p_btn_flag && role_type=="player_info"){
                    	$(this).next(".foldContent").stop(true).slideDown();
                    }
                    if(!a_btn_flag && role_type=="brokers_info"){
                    	$(this).next(".foldContent").stop(true).slideDown();
                    	//loadAgentInfo();
                    }
                    if(!c_btn_flag && role_type=="coach_info"){
                    	$(this).next(".foldContent").stop(true).slideDown();
                    	loadCoachInfo();
                    }
                  //added by gl 点击对应模块时加载对应数据 start
                    
                 	 //added by bo.xie 点击对应模块时加载对应数据 start
                	/* var role_type = $(this).attr("class");
    				if(role_type!="" && role_type=="brokers_info"){
    					loadAgentInfo();
    				}else if(role_type!="" && role_type=="coach_info"){
    					loadCoachInfo();
       				} */
    				//added by bo.xie 点击对应模块时加载对应数据 end
                }
            });
        });

        $(".player_info input[type=button]").click(function() {
            return false;
        });
        $(".brokers_info input[type=button]").click(function () {
            return false;
        });
        $(".coach_info input[type=button]").click(function () {
            return false;
        });

    });
    
    function activation_btn(type,dom){
    	var msg = 'agent'==type?'确定要激活经纪人功能么？':'　　　运筹帷幄，制霸球场';
    	layer.confirm(msg, {
    	    btn: ['确定','取消'], //按钮
    	    shade: false //不显示遮罩
    	}, function(){
    			$(dom).remove();
    			$("#coachDiv").removeAttr("onclick");
    		if('agent'==type){
    			$("#jjr").stop(true).slideDown();
    			loadAgentInfo();
    		}else{
    			$("#coach").stop(true).slideDown();
    			loadCoachInfo();
    		}
   			/* $(dom).attr("flag","1");
   			$("#jjr").trigger('click'); */
   			layer.msg('加载中', {icon: 16,time: 1000});
    	}, function(){});
		
	}

    function shouImageVideoDiv(){
			$("#imageVideos").toggle(function(){
				  $("#imageVideos").show();
			},function(){
				  $("#imageVideos").hide();
			});
    }
    //简练或球员激活后换背景
    $(".player_info").click(function(){
		$(this).css("background","url(${ctx}/resources/images/qiuyuanxinxi_hover.png) no-repeat center");
	});
    $(".coach_info").click(function(){
		$(this).css("background","url(${ctx}/resources/images/jiaolianxinxi.png) no-repeat center");
	});
</script>
</body>
</html>