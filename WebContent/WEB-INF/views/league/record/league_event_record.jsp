<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../common/common.jsp" %>
<title>联赛赛程</title>
<link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<c:set var="currentPage" value="LEAGUEINDEX"/>
</head>
<body>
<div class="warp">
	<div class="masker"></div>
		<input type="hidden" id="league_id" value="${league.id}"/>
         <!--头部-->
         <%@ include file="../../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../../common/naver.jsp" %>    
	     <!--导航 end-->
	     <!--二级导航start-->
	     <%@ include file="../index/statistics_naver.jsp" %>    
	     <!--二级导航 end-->
    <input type="hidden" id="round_id" name="round_id" value=""/>
    <input type="hidden" id="group_id" name="group_id" value=""/>   
	<div class="wrapper" style="margin-top: 40px;">
        <div class="race">
            <div class="title">
                <span class="ml20">${league.name}</span>
                <div class="clearit"></div>
            </div>
            <div class="select_runs">
                <a href="javascript:void(0);" class="runs active" onclick="loadRecords(0,'','all',this)">全部</a>
                <c:forEach begin="1" end="${league.rounds}" varStatus="i">
                	<a href="javascript:void(0);" class="runs" onclick="loadRecords(0,'','${i.index}',this)">第${i.index}轮</a>
                </c:forEach>
            </div>
            <c:if test="${!empty groups}">
	            <ul class="select_group" id="record_group">
	                <li class="active" onclick="loadRecords(0,'all','',this)">全部</li>
					<c:forEach items="${groups}" var="group">
		                <li onclick="loadRecords(0,'${group.id}','',this)">${group.name}</li>
	                </c:forEach>	
	            </ul>
	        </c:if> 
            <div class="select_group_line"></div>
            <div id="recordArea">
            <!-- <table class="race_card">
                <tr>
                    <th class="w50"><span class="f12">组别</span></th>
                    <th class="w80"><span class="f12">比赛日期</span></th>
                    <th class="w60"><span class="f12">比赛时间</span></th>
                    <th class="w50"><span class="f12">轮次</span></th>
                    <th class="w40"><span class="f12">主</span></th>
                    <th class="w100"></th>
                    <th class="w155"><span class="f12">对战双方</span></th>
                    <th class="w100"></th>
                    <th class="w40"><span class="f12">客</span></th>

                    <th class="w155"><span class="f12">比赛地点</span></th>
                    <th class="w100"><span class="f12">数据统计</span></th>
                </tr>
                <tr>
                    <td><span>A组</span></td>
                    <td><span>2016-01-10</span></td>
                    <td><span>10:30</span></td>
                    <td><span>第10轮</span></td>
                    <td align="top">
                        <img src="images/zdaa.png" alt="" class="zddb" />
                    </td>
                    <td>
                        <span class="club_nm">成都律金刚足球俱乐部</span>
                    </td>
                    <td>
                        <span class="point">10</span>
                        <img src="images/l_vs.png" alt="" class="vsi" />
                        <span class="point">1</span>
                    </td>
                    <td>
                        <span class="club_nm">成都律金刚足球俱乐部</span>
                    </td>

                    <td align="top">
                        <img src="images/kdaa.png" alt="" class="kddb" />

                    </td>
                    <td><span>成都谢菲联足球俱乐部</span></td>
                    <td><a href="#" class="census">统计详情</a></td>
                </tr>
                <tr>
                    <td><span>A组</span></td>
                    <td><span>2016-01-10</span></td>
                    <td><span>10:30</span></td>
                    <td><span>第10轮</span></td>
                    <td align="top">
                        <img src="images/zdaa.png" alt="" class="zddb" />
                    </td>
                    <td>
                        <span class="club_nm">成都律金刚足球俱乐部</span>
                    </td>
                    <td>
                        <span class="point">10</span>
                        <img src="images/l_vs.png" alt="" class="vsi" />
                        <span class="point">1</span>
                    </td>
                    <td>
                        <span class="club_nm">成都律金刚足球俱乐部</span>
                    </td>

                    <td align="top">
                        <img src="images/kdaa.png" alt="" class="kddb" />

                    </td>
                    <td><span>成都谢菲联足球俱乐部</span></td>
                    <td><a href="#" class="census">统计详情</a></td>
                </tr>
                <tr>
                    <td><span>A组</span></td>
                    <td><span>2016-01-10</span></td>
                    <td><span>10:30</span></td>
                    <td><span>第10轮</span></td>
                    <td align="top">
                        <img src="images/zdaa.png" alt="" class="zddb" />
                    </td>
                    <td>
                        <span class="club_nm">成都律金刚足球俱乐部</span>
                    </td>
                    <td>
                        <span class="point">10</span>
                        <img src="images/l_vs.png" alt="" class="vsi" />
                        <span class="point">1</span>
                    </td>
                    <td>
                        <span class="club_nm">成都律金刚足球俱乐部</span>
                    </td>

                    <td align="top">
                        <img src="images/kdaa.png" alt="" class="kddb" />

                    </td>
                    <td><span>成都谢菲联足球俱乐部</span></td>
                    <td><a href="#" class="census">统计详情</a></td>
                </tr>
                
            </table> -->
            </div>
            <div class="clearit"></div>
        </div>
    </div>
<div>
   
<%@ include file="../../common/footer.jsp" %>
<script type="text/javascript">
	$(function(){
		loadRecords(0,'all','all');
	})
	//获取赛程纪录
	function loadRecords(currentPage,gid,rid,obj){
		$(obj).addClass("active").siblings().removeClass("active");
		var group_id = '';
		if(gid == 'all'){
			group_id = '';
			$("#group_id").val('');
		}else if(gid == ''){
			group_id = $("#group_id").val();
		}else{
			group_id = gid;
			$("#group_id").val(gid);
		}
		
		if(rid == 'all'){
			round_id = '';
			$("#round_id").val('');
		}else if(rid == ''){
			round_id = $("#round_id").val();
		}else{
			round_id = rid;
			$("#round_id").val(rid);
		}
		var params = {
			league_id : '${league.id}',
			group_id : group_id,
			round_id : round_id,
			currentPage : currentPage,
			pageSize : 10
		};
		$.loadSec('#recordArea',base+'/league/queryEventRecords',params);
	}
</script>
</body>
</html>
