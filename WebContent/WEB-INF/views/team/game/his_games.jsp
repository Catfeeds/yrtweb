<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/common.jsp" %>
<c:set var="currentPage" value="TEAMDETAIL"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>历史比赛记录</title>
    <link href="${ctx}/resources/css/matchRecord.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/clubLook.css" rel="stylesheet" />
</head>
<body>
	<input type="hidden" name="teaminfo_id" id="teaminfo_id" value="${teaminfo_id}"/>
    <div class="warp">
        <!--头部-->
    	<%@ include file="../../common/header.jsp" %>    
    </div>
        <!--导航 start-->
        <%@ include file="../../common/naver.jsp" %>    
        <!--导航 end-->
        <div class="wrapper" style="margin-top: 94px;">
            <!--页面主体-->
            <div class="container ms f14">
               	 <div class="history1 ms f14">
               			<p class="history_title1">比赛历史记录</p>
               			<div id="historyGames">
               				<!-- 比赛历史记录数据 -->
             			</div>
               				
                 </div>
            </div>
        </div>
        <!--评价弹层-->
      	<div class="baby" style="display: none;">
        	<div class="baby_judge">
        		<div class="closeBtn"></div>
        		<div class="judge_title">
        			<p class="f20 text-white text-center">宝贝评价</p>
        		</div>
        		<div class="baby_info">
        			<div class="babyHead">
        				<img id="baby_head_img" src="${ctx}/resources/images/babyHead.png" />
        				<span id="baby_name" class="f20 text-white ml20 babyName mt30"></span>
        			</div>
        		</div>
        		<form id="baby_pijia_form" action="${ctx}/babyeval/saveBabyEval">
        		<input type="hidden" id="baby_user_id" name="user_id" value=""/>
        		<input type="hidden" id="byby_teamgame_id" name="teamgame_id" value=""/>
        		<input type="hidden" id="byby_teaminfo_id" name="teaminfo_id" value=""/>
        		<div class="judge_bottom">
        			<p class="text-center text-white f14">——留下您的评价吧——</p>
        			<!--<p class="text-center mt10">
        				<img src="images/xing.png" />
        				<img src="images/xing.png" />
        				<img src="images/xing.png" />
        				<img src="images/xing.png" />
        				<img src="images/xing.png" />
        			</p>-->
        			<p class="text-center">
        				<textarea placeholder="至少输入10个字" name="content" valid="require len(0,280)" clientidmode="Static"></textarea>
        			</p>
        			<p class="text-center mt10">
        				<input type="button" onclick="$.ajaxSubmit('#baby_pijia_form','#baby_pijia_form',resHandler)" value="提交"/>
        				<input id="resetBtn" type="reset" value="重置" style="background: #7D7D7D;margin-left: 10PX;"/>
        			</p>
        		</div>
        		</form>
        	</div>
        	
        </div>
        <!--页脚-->
    	<%@ include file="../../common/footer.jsp" %>
    	<script type="text/javascript">
			$(function(){
				loadListPage(1);
				$(".baby").find("textarea").val("");
				$(".closeBtn").click(function() {
		            $(".baby").css("display","none");
		            $(".baby").find("textarea").val("");
		        });
				$("#resetBtn").click(function() {
		            $(".baby").find("textarea").val("");
		        });
			});
			
			function resHandler(result){
				if(result.state=='success'){
	   				layer.msg("评价成功",{icon: 1});
	   				$(".baby").css("display","none");
		            $(".baby").find("textarea").val("");
	   			}else{
		   			layer.msg("评价失败",{icon: 2});
	   			}
			}
			

			//获取比赛历史记录数据
			function loadListPage(currentPage){
				$.ajax({
					type:"POST",
					url:base+"/team/gameDatas?random="+Math.random(),
					data:{"teaminfo_id":$("#teaminfo_id").val(),"currentPage":currentPage},
					dataType:"HTML",
					success:function(data){
						$("#historyGames").empty();
						$("#historyGames").html(data);
					}
				});
			}

			//鼠标悬浮
	        function showBtn(dom){
	        	$(dom).children().find(".score_operate1").css("display","block");
	        }
	        
	        //鼠标移开
	        function hideBtn(dom){
	        	$(dom).children().find(".score_operate1").css("display","none");
	        }
			//added by bo.xie 同意、拒绝比分
	        function confirmCore(id,status){
				$.ajaxSec({
					type:"POST",
					url:base+"/teamInvite/checkResult?random="+Math.random(),
					data:{"id":id,"teaminfo_id":$("#teaminfo_id").val(),"status":status},
					dataType:"JSON",
					success:function(data){
						if(data.state=="error"){
							layer.msg(data.message.error[0],{icon: 2});
						}else{
							layer.msg(data.message.success[0],{icon: 1});	
							window.location.reload();
						}
					}
				});
	        }
	        
    	</script>
</body>
</html>
