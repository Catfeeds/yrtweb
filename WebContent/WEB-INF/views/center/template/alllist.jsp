<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/common.jsp" %>
<ul>
	<c:forEach items="${rf.items}" var="dress" varStatus="var">
		<li <c:if test="${var.index == 2 || var.index == 5}">style="margin-right: 0px;"</c:if>>
		<div <c:choose><c:when test="${var.index <3}">class="template1"</c:when><c:otherwise>class="template1 mt"</c:otherwise></c:choose>>		
				<div class="templateCommon"><img src="${filePath}/${dress.img_src}" style="height: 135px;width: 194px;"></div>
				<div class="t_info">
					<span class="pull-left ml10">${dress.name}</span>  
					<span class="pull-right mr10">${dress.price_month}宇币/月</span>
					<div class="clearit"></div>
					<c:choose>
				       <c:when test="${dress.isbuy == 0}"><a href="javascript:void(window.open('${ctx}/centerold/buyDress/${dress.id}'));" class="ml10 text-yellow">购买</a></c:when>
				       <c:when test="${dress.isbuy == 1}">
				      	 <span class="text-gray-s ml10">已购买</span>
				         <%--  <c:choose>
				       		 <c:when test="${dress.status == 1}"><span class="text-gray-s ml10">已购买</span> </c:when>
				       		 <c:otherwise><a href="javascript:void(window.open('${ctx}/center/buyDress/${dress.id}'));" class="ml10 text-yellow">购买</a></c:otherwise>
				          </c:choose> --%>
				       </c:when>   
				    </c:choose>			 
				</div>
			</div>
		</li>
	</c:forEach>
</ul>
<div class="turnPage" style="margin-top: 80px;">
	<ul>
		<c:choose>
		 <c:when test="${rf.pageCount!=0}">
		  <c:choose>
		    <c:when test="${rf.currentPage!=1}"><li style="width: 56px!important;"> <a href="javascript:void(0)" onclick="loadListPage(1)">首页</a></li> <li> <a href="javascript:void(0)" onclick="loadListPage(${rf.currentPage-1})">${rf.currentPage-1}</a></li> <li><b>${rf.currentPage}</b></li></c:when>
		    <c:when test="${rf.currentPage==1}"><li style="width: 56px!important;"> <a href="javascript:void(0)">首页</a></li><li><b>1</b></li> </c:when>
		  </c:choose>
		  <c:choose>
		    <c:when test="${rf.currentPage!=rf.pageCount}"> <li><a href="javascript:void(0)" onclick="loadListPage(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
		      <c:choose>
		        <c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><i>...</i></li> </c:when>
		      </c:choose>
		      <c:choose>
		        <c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li><a href="javascript:void(0)"  onclick="loadListPage(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
		      </c:choose>
		      <li style="width: 56px!important;"><a href="javascript:void(0)" onclick="loadListPage(${rf.pageCount})">末页</a></li>
		    </c:when>
		 	<c:otherwise><li style="width: 56px!important;"><a href="javascript:void(0)" >末页</a></li></c:otherwise>
		  </c:choose>
		 </c:when>
		</c:choose>	
	</ul>
</div>