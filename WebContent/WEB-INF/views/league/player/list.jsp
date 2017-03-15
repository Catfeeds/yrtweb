<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>球员购买列表</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<c:set var="qc" value="st,lw,rw,lf,rf"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm,lcm,rcm,lcb,rcb"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/>
<c:set var="currentPage" value="LEAGUEINDEX"/>
</head>
<body>
<div class="warp">
	<div class="makser"></div>
	<!--历史竞价-->
    <div class="historical">
        <div class="title">
            <div class="closeBtn_1"></div>
            <span class="f20 ms text-white">历史竞价</span>
        </div>
        <div id="historyData">
        </div>
    </div>
	<div class="auction_super_l" id="playerArea"></div>
	<!--头部-->
	<%@ include file="../../common/header.jsp" %>
	<!--导航 start-->
	<%@ include file="../../common/naver.jsp" %>    
	<!--导航 end-->
	<div class="wrapper" style="margin-top: 116px;">
		<div class="zh">
            <div class="title">
                <span class="pull-left ml20">转会公告</span>
                <a href="${ctx}/playerTrade/leagueMarket?s_id=${s_id}" class="mores">更多</a>
            </div> 
            <table class="zhb">
            	<c:if test="${!empty leagueMarkets}">
            	<c:forEach items="${leagueMarkets}" var="lm">
                <tr>
                    <td>
                        <span>[${lm.outname}]</span>
                        <span>的</span>
                        <span>[${empty lm.username?lm.usernick:lm.username}]</span>
                        <span>以</span>
                        <span>[${lm.price}]</span>
                        <span>的转会费，</span>
                        <span>转会到</span>
                        <span>[${lm.inname}]</span>
                    </td>
                    <td align="right">
                        <span class="text-gray-s_666"><fmt:formatDate value="${lm.buy_time}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                    </td>
                </tr>
            	</c:forEach>
            	</c:if>
            </table>
        </div>
		<div class="registration mt20">
            <div class="reg_title">
                <span class="text-white f16 ms">球员购买</span>
            </div>
            <ul class="l_tools_one">
                <li class="active"><span>球员列表</span></li>
				<c:if test="${!empty session_user_id}">
	                <li><span>|</span></li>
	                <li><span><a href="${ctx}/playerTrade/myPlayers?s_id=${s_id}" class="text-gray-s_666">我的购入</a></span></li>
	                <li><span>|</span></li>
	                <li><span><a href="${ctx}/playerTrade/mySalePlayers?s_id=${s_id}" class="text-gray-s_666">我的出售</a></span></li>
				</c:if>
                <div class="clearit"></div>
            </ul>
            <form id="searchForm">
            <input type="hidden" name="s_id" id="s_id" value="${s_id}"/>	
            <input type="hidden" name="currentPage" id="currentPage" value="1"/>
            <input type="hidden" name="pageSize" value="8"/>
            <ul class="l_tools_two">
                <li><span id="all" onclick="getSort('all','#all');">综合排序</span></li>
                <li><span>|</span></li>
                <li>
                    <c:choose>
                		<c:when test="${auctionCondition.age_sort eq 'ASC'}">
		                	<span style="color: #fff;" onclick="getSort('age_sort','#age');">年龄</span><span id="age" style="color: #fff;">&#8593;</span>
                		</c:when>
                		<c:when test="${empty auctionCondition.age_sort eq 'DESC'}">
		                	<span style="color: #fff;" onclick="getSort('age_sort','#age');">年龄</span><span id="age" style="color: #fff;">&#8595;</span>
                		</c:when>
                		<c:otherwise>
                			<span onclick="getSort('age_sort','#age');">年龄</span><span id="age"></span>	
                		</c:otherwise>
                	</c:choose>
                	<input type="hidden" name="age_sort" class="ich" value="${auctionCondition.age_sort}"/>
                </li>
                <li><span>|</span></li>
                <li>
                	<c:choose>
                		<c:when test="${auctionCondition.bid_sort eq 'ASC'}">
                			<span style="color: #fff;" onclick="getSort('bid_sort','#worth');">身价</span><span id="worth" style="color: #fff;">&#8593;</span>
                		</c:when>
                		<c:when test="${empty auctionCondition.bid_sort eq 'DESC'}">
                			<span style="color: #fff;" onclick="getSort('bid_sort','#worth');">身价</span><span id="worth" style="color: #fff;">&#8595;</span>
                		</c:when>
                		<c:otherwise>
                			<span onclick="getSort('bid_sort','#worth');">身价</span><span id="worth"></span>	
                		</c:otherwise>
                	</c:choose>
                	<input type="hidden" name="bid_sort" class="ich" value="${auctionCondition.bid_sort}"/>
              	</li>
                <li><span>|</span></li>
                <li>
                	<c:choose>
                		<c:when test="${auctionCondition.score_sort eq 'ASC'}">
		                	<span style="color: #fff;" onclick="getSort('score_sort','#ability');">能力</span><span id="ability" style="color: #fff;">&#8593;</span>
                		</c:when>
                		<c:when test="${empty auctionCondition.score_sort eq 'DESC'}">
		                	<span style="color: #fff;" onclick="getSort('score_sort','#ability');">能力</span><span id="ability" style="color: #fff;">&#8595;</span>
                		</c:when>
                		<c:otherwise>
                			<span onclick="getSort('score_sort','#ability');">能力</span><span id="ability"></span>	
                		</c:otherwise>
                	</c:choose>
                	<input type="hidden" name="score_sort" class="ich" value="${auctionCondition.score_sort}"/>
                </li>
                <div class="clearit"></div>
            </ul>
            <ul class="l_tools_three">
                <li><span class="text-white f14">姓名</span><input type="text" name="user_name" value="${username}"/></li>
                <li>
                    <span class="text-white f14">位置</span>
                    <select style="" name="position">	
                            <option value="">请选择</option>
                        	<optgroup label="前场位置">
                                <option value="rw" <c:if test="${auctionCondition.position eq 'rw'}">selected</c:if>>右前锋</option>
                                <option value="lw" <c:if test="${auctionCondition.position eq 'lw'}">selected</c:if>>左边锋</option>
                                <option value="st" <c:if test="${auctionCondition.position eq 'st'}">selected</c:if>>中锋</option>
                            </optgroup>
                            <optgroup label="中场位置">
                                <option value="cam" <c:if test="${auctionCondition.position eq 'cam'}">selected</c:if>>前腰</option>
                                <option value="cdm" <c:if test="${auctionCondition.position eq 'cdm'}">selected</c:if>>后腰</option>
                                <option value="lm" <c:if test="${auctionCondition.position eq 'lm'}">selected</c:if>>左前卫</option>
                                <option value="rm" <c:if test="${auctionCondition.position eq 'rm'}">selected</c:if>>右前卫</option>
                                <option value="cm" <c:if test="${auctionCondition.position eq 'cm'}">selected</c:if>>中前卫</option>  
                            </optgroup>
                            <optgroup label="后场位置">
                                <option value="lb" <c:if test="${auctionCondition.position eq 'lb'}">selected</c:if>>左后卫</option>
                                <option value="cb" <c:if test="${auctionCondition.position eq 'cb'}">selected</c:if>>中后卫</option>
                                <option value="rb" <c:if test="${auctionCondition.position eq 'rb'}">selected</c:if>>右后卫</option>
                            </optgroup>
                    </select>
                    <input type="button" onclick="searchPlayer(1)" name="name" value="搜索" class="auction_btn ms ml10" />
                </li>
            </ul>
            </form>
            <div class="clearit"></div>
            <div class="j_fenge"></div>
           	<div  id="player_lists">
           	   
           	</div>
        </div>
	</div>		
