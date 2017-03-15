<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>邀请入驻信息录入</title>
</head>
<body>
	<form id="inInfo">
		<table align="center">
			<input type="hidden" name="user_id" value="${baby_user_id}"/><!--足球宝贝用户user_id-->
			<input type="hidden" name="teaminfo_id" value="${team.id}"/>
			<tr>
				<td>头像</td>
				<td>
					<img src="${el:headPath()}${user.head_icon}" width="73px" height="73px">
				</td>
			</tr>
			<tr>
				<td>昵称</td>
				<td>
					<span>${user.usernick}</span>
				</td>
			</tr>
			<tr>
				<td><span style="color: red;">*</span>入驻天数</td>
				<td>
					<input type="text" value="" name="days" valid="number"/>
				</td>
			</tr>
			<tr>
				<td>入驻俱乐部</td>
				<td>
					<span>${team.name}</span>
				</td>
			</tr>
			<tr>
				<td><span style="color: red;">*</span>联系人</td>
				<td>
					<input type="text" value="" name="contact_person" valid="require"/>
				</td>
			</tr>
			<tr>
				<td><span style="color: red;">*</span>联系电话</td>
				<td>
					<input type="text" value="" name="contact_phone" valid="require"/>
				</td>
			</tr>
			<tr>
				<td>备注</td>
				<td>
					<textarea name="remark"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="提交" onclick="submitInfo()"/>
				</td>
			</tr>
		</table>	
	</form>
	  	<%@ include file="../common/footer.jsp" %>
	  	<script type="text/javascript">
	  	
			function submitInfo(){
				$.ajaxSec({
					context:$("#inInfo"),
					type:"POST",
					url:base+"/babyIn/save?random="+Math.random(),
					data:$("#inInfo").serialize(),
					dataType:"JSON",
					success:function(data){
						if(data.state=="success"){
							layer.msg(data.message.success[0],{icon: 1});
						}else{
							layer.msg(data.message.error[0],{icon: 2});
						}
					},
				});
			
			}
	  	</script>
</body>
</html>