<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<style type="text/css">
.notice_img{
	 float:left;
	 margin-top:6px;
 }
.card {
    background: #424242 none repeat scroll 0 0;
    box-shadow: 2px 2px 10px #111111;
    display: none;
    left: 0;
    padding-bottom: 10px;
    position: absolute;
    top: 24px;
    width: 280px;
    z-index: 12;
}
.card_info {
    margin: 5px auto;
    width: 266px;
}
.card_head {
    border-radius: 6px;
    float: left;
    height: 80px;
    width: 80px;
}
.card_name {
    color: #cbcb9f;
    font-family: "Microsoft YaHei";
    font-size: 16px;
}
.card_details {
    float: left;
    margin-left: 15px;
    width: 168px;
}
.card_details span {
    vertical-align: middle;
}
</style>
<title>消息列表</title>
</head>
<body>
<div class="warp">
	<input type="hidden" id="teaminfo_id" value="${teaminfo_id}"/>
        <%@ include file="../../common/header.jsp" %> 
        <%@ include file="../../common/naver.jsp" %>   
        <div class="wrapper" style="margin-top: 116px;">
            <style>
            </style>
            <div class="credit_list">
                <div class="title">
                    <a href="javascript:loadAllTeamMsg(1)" id="salary" class="f16 ms ml10" style="float:left;">工资清单</a>
                    <%-- <img id="gz_hint" src="${ctx}/resources/images/msginfo.png" alt="" class="ml4 notice_img" style="display: none;">  --%>
                    <div style="left: 67px;top:-1px;z-index:2;display: none;" class="msg_case" id="gz_msg_case_png">
                        <span class="msg_num">1</span>
                    </div>
                    <span class="f16 ms ml10" style="float:left;">|</span>
                    <a href="javascript:transfer_market(2,1)" id="market" class="f16 ms ml10" style="float:left;">转会交易</a>
                    <%-- <img id="zh_hint" src="${ctx}/resources/images/msginfo.png" alt="" class="ml4 notice_img" style="display: none;">    --%>
                    <div style="left: 154px;top:-1px;z-index:2;display: none;" class="msg_case" id="zh_msg_case_png">
                        <span class="msg_num">1</span>
                    </div>
                    <span class="f16 ms ml10" style="float:left;">|</span>
                    <a href="javascript:loan_application(1,1)" id="loan" class="f16 ms ml10" style="float:left;">租借申请</a>
                    <%-- <img id="zj_hint" src="${ctx}/resources/images/msginfo.png" alt="" class="ml4 notice_img" style="display: none;"> --%>   
                    <div style="left: 242px;top:-1px;z-index:2;display: none;" class="msg_case" id="zj_msg_case_png">
                        <span class="msg_num">1</span>
                    </div>
                    <span class="f16 ms ml10" style="float:left;">|</span>
                    <a href="javascript:teamApplyList(1)" id="apply" class="f16 ms ml10" style="float:left;">入队申请</a>
                    <%-- <img id="rd_hint" src="${ctx}/resources/images/msginfo.png" alt="" class="ml4 notice_img" style="display: none;"> --%>
                    <div style="left: 331px;top:-1px;z-index:2;display: none;" class="msg_case" id="rd_msg_case_png">
                        <span class="msg_num">1</span>
                    </div>
                    <span class="f16 ms ml10" style="float:left;">|</span>
                    <a href="javascript:loadInviteList(0)" id="pkInvite" class="active f16 ms ml20" style="float:left;">PK邀请</a>
                    <%-- <img id="pk_hint" src="${ctx}/resources/images/msginfo.png" alt="" class="ml4 notice_img" style="display: none;"> --%>
                    <div style="left: 418px;top:-1px;z-index:2;display: none;" class="msg_case" id="pk_msg_case_png">
                        <span class="msg_num">1</span>
                    </div>
                    <div class="clearit"></div>
                </div>
                <div class="points" id="inviteArea">
                   
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="change_type" value=""/>
   	<%@ include file="../../common/footer.jsp" %>
</body>
<script src="${ctx}/resources/js/person_info.js"></script>
<script type="text/javascript">
$(function () {
	//loadInviteList(0);
	var type = $("#change_type").val();
	if(type=='loan'){
		loan_application(1,1)
	}else if(type=='pkInvite'){
		loadInviteList(0);
	}else if(type=='market'){
		transfer_market(2,1);
	}else if(type=='apply'){
		teamApplyList(1);
	}else{
		loadAllTeamMsg(1);
	}
	check_msg_count('${teaminfo_id}');
});

