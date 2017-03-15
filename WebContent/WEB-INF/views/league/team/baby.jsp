<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <c:choose>
 	<c:when test="${!empty data }">
 	  <ul id="baby">
 	  		<c:forEach items="${data }" var="item" varStatus="num">
 	 	 		<li>
                    <div class="role_ranking">
                        <div class="role_info">
                            <dl class=" ml5 mt5">
                                <dt><span>${item.username}</span></dt>
                                <dd><span>魅力值</span><span class="ml10">${item.usercp}</span></dd>
                            </dl>
                        </div>
                        <img src="${el:headPath()}${item.head_icon}" onclick="javascript:window.location='${ctx}/center/${item.user_id}'"/>
                    </div>
 	 	 		</li>
 	 	 	</c:forEach>	
 	  </ul>
 	</c:when>
 	<c:otherwise>
 		<p style="text-align: center;color: red;">暂无数据...</p>
 	</c:otherwise>
 </c:choose>
 <div class="clearit"></div>	