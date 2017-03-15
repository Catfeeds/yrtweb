<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>    
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:set var="qc" value="st,lw,rw,lf,rf"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm,lcm,rcm,lcb,rcb"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/>
<div class="closeBtn_1" onclick="closeDetail();"></div>
<div class="name ms f30">${auctionMap.username}</div>
<span class="po ms f24">
	<c:forEach items="${fn:split(auctionMap.position,',')}" var="pos" end="0">
		<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
  	</c:forEach>
</span>
<!--中锋标记-->
<div class="player_cf">
    <c:choose>
		<c:when test="${!empty auctionMap.position}">
	 	<c:forEach items="${fn:split(auctionMap.position,',')}" var="pos" end="0">
	 		<c:choose>
	 			<c:when test="${fn:contains(qc, pos)}">
	 				<img src="${ctx}/resources/images/player_fw_l.png" />
	 			</c:when>
	 			<c:when test="${fn:contains(zc, pos)}">
	 				<img src="${ctx}/resources/images/player_cf_l.png" />
	 			</c:when>
	 			<c:when test="${fn:contains(hc, pos)}">
	 				<img src="${ctx}/resources/images/player_ga_l.png" />
	 			</c:when>
	 			<c:when test="${fn:contains(sm, pos)}">
	 				<img src="${ctx}/resources/images/player_gk_l.png" />
	 			</c:when>
	 		</c:choose>
	 	</c:forEach>
		</c:when>
		<c:otherwise>
	     <img src="${ctx}/resources/images/player_cf_l.png" />
		</c:otherwise>
	</c:choose>
</div>
<div class="cf_forward">
     <img src="${el:headPath()}${auctionMap.head_icon}"/>
</div>
<dl class="attr">
    <dt><span class="ms"><fmt:formatNumber value="${(nowDate.time-auctionMap.borndate.time)/1000/60/60/24/365}" pattern="#0"/>岁</span></dt>
    <dd><span class="ms">${auctionMap.height}CM</span></dd>
    <dd><span class="ms">${auctionMap.weight}KG</span></dd>
</dl>
<dl class="quote ms" style="display: block;">
    <dt><span>能 力</span><span class="text-orange ml10">${auctionMap.score}</span></dt>
</dl>
<div class="ability">
    <table>
		<tr>
            <td><span class="ms">传</span><span class="ms ml5 text-orange">${auctionMap.pass_ability}</span></td>
            <td><span class="ms">力</span><span class="ms ml5 text-orange">${auctionMap.power}</span></td>
        </tr>
        <tr>
            <td><span class="ms">射</span><span class="ms ml5 text-orange">${auctionMap.shot}</span></td>
            <td><span class="ms">头</span><span class="ms ml5 text-orange">${auctionMap.header}</span></td>
        </tr>
        <tr>
            <td><span class="ms">速</span><span class="ms ml5 text-orange">${auctionMap.speed}</span></td>
            <td><span class="ms">爆</span><span class="ms ml5 text-orange">${auctionMap.explosive}</span></td>
        </tr>
    </table>
    <div style="width: 80%;margin: 0px auto;text-indent: 2.8em;line-height: 30px;">
        <p>
	       <span class="ms">当前报价</span>
	       <span class="text-orange ml10 ms">
	        	<fmt:formatNumber value="${auctionMap.price}" pattern="#0"/>
	       </span>
        <span class="ms">宇币</span></p>
        <c:choose>
        	<c:when test="${auctionMap.if_one eq 0}">
		        <p><span class="ms">您的报价</span><input type="text" id="bid_price" value="" style="width: 88px;height: 12px;line-height: 12px; margin-left: 8px;" /></p>
        	</c:when>
        	<c:otherwise>
        		<p><span class="ms">一口价</span><input type="text" id="bid_price" value="${auctionMap.price}" style="width: 88px;height: 12px;line-height: 12px; margin-left: 8px;" readonly="readonly"/></p>
        	</c:otherwise>
        </c:choose>
        <p>
        	<span class="ms f14">可用余额</span><span class="text-orange ml10 ms f14">${userAmount.real_amount}</span><span class="ms f14">宇币</span>
        	<a href="javascript:void(0);" class="text-orange f12" onclick="javscript:window.location='${ctx}/team/detail'" target="_blank">[充值]</a>
        </p>
    </div>
    <div style="width:256px;margin: 80px auto 0;text-align: center; ">
        <input type="button" name="name" value="确认" class="btn_l f18 ms" onclick="buyPlayer('${auctionMap.m_id}','${auctionMap.price}','${teamInfo.user_id }','${p_user_id}','${auctionMap.buyer}');"/>
        <input type="button" name="name" value="取消" class="btn_g f18 ms" onclick="closeDetail();"/>
    </div>
</div>
