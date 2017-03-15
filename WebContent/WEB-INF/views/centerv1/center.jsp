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
<link href="${ctx}/resources/css/newCenter.css" rel="stylesheet" />
<link href="${ctx}/resources/js/Canlendar/ccCanlendar.css" rel="stylesheet">
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<link href="${ctx}/resources/admin/css/chosen.min.css" rel="stylesheet">
<link href="${ctx}/resources/css/forum.css" rel="stylesheet" />
</head>
<c:set var="currentPage" value="CENTER"/>
<body>
<div class="warp">
<div class="masker"></div>
 <div class="invitation_code">
            <div class="closeBtn_1" onclick="close_activeCode()"></div>
            <p class="ms titles f24">您的俱乐部正等着您的到来</p>
            <p class="ms title_1 f18">请输入您的邀请码</p>
            <input class="activecode" type="text" id="active_code" value="" /><br />
            <input type="button" onclick="activeCodeTeam()" value="激活" class="btn_l ms f18 mt35" />
        </div>
 <!--礼物弹窗-->
<div class="gift_list">
    <div class="closeBtn_1"></div>
    <p class="mt20 f16 ms" style="text-align: center;">礼物列表</p>
    <ul id="gift_ul" class="gift_ul"></ul>
</div>
<!--礼物弹窗END-->
<!--留下印象-->
<div class="burn_in">
    <div class="closeBtn_1" onclick="closeAll();"></div>
    <div class="imp_title">
        <span class="f20 ms text-white">留下印象</span>
    </div>
    <div class="descrip">
        <span class="text-white">请描述对ta的印象：</span><input type="text" id="tag" name="tag" value="" />
    </div>
    <div class="btn_div">
        <input type="button" name="name" value="提交" class="new_btn_l" onclick="save_center_effect();"/>
        <input type="button" name="name" value="取消" class="new_btn_g ml10" onclick="closeAll();"/>
    </div>
</div>
<!--印象弹层-->
<div class="imp_detail"></div>
<!--评价弹层-->
<div class="pla">
	<form id="pla_form" errorType="2" action="${ctx}/center/saveUserComment">
	<input type="hidden" name="s_user_id" value="${oth_user_id}"/>
	<input type="hidden" id="comment_parent_id" name="parent_id" value=""/>
	<input type="hidden" name="type" value="1"/>
    <div class="closeBtn_1"></div>
    <div class="imp_title">
        <span class="f20 ms text-white">评价</span>
    </div>
    <textarea name="content" valid="require len(0,280)" data-text="评价"></textarea>
    <div class="btn_div" style="margin: 20px auto;">
        <input type="button" onclick="$.ajaxSubmit('#pla_form','#pla_form',pla_handler)" value="评价" class="new_btn_l pull-right mr15" />
    </div>
    </form>
