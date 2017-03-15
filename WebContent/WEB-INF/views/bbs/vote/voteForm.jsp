<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../common/common.jsp" %>
<c:set var="currentPage" value="BBS"/>
<title>宇任拓-发起投票</title>
<link href="${ctx}/resources/css/forum.css" rel="stylesheet" />
<link href="${ctx}/resources/js/Canlendar/ccCanlendar.css" rel="stylesheet">
</head>
<body>
	<div class="masker"></div>
	<div class="warp">
        <!--头部-->
        <%@ include file="../../common/header.jsp" %>
        <!--导航-->
        <%@ include file="../../common/naver.jsp" %>  
  		<div class="bbs">
  			<form id="voteForm" action="${ctx}/bbs/saveVote" method="post">
	            <div class="title">
	                <span class="active">发起投票</span>
					<input type="hidden" name="plate_id" value="${plate_id}"/>	
	            </div>
	            <div class="content_area">
	                <table id="vote">
	                    <tr>
	                        <td class="w130"><span>标题(必填)：</span></td>
	                        <td><input type="text" name="title" value="" class="w438" valid="require"/></td>
	                    </tr>
	                    <tr>
	                        <td class="w130" valign="top"><span>描述：</span></td>
	                        <td><textarea class="describe" name="content" valid="require"></textarea></td>
	                    </tr>
	                    <tr>
	                        <td class="w130" valign="top"><span>投票选项：</span></td>
	                    </tr>
	                    <tr>
	                        <td class="w130"><span>1：</span></td>
	                        <td><input type="text" name="name" value="" class="w438" valid="require len(0,16)"/></td>
	                    </tr>
	                    <tr>
	                        <td class="w130"><span>2：</span></td>
	                        <td><input type="text" name="name" value="" class="w438" valid="require len(0,16)"/></td>
	                    </tr>
	                </table>
	                <input type="button" name="btn_add" value="增加选项" class="btn_l pull-right mt20 ms" id="addopt" style="margin-right: 38px;"/>
	                <div class="clearit"></div>
	                <table>
	                    <tr>
	                        <td class="w130"><span>选项设置：</span></td>
	                        <td valid="singleCheck">
	                            <input type="radio" name="type" value="1" /><span>单选</span>
	                            <input type="radio" name="type" value="2" class="ml10" /><span>多选</span>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="w130"><span>投票有效期至：</span></td>
	                        <td>
								 <input id="Canlendar" name="end_time" class="form-control" type="text" value="" valid="require" readonly="readonly" />			
	                        </td>
	                    </tr>
	                </table>
	                <div class="btn_div">
	                    <input type="button" name="btn_save" value="发起投票" class="btn_l" onclick="saveVote();"/>
	                    <input type="button" name="btn_cancel" value="取消" class="btn_g ml15" onclick="javascript:history.go(-1);"/>
	                </div>
	            </div>
	        </div>      
        </form>
    </div>
<%@ include file="../../common/footer.jsp" %>  
<script src="${ctx}/resources/js/Canlendar/ccCanlendar.js"></script>
<script src="${ctx}/resources/js/mouse.js"></script>
<script type="text/javascript">
	var j = 3;
	$("#addopt").click(function () {
	    $("#vote").append('<tr id='+j+'><td class="w130"><span>' + j + '：</span></td><td><input type="text" name="name" value="" class="w438" valid="require len(0,16)"/><a onclick="delete_tr('+j+');" href="javascript:void(0);" class="f12 text-white ml10">删除</a></td></tr>');
	    j++;
	});
	 function delete_tr(num){
        $("#"+num).remove();
	 }
	 $('#Canlendar').ccCanlendar({
         hasMinitePanel: false,
         showNextMonth: false,
         hasHourPanel:false
     });
	 
	 function saveVote(){
		 if(window.validBeforeAjax('#voteForm') == true){
			 $("#voteForm").submit();
		 }
	 }
	 
</script>
</body>
</html>