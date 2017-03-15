<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-俱乐部列表</title>
<link href="${ctx}/resources/css/clubLook.css" rel="stylesheet" />
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link href="${ctx}/resources/js/Canlendar/ccCanlendar.css" rel="stylesheet">

</head>
<body>
	<div class="masker"></div>
	<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航-->
        <%@ include file="../common/naver.jsp" %>  
        <div class="wrapper" style="margin-top: 116px;">
            <div class="team">
                <div class="title_new">
                    <span focus='0' onclick="change_focus(0,this);" class="active f16 ms ml20">所有俱乐部</span>
                    <span class=" f16 ms ml20">|</span>
                    <span focus='1' onclick="change_focus(1,this);" class=" f16 ms ml20">关注俱乐部</span>
                </div>
                <div class="search_terms">
                	<form action="" method="post" id="searchForm">
                	<input type="hidden" id="f_is_focus" name="is_focus" value="0"/>
                    <div class="mt15 ml20">
                        <span class="text-gray-s_999">名称</span><input type="text" name="name" value="${name}" class="txt ml10">

                        <span class="text-gray-s_999 ml50">城市</span>
                        <select id="s_province" name="province" class="ml10"></select>
                        <select id="s_city" name="city"></select>

                        <span class="text-gray-s_999 ml50">擅长赛制</span>
                        <select id="s_ball_format" name="ball_format">
                            <option value="">选择赛制</option>
                            <option value="5">5人制</option>
                            <option value="7">7/8/9人制</option>
                            <option value="11">11人制</option>
                        </select>
                        <input type="button" onclick="loadTeamList(0)" value="搜索" class="btn_l ml10">
                        <input type="button" onclick="resetTeamList()" value="重置" class="btn_g ml10">
                    </div>
                    </form>
                    <div class="tiaojian">
                        <span class="text-gray-s_999">排序：</span>
                        <span orderby='combat' class="active" ret='0' onclick="loadTeamList(0,'combat',this)">战斗力</span>
                       
                        <span class="text-gray-s_999">|</span>
                        <span orderby='amount' class="" ret='1' onclick="loadTeamList(0,'amount',this)">资产</span>
                     
                      
                    </div>
                </div>
                <div id="team_recommendations" class="warp_team">
                </div>
                <div id="teamList">
                </div>
            </div>
        </div>
    </div>
    <!-- 俱乐部邀请挑战弹窗start -->
         <div id="inviteDialog" class="pk">
         	
         </div>
   <!-- 俱乐部邀请挑战弹窗end -->
    <%@ include file="../common/footer.jsp" %>
<script src="${ctx}/resources/js/mouse.js"></script>
<script src="${ctx}/resources/js/Canlendar/ccCanlendar.js"></script>
<script src="${ctx}/resources/js/area.js"></script>
<script src="${ctx}/resources/js/own/teamlist.js"></script>
<script type="text/javascript">
new PCAS('province', 'city');
jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}
//挑战 受邀俱乐部id,名称，logo
function inviteTeam(teaminfo_id,name,logo){
   var fa_teaminfo_id = '${ti.id}';
   var fa_t_name = '${ti.name}';
   var fa_t_logo = '${ti.logo}';
   var is_pk = $("#is_pk_"+teaminfo_id).val();
   if(fa_teaminfo_id==""){
       layer.msg("只有俱乐部才能发起挑战！",{icon: 0});
   }else if(fa_teaminfo_id==teaminfo_id){
		layer.msg("自己不能挑战自己",{icon: 0});
   }else if(is_pk!=1){
   	layer.msg("该俱乐部暂时不接受对战邀请！",{icon: 0});
   }else{
    	$.loadSec("#inviteDialog",base+"/teamInvite/page",function(){
    		$("#inviteDialog").center().css("display","block");
    		//获取遮罩高度并显示
       	$(".masker").height($(document).height());
       	$('.masker').fadeIn();
    		//向invite_page页面注入俱乐部等信息
    		//发起邀请方
    		$("#fa_teaminfo_id").val(fa_teaminfo_id);
    		$("#fa_t_name").val(fa_t_name);
    		$("#fa_t_logo").val(fa_t_logo);
    		//被邀请方
    		$("#respond_teaminfo_id").val(teaminfo_id);
    		$("#re_r_name").val(name);
    		$("#re_r_logo").val(logo);
    		
    		$("#flush_page").val(true);
    	});
   }
}
</script>
</body>
</html>