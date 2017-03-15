<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>      
<ul class="v_list">
	<c:if test="${empty ivs}">
		<c:forEach var="i" begin="1" end="8">
		<li>
			<div class="" style="position: relative; width: 160px;">
			<img src="${ctx}/resources/images/zwsp.png" class="small">
			</div>
		</li>
		</c:forEach>
	</c:if>
	<c:if test="${!empty ivs}">
	<c:forEach items="${ivs.items }" var="item">
    <li>
        <div class="" style="position: relative; width: 160px;">
            <div class="v_txt">
                <span class="pull-left ml5 playtxt" title="${item.title}">
                <c:choose>
	            	<c:when test="${!empty item.title&&fn:length(item.title)>6}">
	            	${fn:substring(item.title, 0, 6)}...
	            	</c:when>
	            	<c:otherwise>
	            	${empty item.title?'　':item.title}
	            	</c:otherwise>
	            </c:choose>
                </span>
                <span class="pull-right playnum mt5 mr5">
                <c:choose>
		        	<c:when test="${!empty item.click_count && item.click_count>10000}">
		        	${fn:substring(item.click_count/10000, 0, fn:indexOf(item.click_count/10000, "."))}万
		        	</c:when>
		        	<c:otherwise>
		        	${empty item.click_count?0:item.click_count}
		        	</c:otherwise>
		        </c:choose>
                </span>
                <div class="clearit"></div>
            </div>
            <a style="cursor: pointer;" onclick="show_video('${el:filePath(item.f_src,item.to_oss)}','${item.create_time}','${item.id}','${item.role_type}')" class="video"></a>
            <img src="${el:filePath(item.v_cover,item.to_oss)}" class="small">
        </div>
    </li>
    </c:forEach>
    <c:if test="${ivs.items.size()<8}">
    <c:forEach var="i" begin="1" end="${8-ivs.items.size()}">
	<li>
		<div class="" style="position: relative; width: 160px;">
		<img src="${ctx}/resources/images/zwsp.png" class="small">
		</div>
	</li>
	</c:forEach>
    </c:if>
    </c:if>
    <div class="clearit"></div>
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
