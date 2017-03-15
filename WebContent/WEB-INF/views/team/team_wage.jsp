<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
<title>奖金发放</title>
<c:set var="currentPage" value="TEAMDETAIL" />
</head>

<body>
	<style>
body {
	background: url(${ctx}/resources/images/yrfb_bg.jpg) no-repeat top center;
	background-attachment: fixed;
}

.salary {
	width: 882px;
	position: relative;
	padding-bottom: 20px;
	background: url(${ctx}/resources/images/salary_bg.png) repeat-y;
	border: 3px solid rgba(255, 255, 255, 0.2);
	border-radius: 6px;
	z-index: 150;
}

.salary .title {
	width: 100%;
	text-align: center;
	margin-top: 25px;
}

.salary .title span {
	text-align: center;
}

.salary .title_table {
	width: 800px;
	margin: 60px auto 0;
}

.salary .title_table th {
	width: 30%;
}

.salary table th {
	border-bottom: 1px solid #333;
}

.salary table th span {
	font-size: 18px;
	color: #999;
	font-family: "Microsoft YaHei";
}

.pay_div {
	width: 820px;
	height: 328px;
	margin-left: 40px;
	margin-top: 10px;
	overflow: auto;
}

.pay_div table {
	width: 800px;
	color: #fff;
}

.pay_div table td {
	
}

.pay_div table td {
	padding-top: 10px;
	padding-bottom: 10px;
	text-align: center;
}

.pay_div table input[type=text] {
	background: transparent;
	width: 180px;
	height: 20px;
	color: #fff;
}

.jersey_b {
	display: inline-block;
	width: 52px;
	height: 39px;
	background: url(${ctx}/resources/images/jersey_b.png) no-repeat;
}

.jersey_l {
	display: inline-block;
	height: 26px;
	width: 33px;
	line-height: 33px;
	text-align: center;
	cursor: pointer;
	color: #fff;
	background: url(${ctx}/resources/images/jersey.png) -2px -8px no-repeat;
}

.btn_l {
	padding: 4px 22px;
	margin-left: 10px;
	background: #eb6100;
	color: #fff;
	border: none;
	cursor: pointer;
	border-radius: 6px;
}

.btn_g {
	padding: 4px 22px;
	margin-left: 10px;
	background: #7d7d7d;
	color: #fff;
	border: none;
	cursor: pointer;
	border-radius: 6px;
}
  .ui_tip_orange {
            display: none;
        }
        