</div>
 <%@ include file="../../common/footer.jsp" %>   
<script src="${ctx}/resources/vmodel/Filter.js"></script>
<script src="${ctx}/resources/js/own/league_market.js"></script>
<script src="${ctx}/resources/js/ajax-pushlet-client.js"></script> 
<script type="text/javascript">
	$(function(){
		searchPlayer(1);
	});
	
	function getSort(name,sid){
		$(".ich").each(function(i){
			if(name == "all"){
				this.value = "";
				$(sid).css("color","#666");
			}else{
				if(this.name == name){
					if(this.value == "DESC"){
						this.value = "ASC";
					}else if(this.value == "ASC"){
						this.value = "DESC";
					}else{
						this.value = "DESC";					
					}
					$(sid).css("color","#fff");
				}else{
					this.value = "";
					$(sid).css("color","#666");
				}
			}
		});
		//$("#searchForm").submit();
		searchPlayer(1);
	}
	
	//购买球员
	//id 球员市场表ID, price：身价,  tm_user_id:俱乐部管理者用户ID,p_user_id:球员用户ID
	function buyPlayer(id,price,tm_user_id,p_user_id,last_team){
		var priceStr = $("#bid_price").val();
		if(!priceStr){
			layer.msg('请输入你的报价！',{icon: 2});
			return;
		}
		var jsonData = {
			"id":id,
			"price":$("#bid_price").val(),
			"tm_user_id":tm_user_id,
			"p_user_id":p_user_id,
			"s_id":$("#s_id").val(),
			"cfg_id":"${cfg.id}"
		};
		
		$.ajaxSec({
			type:"post",
			url:base+"/playerTrade/buy",
			data:jsonData,
			dataType:"json",
			success:function(data){
				if(data.state=='success'){
					layer.msg(data.message.success[0],{icon: 1});
					if(last_team != ''){
						sendPullMsg(last_team);
					}
					closeDetail();
					searchPlayer($("#currentPage").val());
				}else{
					layer.msg(data.message.error[0],{icon: 2});
				}
			}
		})
	}
	
	function searchPlayer(pageIndex){
		$("#currentPage").val(pageIndex);
		var tempHtml = '<img alt="数据加载中" src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 476px;margin-top: 48px;">';
		$.ajax({
			type:'post',
			url:base+'/playerTrade/listdatas?random='+Math.random(),
			data:$("#searchForm").serialize(),
			dataType:'html',
			beforeSend:function(){
				$("#player_lists").empty();
				$("#player_lists").append(tempHtml);
			},
			success:function(data){
				$("#player_lists").empty();
				$("#player_lists").append(data);
			}
		});
		//$("#searchForm").submit();
	}
	
	//查看球员信息 id 球员用户ID
	function lookPlayer(id){
		$.ajaxSec({
			type: 'POST',
			url: base+"/ifLogin",
			dataType:"json",
			success: function(data){
				if(data.state=='error'){
					layer.msg(data.message.error[0],{icon:2});
				}
			},
			error: $.ajaxError
		});	
		
		$.ajax({
			type: 'POST',
			url: base+"/playerTrade/ifMarket",
			dataType:"json",
			data:{s_id:$("#s_id").val(),id:"${cfg.id}"},
			success: function(data){
				if(data.state=='error'){
					layer.msg(data.message.error[0],{icon:2});
				}else{
					$.ajax({
						type: 'POST',
						url: base+"/playerTrade/lookPlayer",
						data: {"m_id":id},
						dataType:"html",
						success: function(data){
							if(data.state=='error'){
								layer.msg(data.message.error[0],{icon:2});
							}else{
								$("#playerArea").html(data);
								var height = $(document).height();
						        $(".makser").css({ "height": height}).show();
						        $(".auction_super_l").center().show();
							}
						},
						error: $.ajaxError
					});	
				}
			},
			error: $.ajaxError
		});		
		
	}
	//关闭弹出框
	function closeDetail(){
		$("#playerArea").html("");
		cl();
	}
	function cl() {
        $(".makser").hide();
        $(".auction_super_l").hide();
    }
	
	$(".closeBtn_1").click(function(){
		 $(".makser").hide();
	     $(".historical").hide();
	});
	
	p_join_listen('/market');
	var key = "P"+'${teaminfo_id}';
	function onData(pushletEvent) {
		var msg_key = pushletEvent.get(key);
		var info = pushletEvent.get("info");
		if(typeof(msg_key) != "undefined"){
			$.ajax({
				type: 'POST',
				url: base+"/auction/getMsg",
				data: {"key":msg_key,"info":info},
				dataType:"json",
				success: function(data){
					if(data.state=='error'){
						layer.msg(data.message.error[0],{icon:2});
					}else{
						layer.alert(data.message.success[0], {icon:0}, function(index){
							searchPlayer($("#currentPage").val());
							layer.close(index);
						});
					}
				},
				error: $.ajaxError
			});	
		}
	}
	function sendPullMsg(bidder){
	       p_publish('/market', 'P'+bidder,key,'info','system.info.auction.bidpass');  
	}
	
</script>     
</body>
</html>