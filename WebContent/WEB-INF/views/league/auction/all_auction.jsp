<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>竞拍列表</title>
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
		
		<div class="registration">
            <div class="reg_title">
                <span class="text-white f16 ms">球员竞拍</span>
            </div>
            <ul class="l_tools_one">
                <li class="active"><span>竞拍列表</span></li>
				<c:if test="${!empty session_user_id}">
	                <li><span>|</span></li>
	                <li><span><a href="${ctx}/auction/mySearchList?s_id=${auctionCondition.s_id}" class="text-gray-s_666">我的竞拍</a></span></li>
				</c:if>
                <div class="clearit"></div>
            </ul>
            <form action="${ctx}/auction/searchList" method="post" id="searchForm">	
            	<input type="hidden" id="s_id" name="s_id" value="${auctionCondition.s_id}"/> 
            	<input type="hidden" id="currentPage" name="currentPage" value="0"/> 
            	<input type="hidden" id="turn_id" name="turn_id" value="${leagueAuctionCfg.id}"/> 
            	<input type="hidden" id="end_time" name="end_time" value="<fmt:formatDate value='${leagueAuctionCfg.end_time}' pattern='yyyy/MM/dd HH:mm:ss'/>"/> 
            <ul class="l_tools_two">
                <li><span id="all" onclick="getSort('all','#all');">综合排序</span></li>
                <li><span>|</span></li>
                <li>
	                <span onclick="getSort('age_sort','#age_sort');">年龄</span><span id="age_sort"></span>	
                	<input type="hidden" name="age_sort" class="ich" value="${auctionCondition.age_sort}"/>
                </li>
                <li><span>|</span></li>
                <li>
             		<span onclick="getSort('bid_sort','#bid_sort');">身价</span><span id="bid_sort"></span>	
                	<input type="hidden" name="bid_sort" class="ich" value="${auctionCondition.bid_sort}"/>
              	</li>
                <li><span>|</span></li>
                <li>
                	<span onclick="getSort('score_sort','#score_sort');">能力</span><span id="score_sort"></span>	
                	<input type="hidden" name="score_sort" class="ich" value="${auctionCondition.score_sort}"/>
                </li>
                <div class="clearit"></div>
            </ul>
            <ul class="l_tools_three">
                <li><span class="text-white f14">姓名</span><input type="text" name="user_name" value="${auctionCondition.user_name}"/></li>
                <li><span class="text-white f14">类别</span>
                	<select id="level" name="level">
                  		<option value="">请选择</option>
                  		<option value="0">普通球员</option>
                  		<option value="1">妖人球员</option>
                  	</select>
               	</li>
                <li>
                    <span class="text-white f14">位置</span>
                    <select name="position">	
                            <option value="">不限</option>
                        	<optgroup label="前场位置">
                                <option value="rw" <c:if test="${auctionCondition.position eq 'rw'}">selected</c:if>>右边锋</option>
                                <option value="lw" <c:if test="${auctionCondition.position eq 'lw'}">selected</c:if>>左边锋</option>
                                <option value="st" <c:if test="${auctionCondition.position eq 'st'}">selected</c:if>>中锋</option>
                                <option value="lf" <c:if test="${auctionCondition.position eq 'lf'}">selected</c:if>>左前锋</option>
                                <option value="rf" <c:if test="${auctionCondition.position eq 'rf'}">selected</c:if>>右前锋</option>
                            </optgroup>
                            <optgroup label="中场位置">
                                <option value="cam" <c:if test="${auctionCondition.position eq 'cam'}">selected</c:if>>前腰</option>
                                <option value="cdm" <c:if test="${auctionCondition.position eq 'cdm'}">selected</c:if>>后腰</option>
                                <option value="lm" <c:if test="${auctionCondition.position eq 'lm'}">selected</c:if>>左前卫</option>
                                <option value="rm" <c:if test="${auctionCondition.position eq 'rm'}">selected</c:if>>右前卫</option>
                                <option value="cm" <c:if test="${auctionCondition.position eq 'cm'}">selected</c:if>>中前卫</option>
                                <option value="lcm" <c:if test="${auctionCondition.position eq 'lcm'}">selected</c:if>>左中场</option> 
                                <option value="rcm" <c:if test="${auctionCondition.position eq 'rcm'}">selected</c:if>>右中场</option> 
                                <option value="lcb" <c:if test="${auctionCondition.position eq 'lcb'}">selected</c:if>>左中卫</option> 
                                <option value="rcb" <c:if test="${auctionCondition.position eq 'rcb'}">selected</c:if>>右中卫</option>  
                            </optgroup>
                            <optgroup label="后场位置">
                                <option value="lb" <c:if test="${auctionCondition.position eq 'lb'}">selected</c:if>>左后卫</option>
                                <option value="cb" <c:if test="${auctionCondition.position eq 'cb'}">selected</c:if>>中后卫</option>
                                <option value="rb" <c:if test="${auctionCondition.position eq 'rb'}">selected</c:if>>右后卫</option>
                            </optgroup>
                            <optgroup label="守门">
                                <option value="gk" <c:if test="${auctionCondition.position eq 'gk'}">selected</c:if>>守门员</option>
                            </optgroup>
                    </select>
                    <input type="button" name="name" value="搜索" class="auction_btn ms ml10" onclick="loadQueryPage(0);"/>
                </li>
            </ul>
            </form>
            <div class="clearit"></div>
            <div class="j_fenge"></div>
			<div class="auction_area" id="auction_area"></div>		
</div>
</div>
 <%@ include file="../../common/footer.jsp" %>   
