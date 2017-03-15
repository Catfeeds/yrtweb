<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/common.jsp" %>
<div class="registration" style="width: 940px;">
    <div class="clearit"></div>
    
    <div class="auction_area">
        <div class="countdown">	
        	<input type="hidden" id="start_time" name="start_time" value="<fmt:formatDate value='${leagueAuctionCfg.start_time}' pattern='yyyy/MM/dd HH:mm:ss'/>"/>
        	<c:choose>
         	<c:when test="${!empty leagueAuctionCfg.start_time}">
             	<span>距开始：</span><span id="t_d"></span><span id="t_h"></span><span id="t_m"></span><span id="t_s"></span>
             </c:when>
             <c:otherwise>
             	<span>敬请期待！</span>
             </c:otherwise>
         </c:choose>    		
        </div>
    </div>
</div>
<script type="text/javascript">
	function GetRTime() {
	    var startTime = new Date($('#start_time').val());
	    if(startTime == ''){
		    var NowTime = new Date();
		    var t = startTime.getTime() - NowTime.getTime();
		
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
	}
	GetRTime();
	var down = setInterval(GetRTime, 1000);
</script>     
