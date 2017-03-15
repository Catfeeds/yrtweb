<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />   
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>
<ul id="team_video_list">
    <li id="team_video_model" style="display: none;">
        <dl>
            <dt>
                <div class="v_2">
                   <div class="v_1_remove">
                       <a href="javascript:void(0);"><img onclick="deleteFile('${ctx}/imageVideo/removeFile','{{id}}','video')" src="${ctx}/resources/images/v_1_remove.png" alt="删除" title="删除"/></a>
                   </div>
                    <div class="v_1_txt">
                        <span class="pull-left ml5" title="{{title}}" data-id="title"></span>
                        <span class="pull-right playnum mt5" data-id="ccount"></span>
                        <div class="clearit"></div>
                    </div>
                    <a onclick="show_video('{{f_src}}','{{create_time}}','{{id}}','{{role_type}}')" class="video"></a>
                    <img onclick="show_video('{{f_src}}','{{create_time}}','{{id}}','{{role_type}}')" src="${filePath}/{{v_cover}}" class="small"/>
                </div>
            </dt>
            <dd class="w173">
                <span class="pull-left ml5 f14"  data-id="ivname"></span>
                <span data-id="cai" class="pull-right cais mt5" flag="1" title="踩" onclick="do_praise(2,this,'video','{{id}}','{{role_type}}')">0</span>
                <span data-id="zan" class="pull-right zans mt5" flag="1" title="赞" onclick="do_praise(1,this,'video','{{id}}','{{role_type}}')">0</span>
                <div class="clearit"></div>
            </dd>
        </dl>
    </li>
</ul>

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
<script type="text/javascript">

</script>
