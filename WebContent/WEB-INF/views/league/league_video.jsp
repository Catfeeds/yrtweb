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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 我的联赛 -->
<c:choose>
	<c:when test="${!empty ivs.items}">
		<c:choose>
				<c:when test="${fn:length(ivs.items) >1 }">
					<dl class="league_video_list">
						<c:forEach items="${ivs.items }" var="item" begin="0" step="1" end="${fn:length(ivs.items)-2 }">
							<dd><a href="javascript:void(0)" onclick="show_video('${item.f_src}','${item.create_time}','${item.id}','LEAGUE')">${item.title}</a></dd>
						</c:forEach>
					</dl>
					<c:forEach items="${ivs.items }" var="item" begin="${fn:length(ivs.items)-1 }" step="1" end="${fn:length(ivs.items)}">
						<dl class="league_video">
						     <dd>
						         <div class="con">
						             <span class="shuoming">${item.title}</span>
						             <a href="javascript:void(0);" class="v_mask" onclick="show_video('${el:filePath(item.f_src,item.to_oss)}','${item.create_time}','${item.id}','LEAGUE')"></a>
						             <img src="${el:filePath(item.v_cover,item.to_oss)}">
						         </div>
						     </dd>
						 </dl>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach items="${ivs.items }" var="item">
						<dl class="league_video">
						     <dd>
						         <div class="con">
						             <span class="shuoming">${item.title}</span>
						             <a href="javascript:void(0);" class="v_mask" onclick="show_video('${el:filePath(item.f_src,item.to_oss)}','${item.create_time}','${item.id}','LEAGUE')"></a>
						             <img src="${el:filePath(item.v_cover,item.to_oss)}">
						         </div>
						     </dd>
						 </dl>
					</c:forEach>	 
				</c:otherwise>
	</c:choose>
	</c:when>
	<c:otherwise>
		<dl class="league_video_list">
			<dd><font style="color:red;">暂无视频数据</font></dd>
		</dl>
	</c:otherwise>
</c:choose>
