<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>俱乐部成员列表</title>
</head>
<body>
    <div class="warp">
        <!--头部-->
    	<%@ include file="../../common/header.jsp" %> 
        <!--导航-->
        <%@ include file="../../common/naver.jsp" %>    
        <input type="hidden" id="teaminfo_id" name="teaminfo_id" value="${teaminfo_id}"/>
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="mt20">
                <div class="p_title" style="text-align: center;">
                    <span class="f14 ml20 ms text-white">俱乐部成员</span>
                </div>
                <div class="player_pic">
                    <ul class="clearfix">
                        <c:forEach items="${team_players}" var="player" varStatus="i">
							<c:choose>
								<c:when test="${player.type eq 1}">
										<li onmouseover="showBtn('#${i.index}');" onmouseout="hideBtn('#${i.index}');">
											 <div class="person">
												<%-- <img src="${ctx}/resources/images/duiz.jpg" />--%>
												<img src="${el:headPath()}${player.head_icon}" onclick="javascript:window.location='${ctx}/center/${player.user_id}'" style="cursor: pointer;"/>
												<p class="mt10 f12 ms text-white">${player.usernick}</p>
												<p class="text-center text-white">(队长)</p>
											</div>	
										</li>
								</c:when>
								<c:when test="${player.type eq 2}">
									<li onmouseover="showBtn('#${i.index}');" onmouseout="hideBtn('#${i.index}');">
										<div class="person">
											<%-- <img src="${filePath}/${player.head_icon}" /> --%>
											<img src="${el:headPath()}${player.head_icon}" onclick="javascript:window.location='${ctx}/center/${player.user_id}'" style="cursor: pointer;"/>
											<p class="mt10 f12 ms text-white">${player.usernick}(副队长)</p>
											<c:if test="${session_user_id eq user_id}">	
												<div id="${i.index}" style="display: none">
													<p style="background: #00B9ED;border-bottom: 1px solid;"><a href="javascript:void(0);" onclick="changeRole('1','${player.user_id}');">指认队长</a></p>
													<p style="background: #00B9ED;border-bottom: 1px solid;"><a href="javascript:void(0);" onclick="cancelRole('${player.user_id}');">取消队长</a></p>
													<p style="background: #00B9ED;border-bottom: 1px solid;"><a href="javascript:void(0);" onclick="kickTeam('${player.user_id}');">踢出</a></p>
													<p style="background: #00B9ED;"><a href="javascript:void(0);" onclick="defriend('${player.user_id}');">拉黑</a></p>
												</div>
											</c:if>
										</div>	
									</li>
								</c:when>
								<c:when test="${player.type eq 3}">
									<li onmouseover="showBtn('#${i.index}');" onmouseout="hideBtn('#${i.index}');">
										<div class="person">
											<%-- <img src="${filePath}/${player.head_icon}" /> --%>
											<img src="${el:headPath()}${player.head_icon}" onclick="javascript:window.location='${ctx}/center/${player.user_id}'" style="cursor: pointer;"/>
											<p class="mt10 f12 ms text-white">${player.usernick}</p>
											<c:if test="${session_user_id eq user_id}">	
												<div id="${i.index}" style="display: none">
													<p style="background: #00B9ED;border-bottom: 1px solid;"><a href="javascript:void(0);" onclick="changeRole('1','${player.user_id}');">指认队长</a></p>
													<p style="background: #00B9ED;border-bottom: 1px solid;"><a href="javascript:void(0);" onclick="changeRole('2','${player.user_id}');">任命副队</a></p>
													<p style="background: #00B9ED;border-bottom: 1px solid;"><a href="javascript:void(0);" onclick="kickTeam('${player.user_id}');">踢出</a></p>
													<p style="background: #00B9ED;"><a href="javascript:void(0);" onclick="defriend('${player.user_id}');">拉黑</a></p>
												</div>
											</c:if>
										</div>
									</li>
								</c:when>
							</c:choose>
						</c:forEach>
                    </ul>
                    <div class="clearit"></div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../../common/footer.jsp" %>
    <script src="${ctx}/resources/js/own/playeropt.js"></script>
</body>
</html>
