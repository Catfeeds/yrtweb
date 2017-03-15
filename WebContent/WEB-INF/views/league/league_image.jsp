<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<!-- 全局变量 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 我的联赛 -->
<c:choose>
	<c:when test="${!empty images.items}">
		<c:forEach items="${images.items}" var="item" varStatus="num">
			 <img layer-pid="${item.id}" layer-src="${el:filePath(item.f_src,item.to_oss)}" alt="${item.title}" num="" src="${el:filePath(item.f_src,item.to_oss)}" alt="${item.title}" 
			 	<c:if test="${num.index eq 0 }">class="pic_001"</c:if>
			 	<c:if test="${num.index eq 1 }">class="pic_002"</c:if>
			 	<c:if test="${num.index eq 2 }">class="pic_003"</c:if>
			 	<c:if test="${num.index eq 3 }">class="pic_003"</c:if>
			 	<c:if test="${num.index eq 4 }">class="pic_005"</c:if>
			 	<c:if test="${num.index eq 5 }">class="pic_003"</c:if>
			 	<c:if test="${num.index eq 6 }">class="pic_003"</c:if>
			 />
		</c:forEach>
	</c:when>
	<c:otherwise>
		<font style="color: red;">暂无数据...</font>
	</c:otherwise>
</c:choose>
 <div class="clearit"></div>