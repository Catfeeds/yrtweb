<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="http://img.yrt9527.com" />
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>
 <c:forEach items="${images.items}" var="imgs" varStatus="status">
     <img layer-type="image" layer-pid="${imgs.id}" layer-src="${el:filePath(page.items[0].f_src,'1')}${imgs.f_src}" num="${status.index+1}" alt="" src="${el:filePath(page.items[0].f_src,'1')}${imgs.f_src}" class="new_ph the_${imgs.sort }" />
  </c:forEach>
<div class="clearfix"></div>