<script src="${ctx}/resources/vmodel/Filter.js"></script>
<script src="${ctx}/resources/js/ajax-pushlet-client.js"></script>   
<script type="text/javascript">
	//pushlet指定用户消息	
	  // PL.userId = '${session_user_id}';  
	p_join_listen('/auction');
	var key = "K"+'${teaminfo_id}';
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
							loadQueryPage($("#currentPage").val());
							layer.close(index);
						});
					}
				},
				error: $.ajaxError
			});	
		}
	}
	function sendPullMsg(bidder){
	       p_publish('/auction', 'K'+bidder,key,'info','system.info.auction.bidpass');  
	}
	
	function loadQueryPage(pageIndex){
		var jsonData = $("#searchForm").serializeObject();
		jsonData.currentPage = pageIndex;
		jsonData.pageSize = 8;
		$.ajax({
			type: 'POST',
			url: base+"/auction/loadQueryPage",
			data: jsonData,
			dataType:"html",
			success: function(data){
				if(data.state=='error'){
					layer.msg(data.message.error[0],{icon:2});
				}else{
					$("#auction_area").html(data);
				}
			},
			error: $.ajaxError
		});	
	}
	loadQueryPage(0);
	
	
	function getSort(name,sid){
		$(".ich").each(function(i){
			if(name == "all"){
				this.value = "";
				$("#"+this.name).html("");
			}else{
				if(this.name == name){
					if(this.value == "DESC"){
						this.value = "ASC";
						$(sid).html("&#8593;");
					}else if(this.value == "ASC"){
						this.value = "DESC";
						$(sid).html("&#8595;");
					}else{
						this.value = "DESC";
						$(sid).html("&#8595;");
					}
				}else{
					this.value = "";
					$("#"+this.name).html("");
					//$(sid).html("");
				}
			}
		});
		loadQueryPage(0);
	} 
	
	$(".closeBtn_1").click(function(){
		 $(".makser").hide();
	     $(".historical").hide();
	});
	
	//竞拍球员用户ID
	var user_id = "";
	var au_id = "";
	var s_id = "";
	//p_user_id 球员用户ID id:竞拍市场ID l_id:联赛ID
	function showhistory(p_user_id,id,l_id){
		  user_id=p_user_id;
		  au_id = id;
		  s_id = l_id;
		  var height = $(document).height();
          $(".makser").css({ "height": height }).fadeIn();
          $(".historical").center().fadeIn();
          loadhistoryDatas(1);
	}
	
	function loadhistoryDatas(currentPage){
		$.ajax({
			type:'post',
			url:base+'/auction/bidRecord?random='+Math.random(),
			data:{"currentPage":currentPage,"pageSize":10,"user_id":user_id,"au_id":au_id,"s_id":s_id},
			dataType:'json',
			success:function(data){
				$("#historyData").empty();
				var len = data.data.rf.items.length;
				var html='';
					html='<table class="infos">';
					html+='<tr><th><span>出价时间</span></th><th><span>出价俱乐部</span></th><th><span>出价</span></th><th><span>状态</span></th></tr>';
				if(len>0){
				$.each(data.data.rf.items,function(i,item){
					if(i==0 && data.data.rf.currentPage==1){
						html+='<tr><td><dl><dt>'
						html+='<span class="text-orange f16">'+Filter.formatDate(item.bid_time,'yyyy-MM-dd')+'</span>';
						html+='</dt>';
						html+='<dd><span class="text-orange f16">'+Filter.formatDate(item.bid_time,'hh:mm:ss')+'</span></dd></dl></td>';
						html+='<td><span class="text-orange f16">'+item.name+'</span></td>';
						html+='<td><span class="text-orange f16">'+item.bid_price+'</span></td>';
						html+='<td><span class="text-orange f16">当前最高</span></td></tr>';
					}else{
						html+='<tr><td><dl><dt>'
						html+='<span>'+Filter.formatDate(item.bid_time,'yyyy-MM-dd')+'</span>';
						html+='</dt>';
						html+='<dd><span>'+Filter.formatDate(item.bid_time,'hh:mm:ss')+'</span></dd></dl></td>';
						html+='<td><span>'+item.name+'</span></td>';
						html+='<td><span>'+item.bid_price+'</span></td>';
						html+='<td><span>被超过</span></td></tr>';
					}
				})
					html+='</table>';
					html+='<ul class="pagination" style="float:right;margin-top:15px;">';
					html+='<li><label class="index">第'+data.data.rf.currentPage+'页/共'+data.data.pageCount+'页</label> </li>';
					html+='<li><label class="sum">共计'+data.data.rf.totalCount+'条</label> </li>';
					html+='<li><a href="javascript:void(0)" onclick="loadhistoryDatas(1);">首页</a></li>';
					if(eval(data.data.rf.currentPage-1)>0){
						html+='<li><a href="javascript:void(0)" onclick="loadhistoryDatas('+eval(data.data.rf.currentPage-1)+');">上一页</a></li>';
					}else{
						html+='<li><a href="javascript:void(0)">上一页</a></li>';
					}
					if(eval(data.data.rf.currentPage+1)>eval(data.data.pageCount)){
						html+='<li><a href="javascript:void(0)">下一页</a></li>';
					}else{
						html+='<li><a href="javascript:void(0)" onclick="loadhistoryDatas('+eval(data.data.rf.currentPage+1)+');">下一页</a></li>';
					}
					html+='<li><a href="javascript:void(0)" onclick="loadhistoryDatas('+data.data.pageCount+');">最后一页</a></li>';
					html+='</ul><div class="clearfix"></div>';
				}else{
					html+='<tr><td colspan="4">暂无竞价...</td></tr>';
				}
				$("#historyData").append(html);
			}
		});
	}
</script>    
</body>
</html>