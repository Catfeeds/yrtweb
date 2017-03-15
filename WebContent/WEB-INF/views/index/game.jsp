<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<c:forEach items="${games}" var="game" varStatus="var">
	<c:if test="${var.index == 0}">
		<div class="dong_top">
		   <!--  <span class="text-white">比赛</span> -->
		    <h3 class="text-white f18 dong_ding">比 赛</h3>
			<img src="${el:headPath()}${game.t_logo}" style="float: left;width: 80px;height:80px;cursor:pointer;" onclick="javascript:window.open('${ctx}/team/tdetail/${game.initiate_teaminfo_id}')"/>
			<div class="dong_top_r">
				<%-- <img src="${ctx}/resources/images/yellow.png"/>
				<h2><a href="#" style="color: #F0FF00;font-size: 16px">俱乐部比赛预告</a></h2> --%>
				
				<p style="width: 170px;">
					<a href="${ctx}/team/tdetail/${game.initiate_teaminfo_id}">${game.t_name}</a>将于${game.game_time}与<a href="${ctx}/team/tdetail/${game.respond_teaminfo_id}" target="_blank">${game.r_name}</a>在${game.position}进行比赛
				</p>
			</div>
			<a href="/more/1" class="more_012"><img src="${ctx}/resources/images/more_2.png" /></a>
			<div class="clearit"></div>
		</div>
	</c:if>
</c:forEach>
<div class="content_bottom">
 <div class="content_info">
	<c:forEach items="${games}" var="game" varStatus="var">
		<c:if test="${var.index != 0}">
			<!-- <p><img src="/resources/images/sanjiao.png"><a href="#"> ${game.r_name}将于${game.game_time}与${game.t_name}在${game.position}进行比赛</a></p> -->
			<p>
				<a href="${ctx}/team/tdetail/${game.initiate_teaminfo_id}">${game.t_name}</a>将于${game.game_time}与<a href="${ctx}/team/tdetail/${game.respond_teaminfo_id}" target="_blank">${game.r_name}</a>在${game.position}进行比赛
			</p>
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