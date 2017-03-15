<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<style>
    .myhead{
    position:relative;
    cursor: pointer; 
    width: 172px;  
    display: table-cell; 
    text-align: center;
    vertical-align: middle;}
</style>
<div id="user-info-temp" style="display: none;">
<table class="the_info">
    <tr>
         <td class="w100" rowspan="4">
             <div class="myhead" data-id="headimg" onclick="change_head_img()">
                 <a id="league_logo" class="match_2" style="display: none;"></a>
                 <img id="head_image_img" src="${el:headPath()}{{head_icon}}" style="width: 70px;margin-left: 47px;"/>
             </div>
             <div id="dynamicArea" class="cen_guanzhu">
            </div>
        </td>
        <td>
            <span>昵&emsp;&emsp;称：</span>
            <span>{{usernick}}</span>
        </td>
        <td>
            <span>姓&emsp;&emsp;名：</span>
            <span>{{username}}</span>
        </td>
        <td class="w150" rowspan="4">
            <dl>
	            <dt>
	            <!--<input type="button" data-id="message" onclick="window.open('${ctx}/message','_blank');" value="私信" class="cen_btn ms f14" />-->
	             <a href="javascript:void(0);"  data-id="message" onclick="window.open('${ctx}/message','_blank');"  class="cen_btn ms f14" >【私信】</a>
	            </dt>
                <dd>
                <!--<input type="button" data-id="edit" onclick="edit_user()" value="编辑" class="cen_btn ms f14" />-->
                <a href="javascript:void(0);" data-id="edit" onclick="edit_user()"  class="cen_btn ms f14" >【编辑】</a>
                </dd>
	            <dd data-id="player_certificat">
	            <!-- <input type="button" data-id="other" value="球员认证" class="cen_btn ms f14" onclick="javascript:window.open('${ctx}/certificat/player')"/> --> 
	            <a href="javascript:void(0);" data-id="other" class="cen_btn ms f14" onclick="javascript:window.open('${ctx}/certificat/player')" >【认证】</a></dd>
            </dl>
        </td>
    </tr>
    <tr>
        <td>
            <span>性&emsp;&emsp;别：</span>
            <span id="sex" data-id="sex"></span>
        </td>
        <td>
            <span>出生年月：</span>
            <span>{{borndate}}</span>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <span>常住城市：</span>
            <span>{{province}}{{city}}{{area}}</span>
        </td>
      
    </tr>
    <tr>
        <td colspan="2">
            <span>个性签名：</span>
            <span>{{signature}}</span>
        </td>
    </tr>
</table>
</div>
<div id="user-info" class="center_top">
</div>
<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
<script src="${ctx}/resources/layer/layer.js"></script>
<script type="text/javascript">
</script>


