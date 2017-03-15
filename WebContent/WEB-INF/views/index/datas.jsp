<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%-- <c:forEach items="${games}" var="game" varStatus="var">
		<div style="height: 110px;">
			<img src="${filePath}/${game.r_logo}" style="float: left;width: 116px;height:116px;"/>
			<div style="float: left;">
				<img src="${ctx}/resources/images/yellow.png"/>
				<h2><a href="#" style="color: #F0FF00;font-size: 16px">俱乐部比赛预告</a></h2>
				
				<p style="width: 170px;">${game.r_name}将于${game.game_time}与${game.t_name}在${game.position}进行比赛</p>
			</div>
			<div class="clearit"></div>
		</div>
</c:forEach> --%>

<table class="new_info">
	<c:choose>
		<c:when test="${type == 1 }">
			<c:forEach items="${pageModel.items}" var="data" varStatus="var">
			    <tr>
			        <td class="left"><span><a href="${ctx}/team/tdetail/${data.respond_teaminfo_id}" target="_blank">${data.r_name}</a>将于${data.game_time}与<a href="${ctx}/team/tdetail/${data.initiate_teaminfo_id}" target="_blank">${data.t_name}</a>在${data.position}进行比赛</span></td>
			        <td><span>${data.game_time}</span></td>
			    </tr>
		    </c:forEach>
		</c:when>
		<c:when test="${(type == 2) or (type == 3)}">
			<c:forEach items="${pageModel.items}" var="data" varStatus="var">
			  <tr>
		        <td class="left">
		        	<span>
		        		<c:choose>
		        			<c:when test="${type == 3 }">
		        				<a href="${ctx}/center/${data.user_id}">${data.usernick}:</a>${data.text}
		        			</c:when>
		        			<c:otherwise>
					        	${data.text}
		        			</c:otherwise>
		        		</c:choose>
		        	</span>
	        	</td>
		        <td><span></span></td>
		      </tr>
		    </c:forEach>  
		</c:when>
	</c:choose>
</table>
<ul class="pagination" style="float:right;margin-top:15px;">
    	<c:choose>
    		<c:when test="${pageModel.pageCount!=0}">
    			<c:choose>
					<c:when test="${pageModel.currentPage!=1}"> 
						<li data-command="prev"><a href="javascript:void(0)" onclick="loadListPage(1)">首页</a></li>
						<li data-page-num="${pageModel.currentPage-1}"> <a href="javascript:void(0)" onclick="loadListPage(${pageModel.currentPage-1})">${pageModel.currentPage-1}</a></li>
						<li class="active"><a>${pageModel.currentPage}</a></li> 
					</c:when>
					<c:when test="${pageModel.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
				</c:choose>
				<c:choose>
				<c:when test="${pageModel.currentPage!=pageModel.pageCount}"> <li data-page-num="${pageModel.currentPage+1}"><a href="javascript:void(0)" onclick="loadListPage(${pageModel.currentPage+1})">${pageModel.currentPage+1}</a></li>
				<c:choose>
				<c:when test="${(pageModel.currentPage+2)<pageModel.pageCount}"> <li><a>...</a></li> </c:when>
				</c:choose>
				<c:choose>
				<c:when test="${(pageModel.currentPage+1)!=pageModel.pageCount}"> <li data-page-num="${pageModel.pageCount}"><a href="javascript:void(0)"  onclick="loadListPage(${pageModel.pageCount})">${pageModel.pageCount}</a></li> </c:when>
				</c:choose>
				<li data-command="next"><a href="javascript:void(0)" onclick="loadListPage(${pageModel.pageCount})">末页</a></li> </c:when>
				</c:choose>
    		</c:when>
    	</c:choose>
    </ul>	
<div class="clearit"></div>
 <script type="text/javascript">
        $(function () {
            $(".new_info tr:odd").not("th").css({ "background": "#1A1A17" });
            $(".new_info tr:even").not("th").css({ "background": "" });
        });
 </script>