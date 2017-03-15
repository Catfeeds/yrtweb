<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<c:forEach items="${players}" var="player" varStatus="var">
	<c:if test="${var.index == 0}">

		<div class="dong_top">
		    <h3 class="text-white f18 dong_ding">球 员</h3>
			<img src="${el:headPath()}${player.head_icon}" style="float: left;width: 80px;height: 80px;cursor:pointer;" onclick="javascript:window.open('${ctx}/center/${player.user_id}')"/>
			<div class="dong_top_r">
				
				<p style="width: 170px;">
				<a href="${ctx}/center/${player.user_id}" class="text-white">${player.usernick}:</a>
					${player.text}
				</p>
			</div>
			<a href="/more/3" class="more_012"><img src="/resources/images/more_2.png"></a>
			<div class="clearit"></div>
		</div>
	</c:if>
</c:forEach>
<div class="content_bottom">
   <div class="content_info">
	<c:forEach items="${players}" var="player" varStatus="var">
		<c:if test="${var.index != 0}">
			<!-- <p><img src="${ctx}/resources/images/sanjiao.png"/><a href="${ctx}/center/${player.user_id}">${player.text}</a></p> -->
			<p><a href="${ctx}/center/${player.user_id}" target="_blank">${player.usernick}:</a>${player.text}</p>
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