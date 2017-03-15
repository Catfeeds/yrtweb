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
                    <ul style="margin-left: 148px;">
                        <li class="actived"><span>1、报名须知</span></li>
                        <li class=""><span>2、填写资料</span></li>
                        <li class="active"><span>3、完成</span></li>
                        <div class="clearit"></div>
                    </ul>
                </div>
                <div class="staus">
                    <span class="right ms">您已成功报名</span>
                </div>
                <div class="tishi"></div>
                <div style="width: 80%;margin: 40px auto 0;text-align: center;">
                    <input type="button" onclick="location.href=base+'/team/guide'" value="确定" class="btn_l f20 ms" />
                </div>

            </div>

        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
<script type="text/javascript">

</script>
</body>
</html>