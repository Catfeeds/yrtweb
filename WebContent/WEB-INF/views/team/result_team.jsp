<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<input type="hidden" id="p_order_str" value="${params.order_str}"/>
<input type="hidden" id="p_order_type" value="${params.order_type}"/>
<div class="club_area">
    <ul class="club_list">
    	<c:forEach items="${rf.items}" var="team" varStatus="teamIndex"> 
    		<input type="hidden" name="is_pk_${team.id}" id="is_pk_${team.id}" value="${team.is_pk}"/>
        <li>
            <div class="club_infos">
            <div style="float:left; width: 110px;height:110px;margin-left: 8px; border: 1px solid #666;
    border-radius: 4px;margin-top: 10px;">
            	<c:if test="${not empty team.tlid}">
                <span class="biaoji"></span>
            	</c:if>
                <img src="${el:headPath()}${team.logo}" onclick="window.open('${ctx}/team/detail/${team.user_id}.html')" style="cursor: pointer;" alt="" />
            </div>
                <dl>
                    <dt><span class="f16 ms text-white" onclick="window.open('${ctx}/team/detail/${team.user_id}.html')" style="cursor: pointer;">${team.name}</span></dt>
                    <dd><span class="f16 ms text-white">${team.province}${team.city}</span></dd>
                    <dd><span class="f16 ms text-orange">资产：
                    	<c:choose>
                    		<c:when test="${empty team.amount}">
                    		0
                    		</c:when>
                    		<c:otherwise>
		                    	<fmt:formatNumber value="${team.amount}" pattern="##0"/>
                    		</c:otherwise>
                    	</c:choose>
                    	宇币</span></dd>
                    <dd><span class="f16 ms text-orange">战力：${team.combat}</span></dd>
                </dl>
                <div class="clearit"></div>
            </div>
            <div class="btn_div">
                <c:choose>
                	<c:when test="${!empty team.f_teaminfo_id}">
                		<input type="button" onclick="deleteFocus('${team.id}','${rf.currentPage}')" value="取消关注" class="btn_l" />
                	</c:when>
                	<c:otherwise>
                		<input type="button" onclick="t_focus('${team.id}','${rf.currentPage}')" value="关注" class="btn_l" />
                	</c:otherwise>
                </c:choose>
                <input type="button" name="name" value="" id="setting" class="setting ml5" />
                <div class="tools_sss">
                    <dl>
                        <dd><span onclick="inviteTeam('${team.id}','${team.name}','${team.logo}')">挑战</span></dd>
                        <%-- <dd><span onclick="join('${team.id}')">加入</span></dd> --%>
                        <dd><span onclick="openMsg('${team.id}');">私信</span></dd>
                    </dl>
                </div>
            </div>
        </li>
        </c:forEach>
        <div class="clearit"></div>
    </ul>
</div>
<ul class="pagination" style="float:right;margin-top:15px;">
    	<li><label class="index">第${rf.currentPage}页/共${rf.pageCount}页</label> </li>
    	<li><label class="sum">共计${rf.totalCount}条</label> </li>
		<li><a href="javascript:void(0)" onclick="loadTeamList(0);">首页</a></li>
			<c:choose>
				<c:when test="${rf.currentPage-1>0}">
					<li><a href="javascript:void(0)" onclick="loadTeamList(${rf.currentPage-1});">上一页</a></li>
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
					<li><a href="javascript:void(0)" onclick="loadTeamList(${rf.currentPage+1});">下一页</a></li>
				</c:otherwise>
			</c:choose>	
		<li><a href="javascript:void(0)" onclick="loadTeamList(${rf.pageCount});">最后一页</a></li>
		<li><input type="text" name="pIndex" id="pIndex" value="" class="ipt"/></li> 
		<li><a href="javascript:void(0)" onclick="loadTeamList();">跳转</a></li> 
    </ul>	
<div class="clearit"></div>

<script type="text/javascript">
$($(".setting")).each(function () {
    $(this).click(function () {
        if ($(this).next(".tools_sss").is(":visible")) {
            $(this).next(".tools_sss").hide();
        } else {
            $(this).next(".tools_sss").show();
        }

    });
});
$(document).click(function(e) {
	var vinp = $(e.target).attr("id");
    if (!$(".setting").is(':has(' + e.target.localName + ')') && e.target.id != 'setting') {
        $(".tools_sss").hide();
    }
});
</script>