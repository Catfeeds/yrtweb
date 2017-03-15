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
<input type="hidden" id="order_by" value="${orderby}"/>
<ul class="clearfix">
	<c:forEach items="${page.items}" var="videos" varStatus="status">
    <li id="video">
        <div class="video_info">
            <div class="v_info">
                <span class="name">
                <c:choose>
	            	<c:when test="${!empty videos.title&&fn:length(videos.title)>8}">
	            	${fn:substring(videos.title, 0, 8)}...
	            	</c:when>
	            	<c:otherwise>
	            	${empty videos.title?'　':videos.title}
	            	</c:otherwise>
	            </c:choose>
                </span>
                <span class="nums">
                <c:choose>
		        	<c:when test="${!empty videos.click_count && videos.click_count>10000}">
		        	${fn:substring(videos.click_count/10000, 0, fn:indexOf(videos.click_count/10000, "."))}万
		        	</c:when>
		        	<c:otherwise>
		        	${empty videos.click_count?0:videos.click_count}
		        	</c:otherwise>
		        </c:choose>
                </span>
            </div>
            <a class="video" style="cursor: pointer;" onclick="show_video('${el:filePath(videos.f_src,videos.to_oss)}','${videos.create_time}','${videos.id}','${videos.role_type}')"></a>
           <img src="${el:filePath(videos.v_cover,videos.to_oss)}" onclick="show_video('${el:filePath(videos.f_src,videos.to_oss)}','${videos.create_time}','${videos.id}','${videos.role_type}')"/>
        </div>
        <div class="zancai">
            <c:choose>
	     	 	<c:when test="${videos.role_type eq 'TEAM'}">
	     	 	<span class="pull-left" style="cursor: pointer;" onclick="window.open('${ctx}/team/tdetail/${videos.user_id}.html')">${videos.ivname}</span>
	     	 	</c:when>
	     	 	<c:when test="${videos.role_type eq 'LEAGUE'}">
	     	 	<span class="pull-left" style="cursor: pointer;" onclick="window.open('${ctx}/league/index')">${videos.ivname}</span>
	     	 	</c:when>
	     	 	<c:when test="${videos.role_type eq 'BABY'}">
	     	 	<span class="pull-left" style="cursor: pointer;" onclick="window.open('${ctx}/baby/base/user/${videos.user_id}.html')">${videos.ivname}</span>
	     	 	</c:when>
	     	 	<c:otherwise>
	     	 	<span class="pull-left" style="cursor: pointer;" onclick="window.open('${ctx}/center/${videos.user_id}.html')">${videos.ivname}</span>
	     	 	</c:otherwise>
	     	 </c:choose>
            <div class="pull-right">
                <c:choose>
                	<c:when test="${videos.praise=='1'}">
                		<span class="zan_b" title="取消点赞" flag="1" data-id="goodbtn" onclick="do_praise(1,this,'video','${videos.id}','${videos.role_type}')">${videos.praise_count}</span>
                	</c:when>
                	<c:otherwise>
                		<span class="zan_b" title="赞" flag="1" data-id="goodbtn" onclick="do_praise(1,this,'video','${videos.id}','${videos.role_type}')">${videos.praise_count}</span>
                	</c:otherwise>
                </c:choose>
                <c:choose>
                	<c:when test="${videos.unpraise=='2'}">
                		<span class="cai_b" title="取消点踩" flag="1" data-id="badbtn" onclick="do_praise(2,this,'video','${videos.id}','${videos.role_type}')">${videos.unpraise_count}</span>
                	</c:when>
                	<c:otherwise>
                		<span class="cai_b" title="踩" flag="1" data-id="badbtn" onclick="do_praise(2,this,'video','${videos.id}','${videos.role_type}')">${videos.unpraise_count}</span>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
    </li>
    </c:forEach>
</ul>
<div class="clearfix"></div>
<c:choose>
	<c:when test="${page.pageCount!=0}">
	<ul class="pagination" style="float:right;margin-right: 30px;">
		<c:choose>
			<c:when test="${page.currentPage!=1}">
			<li data-command="prev" onclick="load_images_videos_list('#video_list',2,'${page.currentPage-1}')"><a>上一页</a></li>
	        <li data-page-num="${page.currentPage-1}" onclick="load_images_videos_list('#video_list',2,'${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
			</c:when>
			<c:when test="${page.currentPage==1}">
			<li data-command="prev"><a>上一页</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
	        </c:when>
		</c:choose>
		<c:choose>
			<c:when test="${page.currentPage!=page.pageCount}">
			<li data-page-num="${page.currentPage+1}" onclick="load_images_videos_list('#video_list',2,'${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
			<c:choose>
	            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
            </c:choose>
            <c:choose>
	            <c:when test="${(page.currentPage+1)!=page.pageCount}">
	            <li data-page-num="${page.pageCount}" onclick="load_images_videos_list('#video_list',2,'${page.pageCount}')"><a>${page.pageCount}</a></li>
	            </c:when>
	        </c:choose>
	        <li data-command="next" onclick="load_images_videos_list('#video_list',2,'${page.currentPage+1}')"><a>下一页</a></li>
			</c:when>
			<c:otherwise>
	    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
	    	</c:otherwise>
		</c:choose>
	</ul>
	</c:when>
</c:choose>
