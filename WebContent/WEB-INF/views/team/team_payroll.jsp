<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
<link href="${ctx}/resources/css/master.css" rel="stylesheet" />
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>工资发放</title>
<style type="text/css">
</style>
</head>
<body>
 <div class="warp">
        <div class="masker"></div>
		<%@ include file="../common/header.jsp" %>       
		<%@ include file="../common/naver.jsp" %> 
        <div class="wrapper" style="margin-top: 180px;">
            <div class="wages">
                <div class="title">
                    <span class="f18 ms pull-left ml10">工资清单</span>
                    <div class="clearit"></div>
                </div>

                <div class="the_area">
                    <div class="subject_title">
                        <p class="subject">
                        <span class="ml25">${wagePayroll.season }</span><span class="ml25">${wagePayroll.round }</span></p>
                    </div>
                </div>
                <style>
                    </style>
                <table class="name_score_name">
                    <tr>
                        <td>
                            <dl>
                                <dt><img src="${ctx}${wagePayroll.home_team_src }" alt="" class="n_logo"></dt>
                                <dd><span class="f14 text-white ms">${wagePayroll.home_team_name }</span></dd>
                            </dl>
                        </td>
                        <td class="jfen">
                            <span class="f30 text-white ms">${wagePayroll.home_team_score }</span>
                            <img src="${ctx}/resources/images/l_vs.png" alt="vs" class="ml20">
                            <span class="f30 text-white ms ml20">${wagePayroll.visiting_team_score }</span>
                        </td>
                        <td>
                            <dl>
                                <dt><img src="${ctx}${wagePayroll.visiting_team_src }" alt="" class="n_logo"></dt>
                                <dd><span class="f14 text-white ms">${wagePayroll.visiting_team_name }</span></dd>
                            </dl>
                        </td>
                    </tr>
                </table>
                <style>
                    </style>
			<form id="wageForm" method="post" class="form-horizontal">
                <table class="player_salaries">
                    <tr>
                        <th class="center"><span>球衣号码</span></th>
                        <th class="left"><span>球员姓名</span></th>
                        <th class="left"><span>上场时间</span></th>
                        <th class="left"><span>进球数</span></th>
                        <th class="center"><span>应发工资</span></th>
                        <th><span>奖金数额</span></th>
                        <th><span>发放总额</span></th>
                    </tr>
                    <c:forEach items="${wagePlayerList}" var="o">
                    <tr>
                        <td class="center pt15"><span class="num">${o.uniform_number }</span></td>
                        <td class="left pt15"><span>${o.player_name }</span></td>
                        <td class="left pt15"><span>${o.playing_time }</span></td>
                        <td class="left pt15"><span title="进球${o.goal_number }个" class="ball_h_${o.goal_number }"></span></td>
                        <td class="center pt15"><span>${o.wages_should }</span> </td>
                        <td class="center pt15">
                         <c:if test="${sendStatus}">
                         	${o.bonus_amount }
                         </c:if>
                        <c:if test="${sendStatus ==false}">
                        	<input type="text" id="wage_${o.id}" name="wage_${o.id}" value="${o.bonus_amount }" class="bonus" onkeyup="WageUtils.clearChar(this)" onblur="updateSum(this)"/>
                        </c:if>
                        </td>
                        <td class="center pt15"><span>${o.total_distribution }</span></td>
                    </tr>
					</c:forEach>
                </table>
			</form>
                <div class="fgl"></div>
                <div class="grant">
                    <p class="ms f16">本轮发放人数：${wagePayroll.player_count }人</p>
                    <p class="ms f16 mt10">本轮发放总额：<span id="wage_sum">${wagePayroll.wage_bonus_sum +wagePayroll.wage_base_sum }</span>宇币</p>
                    <div class="btn_div">
                    	<input type="hidden"  id="wage_bonus_sum" value="${wagePayroll.wage_bonus_sum }"/>
                    	<input type="hidden"  id="wage_base_sum" value="${wagePayroll.wage_base_sum }"/>
                    	<input type="hidden"  id="salary_msg_id" value="${wagePayroll.salary_msg_id }"/>
                    	<c:if test="${sendStatus ==false}">
                        <input type="button" name="name" value="确认" class="btn_l f14 ms" id="affirm" />
                        <input type="button" name="name" value="清空" class="btn_g f14 ms" id="closeUp" />
                    	</c:if>
                    </div>
                </div>
               
            </div>

        </div>
    </div>
    
	<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script>
  	<script src="${ctx}/resources/layer/layer.js"></script>
    <script src="${ctx}/resources/js/plugins.js"></script>
    <script src="${ctx}/resources/js/sly.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/yt.ext.js"></script>

	<script type="text/javascript">
    $("#closeUp").click(function() {
    	cleanForm();
    });
    $("#affirm").click(function() {
    	updateSum({"value":0});
    	saveWage();
    });
    
	//确认发送
	var ajaxSubmit = function(){
		var salary_id = $('#salary_msg_id').val();
		var jsontxt=[];
		jsontxt.push("{");
		jsontxt.push('"salary_msg_id":"'+salary_id+'"');
		jsontxt.push("}");

		$.ajax({
    		type : "POST",
    		url : "${ctx}/team/wagePayrollSend",
    		data : jsontxt.join(''),
    		dataType : "json",
    		contentType : "application/json",
    		success : function(data) {
    			if(data.state==0){
	    			yrt.msg("发放成功",{icon: 1});
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
	//保存奖金
		var wagePayrollSave = function(){
			var salary_id = $('#salary_msg_id').val();
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
			jsontxt.push('"ids":"'+keys.join('|')+'",');
			jsontxt.push('"salary_msg_id":"'+salary_id+'"');
			jsontxt.push("}");

			
			$.ajax({
	    		type : "POST",
	    		url : "${ctx}/team/wagePayrollSave",
	    		data : jsontxt.join(''),
	    		dataType : "json",
	    		contentType : "application/json",
	    		success : function(data) {
	    			if(data.state==0){
	    				var cmsg = '<p class="f16 text-white ms" style="width:80%;">发放总额: <b style="color: red;">'+WageUtils.wageSum+'</b>宇币</p>';
	    				cmsg += '<p class="f12 text-white ms" style="width:80%;">温馨提示：球员实得金额为发放金额的95%</p>';
	    				yrt.confirm(cmsg, {
	    				    btn: ['确认发放','取消'], //按钮
	    				    shade: true //不显示遮罩
	    				}, function(){ajaxSubmit();}, function(){});
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
		
		var saveWage=function(){
			WageUtils.wageSum=WageUtils.toInt($("#wage_sum").text());
			if(WageUtils.wageSum==0){
    			layer.msg("请填写发放金额",{icon: 0});
				return 0;
			}
			wagePayrollSave();
			
		};
		var updateSum = function(obj){
			WageUtils.checkValue(obj);
			var formArr =  $("#wageForm").serializeArray(); 
			WageUtils.wageSum=0;
			WageUtils.baseSum = WageUtils.toInt($("#wage_base_sum").val());
			for(i in formArr){
				var key = formArr[i].name;
				var value = formArr[i].value;
				if(key.indexOf("wage_")!=-1){
					if(value>0){
						WageUtils.wageSum+=WageUtils.toInt(value);
					}
				}
			}
			$("#wage_bonus_sum").val(WageUtils.wageSum);
			
			$("#wage_sum").text(WageUtils.wageSum+WageUtils.baseSum);
		};

		var cleanForm = function(obj){
			var formArr =  $("#wageForm").serializeArray(); 
			WageUtils.baseSum = WageUtils.toInt($("#wage_base_sum").val());
			for(i in formArr){
				var key = formArr[i].name;
				var value = formArr[i].value;
				if(key.indexOf("wage_")!=-1){
					if(value>0){
						$("#"+key).val("0");
					}
				}
			}
			$("#wage_bonus_sum").val(0);
			$("#wage_sum").text(WageUtils.baseSum);
		};
		
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
	</script>    	
</body>
</html>
