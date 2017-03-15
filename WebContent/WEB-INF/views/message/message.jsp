<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-私信</title>
<!--IE 浏览器运行最新的渲染模式下-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="${ctx}/resources/css/message.css" rel="stylesheet" />
<style>
.change {
	background: white;
	color: black!important;
}

.change span{
	color: black;
}
</style>
</head>
<body>
<div class="warp">
	<!--头部-->
	<%@ include file="../common/header.jsp" %>
	<%@ include file="../common/naver.jsp" %>  
	<div class="wrapper" style="margin-top: 116px;">


            <!--页面主体-->
            <div class="container ms" style="margin-bottom: 80px;">
               <div class="middle">
               			<!--信息列表-->
              			<div class="message_list">
              				<ul>
              					<c:if test="${not empty users}">
              					<c:forEach items="${users}" var="user" varStatus="var">
              					<li data-id="${user.id}">
              						<c:if test="${user.status=='0'&&var.index!=0}">
              							<img id="msg_hint_user_${user.id}" src="/resources/images/msginfo.png" alt="" style="position: absolute;left: -3px;margin-top: -3px;">
              						</c:if>
              						<img src="${el:headPath()}${user.head_icon}" class="pull-left" style="height: 40px; width: 40px;"/>
              						<span>${user.usernick}</span>
              					</li>
              					</c:forEach>
              					</c:if>
              				</ul>
              			</div>
              			<!--聊天部分-->
              			<div class="chatBox">
              				<!--信息展示-->
              				<div class="messageShow">
              					<c:if test="${empty users}">
              					<p style="margin: 0 auto;width: 60px;text-align: center;color: white;margin-top: 10px;">暂无消息</p>
              					</c:if>
              					<c:if test="${not empty users}">
          						<p id="loadMore" onclick="loadMore(this)" style="margin: 0 auto;width: 60px;text-align: center;color: white;margin-top: 10px;cursor: pointer;">更多消息</p>
           						<div id="msgList" class="qipao">
              						<div id="msgModel" data-id="isme" class="">
              							<img data-id="head_icon" src="" class="pull-left" style="width: 40px;height: 40px;"/>
              							<div class="pull-left message_qipao">
              								<div class="qipao_content">
              									<p>{{content}}</p>
              								    <p data-id="create_time" class="qipao_tinme"></p>
              								</div>
              							</div>
              						</div>
           						</div>
              					</c:if>
              				</div>
              				<!--编辑信息-->
              				<form id="messageForm" action="${ctx}/message/saveMsg">
              				<input type="hidden" id="user_id" name="user_id" value=""/>
              				<div id="message" errorType="2" class="EditMessage ms">
              					<textarea valid="require len(0,200)" data-text="消息" id="msg_content" name="content"></textarea>
              					<div class="sendMessage">
              						<input type="button" onclick="sendMsg()" value="发送"/>
              					</div>
              				</div>
              				</form>
              			</div>
               </div>
            </div>
        </div>
</div>
<%@ include file="../common/footer.jsp" %>
<script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).keydown(function(event){
	if((!event.ctrlKey)&&event.keyCode==13){
		sendMsg();
	}
	if(event.ctrlKey&&(event.keyCode==13)){
		var val = $(msg_content).val();
		$(msg_content).val(val+"\r\n");
	}
}); 
$(function(){
	var userli = $(".message_list li");
	if(userli&&userli.length>0){
		var user = userli.get(0);
		$(user).addClass("change");
		queryMessage($(user).attr('data-id'));
		$("#user_id").val($(user).attr('data-id'));
	}
})
$(".message_list li").click(function(){
	$(".message_list li").removeClass("change");
		$(this).each(function(){
			$(this).addClass("change");
			var sid = $(this).attr('data-id');
			queryMessage(sid);
			$("#msg_hint_user_"+sid).remove();
			$("#user_id").val($(this).attr('data-id'));
		});
		
});
var msgList = new List({
	url:'${ctx}/message/queryMessage',
	sendData:{
		currentPage:1,
		pageSize :10
      },
   	listDataModel:$('#msgModel').get(0).outerHTML,
   	listContainer:'#msgList',
   	dynamicVMHandler:function(one){
   		var vm = $(msgList.options.listDataModel);
   		vm.css('display','block');
		if(one.isme==1){
			vm.attr("class","message_right");
		}else{
			vm.attr("class","message_left");
		}
		vm.find("[data-id=head_icon]").attr("src",ossPath+one.head_icon);
   		if(one.create_time){
   			vm.find('[data-id=create_time]').text(Filter.formatDate(one.create_time,'yyyy-MM-dd hh:mm:ss'));
   		}
   		return vm.get(0).outerHTML;
   	},
   	afterRenderList:function(c,v,d){
   		check_msg_state();
   	}
});

function queryMessage(mid){
	msgList.options.sendData = {
		currentPage:1,
		pageSize :7,
		s_user_id:mid
	}
	msgList.loadListData().done(function(data){
		isPageEnd(data.data.page);
		msgList.renderList(data.data.page.items,'reloade_resetScroll','desc');
		$(".messageShow").scrollTop($(".messageShow")[0].scrollHeight);
	});
}

function loadMore(btn){
	msgList.options.sendData.currentPage++;
	msgList.loadListData().done(function(data){
		isPageEnd(data.data.page);
		if(data.data.page.items&&data.data.page.items.length!=0){
			msgList.renderList(data.data.page.items,'prepend');
		}else{
			$(btn).hide();
		}
	});
}

function isPageEnd(page){
	if(page.currentPage*page.pageSize>page.totalCount){
		$('#loadMore').hide();
	}else{
		$('#loadMore').show();
	}
}

function sendMsg(){
	if($("#user_id").val()){
		$.ajaxSubmit('#messageForm','#message',resHandler)
	}else{
		layer.msg("请选择发送人",{icon: 2});
	}
}

function resHandler(result){
	if(result.state=='success'){
		$("#msg_content").val("");
		queryMessage($("#user_id").val());
	}else{
		layer.msg("发送失败",{icon: 2});
	}
}
</script>
</body>
</html>