<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
<c:when test="${empty records.items}">
	<div class="no_match">
	    <span class="text-gray-s_999 f20 ms">近期暂无赛事，敬请期待。</span>
	</div>
</c:when>
<c:otherwise>
	<span class="new_left"></span>
	<span class="new_right"></span>
	<div class="round_info frame" id="record_frame">
	<ul class="clearfix">
	    <c:forEach items="${records.items}" var="record" varStatus="i">
	    	<c:if test="${i.index%3 == 0}">
				<li>
		        <div class="battle_info">
		    </c:if>
		            <div class="battle_${i.index%3}">
		                <dl class="battle_name mt30">
		                    <dt><img src="${el:headPath()}${record.m_logo}" class="n_logo" style="height:50px;width: 50px;"></dt>
		                    <dd><span>${record.m_team_name}</span></dd>
		                </dl>
		                <dl class="bvs">
			                <c:choose>
			                	<c:when test="${record.status == 2}">
			                		 <dd><span>${record.m_score}:${record.g_score}</span></dd><dd></dd>
			                	</c:when>
			                	<c:otherwise>
				                    <dd><span><fmt:formatDate value='${record.play_time}' pattern='yyyy-MM-dd HH:mm:ss'/></span></dd>
			                	</c:otherwise>
			                </c:choose>
		                </dl>
		                <dl class="battle_name mt30">
		                    <dt><img src="${el:headPath()}${record.g_logo}" class="n_logo" style="height:50px;width: 50px;"></dt>
		                    <dd><span>${record.g_team_name}</span></dd>
		                </dl>
		            </div>
			    <c:if test="${i.index%3 == 2}">
			        </div>
					</li>
			    </c:if>
	    </c:forEach>
	</ul>
	</div>
</c:otherwise>
</c:choose>