</div>
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
<!--头部-->
<%@ include file="../common/header.jsp" %>
<!--导航 start-->
<%@ include file="../common/naver.jsp" %>
<div class="wrapper" style="margin-top: 80px;">
	<input type="hidden" id="oth_user_id" value="${oth_user_id}"/>
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
           <div class="une">
                <span class="jiathis_style_24x24">
                    <span class="pull-left text-white ms f12">分享到：</span>
                    <a class="jiathis_button_tsina"></a>
                    <a class="jiathis_button_tqq"></a>
                    <a class="jiathis_button_weixin"></a>
                    <a class="jiathis_button_renren"></a>
                </span>
                 <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
                <span class="text-white ms f18" id="invitePageCount"></span>
            </div>
            <div class="clearfix"></div>
    <div class="new_center" style="">
    	<div id="editUserInfo" style="display: none;">
    	
    	</div>
    	<div id="showUserInfo">
	    	<div id="center_user_info" style="float: left;width: 678px;">
	    	</div>
	        <div class="impression">
	            <div class="sysinfo">
	       
	                <c:choose>
	                    <c:when test="${empty session_user_id}">
			                <a href="javascript:void(0)" class="enthus" onclick="focus_user(this,'${player.id}')">关注</a>
			                <a href="javascript:void(0);" id="describes" class="text-white" onclick="open_center_effect();">留下印象</a>
							<a href="javascript:sendGift()" class="give">赠礼</a>
		                	<a href="javascript:void(0)" class="private" onclick="openMsg('${session_user_id}','${player.usernick}')">私信</a>	
	                    </c:when>
	                	<c:otherwise>
	                		<c:choose>
				                <c:when test="${oth_user_id eq session_user_id}">
				                    
					                <a href="${ctx}/certificat/player" class="new_btn_l">职业认证</a>
					            </c:when>
				                <c:otherwise>
				                	<c:choose>
				               			<c:when test="${focus eq false}">
						                	<a href="javascript:void(0)" class="enthus" onclick="focus_user(this,'${player.id}')">关注</a>
				               			</c:when>
				               			<c:otherwise>
				               				<a href="javascript:void(0)" class="give" onclick="focus_user(this,'${player.id}',true)">取消关注</a>
				               			</c:otherwise>
				               		</c:choose>	
				               		<a href="javascript:void(0);" id="describes" class="text-white" onclick="open_center_effect();">留下印象</a>
		                            <a href="javascript:sendGift()" class="give">赠礼</a>
		                            <a href="javascript:void(0)" class="private" onclick="openMsg('${oth_user_id}','${player.usernick}')">私信</a>
				                </c:otherwise>
			             	</c:choose>
	                	</c:otherwise>
	                </c:choose>
	            </div>
	            <div class="clearit"></div>
	            <div id="center_user_effect" class="impression_area">
	            </div>
	        </div>
	         <div class="clearit"></div>
    	</div>
        <div class="clearit"></div>
        <div class="new_img_video">
            <div class="title">
                <span class="text-white f16 ms t">精彩瞬间</span>
                <a href="javascript:void(0)" id="center_iv_new" onclick="load_center_iv('',1)" class="active ml10">最新</a> |
                <a href="javascript:void(0)" id="center_iv_video" onclick="load_center_iv('video',1)" class="">视频</a> |
                <a href="javascript:void(0)" id="center_iv_image" onclick="load_center_iv('image',1)" class="">照片</a>
                <div id="center_iv_tools" class="new_tools">
                    <a href="javascript:void(0)" id="upiv" class="new_btn_l" style="color: white;">上传</a>
                    <c:choose>
                    	<c:when test="${isme=='1'}">
                    	<a href="javascript:void(0)" id="moreiv" class="new_btn_l" style="color: white;">编辑</a>
                    	</c:when>
                    	<c:otherwise>
                    	<a href="javascript:void(0)" id="moreiv">更多</a>
                    	</c:otherwise>
                    </c:choose>
                    <ul id="up_new_edit" class="new_edit">
                        <li><a href="javascript:openUpTImgs('image')">图片</a></li>
                        <li><a href="javascript:openUpTImgs('video')">视频</a></li>
                    </ul>
                    <ul id="more_new_edit" class="new_edit" style="right: 1px;">
                        <li><a href="${ctx}/player/photo?oth_user_id=${oth_user_id}">图片</a></li>
                        <li><a href="${ctx}/player/video?oth_user_id=${oth_user_id}">视频</a></li>
                    </ul>
                </div>
                <div class="clearit"></div>
            </div>

            <div id="myall">
            </div>
        </div>
        <style>
        </style>
        <!--球员、教练员切换-->
         <div class="more_role">
             <div class="relative">
                 <div id="new_player" class="active">
                 	<div class="functionality" style="display: none;">
                         <dl data-id="playerBtn" class="yq">
                         	<sec:authorize ifAnyGranted="${resources.get('/player/inviteTrial')}">
                             <dd><span onclick="inviteTTPA()" class="private">邀请入队</span></dd>
                             <dd><span onclick="trialShow()" class="private">邀请试训</span></dd>
                             </sec:authorize>
                         </dl>
                         <a data-id="activate" style="cursor: pointer;" class="pull-right text-white f16 ms">完善资料并激活</a>
                         <div class="clearit"></div>
                     </div>
                 </div>
                 <div id="new_coach">
                 	<div class="functionality">
                         <a class="pull-right text-white f16 ms">暂未开放，敬请期待</a>
                         <div class="clearit"></div>
                     </div>
                 </div>
             </div>
             <div id="center_player">
             </div>
             <div class="clearit"></div>
             <div>
             <div id="center_comments">
             	
             </div>
             <div id="center_visitor" >
             	<!--访客记录-->
                 <div class="new_record">
                     <div class="title">
                         <span class="text-white f16 ms t">访客记录</span>
                     </div>
                     <div id="visitorArea" style="position: relative;">
                     	
                     </div>
                 </div>
             </div>
             <div class="clearit"></div>
             </div>
         </div>
    </div>
</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
<script src="${ctx}/resources/vmodel/vmodel.js"></script>
<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
<script src="${ctx}/resources/js/plugins.js"></script>
<script src="${ctx}/resources/js/area.js"></script>
<script src="${ctx}/resources/js/sly.js"></script>
<script src="${ctx}/resources/js/mouse.js"></script>
<script src="${ctx}/resources/js/Canlendar/ccCanlendar.js"></script>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script src="${ctx}/resources/admin/js/jquery.chosen.min.js"></script>
<script src="${ctx}/resources/js/own/center_new.js"></script>
<script src="${ctx}/resources/js/own/center_player.js"></script>
<script src="${ctx}/resources/js/own/center_comment.js"></script>
<script src="${ctx}/resources/js/own/index_new.js"></script>
<script src="${ctx}/resources/js/own/msg.js"></script>
<script src="${ctx}/resources/js/person_info.js"></script>
<script type="text/javascript">
var PageInfo={"login_user_amount":0};
jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}

