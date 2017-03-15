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
<c:if test="${!empty page.items}">
<div class="videoBox_l">
    <div class="video_icon">
        <span class="text-white f18 pull-left">
            <c:choose>
            	<c:when test="${!empty page.items[0].title&&fn:length(page.items[0].title)>20}">
            	${fn:substring(page.items[0].title, 0, 10)}...
            	</c:when>
            	<c:otherwise>
            	${empty page.items[0].title?'':page.items[0].title}
            	</c:otherwise>
            </c:choose>
        </span>
        <span class="videoIco2">
        <c:choose>
        	<c:when test="${!empty page.items[0].click_count && page.items[0].click_count>10000}">
        	${fn:substring(page.items[0].click_count/10000, 0, fn:indexOf(page.items[0].click_count/10000, "."))}万
        	</c:when>
        	<c:otherwise>
        	${empty page.items[0].click_count?0:page.items[0].click_count}
        	</c:otherwise>
        </c:choose>
        </span>
       <div class="clearit"></div>
    </div>
    <a class="video" style="cursor: pointer;" onclick="show_video('${el:filePath(page.items[0].f_src,'1')}','${page.items[0].create_time}','${page.items[0].id}','${page.items[0].role_type}')"></a>
    <img src="${el:filePath(page.items[0].v_cover,'1')}" onclick="show_video('${el:filePath(page.items[0].f_src,'1')}','${page.items[0].create_time}','${page.items[0].id}','${page.items[0].role_type}')" />
     <p class="text-white mt5 f18 ml10">
     	 <c:choose>
     	 	<c:when test="${page.items[0].role_type eq 'TEAM'}">
     	 	<span class="pull-left" style="cursor: pointer;color:#666;" onclick="window.open('${ctx}/team/detail/${page.items[0].user_id}.html')">${page.items[0].ivname}</span>
     	 	</c:when>
     	 	<c:when test="${page.items[0].role_type eq 'LEAGUE'}">
     	 	<span class="pull-left" style="cursor: pointer;color:#666;" onclick="window.open('${ctx}/league/index')">${page.items[0].ivname}</span>
     	 	</c:when>
     	 	<c:when test="${page.items[0].role_type eq 'BABY'}">
     	 	<span class="pull-left" style="cursor: pointer;color:#666;" onclick="window.open('${ctx}/baby/base/user/${page.items[0].user_id}.html')">${page.items[0].ivname}</span>
     	 	</c:when>
     	 	<c:when test="${page.items[0].role_type eq 'PLAYER'}">
     	 	<span class="pull-left" style="cursor: pointer;color:#666;" onclick="window.open('${ctx}/center/${page.items[0].user_id}.html')">${page.items[0].ivname}</span>
     	 	</c:when>
     	 </c:choose>
         <c:choose>
          	<c:when test="${page.items[0].unpraise=='2'}">
          		<a class="cai_l" title="取消点踩" flag="1" style="color:#666;"  data-id="badbtn" onclick="do_praise(2,this,'video','${page.items[0].id}','${page.items[0].role_type}')">${page.items[0].unpraise_count}</a>
          	</c:when>
          	<c:otherwise>
          		<a class="cai_l" title="踩" flag="1" style="color:#666;" data-id="badbtn" onclick="do_praise(2,this,'video','${page.items[0].id}','${page.items[0].role_type}')">${page.items[0].unpraise_count}</a>
          	</c:otherwise>
          </c:choose>
          <c:choose>
          	<c:when test="${page.items[0].praise=='1'}">
          		<a class="zan_l" title="取消点赞" flag="1" style="color:#666;" data-id="goodbtn" onclick="do_praise(1,this,'video','${page.items[0].id}','${page.items[0].role_type}')">${page.items[0].praise_count}</a>
          	</c:when>
          	<c:otherwise>
          		<a class="zan_l" title="赞" flag="1" style="color:#666;" data-id="goodbtn" onclick="do_praise(1,this,'video','${page.items[0].id}','${page.items[0].role_type}')">${page.items[0].praise_count}</a>
          	</c:otherwise>
          </c:choose>
         <div class="clearit"></div>
     </p>
