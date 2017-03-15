<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${ctx}/resources/css/league.css" rel="stylesheet" />
<title>积分榜</title>
<style type="text/css">
.firstone span{color:#ff0000;}
.second span{color:#468847;}
.thirst span{color:#3a87ad;}

</style>
</head>
<body>
<div class="warp">
 	<!--头部-->
    <%@ include file="../../common/header.jsp" %>
	<!--导航 start-->
    <%@ include file="../../common/naver.jsp" %>    
	<!--导航 end-->
	<!--二级导航start-->
    <%@ include file="../index/statistics_naver.jsp" %>    
    <!--二级导航 end-->

	<div class="wrapper" style="margin-top: 40px;">
            <div class="credit_list" style="min-height: 350px;">
                <div class="title">
                    <%-- <span class="f18 ms pull-left ml10"><a href="javascript:void(0);" style="color:#fff" onclick="location.href='${ctx}/league/index?league_id=${league.id}'">${league.simple_name}首页</a>>>积分榜</span>
                    --%> 
                    <span class="f16 ms pull-left ml10">${league.name}</span>
                    <div class="clearit"></div>
                </div>
                <div class="points">
                    <ul id="groupul">
                        <c:forEach var="group" items="${loadLeagueGroups }" varStatus="index">
                           <li class="<c:if test="${index.index == 0 }">active</c:if>" id="group${index.index }" onclick="loadintegralListByGroupId('${group.id }',${index.index })" id="group${index.index }">
                               ${group.name }
                           </li>
                        </c:forEach>
                        <div class="clearit"></div>
                    </ul>
                    <div class="clearit"></div>
                    <div class="l_fenge"></div>
                    <table id="tableinfo">
	                        <tr>
	                            <th><span>名次</span></th>
	                            <th><span>队徽</span></th>
	                            <th><span>队名</span></th>
	                            <th><span>场次</span></th>
	                            <th style="width: 5%;"><span>胜</span></th>
	                            <th style="width: 5%;"><span>平</span></th>
	                            <th style="width: 5%;"><span>负</span></th>
	                            <th><span>进球</span></th>
	                            <th><span>失球</span></th>
	                            <th><span>净胜球</span></th>
	                            <th><span>积分</span></th>
	                        </tr>
	                         <c:choose>
							    <c:when test="${!empty firstLeagueIntegral}">
                                   <c:forEach var="integral" items="${firstLeagueIntegral }" varStatus="num" >
				                        <tr class="<c:if test="${num.index == 0 || num.index == 1 ||num.index == 2 || num.index == 3 }">thirst</c:if> ">
				                            <td><span>${num.index+1 }</span></td>
				                            <td>
				                                <img src="${el:headPath()}${integral.logo }" />
				                            </td>
				                            <td>
				                            	<c:choose>	
					                            	<c:when test="${num.index == 0 || num.index == 1 ||num.index == 2 || num.index == 3 }">
						                            	<a style="cursor: pointer;color: #3a87ad;" onclick="javascript:window.location='${ctx}/team/tdetail/${integral.teaminfo_id}'" >${integral.name }</a>
					                            	</c:when>
					                            	<c:otherwise>
					                            		<a style="cursor: pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${integral.teaminfo_id}'" >${integral.name }</a>
					                            	</c:otherwise>
				                            	</c:choose>
				                            </td>
				                            <td><span>${integral.games }</span></td>
				                            <td class="<c:choose><c:when test="${num.index == 0 }">t l</c:when><c:when test="${num.index == firstLeagueIntegral.size()-1 }">l b</c:when><c:otherwise>l</c:otherwise></c:choose>"><span>${integral.win_games }</span></td>
				                            <td class="<c:choose><c:when test="${num.index == 0 }">t</c:when><c:when test="${num.index == firstLeagueIntegral.size()-1 }">b</c:when></c:choose>"><span>${integral.flat_games }</span></td>
				                            <td class="<c:choose><c:when test="${num.index == 0 }">t r</c:when>
				                                                 <c:when test="${num.index == firstLeagueIntegral.size()-1 }">b r</c:when>
				                                                 <c:otherwise>r</c:otherwise>
				                                       </c:choose>">
				                                       <span>${integral.lose_games }</span>
				                            </td>
				                            <td><span>${integral.in_ball }</span></td>
				                            <td><span>${integral.lose_ball }</span></td>
				                            <td><span>${integral.in_ball - integral.lose_ball }</span></td>
				                            <td><span>${integral.sum_integral }</span></td>
				                        </tr>
                                  </c:forEach>
                                </c:when>
	                            <c:otherwise>
									<tr>
										<tr><td colspan='11'>该分组下还没有联赛积分记录</td></tr>
									</tr>
								</c:otherwise>
							</c:choose>
                    </table>
                </div>
            </div>
        </div>     
</div>
<%@include file="../../common/footer.jsp" %>
</body>
<script type="text/javascript">
function loadintegralListByGroupId(gid,index){
	if(gid != ""){
		var params = $.param({gid:gid});
		$.ajaxSec({
			type:'GET',
			url: base+'/league/integralListByGroupId',
			data: params,
			cache: false,
			dataType:'json',
			success: function(result){
				var html = "<tr>"+
					           "<th><span>名次</span></th>"+
					           "<th><span>队徽</span></th>"+
					           "<th><span>队名</span></th>"+
					           "<th><span>场次</span></th>"+
					           "<th style='width: 5%;'><span>胜</span></th>"+
					           "<th style='width: 5%;'><span>平</span></th>"+
					           "<th style='width: 5%;'><span>负</span></th>"+
					           "<th><span>进球</span></th>"+
					           "<th><span>失球</span></th>"+
					           "<th><span>净胜球</span></th>"+
					           "<th><span>积分</span></th>"+
				            " </tr>";
				if(result.state == 'error'){
					$("#tableinfo").empty();
					$("#groupul li").removeClass("active");
                    $("#group"+index+"").addClass("active");
					html += "<tr><td colspan='11'>该分组下还没有联赛积分记录</td></tr>";
                    $("#tableinfo").append(html);      
				}else{
					var listSize = result.data.data.length;
					$.each(result.data.data,function(i,a){ 
						var leftStyle = "l";
						var centerStyle = "";
						var rightStyle = "r";
					    html += "<tr class='";
						if(i==0 || i==1 || i==2 || i==3){
							html += "thirst'>";
						}else{
							html += "'>";
						}
						
						if(i==0){
							leftStyle = "t l";
							centerStyle = "t";
							rightStyle = "t r";
						}else if(i == (listSize -1) ){
							leftStyle = "l b";
							centerStyle = "b";
							rightStyle = "b r";
						}
						
						if(listSize == 1){
							leftStyle = "t l b ";
							centerStyle = "t b";
							rightStyle = "t r b";
						}
						html += "<td><span>"+(i+1)+"</span></td>"+
                                "<td>" +
                                  "<img src='"+ossPath+a.logo+"' />"+
                                "</td>"+
                                
                                "<td><span style='cursor:pointer' onclick=locationPage('"+a.teaminfo_id+"');>"+a.name+"</span></td>"+
                                "<td><span>"+a.games+"</span></td>"+
                                "<td class='"+leftStyle+"'><span>"+a.win_games+"</span></td>"+
                                "<td class='"+centerStyle+"'><span>"+a.flat_games+"</span></td>"+
                                "<td class='"+rightStyle+"'><span>"+a.lose_games+"</span></td>"+
                                "<td><span>"+a.in_ball+"</span></td>"+
                                "<td><span>"+a.lose_ball+"</span></td>"+
                                "<td><span>"+(a.in_ball - a.lose_ball)+"</span></td>"+
                                "<td><span>"+a.sum_integral+"</span></td>"+
                              "</tr>";
					});
					 $("#groupul li").removeClass("active");
                     $("#group"+index+"").addClass("active");
                     $("#tableinfo").empty();
                     $.parseHTML(html, true );
                     $("#tableinfo").html(html);    
				}
			},
			error: $.ajaxError
		});
	}
}

function locationPage(id){
	window.location= base+"/team/tdetail/"+id;
}


</script>
</html>