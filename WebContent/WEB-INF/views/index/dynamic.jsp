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
<%-- <div class="newDynamic">
	<dl>
	    <c:forEach items="${topDy }" var="item" varStatus="index">
	       <dd class="text-white">
			<span class="flagSys">顶</span> <span class="ml5">${item.user_name }：</span>
			<span class="p_content">${item.text }</span>
		   </dd>
	    </c:forEach>
	</dl>
</div> --%>

<div class="scrollbar">
    <div class="handle">
        <div class="mousearea"></div>
    </div>
</div>
<div class="newDynamic frame" id="chat">
    <ul class="items">
    	<c:forEach items="${topDy }" var="item" varStatus="index">
        <li>
            <span class="flagSys">置顶</span>
            <span class="ml5 text-white">${item.user_name }：</span>
            <span class="p_content">${item.text }</span>
        </li>
        </c:forEach>
    </ul>

</div>


<div class="scrollbar_two">
	<div class="handle">
		<div class="mousearea"></div>
	</div>
</div>
<div class="frame d_content" id="chat_two">
	<ul class="items">
	   <c:forEach items="${retList }" var="item" varStatus="index">
	      <li><span class="flagSys">${item.msg_type }</span> <span class="text-white ml5">${item.user_name }：${item.text }</span></li>
	   </c:forEach>
	</ul>
</div>
<div class="clearfix"></div>
