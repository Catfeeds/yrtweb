<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>选择市场</title>
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
                    <span class="ml20">赛区转会市场</span>
                </div>
                <div class="select_area">
                   <ul class="enlist_area">
                    	<c:if test="${!empty leagueAreas}">
                    	<c:forEach items="${leagueAreas}" var="area">
                    	<li>
                            <div class="enlist">
                                <div class="i_pic" style="background: url(${el:headPath()}${area.image_src})no-repeat;">
                                    <p class="area_name"><yt:areaName code="${area.area_code}" clazz="form-control"/>赛区</p>
                                </div>
                                <input type="button" onclick="javascript:window.location='${ctx}/playerTrade/list?s_id=${area.id}'" value="转会市场" class="btn_l ms f14" />
                            </div>
                        </li>
                    	</c:forEach>
                    	</c:if>
                        
                        <div class="clearit"></div>
                    </ul>
                    <h3 class="more_area">更多赛区，敬请期待！</h3>
                </div>

            </div>
        </div>
    </div>
      <%@ include file="../../common/footer.jsp" %>
</body>
</html>