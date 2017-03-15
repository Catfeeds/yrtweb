<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<c:set var="qc" value="st,lw,rw"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/>
<div class="title">
	<span class="f18 ms pull-left ml10">租借球员</span>
	<div class="clearit"></div>
</div>
   <table>
       <tr>
           <th><span>球衣号</span></th>
           <th><span>姓名</span></th>
           <th><span>年龄</span></th>
           <th><span>薪资</span></th>
           <th><span>身价</span></th>
           <th><span>到期时间</span></th>
       </tr>
       <c:choose>	
		<c:when test="${empty team_players}">
			 <tr>
	           <td colspan="7">暂无球员！</td>
	         </tr>  
		</c:when>
		<c:otherwise>
		   <c:forEach items="${team_players.items}" var="player" varStatus="num">
	       <tr>
	           <td>
	           		<c:choose>
	           			<c:when test="${!empty player.sp_id}">
	           				<span class="ban2"></span>
	           			</c:when>
	           			<c:otherwise>
			               <span class="num">${player.player_num}</span>
	           			</c:otherwise>
	           		</c:choose>
	           </td>
	           <td style="position: relative;">
	               <span onclick="window.location='${ctx}/center/${player.user_id}'" onmouseover="showUserInfo('${player.user_id}','#down_playerB_${num.index}')" onmouseout="hideUserInfo('#down_playerB_${num.index}')">${player.usernick}</span>
	          	   <span>
                     <!--名片-->
                    <div class="card" id="down_playerB_${num.index}"></div>
                   </span>
	           </td>
	           <td>
	               <span>
	               		${fn:substringBefore((nowDate.time-player.borndate.time)/1000/60/60/24/365,'.')}
	               </span>
	           </td>
	           <td>
	               <span>${player.salary}</span>
	           </td>
	           <td>
	               <span>${player.current_price}</span>
	           </td>
	           <td>
	               <span><fmt:formatDate value="${player.end_time}" pattern="yyyy-MM-dd hh:mm:ss"/> </span>
	           </td>
	       </tr>
	       </c:forEach>
		</c:otherwise>	
	</c:choose>	
</table>
<ul class="pagination" style="float:right;">
   	<c:choose>
   		<c:when test="${team_players.pageCount!=0}">
   			<c:choose>
				<c:when test="${team_players.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="loadPlayers(1)">首页</a></li>
					<li data-page-num="${team_players.currentPage-1}"> <a href="javascript:void(0)" onclick="loadPlayers(${team_players.currentPage-1})">${team_players.currentPage-1}</a></li>
					<li class="active"><a>${team_players.currentPage}</a></li> 
				</c:when>
				<c:when test="${team_players.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${team_players.currentPage!=team_players.pageCount}"> <li data-page-num="${team_players.currentPage+1}"><a href="javascript:void(0)" onclick="loadPlayers(${team_players.currentPage+1})">${team_players.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(team_players.currentPage+2)<team_players.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(team_players.currentPage+1)!=team_players.pageCount}"> <li data-page-num="${team_players.pageCount}"><a href="javascript:void(0)"  onclick="loadPlayers(${team_players.pageCount})">${team_players.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="loadPlayers(${team_players.pageCount})">末页</a></li> </c:when>
			</c:choose>
   		</c:when>
   	</c:choose>
</ul>	
<div class="clearit"></div>
