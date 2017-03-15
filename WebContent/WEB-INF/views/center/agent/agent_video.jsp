<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ include file="../../common/common.jsp" %>
<style>
.user_pic .video {
    background: rgba(0, 0, 0, 0) url("${ctx}/resources/images/video_p.png") no-repeat scroll 0 0;
    display: inline-block;
    height: 32px;
    position: relative;
    top: 80px;
    width: 32px;
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
    z-index:2000;
}
</style>
<table class="shengao_2">
  <tbody>
  	 <tr>
  	 	<c:choose>
  	 		<c:when test="${empty rf.items }">
  	 			 <td style="border-left: none;">暂无视频</td>
  	 		</c:when>
  	 		<c:otherwise>
		        <td style="border-left: none;">
		            <ul class="show_pic">
		            	<c:forEach items="${rf.items }" var="image">
			                <li>
			                 <div class="user_pic" style="margin-top:-50px;">
			                 	<a class="video" onclick="createVideo('${image.src}')"></a>
		                 		<img src="${filePath}/${fn:substring(image.src,0,fn:indexOf(image.src,'.'))}.jpg" onclick="createVideo('${image.src}')" width="132px;" height="132px;">
	                 		 </div>
			                </li>
		            	</c:forEach>
		            </ul>
		            <div class="clearit"></div>
		        </td>
  	 		</c:otherwise>
  	 	</c:choose>
    </tr>
  </tbody>
</table>