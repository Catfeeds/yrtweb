<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<style>
.img_video_ul li{
	float: left;
}
#img_video_div{
	position: relative;
}
#img_video_div .video {
    cursor: pointer;
    position: absolute;
    width: 32px;
    height: 32px;
    display: inline-block;
    left: 113px;
    top: 54px;
    background: url(${ctx}/resources/images/video_p.png) no-repeat;
}
</style>
<a href="${ctx}/imageVideo/loadVideos" style="position: absolute;right:10px;top:-28px;"><img src="${ctx}/resources/images/more_2.png" /></a>
<ul class="img_video_ul" style="margin-left: -2px;">

 
<c:forEach items="${videos}" var="result" varStatus="var">
	<c:if test="${var.index < 4}">
	<li>
		<div id="img_video_div">
		<a class="video" onclick="createVideo('${result.src}','${result.create_time}')"></a>
		<img style="width: 240px;height: 155px;" onclick="createVideo('${result.src}','${result.create_time}')" src="${filePath}/${fn:substring(result.src, 0, fn:indexOf(result.src, '.') )}.jpg" />
		</div>
	</li>
	</c:if>
</c:forEach>
<div class="clearit"></div>
</ul>