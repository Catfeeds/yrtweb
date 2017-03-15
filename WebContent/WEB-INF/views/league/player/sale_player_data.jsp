<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<c:set var="qc" value="st,lw,rw,lf,rf"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm,lcm,rcm,lcb,rcb"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${empty rf.items}">
		<div style="text-align: center;color: red;">暂无出售球员数据...</div>
	</c:when>	
	<c:otherwise>
		<div class="auction_area">
                <ul class="a_list">
                	<c:forEach items="${rf.items}" var="auction">
                		<li>
                        <div class="auction_super">
                            <div class="name ms f24">${auction.username}</div>
                            <span class="po ms f14">
                            	<c:forEach items="${fn:split(auction.position,',')}" var="pos" end="0">
                            		<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
                            	</c:forEach>
                            </span>
                            <!--中锋标记-->
                            <div class="player_cf" onclick="window.location='${ctx}/center/${auction.user_id}'">
                            	<c:choose>
                            		<c:when test="${!empty auction.position}">
		                            	<c:forEach items="${fn:split(auction.position,',')}" var="pos" end="0">
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
		                            	</c:forEach>
                            		</c:when>
                            		<c:otherwise>
		                                <img src="${ctx}/resources/images/player_gk.png" />
                            		</c:otherwise>
                            	</c:choose>
                            </div>
                            <c:if test="${auction.status == 1}">
	                           <%--  <i><img src="${ctx}/resources/images/qiuyi.png"/></i> --%>
	                                <div class="numbers">
	                                    <dl>
	                                        <dt><span>理想球衣号</span></dt>
	                                        <dd>
	                                        	<c:forEach items="${fn:split(auction.love_num,',')}" var="lnum">
		                                            <div class="num">${lnum}</div>
	                                        	</c:forEach>
	                                        </dd>
	                                    </dl>
	                                </div>
	                        </c:if>        
                            <div class="cf_forward">
                                <img src="${el:headPath()}${auction.head_icon}"/>
                            </div>
                            <dl class="attr">
                                <dt><span class="ms">${fn:substringBefore((nowDate.time-auction.borndate.time)/1000/60/60/24/365,'.')} 岁</span></dt>
                                <dd><span class="ms">${auction.height}CM</span></dd>
                                <dd><span class="ms">${auction.weight}KG</span></dd>
                            </dl>
                            <dl class="quote ms">
                            	<dt><span class=" ml10 f14">挂牌俱乐部</span></dt>
                                <dd><span class="text-orange ml10 f14">${auction.team_name}</span></dd>
                                <dd>
                                    <span class="pull-left ml30">能&emsp;力</span><span class="text-orange pull-left ml10">${auction.score}</span>
                                    <div class="clearit"></div>
                                </dd>
                                <dd>
                                    <span class="pull-left ml30">身&emsp;价</span>
                                    <span class="text-orange pull-left ml10"><fmt:formatNumber value="${auction.price}" pattern="#0"/></span>
                                    <span class="pull-left ml5 f14">宇币</span>
                                    <div class="clearit"></div>
                                </dd>
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
                            		<c:when test="${auction.status == 1}">
                            			<span>已出售</span>	
                            		</c:when>
                            		<c:otherwise>
                            		<input type="button" class="ac_btn_end ms" onclick="delSell('${auction.tp_id}')" value="撤消出售" name="name">
                            		</c:otherwise>
                            	</c:choose>
                            </div>
                        </div>
                    </li>
                	</c:forEach>
                    <div class="clearit"></div>
                </ul>
            </div>
        </div>
       <!--分页-->
        <ul class="pagination" style="margin-top:15px;margin-right: 40px;">
			<c:choose>
				<c:when test="${rf.pageCount!=0}">
					<c:choose>
				<c:when test="${rf.currentPage!=1}"> 
					<li data-command="prev"><a href="javascript:void(0)" onclick="searchPage(1)">首页</a></li>
					<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="searchPage(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
					<li class="active"><a>${rf.currentPage}</a></li> 
				</c:when>
				<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
				</c:choose>
				<c:choose>
				<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="searchPage(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
				<c:choose>
				<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
				</c:choose>
				<c:choose>
				<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="searchPage(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
				</c:choose>
				<li data-command="next"><a href="javascript:void(0)" onclick="searchPage(${rf.pageCount})">末页</a></li> </c:when>
				</c:choose>
				</c:when>
			</c:choose>
		</ul>  
	</c:otherwise>
</c:choose>
<script>
$($(".auction_super")).each(function(){
    $(this).mouseover(function (){
        $(this).find(".quote").hide();
        $(this).find(".ability").show();
    });
}).mouseout(function () {
    $(this).find(".quote").show();
    $(this).find(".ability").hide();
});
</script>