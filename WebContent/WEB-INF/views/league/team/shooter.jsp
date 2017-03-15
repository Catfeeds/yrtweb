<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <!--射手-->
 <c:choose>
 	<c:when test="${!empty data }">
 	 <ul>
 	 	<c:forEach items="${data }" var="item" varStatus="num">
 	 	 <li>
	         <div class="role_ranking">
	             <span <c:choose>
            				<c:when test="${num.index eq 0 }">
            					class="rank_1"
            				</c:when>
            				<c:when test="${num.index eq 1 }">
            					class="rank_2"
            				</c:when>
            				<c:when test="${num.index eq 2 }">
            					class="rank_3"
            				</c:when>
            				<c:otherwise>
            					class="rank_4"
            				</c:otherwise>
            			</c:choose>
            	  >${num.index+1}</span>
	             <div class="role_info">
	                 <!--<div class="pull-left mt5 ml5 f_num">${item.player_num }</div>
	                 <dl class="pull-left ml5 mt5">
	                     <dt><span>${empty item.username?item.usernick:item.username}</span></dt>
	                     <dd><span>进球</span></dd>
	                 </dl>
	                 <dl class="pull-right mr3 mt5">
	                     <dt>
	                     	<span class="">
	                     		
	                     		<yt:dict2Name nodeKey="p_position" key="${item.position}"></yt:dict2Name>
	                     	</span>
                     	</dt>
	                     <dd><span>${empty item.jinqiu_num?0:item.jinqiu_num}</span></dd>
	                 </dl> -->
	                 
	                  <dl class="pull-left ml5 mt5" style="width: 90%;">
                           <dt><div class="pull-left f_num_s">${item.player_num }</div><span class="pull-left ml5">${empty item.username?item.usernick:item.username}</span>
                               <div class="clearit"></div>
                           </dt>
                           <dd><span class="pull-left ml25"><yt:dict2Name nodeKey="p_position" key="${item.position}"></yt:dict2Name></span><span class="pull-right">进球&ensp;<fmt:formatNumber value="${empty item.jinqiu_num?0:item.jinqiu_num}" pattern="0"/></span><div class="clearit"></div></dd>
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
