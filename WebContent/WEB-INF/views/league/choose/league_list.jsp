<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>选择联赛</title>
</head>
<body>
<div class="warp">
        <!--头部-->
         <%@ include file="../../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>    
	     <!--导航 end-->
        <div class="wrapper" style="margin-top: 40px;">
            <div class="race">
                <div class="title">
                    <span class="ml20">联赛选择</span>
                </div>
                <div class="select_area">
                   <ul class="enlist_area">
                    	<c:if test="${!empty leagueList}">
	                    	<c:forEach items="${leagueList}" var="league">
	                    	<li>
	                            <div class="enlist">
	                                <div class="i_pic" style="background: url(${el:headPath()}${league.image_src})no-repeat;">
	                                    <p class="area_name">${league.simple_name}</p>
	                                </div>
	                                <input type="button" onclick="javascript:window.location='${ctx}/league/index?league_id=${league.id}'" value="联赛" class="btn_l ms f14" />
	                            </div>
	                        </li>
	                    	</c:forEach>
                    	</c:if>
                        <div class="clearit"></div>
                    </ul>
                    <h3 class="more_area">更多联赛，敬请期待！</h3>
                </div>

            </div>
        </div>
    </div>
      <%@ include file="../../common/footer.jsp" %>
</body>
</html>