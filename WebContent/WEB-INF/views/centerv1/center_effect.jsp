<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<span class="ml5 text-white ms f14">对我的印象</span>
<c:choose>
	<c:when test="${empty tags}">
		<c:choose>
			<c:when test="${session_user_id eq user_id}">
				<p class="text-gray-s_999 mt50 ml30 f16 ms text-center">
	               	还没有人对我留下印象        
				</p>
			</c:when>
			<c:otherwise>
				<dl class="ms f18 mt30 ml70">
                    <dt><span class="text-gray-s_999 f16 ms">点击上方“留下印象”</span></dt>
                    <dd class="mt10"><span class="text-gray-s_999 f16 ms">按钮，留下对我印象吧</span></dd>
                </dl>
			</c:otherwise>
		</c:choose>	
	</c:when>
	<c:otherwise>
		<c:if test="${session_user_id eq user_id}">
			<a href="javascript:void(0);" class="pull-right text-white" id="yxxq" onclick="open_center_effect_detail();">详情</a>
		</c:if>
		<c:forEach items="${tags}" var="playerTag" varStatus="i">
			<div class="myim imp${i.index}">
				<c:if test="${session_user_id eq playerTag.s_user_id}">
			    	<img src="${ctx}/resources/images/im_close.png" class="im_close" onclick="del_center_effect('${playerTag.id}');"/>
				</c:if>
				<c:if test="${session_user_id eq user_id}">
			    	<img src="${ctx}/resources/images/im_close.png" class="im_close" onclick="del_center_effect('${playerTag.id}');"/>
				</c:if>
			    <span>${playerTag.tag}</span>
			</div>	
		</c:forEach>
	</c:otherwise>
</c:choose>
<script>
//印象关闭按钮显示
	$(".myim").mouseover(function () {
	    $(this).find(".im_close").show();
	}).mouseout(function () {
	    $(this).find(".im_close").hide();
	});
</script>


