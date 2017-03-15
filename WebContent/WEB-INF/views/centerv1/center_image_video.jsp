<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>
<input type="hidden" id="center_iv_isme" value="${isme}"/>
<c:if test="${empty views.items}">
<c:choose>
	<c:when test="${isme=='1'}">
	<div class="visitor_no_iv_data">
	    <span class="text-white f16 ms">点击右上方“上传”按钮，上传你的精彩瞬间</span>
	</div>
	</c:when>
	<c:otherwise>
	<div class="visitor_no_iv_data">
        <span class="text-gray-s_999 f16 ms">该用户尚未上传精彩瞬间，</span><span class="new_btn_l f12" onclick="inviteUpload('${c_user.usernick}','${c_user.id}','1')">邀请</span><span class="text-gray-s_999 f16 ms">Ta上传吧</span>
    </div>
	</c:otherwise>
</c:choose>
</c:if>
<c:if test="${!empty views.items}">
<div class="newiv frame" id="all">
    <ul class="clearfix iv">
        <li>
            <div class="newiv_area">
                <c:forEach items="${views.items}" var="iv" varStatus="status">
				<div class="adiv">
					<c:if test="${isme==1}">
				    <div class="remove">
				         <span  style="background: url(/resources/images/v_1_remove.png) no-repeat;display: inline-block;width: 15px;height: 15px; " alt="删除" title="删除${iv.to_oss}" onclick="deleteFile('${ctx}/imageVideo/removeFile','${iv.id}','${iv.type}')" class="pull-right mt5">
				        <div class="clearfix"></div>
				    </div>
				    </c:if>
				    <c:choose>
				    	<c:when test="${iv.type eq 'video'}">
				    	 <a href="javascript:show_video('${el:filePath(iv.f_src,iv.to_oss)}','${iv.create_time}','${iv.id}','PLAYER');" class="video_aplay"></a>
				    	<img src="${el:filePath(iv.v_cover,iv.to_oss)}" layer-type="video" layer-date="${iv.create_time}" layer-url="${el:filePath(iv.f_src,iv.to_oss)}" layer-pid="${iv.id}" layer-src="${el:filePath(iv.v_cover,iv.to_oss)}" alt="" num="${iv.index+1}" alt="Alternate Text" style="width: 102px;height: 117px;" />
				    	</c:when>
				    	<c:otherwise>
				    	<img src="${el:filePath(iv.f_src,iv.to_oss)}" layer-type="image" layer-pid="${iv.id}" layer-src="${el:filePath(iv.f_src,iv.to_oss)}" alt="" num="${status.index+1}" alt="Alternate Text" style="width: 102px;height: 117px;" />
				    	</c:otherwise>
				    </c:choose>
				</div>
				</c:forEach>
            </div>
        </li>
    </ul>
</div>
<c:choose>
	<c:when test="${views.currentPage!=1}">
		<input type="button" onclick="load_center_iv('${type}','${views.currentPage-1}')" class="prev" />
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${views.currentPage!=views.pageCount&&views.pageCount!=0}">
		<input type="button" onclick="load_center_iv('${type}','${views.currentPage+1}')" class="next" />
	</c:when>
</c:choose>
</c:if>