</div>
<div class="videoBox_r">
    <ul class="clearfix">
    	<c:forEach items="${page.items}" var="videos" varStatus="status">
    	<c:if test="${status.index>0}">
    	<li>
    	<div style="border: 1px solid #fff;padding: 0px 1px 7px 1px;">
            <div class="videos_img">
                <div class="video_icon">
                    <span class="text-white f12 pull-left">
                        <c:choose>
			            	<c:when test="${!empty videos.title&&fn:length(videos.title)>6}">
			            	${fn:substring(videos.title, 0, 6)}...
			            	</c:when>
			            	<c:otherwise>
			            	${empty videos.title?'　':videos.title}
			            	</c:otherwise>
			            </c:choose>
                    </span>
                    <span class="videoIco2">
                    <c:choose>
			        	<c:when test="${!empty videos.click_count && videos.click_count>10000}">
			        	${fn:substring(videos.click_count/10000, 0, fn:indexOf(videos.click_count/10000, "."))}万
			        	</c:when>
			        	<c:otherwise>
			        	${empty videos.click_count?0:videos.click_count}
			        	</c:otherwise>
			        </c:choose>
                    </span>
                    <div class="clearit"></div>
                </div>
                <a class="video" style="cursor: pointer;" onclick="show_video('${el:filePath(videos.f_src,'1')}','${videos.create_time}','${videos.id}','${videos.role_type}')"></a>
                <img src="${el:filePath(videos.v_cover,'1')}" onclick="show_video('${el:filePath(videos.f_src,'1')}','${videos.create_time}','${videos.id}','${videos.role_type}')"/>
                <div style="width: 100%;color: #fff;margin-top: 5px;">
              
                    <c:choose>
			     	 	<c:when test="${videos.role_type eq 'TEAM'}">
			     	 	<span class="pull-left" style="cursor: pointer;color:#666;" onclick="window.open('${ctx}/team/tdetail/${videos.user_id}.html')">${videos.ivname}</span>
			     	 	</c:when>
			     	 	<c:when test="${videos.role_type eq 'LEAGUE'}">
			     	 	<span class="pull-left" style="cursor: pointer;color:#666;" onclick="window.open('${ctx}/league/index')">${videos.ivname}</span>
			     	 	</c:when>
			     	 	<c:when test="${videos.role_type eq 'BABY'}">
			     	 	<span class="pull-left" style="cursor: pointer;color:#666;" onclick="window.open('${ctx}/baby/base/user/${videos.user_id}.html')">${videos.ivname}</span>
			     	 	</c:when>
			     	 	<c:otherwise>
			     	 	<span class="pull-left" style="cursor: pointer;color:#666;" onclick="window.open('${ctx}/center/${videos.user_id}.html')">${videos.ivname}</span>
			     	 	</c:otherwise>
			     	 </c:choose>
                    <c:choose>
                    	<c:when test="${videos.unpraise=='2'}">
                    		<a class="cai_r" title="取消点踩" flag="1" data-id="badbtn" onclick="do_praise(2,this,'video','${videos.id}','${videos.role_type}')">${videos.unpraise_count}</a>
                    	</c:when>
                    	<c:otherwise>
                    		<a class="cai_r" title="踩" flag="1" data-id="badbtn" onclick="do_praise(2,this,'video','${videos.id}','${videos.role_type}')">${videos.unpraise_count}</a>
                    	</c:otherwise>
                    </c:choose>
                    <c:choose>
                    	<c:when test="${videos.praise=='1'}">
                    		<a class="zan_r" title="取消点赞" flag="1" data-id="goodbtn" onclick="do_praise(1,this,'video','${videos.id}','${videos.role_type}')">${videos.praise_count}</a>
                    	</c:when>
                    	<c:otherwise>
                    		<a class="zan_r" title="赞" flag="1" data-id="goodbtn" onclick="do_praise(1,this,'video','${videos.id}','${videos.role_type}')">${videos.praise_count}</a>
                    	</c:otherwise>
                    </c:choose>
                    <div class="clearit"></div>
                </div>
            </div>
             </div>
        </li>
    	</c:if>
        </c:forEach>
    </ul>
</div>
</c:if>
<div class="clearfix"></div>
