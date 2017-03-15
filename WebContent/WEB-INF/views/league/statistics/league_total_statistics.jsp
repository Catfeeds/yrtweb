<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../../common/common.jsp" %>
<title>排行总览</title>
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
		<div class="wrapper" style="margin-top: 40px;">
    		<div class="race">
                <div class="title">
                    <span class="ml20">${league.name}</span>
                </div>
                <div class="race_content">
                    <div id="the_1">
                        <div class="nag">
                            <span class="nag_title">射手榜</span>
                        </div>
                        <div class="nag_line"></div>
                        <a href="${ctx}/league/scorerRank?league_id=${league.id}" class="full">查看完整排行</a>
                        <div class="clearit"></div>
                        <ul class="nag_name">
                     					<c:forEach items="${shotList.items}" var="shot" varStatus="i">
		                     				<c:if test="${i.index eq 1}">
					                            <li style="margin-left: 0;">
					                                <dl class="nag_info_2">
					                                    <dt>
					                                        <div class="nag_h">
					                                            <img src="${el:headPath()}${shot.head_icon}" alt="头像" class="nag_head_2" />
					                                            <span class="d_er"></span>
					                                        </div>
					                                    </dt>
					                                    <dd class="mt20"><span class="ms f16 text-white">${shot.username}</span></dd>
					                                </dl>
					                            </li>
					                         </c:if>
				                     	</c:forEach>  
			                         	<c:forEach items="${shotList.items}" var="shot" varStatus="i">
		                     				<c:if test="${i.index eq 0}">
					                            <li>
					                                <dl class="nag_info_1">
					                                    <dt>
					                                        <div class="nag_h">
					                                            <img src="${el:headPath()}${shot.head_icon}" alt="头像" class="nag_head_1" />
					                                            <span class="d_yi"></span>
					                                        </div>
					                                    </dt>
					                                    <dd class="mt25"><span class="ms f16 text-white">${shot.username}</span></dd>
					                                </dl>
					                            </li>
			                          	 	</c:if>
				                     	</c:forEach>
			                          	<c:forEach items="${shotList.items}" var="shot" varStatus="i">
		                     				<c:if test="${i.index eq 2}">  
					                            <li>
					                                <dl class="nag_info_3">
					                                    <dt>
					                                        <div class="nag_h">
					                                            <img src="${el:headPath()}${shot.head_icon}" alt="头像" class="nag_head_2" />
					                                            <span class="d_san"></span>
					                                        </div>
					                                    </dt>
					                                    <dd class="mt20"><span class="ms f16 text-white">${shot.username}</span></dd>
					                                </dl>
					                            </li>
			                          		</c:if>
				                     	</c:forEach>
                            <div class="clearit"></div>
                        </ul>
                    </div>
                    <div id="the_2">
                        <div class="nag">
                            <span class="nag_title">身价榜</span>
                        </div>
                        <div class="nag_line"></div>
                        <a href="${ctx}/league/toPrice?league_id=${league.id}" class="full">查看完整排行</a>
                        <div class="clearit"></div>
                        <ul class="nag_name">
                      			<c:forEach items="${worthList.items}" var="worth" varStatus="i">
	                       			<c:if test="${i.index eq 1}">
			                            <li style="margin-left: 0;">
			                                <dl class="nag_info_2">
			                                    <dt>
			                                        <div class="nag_h">
			                                            <img src="${el:headPath()}${worth.head_icon}" alt="头像" class="nag_head_2" />
			                                            <span class="d_er"></span>
			                                        </div>
			                                    </dt>
			                                    <dd class="mt20"><span class="ms f16 text-white">${worth.username}</span></dd>
			                                </dl>
			                            </li>
		                            </c:if>
	                         	</c:forEach>   
		                        <c:forEach items="${worthList.items}" var="worth" varStatus="i">
	                       			<c:if test="${i.index eq 0}">
			                            <li>
			                                <dl class="nag_info_1">
			                                    <dt>
			                                        <div class="nag_h">
			                                            <img src="${el:headPath()}${worth.head_icon}" alt="头像" class="nag_head_1" />
			                                            <span class="d_yi"></span>
			                                        </div>
			                                    </dt>
			                                    <dd class="mt25"><span class="ms f16 text-white">${worth.username}</span></dd>
			                                </dl>
			                            </li>
	                      			</c:if>
                         		</c:forEach> 
		                     	<c:forEach items="${worthList.items}" var="worth" varStatus="i">
	                       			<c:if test="${i.index eq 2}">
			                            <li>
			                                <dl class="nag_info_3">
			                                    <dt>
			                                        <div class="nag_h">
			                                            <img src="${el:headPath()}${worth.head_icon}" alt="头像" class="nag_head_2" />
			                                            <span class="d_san"></span>
			                                        </div>
			                                    </dt>
			                                    <dd class="mt20"><span class="ms f16 text-white">${worth.username}</span></dd>
			                                </dl>
			                            </li>
		                            </c:if>
	                        	</c:forEach>
                            <div class="clearit"></div>
                        </ul>
                    </div>
                    <div id="the_3">
                        <div class="nag">
                            <span class="nag_title">助攻榜</span>
                        </div>
                        <div class="nag_line"></div>
                        <a href="${ctx}/league/assistsRank?league_id=${league.id}" class="full">查看完整排行</a>
                        <div class="clearit"></div>
                        <ul class="nag_name">
		                    	<c:forEach items="${assistList.items}" var="assist" varStatus="i">
	                    			<c:if test="${i.index eq 1}">
	                            		<li style="margin-left: 0;">
			                                <dl class="nag_info_2">
			                                    <dt>
			                                        <div class="nag_h">
			                                        	<img src="${el:headPath()}${assist.head_icon}" alt="头像" class="nag_head_2" />
			                                            <span class="d_er"></span>
			                                        </div>
			                                    </dt>
			                                    <dd class="mt20"><span class="ms f16 text-white">${assist.username}</span></dd>
			                                </dl>
			                            </li>
			                    	</c:if>
			                    </c:forEach>	
		                    	<c:forEach items="${assistList.items}" var="assist" varStatus="i">
                    				<c:if test="${i.index eq 0}">   
			                            <li>
			                                <dl class="nag_info_1">
			                                    <dt>
			                                        <div class="nag_h">
			                                            <img src="${el:headPath()}${assist.head_icon}" alt="头像" class="nag_head_1" />
			                                            <span class="d_yi"></span>
			                                        </div>
			                                    </dt>
			                                    <dd class="mt25"><span class="ms f16 text-white">${assist.username}</span></dd>
			                                </dl>
			                            </li>
			                        </c:if>
			                    </c:forEach>
			                	<c:forEach items="${assistList.items}" var="assist" varStatus="i">
                    				<c:if test="${i.index eq 2}">	    
			                            <li>
			                                <dl class="nag_info_3">
			                                    <dt>
			                                        <div class="nag_h">
			                                        	<img src="${el:headPath()}${assist.head_icon}" alt="头像" class="nag_head_2" />
			                                            <span class="d_san"></span>
			                                        </div>
			                                    </dt>
			                                    <dd class="mt20"><span class="ms f16 text-white">${assist.username}</span></dd>
			                                </dl>
			                            </li>
			                        </c:if>
			                    </c:forEach>    
                            <div class="clearit"></div>
                        </ul>
                    </div>
                    <div id="the_4">
                        <div class="nag">
                            <span class="nag_title">红黄榜</span>
                        </div>
                        <div class="nag_line"></div>
                        <a href="${ctx}/league/toCard?league_id=${league.id}" class="full">查看完整排行</a>
                        <div class="clearit"></div>
                        <ul class="nag_name">
		                        	<c:forEach items="${cardList.items}" var="card" varStatus="i">
		                    			<c:if test="${i.index eq 1}">
				                            <li style="margin-left: 0;">
				                                <dl class="nag_info_2">
				                                    <dt>
				                                        <div class="nag_h">
				                                            <img src="${el:headPath()}${card.head_icon}" alt="头像" class="nag_head_2" />
				                                            <span class="d_er"></span>
				                                        </div>
				                                    </dt>
				                                    <dd class="mt20"><span class="ms f16 text-white">${card.username}</span></dd>
				                                </dl>
				                            </li>
				                    	</c:if>
				                     </c:forEach>   
			                         <c:forEach items="${cardList.items}" var="card" varStatus="i">
		                    			<c:if test="${i.index eq 0}">  
				                            <li>
				                                <dl class="nag_info_1">
				                                    <dt>
				                                        <div class="nag_h">
				                                            <img src="${el:headPath()}${card.head_icon}" alt="头像" class="nag_head_1" />
				                                            <span class="d_yi"></span>
				                                        </div>
				                                    </dt>
				                                    <dd class="mt25"><span class="ms f16 text-white">${card.username}</span></dd>
				                                </dl>
				                            </li>
			                         	</c:if>
				                     </c:forEach>
			                         <c:forEach items="${cardList.items}" var="card" varStatus="i">
		                    			<c:if test="${i.index eq 2}">    
				                            <li>
				                                <dl class="nag_info_3">
				                                    <dt>
				                                        <div class="nag_h">
				                                            <img src="${el:headPath()}${card.head_icon}" alt="头像" class="nag_head_2" />
				                                            <span class="d_san"></span>
				                                        </div>
				                                    </dt>
				                                    <dd class="mt20"><span class="ms f16 text-white">${card.username}</span></dd>
				                                </dl>
				                            </li>
			                         	</c:if>
				                     </c:forEach>        
                            <div class="clearit"></div>
                        </ul>
                    </div>
                </div>
            </div>
    </div>
<div>
<%@ include file="../../common/footer.jsp" %>
<script type="text/javascript">
</script>
</body>
</html>
