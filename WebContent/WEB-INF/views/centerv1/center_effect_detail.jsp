<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />

<div class="closeBtn_1" onclick="closeAll();"></div>
    <div class="imp_title">
        <span class="f20 ms text-white">印象详情</span>
    </div>
    <div class="impression_area">
        <c:forEach items="${tags}" var="playerTag" varStatus="i">
			<div class="myim imp${i.index}">
				<c:if test="${session_user_id eq playerTag.s_user_id}">
			    	<img src="${ctx}/resources/images/im_close.png" class="im_close" onclick="delTag('${playerTag.id}');"/>
				</c:if>
			    <span>${playerTag.tag}</span>
			</div>	
		</c:forEach>
    </div>
    <div class="author">
        <table style="width: 100%;">
        	<c:forEach items="${tags}" var="playerTag">
	            <tr>
					<td><span class=""><yt:id2NameDB beanId="userService" id="${playerTag.s_user_id}"></yt:id2NameDB></span></td>
	                <td><span class="text-white">${playerTag.tag}</span></td>
	                <td><span><fmt:formatDate value="${playerTag.create_time}" pattern="yyyy-MM-dd"/></span></td>
	            </tr>
			</c:forEach>	
        </table>
    </div>
    <div class="clearit"></div>
    <div class="btn_div">
        <input type="button" name="name" value="关闭" class="new_btn_g" id="close_imp_detail" onclick="closeAll();"/>
    </div>