//入队申请列表
function teamApplyList(currentPage){
	$("#pkInvite").removeClass("active");
	$("#salary").removeClass("active");
	$("#market").removeClass("active");
	$("#loan").removeClass("active");
	$("#apply").addClass("active");
	$.ajax({
		type:'post',
		url:base+"/teamInvite/teamApply",
		data:{"teaminfo_id":$("#teaminfo_id").val(),"currentPage":currentPage,pageSize:10},
		dataType:'html',
		success:function(data){
			$("#change_type").val('apply');
			$("#inviteArea").empty();
			$("#inviteArea").html(data);
		}
	});
};
/**检测未读消息*/
function check_msg_count(teamId){
	$.ajax({
		type: 'post',
		url: base+'/teamInvite/queryNotReadTeamMsg?teaminfo_id='+teamId,
		dataType:'json',
		success: function(result){
			if(result.teamMsgCount > 0){
			    //$("#pk_hint").show();
			    $("#gz_msg_case_png").find(".msg_num").text(result.teamMsgCount);
			    $("#gz_msg_case_png").show();
			}else{
				//$("#pk_hint").hide();
				$("#gz_msg_case_png").hide();
			}
			if(result.teamInviteCount > 0){
			    //$("#pk_hint").show();
			    $("#pk_msg_case_png").find(".msg_num").text(result.teamInviteCount);
			    $("#pk_msg_case_png").show();
			}else{
				//$("#pk_hint").hide();
				$("#pk_msg_case_png").hide();
			}
			if(result.teamApplyCount > 0){
			    //$("#rd_hint").show();
				$("#rd_msg_case_png").find(".msg_num").text(result.teamApplyCount);
			    $("#rd_msg_case_png").show();
			}else{
				//$("#rd_hint").hide();
				$("#rd_msg_case_png").hide();
			}
			if(result.teamTmarketCount > 0){
			    //$("#rd_hint").show();
				$("#zh_msg_case_png").find(".msg_num").text(result.teamTmarketCount);
			    $("#zh_msg_case_png").show();
			}else{
				//$("#rd_hint").hide();
				$("#zh_msg_case_png").hide();
			}
			if(result.teamLoanCount > 0){
			    //$("#zj_hint").show();
				$("#zj_msg_case_png").find(".msg_num").text(result.teamLoanCount);
			    $("#zj_msg_case_png").show();
			}else{
				//$("#zj_hint").hide();
				$("#zj_msg_case_png").hide();
			}
				
		},
		error: $.ajaxError
	});
}
//同意入队申请
function agreeApply(user_id,type){
	$.ajax({
		type:'post',
		url:base+"/teamInvite/agreenApply",
		data:{"type":type,"user_id":user_id,"teaminfo_id":$("#teaminfo_id").val()},
		dataType:'json',
		success:function(data){
			if(data.state=='success'){
				layer.msg(data.message.success[0],{icon:1});
				setTimeout(function(){
					teamApplyList(1);
				},1000)
			}else{
				layer.msg(data.message.error[0],{icon:2});
			}
		}
	});
}



//PK邀请列表
function loadInviteList(pageIndex){
	$("#pkInvite").addClass("active");
	$("#apply").removeClass("active");
	$("#market").removeClass("active");
	$("#loan").removeClass("active");
	$("#salary").removeClass("active");
	$.ajax({
		type: 'POST',
		url: base+"/teamInvite/listInvite/result_invite",
		data: {"teaminfo_id":$("#teaminfo_id").val(),"currentPage":pageIndex,"pFlag":"1",pageSize:10},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				$("#change_type").val('pkInvite');
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
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg("操作成功!",{icon:1});
				setTimeout(function(){
					loadInviteList(1);
				},1000)
			}
		},
		error: $.ajaxError
	});	
}

function loadAllTeamMsg(currentPage){
	$("#pkInvite").removeClass("active");
	$("#apply").removeClass("active");
	$("#market").removeClass("active");
	$("#loan").removeClass("active");
	$("#salary").addClass("active");
	var teaminfo_id = $("#teaminfo_id").val();
	$.ajax({
		type:'post',
		url:base+'/teamInvite/salary_list',
		data:{'currentPage':currentPage,'pageSize':6,'teaminfo_id':teaminfo_id},
		dataType:'html',
		success:function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				$("#change_type").val('');
				$("#inviteArea").html(data);
			}
		}
		
	})
}

function transfer_market(type,curPage){
	$("#pkInvite").removeClass("active");
	$("#apply").removeClass("active");
	$("#salary").removeClass("active");
	$("#loan").removeClass("active");
	$("#market").addClass("active");
	var teaminfo_id = $("#teaminfo_id").val();
	$.ajax({
		type:'post',
		url:base+'/teamInvite/transferMarket',
		data:{'teaminfo_id':teaminfo_id,'type':type,'currentPage':curPage,'pageSize':10},
		dataType:'html',
		success:function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				$("#change_type").val('market');
				$("#inviteArea").html(data);
			}
		}
		
	})
}

function loan_application(type,curPage){
	$("#pkInvite").removeClass("active");
	$("#apply").removeClass("active");
	$("#salary").removeClass("active");
	$("#market").removeClass("active");
	$("#loan").addClass("active");
	var teaminfo_id = $("#teaminfo_id").val();
	$.ajax({
		type:'post',
		url:base+'/teamLoan/loanApplication',
		data:{'teaminfo_id':teaminfo_id,'type':type,'currentPage':curPage,'pageSize':10},
		dataType:'html',
		success:function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				$("#change_type").val('loan');
				$("#inviteArea").html(data);
				if(type==1){
					$(".mybuy").addClass("active");
			        $(".mysell").removeClass("active");
				}else{
					$(".mysell").addClass("active");
			        $(".mybuy").removeClass("active");
				}
			}
		}
		
	})
}

function loan_manage(id,type){
	var msg = '是否同意出租“'+$("#player_name_"+id).text()+'”球员？';
	if(type==2){
		msg = '是否拒绝出租“'+$("#player_name_"+id).text()+'”球员？';
	}else if(type==3){
		msg = '是否撤销租借“'+$("#player_name_"+id).text()+'”球员？';
	}
	yrt.confirm(msg, {
	    btn: ['确定','取消'], //按钮
	    shade: true, //不显示遮罩
	    cwidth:'80%'
	}, function(){
		var index = yrt.msg('加载中', {icon: 16,time: 0});
		$.ajaxSec({
			type: 'POST',
			url: base+'/teamLoan/loanManage',
			data:{"id":id,"type":type},
			cache: false,
			success: function(result){
				if(result.state=='success'){
					yrt.msg('操作成功！',{icon: 1});
					if(type==3){
						loan_application(2,1);
					}else{
						loan_application(1,1);
					}
				}else{
					yrt.msg(result.message.error[0],{icon: 2});
				}
				yrt.close(index);
			},
			error: $.ajaxError
		}); 
	}, function(){});
}
</script>
</html>