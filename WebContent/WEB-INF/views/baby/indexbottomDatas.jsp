<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝贝首页最新加入</title>
</head>
<body>
    <div class="baby_join ms mt20">
 		<h2 class="fw">最新加入</h2>
 		<ul class="ml10 mt10">
 		<c:forEach items="${rf.items}" var="item">
 			<li>
 			 <div class="huang_baby ">
    			 <div class="rz_baby">
 				 <c:if test="${item.status eq 1}">
                  <img src="${ctx}/resources/images/rzld.png" class="rzld" />
    			 </c:if>
 				 <a href="javascript:void(window.open('${ctx}/baby/base/baby/${item.id}'))">
		         	<img src="${el:headPath()}${item.head_icon}">
		         </a>
		         </div>
		         </div>
 			</li>
 		</c:forEach>	
             <div class="clearit"></div>
 		</ul>	
 	</div>
</body>
</html>