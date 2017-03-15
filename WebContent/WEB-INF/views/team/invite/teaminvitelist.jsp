<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/photoAlbum.css" rel="stylesheet" />
<title>对战受邀列表</title>
</head>
<body>
	<input type="hidden" name="teaminfo_id" id="teaminfo_id" value="${teaminfo_id}"> 
    <div class="warp">
        <!--头部-->
    	<%@ include file="../../common/header.jsp" %> 
        <!--导航-->
        <%@ include file="../../common/naver.jsp" %>    
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="mt20" style="">
                <div class="p_title" style="text-align: center;">
                    <span class="f14 ml20 ms text-white">对战受邀信息</span>
                </div>
                <div class="beinvited" id="inviteArea">
                   
                </div>
            </div>
        </div>
    </div>
    <!--页脚-->
   	<%@ include file="../../common/footer.jsp" %>
    <script type="text/javascript">
        $(function () {
			loadInviteList(0);
        });
        
        function loadInviteList(pageIndex){
        	$.ajax({
        		type: 'POST',
        		url: base+"/teamInvite/listInvite/result_invite",
        		data: {"teaminfo_id":$("#teaminfo_id").val(),"currentPage":pageIndex,"pFlag":"1",pageSize:10},
        		dataType:"html",
        		success: function(data){
        			if(data.state=='error'){
        				layer.msg(data.message.error[0]);
        			}else{
        				$("#inviteArea").html(data);
        			}
        		},
        		error: $.ajaxError
        	});	
        }
        
      //add by ylt 确认邀请比赛
        function checkInvite(teaminfo_id,status,id){
        	var jsonData = {
        		"id" : id,
        		"status" : status,
        		"teaminfo_id" : teaminfo_id,
        		"respond_teaminfo_id" : $("#teaminfo_id").val()
        	};
        	$.ajax({
        		type: 'POST',
        		url: base+"/teamInvite/acceptOrRefuseInvite",
        		data: jsonData,
        		success: function(data){
        			if(data.state=='error'){
        				layer.msg(data.message.error[0]);
        			}else{
        				layer.msg("操作成功!");
        				loadTeamInvite();
        			}
        		},
        		error: $.ajaxError
        	});	
        }
    </script>
</body>
</html>