</style>
	<div class="masker"></div>
	<div class="salary">
	 <a href="#" class="pull-right mr15 mt10 text-white" id="why">为什么要给球员发奖金</a>
        <div class="ui_tip_orange" style="right: 22px; top: 40px;">
            <div class="ui_tip_content">
                <span class="ui_txt fh">为你的球员发放奖金，</span><br/>
                <span class="ui_txt fh">他们会更努力的比赛哦！</span>
            </div>
            <div class="ui_millde">
                <div class="arrow_border arrow_border_top" style="left: 80%;"></div>
                <div class="arrow_content arrow_content_top" style="left: 80%;"></div>
            </div>
        </div>
		<div class="title" style="width: 209px; height: 38px; margin: 0 auto; line-height: 38px; text-align: center; background: url(${ctx}/resources/images/bb_title.png) no-repeat; ">
			 <span class="text-white f16 ms ">奖金发放</span>
			
		</div>

		<table class="title_table">
			<tr>
				<th style="width: 10%;"><span class="jersey_b"></span></th>
				<th><span>昵称</span></th>
				<th><span>位置</span></th>
				<th><span>发放金额</span></th>
			</tr>
		</table>
		<div class="pay_div">
			<table>
			<form id="wageForm" method="post" class="form-horizontal">
				<input type="hidden" name="teaminfo_id" value="${teaminfo_id}" />
				<c:forEach items="${_plist}" var="_item">
					<tr>
						<td style="width: 78px;"><span class="jersey_l">${_item.player_num} </span></td>
						<td style="width: 237px;"><span class="ms f16">${_item.user_name} </span></td>
						<td style="width: 237px;"><span class="ms f16">${_item.position} </span></td>
						<td><input type="text" id="wage_${_item.user_id}" name="wage_${_item.user_id}" onkeyup="WageUtils.clearChar(this)" onblur="updateSum(this)"/></td>
					</tr>
				</c:forEach>
			</form>
			</table>
		</div>
		<div
			style="width: 800px; margin: 20px auto; border-top: 1px solid #333; text-align: center;">
			<div class="pull-right mt30">
				<span class="ms f18 text-white">发放总额：
				<span id="team_wage" class="text-brown f24">0</span></span> 
				<span class="ml10 ms f18 text-gray-s_666">可用宇币：${userAmount.real_amount }</span> 
				<a href="${ctx}/account/recharge" target="_blank" class="text-white f16 ms">【充值】</a>

			</div>
			<div class="clearit"></div>
			<c:if test="${teamManage }">
				<input type="button" name="name" onclick="saveWage()" value="确认" class="btn_l ms f16 mt40" />
				<input type="button" name="name" onclick="WageUtils.closeWind()" value="取消" class="btn_g ms f16 ml20 mt40" />
			</c:if>
		</div>


	</div>

	<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script>
  	<script src="${ctx}/resources/layer/layer.js"></script>
    <script src="${ctx}/resources/js/plugins.js"></script>
    <script src="${ctx}/resources/js/sly.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/yt.ext.js"></script>

	<script type="text/javascript">
		jQuery.fn.center = function() {
			this.css("position", "absolute");
			this.css("top", ($(window).height() - this.height()) / 2
					+ $(window).scrollTop() - 65 + "px");
			this.css("left", ($(window).width() - this.width()) / 2
					+ $(window).scrollLeft() + "px");
			return this;
		}

		$(".masker").height($(document).height()).fadeIn();
		$(".salary").center();
		
		var ajaxSubmit = function(){

			var formArr =  $("#wageForm").serializeArray(); 
			var jsontxt=[];
			var keys=[];
			jsontxt.push("{");
			for(i in formArr){
				var key = formArr[i].name;
				var value = formArr[i].value;
				if(key.indexOf("wage_")!=-1){
					if(value>0){
						keys.push(key);
						jsontxt.push('"'+key+'":"'+value+'",');
					}
				}else{
					jsontxt.push('"'+key+'":"'+value+'",');
				}
			}
			jsontxt.push('"userids":"'+keys.join('|')+'"');
			jsontxt.push("}");

			
			$.ajax({
	    		type : "POST",
	    		url : "${ctx}/team/wageSave",
	    		data : jsontxt.join(''),
	    		dataType : "json",
	    		contentType : "application/json",
	    		success : function(data) {
	    			if(data.state==0){
	    				cleanForm();
		    			yrt.msg("奖金发放成功",{icon: 1});
	    			}else{
		    			yrt.msg(data.message,{icon: 0});
	    			}
	    		},
	    		error : function(msg) {
	    			yrt.msg("操作失败",{icon: 0});
	    			if (msg.statusText != "abort") {
	    				
	    			}
	    		}
	    	});
		}
		var cleanForm = function(obj){
			var formArr =  $("#wageForm").serializeArray(); 
			for(i in formArr){
				var key = formArr[i].name;
				var value = formArr[i].value;
				if(key.indexOf("wage_")!=-1){
					if(value>0){
						$("#"+key).val("0");
					}
				}
			}
			WageUtils.wageSum=0;
			$("#team_wage").text(WageUtils.wageSum);
		};
		
		var saveWage=function(){
			if(WageUtils.wageSum==0){
    			layer.msg("请填写发放金额",{icon: 0});
				return 0;
			}
			var cmsg = '<p class="f16 text-white ms" style="width:80%;">发放总额: <b style="color: red;">'+WageUtils.wageSum+'</b>宇币</p>';
			cmsg += '<p class="f12 text-white ms" style="width:80%;">温馨提示：球员实得奖金为发放奖金的95%</p>';
			yrt.confirm(cmsg, {
			    btn: ['确认发放','取消'], //按钮
			    shade: true //不显示遮罩
			}, function(){ajaxSubmit();}, function(){});
		};
		var updateSum = function(obj){
			WageUtils.checkValue(obj);
			var formArr =  $("#wageForm").serializeArray(); 
			WageUtils.wageSum=0;
			for(i in formArr){
				var key = formArr[i].name;
				var value = formArr[i].value;
				if(key.indexOf("wage_")!=-1){
					if(value>0){
						WageUtils.wageSum+=WageUtils.toInt(value);
					}
				}
			}
			$("#team_wage").text(WageUtils.wageSum);
		}
		
		var WageUtils = {
				wageSum :0,
				closeWind:function(){
					window.close();  
				},
				clearChar : function(obj) {//清除文本框非数字
					var str = obj.value;
					var intVar = WageUtils.clearCharValue(str);
					if(intVar!=""){
						obj.value = WageUtils.toInt(intVar);
					}
				},
				checkValue : function(obj) {//清除文本框非数字
					var str = obj.value;
					if(str=='' || str==null){
						obj.value = parseInt(0);
					}else{
						obj.value = WageUtils.toInt(str);
					}
					//obj.value = WageUtils.toInt(str/100)*100;
				},
				clearCharValue : function(val) {//清除非数字的字符
					var str = val;
					str = str.replace(/[^\d.]/g, "");
					str = str.replace(/^\./g, "");
					str = str.replace(/\.{2,}/g, ".");
					return str.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
				},
				toInt : function(str) {//转整数类型
					var i =  parseInt(str, 10);
					if(!isNaN(i)){
						return i;
					}else{
						return 0;
					}
				}
		};
		cleanForm();
		  $("#why").mouseover(function() {
	            $(".ui_tip_orange").fadeIn();
	        }).mouseout(function() {
	            $(".ui_tip_orange").fadeOut();
	        });
	</script>
</body>
</html>
