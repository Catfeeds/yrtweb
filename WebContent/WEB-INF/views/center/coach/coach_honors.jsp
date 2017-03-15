<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="../../common/common.jsp" %>
<c:choose>
	<c:when test="${!empty honors }">
		<div class="zs">
                    <div class="career_1">
                        <div class="mysly">
                            <a href="javascript:void(0);" class="prev"></a>
                            <a href="javascript:void(0);" class="next"></a>
                            <div class="frame oneperframe" id="honorframe">
                                <ul class="clearfix">
                                	 <c:forEach items="${honors }" var="honor" varStatus="num">
                                         <li>
                                             <div class="guding">
                                                 <!-- <span class="yt_editer mt10"></span><span class="yt_removeer"></span> -->
                                                 <div class="readme">
                                                     <span class="f12">${honor.name}</span>
                                                 </div>
                                                 <img src="${filePath}/${honor.images_url}"/>
                                             </div>
                                         </li>
                                      </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- <input type="button" name="name" value="继续添加" class="pull-right yt_add ms f16" /> -->
                    <div class="clearit"></div>
                </div>
	</c:when>
	<c:otherwise>
		<div align="center">
			 <c:if test="${session_user_id eq oth_user_id}">
				<img src="${ctx}/resources/images/add_pic.jpg" onclick="editCoachHonor()">
			 </c:if>	
		</div> 
	</c:otherwise>
</c:choose>    
