<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
	 <table class="race_card">
	     <tr>
          	 <th><span class="f12">排名</span></th>
             <th class="w190"><span class="f12">球员</span></th>
             <th class="w305"><span class="f12">俱乐部</span></th>
             <th><span class="f12">红牌</span></th>
             <th><span class="f12">黄牌</span></th>
             <th><span class="f12">双黄牌</span></th>
	     </tr>
	     <c:choose>
	     	<c:when test="${!empty rf.items}">
			     <c:forEach items="${rf.items}" var="card" varStatus="i">
				     <tr>
				         <td>
				         	 <div 
				         	 	<c:choose>
				         	 		<c:when test="${i.index == 0}">
				         	 			class="f_1"
				         	 		</c:when>
				         	 		<c:when test="${i.index == 1}">
				         	 			class="s_2"
				         	 		</c:when>
				         	 		<c:when test="${i.index == 2}">
				         	 			class="t_3"
				         	 		</c:when>	
				         	 		<c:otherwise>
				         	 			class="f_4"
				         	 		</c:otherwise>
				         	 	</c:choose>
				         	 >
 								<span class="seq">
									${i.index+1}
								</span>
                             </div>
				         </td>
				         <td>
				             <img src="${el:headPath()}${card.head_icon}" alt="头像" class="portrait" />
				             <span class="z_name"><a href="${ctx}/center/${card.id}" class="text-white"><yt:userName id="${card.id}"/></a></span>
				         </td>
				         <td>
				         	 <img src="${el:headPath()}${card.logo}" alt="头像" class="team_name" />
                             <span class="z_name">
                             	<a href="${ctx}/team/tdetail/${card.teaminfo_id}" class="text-white">
		         					${card.tname}
		         				</a>
                             </span>
				         </td>
				         <td><span class="f14 ms"><fmt:formatNumber value="${card.hongpai_num}" pattern="#0"/></span></td>
				         <td><span class="f14 ms"><fmt:formatNumber value="${card.huangpai_num}" pattern="#0"/></span></td>
				         <td><span class="f14 ms"></span></td>
				     </tr>
			     </c:forEach>
			 </c:when>    
	     <c:otherwise>
			<tr>
				<tr><td colspan='5'>暂无红黄牌纪录......</td></tr>
			</tr>
		</c:otherwise>
		</c:choose>
	 </table>
<ul class="pagination" style="float:right;margin-top:60px;">
   	<li><label class="index">第${rf.currentPage}页/共${rf.pageCount}页</label> </li>
   	<li><label class="sum">共计${rf.totalCount}条</label> </li>
	<li><a href="javascript:void(0)" onclick="cardSearch(0);">首页</a></li>
		<c:choose>
			<c:when test="${rf.currentPage-1>0}">
				<li><a href="javascript:void(0)" onclick="cardSearch(${rf.currentPage-1});">上一页</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:void(0)">上一页</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${rf.currentPage+1>rf.pageCount}">
				<li><a href="javascript:void(0)">下一页</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:void(0)" onclick="cardSearch(${rf.currentPage+1});">下一页</a></li>
			</c:otherwise>
		</c:choose>	
	<li><a href="javascript:void(0)" onclick="cardSearch(${rf.pageCount});">最后一页</a></li>
</ul>
<div class="clearit"></div>
