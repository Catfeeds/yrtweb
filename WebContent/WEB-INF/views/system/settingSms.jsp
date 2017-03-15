<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>短信设置</title>
<c:set var="currentPage" value="SMS"/>
</head>
<body>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../common/header.jsp" %>
		<!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>  
		<div class="wrapper" style="margin-top: 30px;">
			 <!--页面主体-->
			 <div class="container ms">
                <div class="middle">
                <%@include file="left.jsp" %>
			 <div class="content ms">
	             <div class="content_top">
                            <div class="title ms">
                                <span class="text-white f16">短信设置</span>
                            </div>
                            <div class="message_set">
                                <div>
                                    <p class="text-gray f14">您可以在此处设置是否接受宇任拓给你发送的短信设置</p>
                                    <p class="text-gray f14 ml70 mt50">
                                    	<span>接受短信：</span>
                                    	<span>
                                    		<input type="radio" name="receive_sms" value="1" <c:if test="${user.receive_sms eq 1 }">checked="checked"</c:if>/>是
                                    	</span>
                                    	<span class="ml50">
                                    		<input type="radio" name="receive_sms" value="2" <c:if test="${user.receive_sms eq 2 }">checked="checked"</c:if>/>否
                                    	</span>
                                    </p>
                                    <p class="text-gray f14">
                                    	<input type="button" value="保存" class="message_setBtn" onclick="submitVal()"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                   </div>  
                </div>
             </div>         
		</div>
</div>		
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript">
function submitVal(){
	var receive_sms = $("input[name='receive_sms']:checked").val();
	$.ajaxSec({
		type:"POST",
		url:base+"/system/updateSms",
		data:{"receive_sms":receive_sms},
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				layer.msg("保存成功！",{icon: 1});
			}else{
				layer.msg("保存失败！",{icon: 2});
			}
		}
	})
}
</script>
</html>