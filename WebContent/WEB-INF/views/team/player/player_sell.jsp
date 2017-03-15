<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:set var="qc" value="st,lw,rw"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/>
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<div class="closeBtn_1" onclick="cl();"></div>
<div class="title">
    <span class="f16 ms">挂牌确认</span>
</div>
<div class="auction_super">
   <div class="name ms f24">${player.usernick}</div>
   <span class="po ms f14">
	   	<c:forEach items="${fn:split(player.p_position,',')}" var="pos" end="0">
			<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
		</c:forEach>
   </span>
    <!--中锋标记-->
   <div class="player_cf">
   	   <c:choose>
   	   	    <c:when test="${player.level > 0}">
   	   			<c:choose>
			   		<c:when test="${!empty player.p_position}">
				     	<c:forEach items="${fn:split(player.p_position,',')}" var="pos" end="0">
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
				     	</c:forEach>
			   		</c:when>
			   		<c:otherwise>
			       		<img src="${ctx}/resources/images/player_y_gk.png" />
			   		</c:otherwise>
		   		</c:choose>	
   	   		</c:when>
   	   		<c:otherwise>
   	   			<c:choose>
			   		<c:when test="${!empty player.p_position}">
				     	<c:forEach items="${fn:split(player.p_position,',')}" var="pos" end="0">
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
   	   		</c:otherwise>
   	   </c:choose>	
   </div>
   <div class="cf_forward">
       <img src="${el:headPath()}${player.head_icon}" />
   </div>
   <dl class="attr">
       <dt><span class="ms"><fmt:formatNumber value="${(nowDate.time-player.borndate.time)/1000/60/60/24/365}" pattern="#0"/> 岁</span></dt>
       <dd><span class="ms">${player.height}CM</span></dd>
       <dd><span class="ms">${player.weight}KG</span></dd>
   </dl>
   <div class="ability">
       <table>
           <tr>
		        <td><span class="ms">传</span><span class="ms ml5 text-orange">${player.pass_ability}</span></td>
		        <td><span class="ms">力</span><span class="ms ml5 text-orange">${player.power}</span></td>
		    </tr>
		    <tr>
		        <td><span class="ms">射</span><span class="ms ml5 text-orange">${player.shot}</span></td>
		        <td><span class="ms">头</span><span class="ms ml5 text-orange">${player.header}</span></td>
		    </tr>
		    <tr>
		        <td><span class="ms">速</span><span class="ms ml5 text-orange">${player.speed}</span></td>
		        <td><span class="ms">爆</span><span class="ms ml5 text-orange">${player.explosive}</span></td>
		    </tr>
       </table>
   </div>
   
</div>
<div class="auc_div">
    <form action="" method="post" id="sellForm">
        <input type="hidden" name="user_id" id="id" value="${player.user_id}" />
        
        <dl style="width: 310px;margin: 10px auto;text-align: left;">
            <dt><span>挂牌价</span><input type="text" name="price" value="${market.price}" onkeyup="this.value=this.value.replace(/\D/g,'')" style="width: 100px;margin-left: 10px;" valid="require" /><span class="ml10">宇币</span></dt>
            <dd class="mt5"><span>一口价</span><yt:dictSelect name="if_one" nodeKey="status" value="${market.if_one}" clazz="ml10"></yt:dictSelect></dd>
        </dl>
        <input type="button" name="name" value="确认" class="btn_l mt20 f16 ms" onclick="sellPlayer();" />
        <input type="button" name="name" value="取消" class="btn_g mt20 f16 ms" onclick="cl();" />
    </form>
</div>