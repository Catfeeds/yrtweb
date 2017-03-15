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
<input type="hidden" id="user_nick_hui" value="${params.ivname}"/>
<input type="hidden" id="s_role_type" value="${params.role_type}"/>
<ul class="pic_l">
	<c:forEach items="${page.items}" var="image" varStatus="status">
         <li>
             <div class="picture_details">
                 <div class="picture_info">
                     <c:choose>
			     	 	<c:when test="${image.role_type eq 'TEAM'}">
			     	 	<span title="${image.ivname}" class="pull-left" style="cursor: pointer;" onclick="window.open('${ctx}/team/tdetail/${image.user_id}.html')">
			     	 	</c:when>
			     	 	<c:when test="${image.role_type eq 'LEAGUE'}">
			     	 	<span title="${image.ivname}" class="pull-left" style="cursor: pointer;" onclick="window.open('${ctx}/league/index')">
			     	 	</c:when>
			     	 	<c:when test="${image.role_type eq 'BABY'}">
			     	 	<span title="${image.ivname}" class="pull-left" style="cursor: pointer;" onclick="window.open('${ctx}/baby/base/user/${image.user_id}.html')">
			     	 	</c:when>
			     	 	<c:otherwise>
			     	 	<span title="${image.ivname}" class="pull-left" style="cursor: pointer;" onclick="window.open('${ctx}/center/${image.user_id}.html')">
			     	 	</c:otherwise>
			     	 </c:choose>
                     <c:choose>
			            	<c:when test="${!empty image.ivname&&fn:length(image.ivname)>6}">
			            	${fn:substring(image.ivname, 0, 6)}...
			            	</c:when>
			            	<c:otherwise>
			            	${empty image.ivname?'　':image.ivname}
			            	</c:otherwise>
			            </c:choose>
                     </span>
                     <span class="pull-right mr10"><fmt:formatDate value="${image.create_time}" type="both" pattern="yyyy-MM-dd" /></span>
                     <div class="clearit"></div>
                 </div>
                 <img layer-pid="${image.id}" layer-src="${el:filePath(image.f_src,image.to_oss)}" alt="${image.ivname}" num="" src="${el:filePath(image.f_src,image.to_oss)}" />
             </div>
         </li>
    </c:forEach>
   	<div class="clearit"></div>
</ul>
<div class="clearfix"></div>
<span class="pull-left mt50 ml30 text-gray-s_999">*本站新闻图片，未经许可，不得转载，违者必究！</span>
<c:choose>
	<c:when test="${page.pageCount!=0}">
	<ul class="pagination" style="float:right;margin-right: 30px;">
		<c:choose>
			<c:when test="${page.currentPage!=1}">
			<li data-command="prev" onclick="load_images_videos_list('#image_list',1,'${page.currentPage-1}')"><a>上一页</a></li>
	        <li data-page-num="${page.currentPage-1}" onclick="load_images_videos_list('#image_list',1,'${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
			</c:when>
			<c:when test="${page.currentPage==1}">
			<li data-command="prev"><a>上一页</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
	        </c:when>
		</c:choose>
		<c:choose>
			<c:when test="${page.currentPage!=page.pageCount}">
			<li data-page-num="${page.currentPage+1}" onclick="load_images_videos_list('#image_list',1,'${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
			<c:choose>
	            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
            </c:choose>
            <c:choose>
	            <c:when test="${(page.currentPage+1)!=page.pageCount}">
	            <li data-page-num="${page.pageCount}" onclick="load_images_videos_list('#image_list',1,'${page.pageCount}')"><a>${page.pageCount}</a></li>
	            </c:when>
	        </c:choose>
	        <li data-command="next" onclick="load_images_videos_list('#image_list',1,'${page.currentPage+1}')"><a>下一页</a></li>
			</c:when>
			<c:otherwise>
	    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
	    	</c:otherwise>
		</c:choose>
	</ul>
	</c:when>
</c:choose>
<div class="clearit"></div>
