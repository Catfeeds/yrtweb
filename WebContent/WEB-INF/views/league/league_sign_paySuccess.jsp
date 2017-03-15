<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>成功</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
</head>
<body>
<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
	     <div class="wrapper" style="margin-top: 116px;">
            <div class="reg_result">
                <div class="result_title">
                    <span class="text-white ml20 f16 ms">报名结果</span>
                </div>
                <c:choose>
                	<c:when test="${flag eq true }">
                		  <div class="staus">
			                    <span class="right ms">缴费成功</span>
			                </div>
			                <div style="width: 460px; margin: 20px auto; text-align: center; color: #fff; font-size: 16px; font-family: 'Microsoft YaHei'">
			                    <p>恭喜您已成功报名宇任拓超级联赛，等待您的伯乐吧。 </p>
			                    <p class="mt5">宇任拓，由你精彩</p>
			                </div>
			              <%--   <div style="width: 80%;margin: 40px auto 0;text-align: center;">
			                    <input type="button" name="name" value="上传精彩视频" class="btn_l f16 ms" />
			                    <input type="button" name="name" onclick="window.location='${ctx}/'" value="返回首页" class="btn_l f16 ms" style="background: #7d7d7d;"/>
			                </div> --%>
                	</c:when>
                	<c:otherwise>
                			<div class="staus">
			                    <span class="fail ms">报名失败</span>
			                </div>
			                <div style="width: 460px; margin: 20px auto; text-align: center; color: #fff; font-size: 16px; font-family: 'Microsoft YaHei'">
			                    <p>很遗憾，您的报名失败了，感谢您对宇任拓的关注。 </p>
			                    <p class="mt5">宇任拓，由你精彩</p>
			                </div>
			                <div style="width: 80%;margin: 40px auto 0;text-align: center;">
			                    <input type="button" name="name" onclick="window.location='${ctx}/'" value="返回首页" class="btn_l f16 ms" style="background: #7d7d7d;"/>
			                </div>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
</div>	  
<%@ include file="../common/footer.jsp" %>   
</body>
</html>