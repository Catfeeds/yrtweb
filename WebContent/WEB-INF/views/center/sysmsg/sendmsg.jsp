<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />
<link href="${app}/resources/css/center.css" rel="stylesheet" />
<link href="${app}/resources/css/reset.css" rel="stylesheet" />
<form action="" method="post">
	<input type="hidden" name="s_id" id="s_id" value="${s_id}"/>
	<div class="masker">
	    </div>
	    <div class="privateLetter">
	        <div class="closeBtn_1" onclick="close_msg_iframe()"></div>
	        <div class="custom_title">
	            <span class="f16 text-white ms">私信发送</span>
	        </div>
	        <table class="u_letter">
	            <tr>
	                <td class="w60"><span style="font-size: 14px;">收件人：</span></td>
	                <td><span style="font-size: 14px;">${usernick}</span></td>
	            </tr>
	            <tr>
	                <td valign="top">
	                    <span style="font-size: 14px;">内&emsp;容：</span>
	                </td>
	                <td>
	                    <textarea id="content"></textarea>
	                </td>
	            </tr>
	            <tr><td colspan="2">
	                    <input type="button" id="sendBtn" onclick="sendMsg();" value="发送" class="pull-right custom_btn mt10" />
	                </td></tr>
	        </table>
	    </div>
 </form>   

<script type="text/javascript">
	function sendMsg(){
		var content = $("#content").val();
		if (!content || content == "" || new RegExp('^[ ]+$').test(content)) {
			layer.msg("内容不能为空",{icon: 2});
            return;
        } 
		 var jsonData = {
				"content" : $("#content").val(),
				"user_id" : $("#s_id").val()
		 }
		 $.ajaxSec({
				type: 'POST',
				url: "${app}/message/saveMsg",
				data: jsonData,
				success: function(data){
					if(data.state=='error'){
						layer.msg(data.message.error[0],{icon: 2});
					}else{
						layer.alert('发送成功！', {
						    icon: 6
						}, function(){
							var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							parent.layer.close(index); //再执行关闭     
						});  
					}
				},
				error: $.ajaxError
			}); 
	};
	function close_msg_iframe(){
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭    
	}
</script>
 <script src="${app}/resources/js/jquery-1.10.2.min.js"></script> 
  <script src="${app}/resources/layer/layer.js"></script>
  <script type="text/javascript" src="${app}/resources/js/yt.ext.js"></script>