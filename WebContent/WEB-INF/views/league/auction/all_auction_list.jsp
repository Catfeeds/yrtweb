<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/common.jsp" %>
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<c:set var="qc" value="st,lw,rw,lf,rf"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm,lcm,rcm,lcb,rcb"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/>
       	<input type="hidden" id="s_id" name="s_id" value="${auctionCondition.s_id}"/> 
      	<input type="hidden" id="currentPage" name="currentPage" value="${rf.currentPage}"/> 
      	<input type="hidden" id="turn_id" name="turn_id" value="${leagueAuctionCfg.id}"/> 
      	<input type="hidden" id="end_time" name="end_time" value="<fmt:formatDate value='${leagueAuctionCfg.end_time}' pattern='yyyy/MM/dd HH:mm:ss'/>"/> 
          
          <c:choose>
           <c:when test="${ifOpen eq false}">
           	<h1 class="market_end ms">市场未开放，敬请期待！</h1>
           </c:when>
           <c:when test="${ifEnd eq false}">
           	<h1 class="market_end ms">市场已结束，期待下次竞拍！</h1>
           </c:when>
          	<c:otherwise>
             	<div class="countdown">
                    <span>距结束：</span><span id="t_d"></span><span id="t_h"></span><span id="t_m"></span><span id="t_s"></span>
                </div>
               	<div class="rounds">
                     <dl>
                         <dt><label class="f14 ms">当前轮数</label></dt>
                         <dd>
                        	 <span class="active">${leagueAuctionCfg.turn_num}</span>
                       	 </dd>
                     </dl>
                </div>
                <ul class="a_list">
                	<c:forEach items="${rf.items}" var="auction">
                		<li>
                        <div class="auction_super">
                            <div class="name ms f24">${auction.username}</div>
                            <span class="po ms f14">
                            		<c:choose>
                            			<c:when test="${!empty auctionCondition.position}">
		                            		<yt:dict2Name nodeKey="p_position" key="${auctionCondition.position}"></yt:dict2Name>
                            			</c:when>
                            			<c:otherwise>
			                            	<c:forEach items="${fn:split(auction.position,',')}" var="pos" end="0">
                            					<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
			                            	</c:forEach>
                            			</c:otherwise>
                            		</c:choose>
                            </span>
                            <!--中锋标记-->
                            <div class="player_cf" onclick="window.location='${ctx}/center/${auction.user_id}'">
                            	<c:choose>
                           			<c:when test="${!empty auctionCondition.position}">
                           				<c:choose>
	                            			<c:when test="${fn:contains(qc, auctionCondition.position)}">
	                            				<img src="${ctx}/resources/images/player_fw.png" />
	                            			</c:when>
	                            			<c:when test="${fn:contains(zc, auctionCondition.position)}">
	                            				<img src="${ctx}/resources/images/player_cf.png" />
	                            			</c:when>
	                            			<c:when test="${fn:contains(hc, auctionCondition.position)}">
	                            				<img src="${ctx}/resources/images/player_ga.png" />
	                            			</c:when>
	                            			<c:when test="${fn:contains(sm, auctionCondition.position)}">
	                            				<img src="${ctx}/resources/images/player_gk.png" />
	                            			</c:when>
	                            			<c:otherwise>
				                                <img src="${ctx}/resources/images/player_gk.png" />
		                            		</c:otherwise>
	                            		</c:choose>
                           			</c:when>
                           			<c:otherwise>
		                            	<c:choose>
		                            		<c:when test="${!empty auction.position}">
				                            	<c:forEach items="${fn:split(auction.position,',')}" var="pos" end="0">
				                            		<c:choose>
	                         							<c:when test="${auction.level > 0}">
						                            		<c:choose>
						                            			<c:when test="${fn:contains(qc, pos)}">
						                            				<img src="${ctx}/resources/images/player_y_fw.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(zc, pos)}">
						                            				<img src="${ctx}/resources/images/player_y_cf.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(hc, pos)}">
						                            				<img src="${ctx}/resources/images/player_y_ga.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(sm, pos)}">
						                            				<img src="${ctx}/resources/images/player_y_gk.png" />
						                            			</c:when>
						                            		</c:choose>
						                            	</c:when>
						                            	<c:otherwise>
						                            		<c:choose>
						                            			<c:when test="${fn:contains(qc, pos)}">
						                            				<img src="${ctx}/resources/images/player_fw.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(zc, pos)}">
						                            				<img src="${ctx}/resources/images/player_cf.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(hc, pos)}">
						                            				<img src="${ctx}/resources/images/player_ga.png" />
						                            			</c:when>
						                            			<c:when test="${fn:contains(sm, pos)}">
						                            				<img src="${ctx}/resources/images/player_gk.png" />
						                            			</c:when>
						                            		</c:choose>
						                            	</c:otherwise>
						                           </c:choose> 		
				                            	</c:forEach>
		                            		</c:when>
		                            		<c:otherwise>
						                        	<c:choose>
				                            			<c:when test="${player.level > 0}">
				                               				<img src="${ctx}/resources/images/player_y_gk.png" />
														</c:when>
														<c:otherwise>
															<img src="${ctx}/resources/images/player_gk.png" />
														</c:otherwise>
				                               		</c:choose>
		                            		</c:otherwise>
		                            	</c:choose>
                            		</c:otherwise>
                           		</c:choose>	
                            </div>
                            <div class="cf_forward">
                                <img src="${el:headPath()}${auction.head_icon}"/>
                            </div>
                            <dl class="attr">
                                <dt><span class="ms">
                                	<c:choose>
	                                	<c:when test="${empty auction.borndate}">
	                                		保密
	                                	</c:when>
	                                	<c:otherwise>
	                                		${fn:substringBefore((nowDate.time-auction.borndate.time)/1000/60/60/24/365,'.')} 岁
			                                <%-- <fmt:formatNumber value="${(nowDate.time-auction.borndate.time)/1000/60/60/24/365}" type="number" pattern="#0"/> 
	                                	 --%></c:otherwise>
                                	</c:choose>	
                                	</span>
                                </dt>
                                <dd><span class="ms">${auction.height}CM</span></dd>
                                <dd><span class="ms">${auction.weight}KG</span></dd>
                            </dl>
                            <dl class="quote ms">
                                <dt><span>能&emsp;力</span><span class="text-orange ml10">${auction.score}</span></dt>
                                <dd><span>当前身价</span></dd>
                                <dd><span class="text-orange">
                                	<c:choose>
                                		<c:when test="${!empty auction.bid_price}">
                                			<fmt:formatNumber value="${auction.bid_price}" pattern="#0"/>
                                		</c:when>
                                		<c:otherwise>
                                			<fmt:formatNumber value="${auction.init_price}" pattern="#0"/>
                                		</c:otherwise>
                                	</c:choose>
                                	</span><span class="ml10">宇币</span></dd>
                            </dl>
                            <div class="ability" style="display: none;">
                                <table>
                                    <tr>
                                        <td><span class="ms">传</span><span class="ms ml5 text-orange">${auction.pass_ability}</span></td>
                                        <td><span class="ms">力</span><span class="ms ml5 text-orange">${auction.power}</span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="ms">射</span><span class="ms ml5 text-orange">${auction.shot}</span></td>
                                        <td><span class="ms">头</span><span class="ms ml5 text-orange">${auction.header}</span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="ms">速</span><span class="ms ml5 text-orange">${auction.speed}</span></td>
                                        <td><span class="ms">爆</span><span class="ms ml5 text-orange">${auction.explosive}</span></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="auc_div">
                               	<c:choose>
                               		<c:when test="${session_user_id eq auction.bidder}">
		                                <input type="button" name="name" value="已出价" class="ac_btn_end ms" />
                               		</c:when>
                               		<c:otherwise>
		                                <input type="button" id="ac_btn" name="name" value="竞拍" class="ac_btn ms" onclick="lookPlayer('${auction.id}');"/>
                               		</c:otherwise>
                               	</c:choose>
                               	<input type="button" class="ac_btn ms ml10" value="历史竞价" name="name" onclick="showhistory('${auction.user_id}','${auction.id}','${auction.s_id}')">
                            </div>
                        </div>
                    </li>
                	</c:forEach>
                    <div class="clearit"></div>
                </ul>
          	
      <!--分页-->
		<ul class="pagination" style="float:right; margin-top:15px;margin-right: 40px;">
		    <c:choose>
				<c:when test="${rf.pageCount!=0}">
					<c:choose>
				<c:when test="${rf.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="loadQueryPage(1)">首页</a></li>
					<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadQueryPage(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
					<li class="active"><a>${rf.currentPage}</a></li> 
				</c:when>
				<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
				</c:choose>
				<c:choose>
				<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadQueryPage(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
				<c:choose>
				<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
				</c:choose>
				<c:choose>
				<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadQueryPage(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
				</c:choose>
				<li data-command="next"><a href="javascript:void(0)" onclick="loadQueryPage(${rf.pageCount})">末页</a></li> </c:when>
				</c:choose>
				</c:when>
			</c:choose>
		</ul>
		 <div class="clearit"></div>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}
$($(".auction_super")).each(function(){
    $(this).mouseover(function (){
        $(this).find(".quote").hide();
        $(this).find(".ability").show();
    });
}).mouseout(function () {
    $(this).find(".quote").show();
    $(this).find(".ability").hide();

});
function GetRTime() {
    var EndTime = new Date($('#end_time').val());
    var NowTime = new Date();
    var t = EndTime.getTime() - NowTime.getTime();

    var d = Math.floor(t / 1000 / 60 / 60 / 24);	
    if (d < 10) {
        d = "0" + d;
    }
    var h = Math.floor(t / 1000 / 60 / 60 % 24);
    if (h < 10) {
        h = "0" + h;
    }
    var m = Math.floor(t / 1000 / 60 % 60);
    if (m < 10) {
        m = "0" + m;
    }
    var s = Math.floor(t / 1000 % 60);
    if (s < 10) {
        s = "0" + s;
    }

    if (d == 0 && h == 0 && m == 0 && s == 0) {
        document.getElementById("t_d").innerHTML = d + "天";
        document.getElementById("t_h").innerHTML = h + "时";
        document.getElementById("t_m").innerHTML = m + "分";
        document.getElementById("t_s").innerHTML = s + "秒";
        clearInterval(down);
    } else {
        document.getElementById("t_d").innerHTML = d + "天";
        document.getElementById("t_h").innerHTML = h + "时";
        document.getElementById("t_m").innerHTML = m + "分";
        document.getElementById("t_s").innerHTML = s + "秒";
    }
}
GetRTime();
var down = setInterval(GetRTime, 1000);

function search(pageIndex){
	$("#currentPage").val(pageIndex);
	$("#searchForm").submit();
}



//查看球员信息
function lookPlayer(id){
	$.ajaxSec({
		type: 'POST',
		url: base+"/ifLogin",
		dataType:"json",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				$.ajaxSec({
					type: 'POST',
					url: base+"/auction/ifAuction",
					dataType:"json",
					data:{s_id:$("#s_id").val(),turn_num: '${leagueAuctionCfg.turn_num}'},
					success: function(data){
						if(data.state=='error'){
							layer.msg(data.message.error[0],{icon:2});
							//return false;
						}else{
							$.ajax({
								type: 'POST',
								url: base+"/auction/lookPlayer",
								data: {"id":id},
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
		},
		error: $.ajaxError
	});		
	
	
	
	
}
//竞拍球员
function bid(id,bidder){
	var jsonData = {
		"id" : id,
		"turn_id" : $("#turn_id").val(),
		"bid_price" : $("#bid_price").val(),
	};
	$.ajaxSec({
		type: 'POST',
		url: base+"/auction/bidAuction",
		data: jsonData	,
		dataType:"json",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				if(bidder !=''){
					sendPullMsg(bidder);
				}
				closeDetail();
				loadQueryPage($("#currentPage").val());
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
</script>    
