<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
		<div style="position: relative;">
		<div class="closeBtn_1"></div>
			<img src="${ctx}/resources/images/clubPk.png" />
		</div>
		<div style="width: 366px;height: 298px;margin:0 auto;">
			<form id="invite_form">
				<input type="hidden" id="fa_teaminfo_id" name="teaminfo_id" value=""/>
				<input type="hidden" id="respond_teaminfo_id" name="respond_teaminfo_id" value=""/>
				<input type="hidden" id="in_status" name="status" value="2"/>
				<input type="hidden" id="fa_t_name" name="t_name" value=""/>
				<input type="hidden" id="fa_t_logo" name="t_logo" value=""/>
				<input type="hidden" id="re_r_name" name="r_name" value=""/>
				<input type="hidden" id="re_r_logo" name="r_logo" value=""/>
				<!-- 是否需要强制刷新页面 -->
				<input type="hidden" id="flush_page" name="flush_page" value=""/>
				<table>
					<tr>
						<td>比赛时间：</td>
						<td>
            				<input id="invite_time" name="invite_time" valid="require" class="form-control w160" type="text" value="" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td>比赛地点：</td>
						<td>
							<input type="text" id="position" name="position" value="" valid="require"/>
						</td>
					</tr>
					<tr>
						<td>对战赛制：</td>
						<td>
							<yt:dictSelect name="ball_format" nodeKey="ball_format" value="" clazz="pk_select"></yt:dictSelect>
						</td>
					</tr>
					<tr>
						<td>对战宣言：</td>
						<td colspan="3">
							<textarea name="declar" id="declar"></textarea>
						</td>
					</tr>
					<tr style="height: 60px;">
						<td></td>
						<td colspan="3">
							<input type="button" value="确认挑战" class="pkBtn" style="margin-right: 32px;" onclick="saveInviteInfo()"/>
							<input type="button" value="取消挑战" class="pkBtn" id="cancel_pk"/>
						</td>
					</tr>
				</table>
			</form>
	</div>
  <script type="text/javascript">
    //pk弹层隐藏显示 
    $("#cancel_pk").click(function(){
    	layer.closeAll();
    	$("#inviteDialog").css("display","none");
    	$(".masker").fadeOut();//隐藏遮罩层
    });
    $(".closeBtn_1").click(function(){
    	layer.closeAll();
    	$("#inviteDialog").css("display","none");
    	$(".masker").fadeOut();//隐藏遮罩层
    });
    
    $("#invite_time").ccCanlendar({
    	iniValue:false,
    	startYear:1970,
    	hasHourPanel:false,
    	hasMinitePanel:false,
    	autoSetMinLimit:false,
    	showNextMonth:false,
    	minLimit:'${minDate}',
   		maxLimit:'${maxDate}'
    });

    //保存邀请挑战信息
    function saveInviteInfo(){
		$.ajaxSec({
			context:$("#invite_form"),
			type:"POST",
			url:base+"/teamInvite/saveOrUpdate?random="+Math.random(),
			data:$("#invite_form").serialize(),
			dataType:"JSON",
			success:function(data){
				if(data.state=="error"){
					layer.msg(data.message.error[0],{icon: 2});
					//layer.alert(data.message.error[0]);
				}else{
					if(data.data.flush_page=="true"){//强制刷新页面
						window.location.reload();
					}else{
						layer.msg('邀请成功',{icon: 1});
						$("#inviteDialog").css("display","none");
						$(".masker").fadeOut();//隐藏遮罩层
					}
				}
			}
			
		});
    }
  </script>    	