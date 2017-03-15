<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>阵型设置</title>
</head>
<body>
 <div class="warp">
 		<%@ include file="../../common/header.jsp" %>       
		<%@ include file="../../common/naver.jsp" %>         
        <div class="wrapper" style="margin-top: 116px;">
			<input type="hidden" id="teaminfo_id" value="${teaminfo_id}"/>
            <div class="formation">
                <div class="title">
                    <span class="f18 ms pull-left ml10">阵形设置</span>
                    <div class="clearit"></div>
                </div>
                <div id="formatArea">
                
                </div>
            </div>
        </div>
    </div>
 <%@ include file="../../common/footer.jsp" %>
    <script type="text/javascript">
		$(function(){
			loadformatArea();
		});
		
		
        
		function loadformatArea(){
			$.ajax({
        		type:'post',
        		url:base+'/tformat/format?random='+Math.random(),
        		data:{'teaminfo_id':$('#teaminfo_id').val()},
        		dataType:"html",
        		beforeSend:function(){
        			
        		},
        		success:function(data){
        			$("#formatArea").empty(),
        			$("#formatArea").append(data);
        			loadTeamPlayers();
        		}
        	});
		}
		
		
		//载入俱乐部阵型成员列表
        function loadTeamPlayers(){
        	$.ajax({
        		type:'post',
        		url:base+'/tformat/datas?random='+Math.random(),
        		data:{'teaminfo_id':$('#teaminfo_id').val()},
        		dataType:"json",
        		beforeSend:function(){
        			
        		},
        		success:function(data){
        			if(data.data.tps.length>0){
        				$.each(data.data.tps,function(i,item){
        					if(item.position_num!=null && item.position!=''){
        						$(".seat").find("img[index='"+item.position_num+"']").attr("src",ossPath+item.head_icon);
        					}
        				});
        			}
        		}
        	});
        }
        
		//载入俱乐部成员列表
		/* function loadPlayersDatas(){
			$.ajax({
        		type:'post',
        		url:base+'/tformat/allPlayers?random='+Math.random(),
        		data:{'teaminfo_id':$('#teaminfo_id').val()},
        		dataType:"html",
        		beforeSend:function(){
        			
        		},
        		success:function(data){
        			$("#arrangement").empty(),
        			$("#arrangement").append(data);
        		}
        	});
		} */
    </script>
</body>
</html>
