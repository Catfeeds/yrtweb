<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:set var="now" value="<%=new java.util.Date()%>" />        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<form id="userForm" action="${ctx}/system/saveBaseInfo" method="post">
<input type="hidden" name="id" value="${user.id}"/>
<input type="hidden" name="username" value="${user.username}"/>
<input type="hidden" id="edit_head_icon" name="head_icon" value="${user.head_icon}"/>
<div class="new_p_info">
     <div class="new_p_head">
     	<a style="cursor: pointer;" data-id="headimg" onclick="change_head_img()">
         <img id="head_image_img_0" src="${el:headPath()}${user.head_icon}" alt="" class="new_head" />
        </a> 
     </div>
 </div>
 <div class="data_edit">
    <table class="new_tab">
        <tr>
            <td>
                <span>昵称</span>
            </td>
            <td>
                <input type="text" name="usernick" value="${user.usernick}" valid="require" class="shuju" maxlength="15" />
            </td>
            <td>
                <span>城市</span>
            </td>
            <td>
                <select id="s_province" name="province"></select>
                <select id="s_city" name="city"></select>&nbsp;
                <select id="s_county" name="county"></select>&nbsp;
            </td>
          
        </tr>
        <tr>
            <td>
                <span>出生年月：</span>
            </td>
            <td>
                <fmt:formatDate value="${user.borndate}" var="borndate" pattern="yyyy-MM-dd"/>
           		<input id="ccCanlendar1" name="date" class="form-control" type="text" value="${borndate}" readonly="readonly"/>
            </td>
            <td>
                <span>性别</span>
            </td>
            <td>
                <input type="radio" name="sex" value="1" <c:if test="${user.sex==1}">checked="checked"</c:if>/>男
                <input type="radio" name="sex" value="0" <c:if test="${user.sex==0}">checked="checked"</c:if>/>女
            </td>
        </tr>
        <tr>
            <td valign="top">
                <span>
                    签名
                </span>
            </td>
            <td colspan="3">
                <input type="text" name="signature" value="${user.signature}" class="shuju" maxlength="80" style="width: 475px;"/>
            </td>
        </tr>
    </table>
   <a href="javascript:void(0)"  onclick="load_center_user()"  style="float: right;
    margin-top: 10px;
    margin-right: 10px;
    width: 45px;
    height: 20px;
    line-height: 20px;
    text-align: center;
    border: none;
    border-radius: 4px;
    background: #eb6100;
    color: #fff;">取消</a>
   <a href="javascript:void(0)"  onclick="updateUserInfo()"  style="float: right;
    margin-top: 10px;
    margin-right: 10px;
    width: 45px;
    height: 20px;
    line-height: 20px;
    text-align: center;
    border: none;
    border-radius: 4px;
    background: #eb6100;
    color: #fff;">保存</a>
</div>
</form>
<script>
new PCAS('province', 'city', 'county', '${user.province}', '${user.city}', '${user.area}');

//add 更新用户基本信息
function updateUserInfo(){
	$.ajax({
		context:$("#userForm"),
		type:'post',
		url:base+"/system/saveBaseInfo?random="+Math.random(),
		data:$("#userForm").serialize(),
		dataType:'json',
		success:function(data){
			if(data.state=='success'){
				layer.msg(data.message.success[0],{icon:1});
				setTimeout(function(){
					load_center_user();
				},1000);
			}else{
				layer.msg(data.message.error[0],{icon:2});
			}
		}
		
	});
}

$("input[name=date]").ccCanlendar({
	iniValue:false,
	startYear:1970,
	hasHourPanel:false,
	hasMinitePanel:false,
	autoSetMinLimit:false,
	showNextMonth:false,
	maxLimit:'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" />'
});
</script>