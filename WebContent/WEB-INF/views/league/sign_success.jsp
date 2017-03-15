<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-俱乐部报名</title>
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
                <div class="player_reg">
                    <ul>
                        <li class="actived"><span>1、报名须知</span></li>
                        <li class=""><span>2、填写资料</span></li>
                        <li class=""><span>3、等待审核</span></li>
                       <!--  <li class=""><span>4、支付报名费</span></li> -->
                        <li class=""><span>4、参赛方式</span></li>
                        <li class="active"><span>5、完成</span></li>
                        <div class="clearit"></div>
                    </ul>
                </div>
                <div class="staus">
                    <span class="right ms">报名成功</span>
                </div>
                <div style="width: 460px; margin: 20px auto; text-align: center; color: #fff; font-size: 16px; font-family: 'Microsoft YaHei'">
                	<c:if test="${entryMode=='1'}">
                    <p>恭喜您已成功报名宇任拓超级联赛，等待您的伯乐吧。 </p>
                	</c:if>
                	<c:if test="${entryMode=='2'}">
                    <p>恭喜您已成功报名宇任拓超级联赛，等待您的伯乐吧。 </p>
                	</c:if>
                    <p class="mt5">宇任拓，由你精彩</p>
                </div>

                <div style="width: 80%;margin: 40px auto 0;text-align: center;">
                    <input type="button" onclick="location.href='${ctx}/center'" value="上传精彩视频" class="btn_l f16 ms" />
                    <input type="button" onclick="location.href='${ctx}/'" value="返回首页" class="btn_l f16 ms" style="background: #7d7d7d;"/>
                </div>


            </div>

        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
<script type="text/javascript">

</script>
</body>
</html>