<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<div class="closeBtn_1" onclick="cl();"></div>
<div class="title">
    <span class="f16 ms">发&emsp;布</span>
</div>
<form action="" method="post" id="nForm">
	<input type="hidden" id="teaminfo_id" name="teaminfo_id" value="${teaminfo_id}"/>
	<input type="hidden" name="id" value="${notice.id}"/>
	<table>
	    <tr>
	        <td><span class="f14 text-white ms">标题</span></td>
	        <td>
	            <input type="text" id="name" name="name" value="${notice.name}" class="ml10" valid="require" />
	        </td>
	    </tr>
	    <tr>
	        <td valign="top">
	            <span class="f14 text-white ms">详情</span>
	        </td>
	        <td><textarea id="describle" name="describle" valid="require">${notice.describle}</textarea></td>
	    </tr>
	</table>
</form>
<input type="button" name="name" value="发布" class="btn_l ml150" onclick="saveNotice();"/>
<input type="button" name="name" value="取消" class="btn_g ml20" id="cannel" onclick="cl();"/>
<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
<script src="${ctx}/resources/layer/layer.js"></script>
<script src="${ctx}/resources/js/base.js"></script>
<script src="${ctx}/resources/js/validation.js"></script>
<script src="${ctx}/resources/js/yt.ext.js"></script>
<script src="${ctx}/resources/js/jQuery.md5.js"></script>