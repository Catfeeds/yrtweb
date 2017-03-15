<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<script type="text/javascript">
	var base = '${pageContext.request.contextPath}';
	var filePath = base+"/upload";
</script>
 <div>
 <c:forEach items="${images.items}" var="imgs" varStatus="status">
    <c:if test="${imgs.sort<=11}">
        <img layer-type="image" layer-pid="${imgs.id}" layer-src="${filePath}/${imgs.f_src}" num="${status.index+1}" alt="" src="${filePath}/${imgs.f_src}" class="ph${imgs.sort }" />
    </c:if>
  </c:forEach>
</div>
<div class="ml460">
   <c:forEach items="${images.items}" var="imgs" varStatus="status" >
   <c:if test="${imgs.sort>11}">
        <img layer-type="image" layer-pid="${imgs.id}" layer-src="${filePath}/${imgs.f_src}" num="${status.index+1}" alt="" src="${filePath}/${imgs.f_src}" class="ph${imgs.sort - 11 }" />
   </c:if>
   </c:forEach>
</div>      
<div class="clearfix"></div>


