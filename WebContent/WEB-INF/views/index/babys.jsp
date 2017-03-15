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
<%-- <div id="box_wwwzzjsnet">
	  <pre class="prev">prev</pre>
	  <pre class="next">next</pre>
	  <ul id="index_baby">
	  	<c:forEach items="${page.items}" var="baby" varStatus="status">
		    <li onclick="window.location='${ctx}/baby/base/baby/${baby.id}'">
		      <img src="${filePath}/${baby.f_src}" />
		      <div class="index_baby">
			        <h4 class="text-center text-white f14">
			        	<span>${baby.usernick}</span>
			        	<span class="ml10"><fmt:formatNumber value="${baby.age}" pattern="0"/>岁</span>
			        </h4>
			        <p class="text-center text-white f14"><fmt:formatNumber value="${baby.height}" pattern="0"/>CM</p>
			        <p class="text-center text-white f14">
			        	<span>三围</span>
			        	<span><fmt:formatNumber value="${baby.chest}" pattern="0"/>/<fmt:formatNumber value="${baby.waist}" pattern="0"/>/<fmt:formatNumber value="${baby.hip}" pattern="0"/></span>
			        </p>	
		      </div>
		    </li>
	    </c:forEach>
	  </ul>
</div> --%>
<div class="carousel-container" style="height: 263px;">
<div class="new_light" style="margin-top: 59px;">
                        </div>
        <div id="icarousel2" class="baby_show">
        
        	<c:forEach items="${page.items}" var="baby" varStatus="status">
            <div class="show_box">
             <div class="baby_masker"></div>
                <div class="show_baby_info">
                    <dl>
                        <dt>
                            <span class="f14 ms">${baby.usernick}</span>
                            
                           
                        </dt>
                        <dd><span class="pull-left ml30  f14 ms"><fmt:formatNumber value="${baby.age}" pattern="0"/>岁</span><span class="pull-right mr30 f14 ms"><fmt:formatNumber value="${baby.height}" pattern="0"/>CM</span> <div class="clearit"></div></dd>
                        <dd><span class=" f14 ms">三围 <fmt:formatNumber value="${baby.chest}" pattern="0"/>/<fmt:formatNumber value="${baby.waist}" pattern="0"/>/<fmt:formatNumber value="${baby.hip}" pattern="0"/></span></dd>
                    </dl>
                </div>
                <img src="${filePath}/${baby.f_src}" class="bb_showimg" onclick="window.location='${ctx}/baby/base/baby/${baby.id}'"/>
            </div>
            </c:forEach>
        </div>

 </div>


