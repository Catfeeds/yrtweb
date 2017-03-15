<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<c:forEach items="${teams}" var="team" varStatus="var">
	<c:if test="${var.index == 0}">
		<div class="dong_top">
		    <h3 class="text-white f18 dong_ding">俱乐部</h3>
			<img src="${el:headPath()}${team.logo}" style="float: left;width: 80px;height: 80px; cursor:pointer;"
				 onclick="javascript:window.open('${ctx}/team/tdetail/${team.teaminfo_id}')"/>
			<div class="dong_top_r">
				<%-- <img src="${ctx}/resources/images/yellow.png"/>
				<h2><a href="#" style="color: #F0FF00;font-size: 16px;">俱乐部动态消息</a></h2> --%>
		
				<%-- <img src="${filePath}/${team.logo}" style="float: left;width: 80px;height: 80px;"/> --%>
			
				<p style="width: 170px;">${team.text}</p>
			</div>
			<a href="/more/2" class="more_012"><img src="/resources/images/more_2.png"></a>
			<div class="clearit"></div>
		</div>
	</c:if>
</c:forEach>
		<div class="content_bottom">
		   <div class="content_info">
		
			<c:forEach items="${teams}" var="team" varStatus="var">
				<c:if test="${var.index != 0}">
					<!-- <p><img src="/resources/images/sanjiao.png"><a href="${ctx}/team/detail/${session_user_id}.html">${team.text}</a></p> -->
				    <p> ${team.text}</p>
				</c:if>
			</c:forEach>
			</div>
		</div>
		<script type="text/javascript">
        $(function () {
            $(".content_info a").each(function () {
                var maxwidth = 29;
                if ($(this).text().length > maxwidth) {
                    $(this).text($(this).text().substring(0, maxwidth));
                    $(this).html($(this).html() + '…');
                }
            });

        });

 </script>