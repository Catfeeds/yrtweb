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
<input type="hidden" id="order_by" value="${params.orderby}"/>
<input type="hidden" id="s_role_type" value="${params.role_type}"/>
<ul id="team_imgs">
<c:forEach items="${page.items}" var="imgs" varStatus="status">
   <li>
   <c:if test="${params.isme==1}">
   <div class="pic_del">
		
		 <span  style="background: url(/resources/images/v_1_remove.png) no-repeat;display: inline-block;width: 15px;height: 15px; " alt="删除" title="删除" onclick="deleteFile('${ctx}/imageVideo/removeFile','${imgs.id}','image')" class="pull-right mt5">
				        <div class="clearfix"></div>
	</div> 
   </c:if>
	<img layer-pid="${imgs.id}" layer-src="${el:filePath(imgs.f_src,imgs.to_oss)}" alt="" num="${status.index+1}" src="${el:filePath(imgs.f_src,imgs.to_oss)}" alt="Alternate Text" width="180" height="130"/>
   </li>
 </c:forEach>
</ul>
<div class="clearfix"></div>

<script type="text/javascript">
<c:if test="${params.isme==1}">
$(".showPhotos_fix li").each(function() {
	   $(this).mouseover(function() {
        $(this).find(".pic_del").show();
    }).mouseout(function() {
        $(this).find(".pic_del").hide();
    });
 });
</c:if>
<c:if test="${params.isme==0}">
$("#up_team_image").remove();
</c:if>
</script>