$("#trial_tdate").ccCanlendar({
	iniValue:false,
	startYear:1970,
	hasHourPanel:false,
	hasMinitePanel:false,
	autoSetMinLimit:false,
	showNextMonth:false,
	minLimit:'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" />'
});

//留下印象
/* $("#describes").click(function () {
    $(".masker").height($(document).height()).fadeIn();
    $(".burn_in").center().fadeIn();
}); */

//关闭印象
function closeAll() {
    $(".masker").fadeOut();
    $(".imp_detail").fadeOut();
    $(".burn_in").fadeOut();
    $(".pla").fadeOut();
    $(".gift_list").fadeOut();
}

$(".masker").click(function () {
    closeAll();
});
$("#close_imp_detail").click(function () {
    closeAll();
});
$(".closeBtn_1").click(function () {
    closeAll();
});

//显示设置
$("#setting").mouseover(function () {
    //if ($(".set").is(":visible")) {
    //    $(".set").hide();
    //} else {
    //    $(".set").show();
    //}
    $(".set").show();
});

//激活码
function input_code(){
	$(".makser").height($(document).height()).fadeIn();
	$("#code_str").val("");
    $(".invitation_code").center().fadeIn();
}

$("#invi_btn").click(function () {
	input_code();
});

function close() {
    $(".makser").fadeOut();
    $(".invitation_code").fadeOut();
}

//印象关闭按钮显示
$(".myim").mouseover(function () {
    $(this).find(".im_close").show();
}).mouseout(function () {
    $(this).find(".im_close").hide();
});

//上传图片、视频
$("#upiv").mouseover(function () {
    $("#up_new_edit").show();
});
//更多
$("#moreiv").mouseover(function () {
    $("#more_new_edit").show();
});

$(function(){
	//更新页面受访次数
	updatePageCount();
	
	if('${oth_user_id}'=='${session_user_id}'){
		  $(".new_gfd").css({ "margin-top": "150px" });
          $(".new_img_video").css({"margin-top":"20px"});
	}else{
		 $(".new_gfd").css({ "margin-top": "160px" });
         $(".new_img_video").css({ "margin-top": "0px" });
	}
	
	/* $(document).mouseover(function (e) {
		var vinp = $(e.target).attr("id");
		if(!$(".new_edit").is(':has('+e.target.localName+')')&&!(vinp=='upiv')){
			$(".new_edit").hide();
		}
	}); */
	$(document).click(function(e) {
		var vinp = $(e.target).attr("id");
		if(!$(".new_edit").is(':has('+e.target.localName+')')&&!(vinp=='upiv')){
			$(".new_edit").hide();
		}
		if (!$(".select_type").is(':has(' + e.target.localName + ')') && e.target.id != 'type') {
            $(".select_type").hide();
        }
        if (!$(".pp_tag").is(':has(' + e.target.localName + ')') && e.target.id != 'pp_tag') {
            $(".select_tag").hide();
        }
        if (!$(".select_foot").is(':has(' + e.target.localName + ')') && e.target.id != 'foot') {
            $(".select_foot").hide();
        }
        if (!$(".remove_s").is(':has(' + e.target.localName + ')') && e.target.id != 'remove_s') {
            $(".remove_ss").hide();
        }
        if (!$(".huifu_s").is(':has(' + e.target.localName + ')') && e.target.id != 'huifu_s') {
            $(".huifu_ss").hide();
        }
        if (!$(".setting").is(':has(' + e.target.localName + ')') && e.target.id != 'setting') {
            $(".set").hide();
        }
        if (!$("#upiv").is(':has(' + e.target.localName + ')') && e.target.id != 'upiv') {
            $(".new_edit").hide();
        }
	});
	
})

//added by bo.xie 页面访问记录统计
function updatePageCount(){
	$.ajax({
		type:'post',
		url:base+'/center/updateCount?random='+Math.random(),
		data:{"user_id":'${oth_user_id}',"code_str":"CENTER"},
		dataType:'json',
		success:function(data){
			if(data.state=='success'){
				$("#invitePageCount").text(" | 到访数："+data.data.pageCount.count);
			}
		}
	})
}


</script>
<!--固定访客记录-->
<script src="${ctx}/resources/js/jquery.sticky-kit.js"></script>
<%-- <script src="${ctx}/resources/js/own/center_comment.js"></script> --%>
<script type="text/javascript">
   (function () {
        $(function () {

            return $(".new_record").stick_in_parent().on("sticky_kit:stick", (function (_this) {
                return function (e) {
                    return setTimeout(function () {
                        return $(e.target).css({ "margin-top": "0px" });
                    }, 0);
                };
            })(this)).on("sticky_kit:unstick", (function (_this) {
                return function (e) {
                    return setTimeout(function () {
                        return $(e.target).css({ "margin-top": "0px" });
                    }, 0);
                };
            })(this));
        });

    }).call(this);
</script>
</body>
</html>