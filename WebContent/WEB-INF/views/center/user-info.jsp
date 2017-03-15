<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:set var="now" value="<%=new java.util.Date()%>" />
<form id="userForm" action="${ctx}/system/saveBaseInfo" method="post">
<input type="hidden" name="id" value="${user.id}"/>
<input type="hidden" name="username" value="${user.username}"/>
<input type="hidden" id="edit_head_icon" name="head_icon" value="${user.head_icon}"/>
<table class="the_info">
    <tr>
        <td class="w100" rowspan="4">
            <a style="cursor: pointer;" data-id="headimg" onclick="change_head_img()"><img id="head_image_img_0" style="width: 70px;height:70px;" src="${el:headPath()}${user.head_icon}"/></a>
        </td>
        <td>
            <span>昵&emsp;&emsp;称：</span>
            <span><input type="text" name="usernick" value="${user.usernick}" valid="require" class="shuju" maxlength="15" /></span>
        </td>
        <td>
            <%-- <span>姓&emsp;&emsp;名：</span>
            <span><input type="text" name="username" value="${user.username}" class="shuju" maxlength="15" /></span> --%>
        </td>
        <td class="w150" rowspan="4">
            <dl>
                <dt><input type="button" onclick="$.ajaxSubmit('#userForm','#userForm',reloadUserInfo)" value="【保存】" class="cen_btn1 ms f14" /></dt>
                <dd><input type="button" onclick="userModel.backModel();" value="【返回】" class="cen_btn1 ms f14" /></dd>
            </dl>
        </td>
    </tr>
    <tr>
        <td>
            <span>性&emsp;&emsp;别：</span>
            <span>
            	<input type="radio" name="sex" value="1" <c:if test="${user.sex==1}">checked="checked"</c:if>/>男
                <input type="radio" name="sex" value="0" <c:if test="${user.sex==0}">checked="checked"</c:if>/>女
            </span>
        </td>
        <td>
            <span>出生年月：</span>
            <span>
            <fmt:formatDate value="${user.borndate}" var="borndate" pattern="yyyy-MM-dd"/>
            <input id="ccCanlendar1" name="date" class="form-control" type="text" value="${borndate}" readonly="readonly"/>
            </span>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <span>常住城市：</span>
            <span>
            	<select id="s_province" name="province"></select>&nbsp;&nbsp;
                <select id="s_city" name="city"></select>&nbsp;&nbsp;
                <select id="s_county" name="county"></select>
            </span>
        </td>
      
    </tr>
    <tr>
        <td colspan="2">
            <span>个性签名：</span>
            <span><input type="text" name="signature" value="${user.signature}" class="shuju" maxlength="100" style="width: 475px;"/></span>
        </td>
    </tr>
</table>
</form>
<script type="text/javascript">
new PCAS('province', 'city', 'county', '${user.province}', '${user.city}', '${user.area}');

function select() {
    var opts = document.getElementById('').getElementsByTagName('option'),
        opt_value = '4';
    for (var i in opts) {
        if (opts[i].value == opt_value) {
            opts[i].selected = 'selected';
            return;
        }
    }
}

function reloadUserInfo(result){
	if(result.state=='success'){
		layer.msg("保存成功",{icon: 1});
		userModel.renderModel(result.data.user,'reloaded');
	}else{
		if(result.message.error[0]){
			layer.msg(result.message.error[0],{icon: 2});
		}else{
			layer.msg("保存失败",{icon: 2});
		}
	}
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
