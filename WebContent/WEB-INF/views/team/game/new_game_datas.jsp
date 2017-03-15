<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<table class="lc_tab" >
<tr>
  <th style="width: 5%;"><span>场次</span></th>
  <th colspan="3" style="width: 20%;"><span>对战双方</span></th>
  <th style="width: 5%;"><span>比分</span></th>
  <th><span>时间地点</span></th>
  <c:if test="${session_user_id!=null and (session_user_id eq oth_user_id)}">
  <th style="width: 5%;"><span>比赛状态</span></th>
  </c:if>
</tr>
<c:choose>
	<c:when test="${!empty rf.items }">
		<c:forEach items="${rf.items}" var="item" varStatus="st">
				<tr>
                       <td>
                           <span>第${rf.totalCount-rf.pageSize*(rf.currentPage-1)-st.index}场</span>
                       </td>
                       <td style="width: 7%;cursor:pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${item.initiate_teaminfo_id}.html'">
                         <a>${item.t_name}</a>

                     </td>
                     <td style="width: 4%;">
                         <span>VS</span>

                     </td>
                     <td style="width: 7%;cursor:pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${item.respond_teaminfo_id}.html'">
                         <a>${item.r_name }</a>

                     </td>
                     <td>
                         <span>${item.initiate_score }</span>:<span>${item.respond_score}</span>
                     </td>
                     <td>
                         <dl>
                             <dt>
	                             <span>
	                               <fmt:formatDate value="${item.game_time}" pattern="yyyy-MM-dd"/> 
	                             </span>
                             </dt>
                             <dd><span>${item.position}</span></dd>
                         </dl>
                     </td>
                     <c:if test="${session_user_id!=null and (session_user_id eq oth_user_id)}">
                     <td>
                     	<c:choose>
                     		<c:when test="${item.status == 0}">
                     		  <a class="text-red" href="javascript:void(0)" onclick="wriBeScore('${item.id}')">【录入比分】</a>
                     		</c:when>
                     		<c:otherwise>
								<c:choose>
									<c:when test="${item.status eq 1}">
				                           <span>双方确认</span>
									</c:when>
									<c:when test="${item.status eq 2}">
					                         <span>比赛作废</span>
									</c:when>
									<c:when test="${item.status eq 3}">
				                          <c:choose>
					                     	<c:when test="${item.initiate_teaminfo_id eq teaminfo_id}">
					                     		<c:choose>
					                     			<c:when test="${item.initiate_sure == 1 }">
								                         <span>对方未确认</span>
					                     			</c:when>
					                     			<c:otherwise>
					                     			 <a class="text-red" href="javascript:void(0)" onclick="wriBeScore('${item.id}')">【确认比分】</a>
					                     			</c:otherwise>
					                     		</c:choose>
					                     	</c:when>
					                     	<c:otherwise>
					                     		<c:choose>
					                     			<c:when test="${item.initiate_sure == 1 }">
								                          <a class="text-red" href="javascript:void(0)" onclick="wriBeScore('${item.id}')">【确认比分】</a>
					                     			</c:when>
					                     			<c:otherwise>
					                     				 <span>对方未确认</span>
					                     			</c:otherwise>
					                     		</c:choose>
					                     	</c:otherwise>
					                     </c:choose>   
									</c:when>
									<c:when test="${item.status eq 4}">
										联赛比赛
									</c:when>
								</c:choose>
                     		</c:otherwise>
						</c:choose>	
                     </td>
                     </c:if>
                 </tr>
		</c:forEach>
	</c:when>
</c:choose>
</table>
<c:if test="${type eq 'LIST'}">
					<!-- 分页start -->
						 <ul class="pagination" style="float:right;margin-top:15px;margin-right: 40px;">
					    	<c:choose>
					    		<c:when test="${rf.pageCount!=0}">
					    			<c:choose>
										<c:when test="${rf.currentPage!=1}"> 
											<li data-command="prev"><a href="javascript:void(0)" onclick="loadListPage(1,'${teaminfo_id}','LIST')">首页</a></li>
											<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadListPage(${rf.currentPage-1},'${teaminfo_id}','LIST')">${rf.currentPage-1}</a></li>
											<li class="active"><a>${rf.currentPage}</a></li> 
										</c:when>
										<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
									</c:choose>
									<c:choose>
									<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadListPage(${rf.currentPage+1},'${teaminfo_id}','LIST')">${rf.currentPage+1}</a></li>
									<c:choose>
									<c:when test="${(rf.currentPage+2)<rf.pageCount}"><li><a>...</a></li> </c:when>
									</c:choose>
									<c:choose>
									<c:when test="${(rf.currentPage+1)!=rf.pageCount}"><li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadListPage(${rf.pageCount},'${teaminfo_id}','LIST')">${rf.pageCount}</a></li> </c:when>
									</c:choose>
									<li data-command="next"><a href="javascript:void(0)" onclick="loadListPage(${rf.pageCount},'${teaminfo_id}','LIST')">末页</a></li> </c:when>
									</c:choose>
					    		</c:when>
					    	</c:choose>
					    </ul>	
						<div class="clearit"></div>
					    <!-- 分页end --> 
</c:if>
