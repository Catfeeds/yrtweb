<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
 <table style="float: left; width: 100%;margin-top: 20px;">
    <tr>
        <th><span>头像</span></th>
        <th><span>名称</span></th>
        <th><span>年龄</span></th>
        <th><span>所属俱乐部</span></th>
        <th><span>球员综合评分</span></th>
        <th><span>场上位置</span></th>
        <th><span>所属城市</span></th>
        <th><span>常参与赛制</span></th>
        <th><span>特性标签</span></th>
        <c:if test="${!empty session_user_id}">
      	<th><span>操作</span></th>
        </c:if>
    </tr>
   <c:forEach items="${rf.items}" var="player" varStatus="i"> 
		<tr>
	        <td>
	            <!-- <a class="match_1"></a> -->
	            <img src='${el:headPath()}${player.head_icon}' style="cursor: pointer;" class='ml15' width="40px" height="40" onclick="javascript:window.location='${ctx}/center/${player.user_id}'"/>
	        </td>
	        <td>
	            <span><a href="${ctx}/center/${player.user_id}" target="_blank" class="no">${player.usernick}</a></span>
	        </td>
	        <td>
	        	 <span>${player.age}</span>
	        </td>
	        <td>
	            <span><a target="_blank" href="${ctx}/team/tdetail/${player.team_id}.html" class="no">
	            	<yt:id2NameDB beanId="teamInfoService" id="${player.team_id}"></yt:id2NameDB></a></span>
	        </td>
	        <td>
	            <span>${player.score}</span>
	        </td>
	        <td>
	            <span><yt:dict2Name nodeKey="p_position" key="${player.position}"></yt:dict2Name></span>
	        </td>
	        <td>
	            <span>${player.city}</span>
	        </td>
	        <td>
	            <span>${player.ball_format}</span>
	        </td>
	        <td>
		        <span><yt:dict2Name nodeKey="p_tags" key="${player.tags}"></yt:dict2Name></span>
	        </td>
	        <c:if test="${!empty session_user_id}">
		        <td>
		            <dl>
		            	<c:choose>
			            	<c:when test="${!empty session_user_id}">
			                	<dt>
			                		<a href="javascript:void(0)" onclick="openMsg('${player.user_id}','${player.usernick}');" class="text-white a_tool">私信</a>
			                		<a href="javascript:void(0)" class="ml5 text-white a_tool" onclick="trialShow('${player.user_id}')">试训</a>
			                	</dt>
			               	 	<dd class="mt5">
			               	 		<%-- <a href="javascript:void(0)" onclick="sign_user(this,'${player.user_id}');" class="text-white">签约</a> --%>
			               	 		<c:choose>
					                	<c:when test="${!empty player.f_user_id}">
					                		<a href="javascript:void(0)" onclick="focus_user(this,'${player.user_id}',true,'${rf.currentPage}');" class="text-white a_tool">取消</a>
					                	</c:when>
					                	<c:otherwise>
					               	 		<a href="javascript:void(0)" onclick="focus_user(this,'${player.user_id}','','${rf.currentPage}');" class="text-white a_tool">关注</a>
					                	</c:otherwise>
					                </c:choose>
			               	 		<a href="javascript:void(0)" class="ml5 text-white a_tool" onclick="invite_user(this,'${player.user_id}');">邀请</a>
			               	 	</dd>
			            	</c:when>
			            	<c:otherwise>
			                	<dt>
			                		<a href="javascript:void(0)" class="text-gray a_tool" onclick="layer.msg('请登录后操作!',{icon: 2});">私信</a>
			                		<a href="javascript:void(0)" class="ml5 text-gray a_tool" onclick="layer.msg('请登录后操作!',{icon: 2});">试训</a>
			                	</dt>
			               	 	<dd class="mt5">
			               	 		<!-- <a href="javascript:void(0)" class="text-gray" onclick="layer.msg('请登录后操作!',{icon: 2});">签约</a> -->
			               	 		<a href="javascript:void(0)" class="text-white a_tool" onclick="layer.msg('请登录后操作!',{icon: 2});" >关注</a>
			               	 		<a href="javascript:void(0)" class="ml5 text-gray a_tool" onclick="layer.msg('请登录后操作!',{icon: 2});">邀请</a>
			               	 	</dd>
			            	</c:otherwise>
		            	</c:choose>
		            </dl>
		        </td>
		       </c:if> 
	    </tr>
 	</c:forEach>
</table>
<div class="clearit"></div>

<ul class="pagination" style="float:right;margin-top:15px;">
   	<li><label class="index">第${rf.currentPage}页/共${rf.pageCount}页</label> </li>
   	<li><label class="sum">共计${rf.totalCount}条</label> </li>
	<li><a href="javascript:void(0)" onclick="userSearch(0);">首页</a></li>
		<c:choose>
			<c:when test="${rf.currentPage-1>0}">
				<li><a href="javascript:void(0)" onclick="userSearch(${rf.currentPage-1});">上一页</a></li>
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
				<li><a href="javascript:void(0)" onclick="userSearch(${rf.currentPage+1});">下一页</a></li>
			</c:otherwise>
		</c:choose>	
	<li><a href="javascript:void(0)" onclick="userSearch(${rf.pageCount});">最后一页</a></li>
	<li><input type="text" name="pIndex" id="pIndex" value="" class="ipt"/></li> 
	<li><a href="javascript:void(0)" onclick="userSearch();">跳转</a></li> 
</ul>
<%-- <ul class="pagination" style="float: right">
   	<c:choose>
   		<c:when test="${rf.pageCount!=0}">
   			<c:choose>
				<c:when test="${rf.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="userSearch(1)">首页</a></li>
					<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="userSearch(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
					<li class="active"><a>${rf.currentPage}</a></li> 
				</c:when>
				<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
			</c:choose>
			<c:choose>
			<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="userSearch(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
			<c:choose>
			<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
			</c:choose>
			<c:choose>
			<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="userSearch(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
			</c:choose>
			<li data-command="next"><a href="javascript:void(0)" onclick="userSearch(${rf.pageCount})">末页</a></li> </c:when>
			</c:choose>
   		</c:when>
   	</c:choose>
</ul>	 --%>
