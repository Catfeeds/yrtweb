<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>推荐宝贝</title>
</head>
<body>
 <div class="baby_pic mt10 ms frame" id="babyframe">
   <ul class="clearfix" id="baby">
   <c:forEach items="${reMaps}" var="item">
       <li>
           <div class="babyList">
           		<c:if test="${item.status eq 1}">
                    <img src="${ctx}/resources/images/rzld.png" class="rzld" />
		    	</c:if>
		        <a href="javascript:void(window.open('${ctx}/baby/base/baby/${item.baby_id}'))">
		            <img  src="${filePath}/${item.f_src}"/>
		        </a>
		        <p class="baby_name">
		            <a href="javascript:void(window.open('${ctx}/baby/base/baby/${item.baby_id}')" class="text-white">${item.usernick}</a>
		        </p>
           </div>
       </li>
     </c:forEach>  
        
	</ul>
		<!--翻页-->
   		<div class="baby_turn">
   			<a href="javascript:void(0)" class="baby_left"></a>
   			<a href="javascript:void(0)" class="baby_right"></a>
   		</div>
</div>                            
</body>
</html>