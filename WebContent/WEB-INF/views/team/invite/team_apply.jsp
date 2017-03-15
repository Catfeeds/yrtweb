<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<!-- 全局变量 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <table class="the_team">
      <tr>
          <th class="w15"><span>申请人</span></th>
          <th><span>城市</span></th>
          <th><span>年龄</span></th>
          <th><span>身高(cm)</span></th>
          <th><span>体重(kg)</span></th>
          <th class="w15"><span>擅长位置</span></th>
          <th><span>综合能力</span></th>
          <th class="w15"><span>操作</span></th>
      </tr>
      <c:choose>
      	<c:when test="${fn:length(rf.items)>0 }">
      		<c:forEach items="${rf.items}" var="item" varStatus="num">
      			<tr>
			          <td>
			              <img src="${el:headPath()}${item.head_icon}" class="pull-left ml10" onmouseover="showUserInfo('${item.user_id}','#visitor_playerA_${num.index}')" onmouseout="hideUserInfo('#visitor_playerA_${num.index}')">
			              <span>
		                     <!--名片-->
		                    <div class="card" id="visitor_playerA_${num.index}"></div>
		                   </span>
			              <span class="pull-left f14 ml10 mt15">${item.username}</span>
			          </td>
			          <td>
			              <span class="f14">${item.city}</span>
			          </td>
			          <td><span class="f14">
			          	<fmt:formatNumber value="${item.age}" pattern="#"/>
			           </span></td>
			          <td><span class="f14">${item.height}</span></td>
			          <td><span class="f14">${item.weight}</span></td>
			          <td><span class="f14">
			          		<c:forEach items="${fn:split(item.position,',')}" var="pos">
                          			<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
                           	</c:forEach>
			          </span></td>
			          <td><span class="f14">${item.score}</span></td>
			          <td>
			          		<c:choose>
			          			<c:when test="${item.status eq 1 }">
			          				<span class="f14">已同意</span>
			          			</c:when>
			          			<c:when test="${item.status eq 2 }">
			          				<span class="f14">已拒绝</span>
			          			</c:when>
			          			<c:otherwise>
					              <input type="button" name="name" value="同意" class="argee_btn" onclick="agreeApply('${item.user_id}',1)"/>
					              <input type="button" name="name" value="拒绝" class="refuse_btn ml10" onclick="agreeApply('${item.user_id}',2)"/>
			          			</c:otherwise>
			          		</c:choose>
			          </td>
			      </tr>
      		</c:forEach>
      	</c:when>
      	<c:otherwise>
      		<tr>
      			<td colspan="8"><font color="red">暂无数据...</font></td>
      		</tr>
      	</c:otherwise>
      </c:choose>
  </table>
  <ul class="pagination" style="float:right;margin-top:15px;margin-right: 40px;">
   	<c:choose>
   		<c:when test="${rf.pageCount!=0}">
   			<c:choose>
				<c:when test="${rf.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="teamApplyList(1)">首页</a></li>
					<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="teamApplyList(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
					<li class="active"><a>${rf.currentPage}</a></li> 
				</c:when>
				<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="teamApplyList(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="teamApplyList(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="teamApplyList(${rf.pageCount})">末页</a></li> </c:when>
			</c:choose>
   		</c:when>
   	</c:choose>
</ul>	
<div class="clearit"></div>