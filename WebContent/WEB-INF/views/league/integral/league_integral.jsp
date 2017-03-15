<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 积分榜 -->
<div class="i_list">
    <ul>
    	<c:choose>
    		<c:when test="${!empty groups}">
    			<c:forEach items="${groups}" var="item" varStatus="num">
    				<li class="f16 ms <c:if test="${item.id eq group_id}">active</c:if>" dataAttr="${item.id}" onclick="loadIntegral(this,'${item.id}','${item.league_id}')">${item.name}</li>
    			</c:forEach>
    		</c:when>
    	</c:choose>
        <div class="clearit"></div>
    </ul>
</div>
<div class="l_fenge"></div>
<table class="jifen" id="jifenArea">
<tr>
    <td></td>
    <td><span class="text-gray-s_666">俱乐部</span></td>
    <td><span class="text-gray-s_666">场次</span></td>
    <td><span class="text-gray-s_666">胜</span></td>
    <td><span class="text-gray-s_666">负</span></td>
    <td><span class="text-gray-s_666">平</span></td>
    <td><span class="text-gray-s_666">积分</span></td>
</tr>
<c:choose>
	<c:when test="${!empty intes.items }">
		<c:forEach items="${intes.items}" var="item" varStatus="num">
			  <tr>
                  <td>
                  	<span class="<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if> s">
                  		${num.index+1}
                 	</span>
                  </td>
                  <td><span style="cursor: pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${item.teaminfo_id}'" class="
                       <c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
	                  	${item.name }
	                  	</span>
                  	</td>
                  <td><span class="
                  		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
                  		${item.games }
                  		</span>
                  </td>
                  <td><span class="
                  		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
                  		${item.win_games }
                  		</span>
                   </td>
                  <td><span class="
                  		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
                  		${item.lose_games }
                  	  </span>
                  </td>
                  <td>
                  		<span class="
                  		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
                  			${item.flat_games }
                  		</span>
                  </td>
                  <td><span class="
                 		<c:if test="${num.index eq 0 }">white_four</c:if>
	                  	<c:if test="${num.index eq 1 }">white_four</c:if>
	                  	<c:if test="${num.index eq 2 }">white_four</c:if>
	                  	<c:if test="${num.index eq 3 }">white_four</c:if>">
                    	${item.sum_integral}
                  	  </span>
                  </td>
              </tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="7">  
			            <div class="nodate">
                            <img src="${ctx}/resources/images/wjqqd.png" alt="Alternate Text" />
                        </div></td>
		</tr>
	</c:otherwise>
</c:choose>
</table>