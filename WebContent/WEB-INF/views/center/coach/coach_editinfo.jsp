<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="career">
    <span class="pull-left ml15 fw text-white ms f16">基本信息</span>
     <c:if test="${session_user_id eq oth_user_id}">
	    <!-- <span class="pull-right yt_edit" onclick="editCoachInfo()" title="编辑"></span> -->
	    <span class="pull-right yt_saver_s" onclick="saveInfo('coachForm','/coach/saveOrUpdate')" title="保存"></span>
     </c:if>
    <div class="clearit"></div>
</div>
<form id="coachForm">
	<input type="hidden" name="id" value="${coach.id}"/>
	<input type="hidden" name="user_id" value="${coach.user_id}"/>
	<table style="margin-top: 20px;">
	    <tr>
	        <td class="w110">
	            <span class="f12 text-gray-s_81">是否有球员经历：</span>
	        </td>
	        <td>
	            <input type="radio" name="is_player" value="1" <c:if test="${coach.is_player eq 1}">checked</c:if>/><span class="text-white">是</span> 
				<input type="radio" name="is_player" value="0" <c:if test="${coach.is_player eq 0}">checked</c:if>/><span class="text-white">否</span>
	        </td>
	    </tr>
	    <tr>
	        <td class="w110">
	            <span class="f12 text-gray-s_81">证书编号：</span>
	        </td>
	        <td>
	            <span class="f12">
	           	 <input type="text" name="cer_no" class="shuju" value="${coach.cer_no }" valid="require len(1,60)" style="width: 250px;"/>
	            </span>
	        </td>
	    </tr>
	    <tr>
	        <td class="w110">
	            <span class="f12 text-gray-s_81">所属俱乐部：</span>
	        </td>
	        <td>
	            <span class="f12">
	            	<input type="text" name="in_team" value="${coach.in_team }" style="width: 250px;"/>
	            </span>
	        </td>
	    </tr>
	    <tr>
	        <td class="w110">
	            <span class="f12 text-gray-s_81">所培养球星：</span>
	        </td>
	        <td>
	            <span class="f12">
	            <input type="text" name="stars" value="${coach.stars }" style="width: 250px;"/>
	            </span>
	        </td>
	    </tr>
	</table>
</form>