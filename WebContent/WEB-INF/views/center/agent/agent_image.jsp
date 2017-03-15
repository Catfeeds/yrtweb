<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../common/common.jsp" %>
<table class="shengao_2">
  <tbody>
  	 <tr>
  	 	<c:choose>
  	 		<c:when test="${empty rf.items }">
  	 			 <td style="border-left: none;">暂无图片</td>
  	 		</c:when>
  	 		<c:otherwise>
		        <td style="border-left: none;">
		            <ul class="show_pic">
		            	<c:forEach items="${rf.items }" var="image">
			                <li>
			               	 <div class="user_pic"><img src="${filePath}/${image.src}" width="132px;" height="132px;" onclick="showImage(this)"></div>
			                </li>
		            	</c:forEach>
		            </ul>
		            <div class="clearit"></div>
		        </td>
  	 		</c:otherwise>
  	 	</c:choose>
    </tr>
  </tbody>
</table>