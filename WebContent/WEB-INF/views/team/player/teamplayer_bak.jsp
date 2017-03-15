<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
	<ul class="ml20 mt5">
		<c:forEach items="${team_players}" var="player" varStatus="i" begin="0" end="2">
			<c:choose>
				<c:when test="${player.type eq 1}">
					<li>
						<div class="membersPic">
							<p class="p_pic">
   								<img src="${el:headPath()}${player.head_icon}" onclick="javascript:window.location='${ctx}/center/${player.user_id}'"/>
   							</p>
   							<p class="text-center text-white">
   								${player.usernick}
   							</p>
   							<p class="text-center text-white">(队长)</p>
                       	</div>    
					</li>
				</c:when>
				<c:when test="${player.type eq 2}">
					<li>
						<div class="membersPic">
	                          	
	                          	<c:if test="${session_user_id eq user_id}">	
	                          		<div class="m_operate" id="${i.index}" style="display: none">
	                          			 <p class="m_operate_p" onclick="changeRole('1','${player.user_id}');">指认队长</p>
	                          			 <p class="m_operate_p" onclick="cancelRole('${player.user_id}');">取消副队</p>
	                          			 <p class="m_operate_p" onclick="kickTeam('${player.user_id}');">踢出</p>
	                             		 <p class="m_operate_p" onclick="defriend('${player.user_id}');">拉黑</p>
	                          		</div>
	                          	</c:if>
	                          	<p class="p_pic">
   									<img src="${el:headPath()}${player.head_icon}" onclick="javascript:window.location='${ctx}/center/${player.user_id}'"/>
	   							</p>
	   							<p class="text-center text-white">
	   								${player.usernick}(副队长)
	   							</p>
                         </div>    
					</li>
				</c:when>
				<c:when test="${player.type eq 3}">
					<li>
						<div class="membersPic">
                   			
	                       	<c:if test="${session_user_id eq user_id}">	
	                        	<div class="m_operate" id="${i.index}" style="display: none">
		                          <p class="m_operate_p" onclick="changeRole('1','${player.user_id}');">指认队长</p>
		                          <p class="m_operate_p" onclick="changeRole('2','${player.user_id}');">任命副队</p>
		                          <p class="m_operate_p" onclick="kickTeam('${player.user_id}');">踢出</p>
		                          <p class="m_operate_p" onclick="defriend('${player.user_id}');">拉黑</p>
		                     	</div> 
		                     </c:if>
		                    <p class="p_pic">
   								<img src="${el:headPath()}${player.head_icon}" onclick="javascript:window.location='${ctx}/center/${player.user_id}'"/>
   							</p>
   							<p class="text-center text-white">
   								${player.usernick}
   							</p>    
                       </div>
					</li>
				</c:when>
			</c:choose>
		</c:forEach>
	</ul>
<c:if test="${session_user_id eq user_id}">	
	<input type="button" value="操作" class="members_operate"/> 
</c:if>
<script type="text/javascript">
	var status =1;
	/* 成员操作 */
	$(".members_operate").click(function(){
	  	if(status==1){
	  		status=0;
	  		$(".m_operate").each(function(){
	  			$(this).css('display','block');
	  		});
	  		$(".members_operate").val("取消");
	  	}else if(status==0){
	  		status=1;
	  		$(".m_operate").each(function(){
	  			$(this).css('display','none');
	  		});
	  		$(".members_operate").val("操作");
	  	}
	  });
</script>