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
<div class="closeBtn_1" onclick="cl();"></div>
<div class="name ms f30">${dataMap.username}</div>
<span class="po ms f24">
	<c:forEach items="${fn:split(dataMap.position,',')}" var="pos" end="0">
		<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
  	</c:forEach>
</span>
<!--中锋标记-->
<div class="player_cf">
	<c:choose>
		<c:when test="${dataMap.level > 0}">
		    <c:choose>
				<c:when test="${!empty dataMap.position}">
			 	<c:forEach items="${fn:split(dataMap.position,',')}" var="pos" end="0">
			 		<c:choose>
			 			<c:when test="${fn:contains(qc, pos)}">
			 				<img src="${ctx}/resources/images/player_y_fw_l.png" />
			 			</c:when>
			 			<c:when test="${fn:contains(zc, pos)}">
			 				<img src="${ctx}/resources/images/player_y_cf_l.png" />
			 			</c:when>
			 			<c:when test="${fn:contains(hc, pos)}">
			 				<img src="${ctx}/resources/images/player_y_ga_l.png" />
			 			</c:when>
			 			<c:when test="${fn:contains(sm, pos)}">
			 				<img src="${ctx}/resources/images/player_y_gk_l.png" />
			 			</c:when>
			 		</c:choose>
			 	</c:forEach>
				</c:when>
				<c:otherwise>
			     <img src="${ctx}/resources/images/player_y_cf_l.png" />
				</c:otherwise>
			</c:choose>
	</c:when>
	<c:otherwise>
			<c:choose>
				<c:when test="${!empty dataMap.position}">
			 	<c:forEach items="${fn:split(dataMap.position,',')}" var="pos" end="0">
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
	</c:otherwise>
	</c:choose>				
</div>
<div class="cf_forward">
     <img src="${el:headPath()}${dataMap.head_icon}"/>
</div>
<dl class="attr">
    <dt><span class="ms"><fmt:formatNumber value="${(nowDate.time-dataMap.borndate.time)/1000/60/60/24/365}" pattern="#0"/>岁</span></dt>
    <dd><span class="ms">${dataMap.height}CM</span></dd>
    <dd><span class="ms">${dataMap.weight}KG</span></dd>
</dl>
<dl class="quote ms" style="display: block;">
    <dt><span>能 力</span><span class="text-orange ml10">${dataMap.score}</span></dt>
</dl>
<div class="ability">
    <table>
		<tr>
            <td><span class="ms">传</span><span class="ms ml5 text-orange">${dataMap.pass_ability}</span></td>
            <td><span class="ms">力</span><span class="ms ml5 text-orange">${dataMap.power}</span></td>
        </tr>
        <tr>
            <td><span class="ms">射</span><span class="ms ml5 text-orange">${dataMap.shot}</span></td>
            <td><span class="ms">头</span><span class="ms ml5 text-orange">${dataMap.header}</span></td>
        </tr>
        <tr>
            <td><span class="ms">速</span><span class="ms ml5 text-orange">${dataMap.speed}</span></td>
            <td><span class="ms">爆</span><span class="ms ml5 text-orange">${dataMap.explosive}</span></td>
        </tr>
    </table>
    <div style="width: 80%;margin: 10px auto 0;text-indent: 2.4em;line-height: 25px;">
		<p><span class="ms f14">租借日期</span><input type="text" id="end_time" name="end_time" id="end_time" value="" class="datainp" style="width: 116px;height: 12px;line-height: 12px; margin-left: 8px;" /><span>&emsp;&emsp;</span></p>
		<span class="text-white f12 ml40">（最长租借至该俱乐部联赛结束）</span>
		<p><span class="ms f14">租借金额</span><input type="text" id="price" name="price"  valid="required num" value="" style="width: 88px;height: 12px;line-height: 12px; margin-left: 8px;" /><span class="ms f14 ml5">宇币</span></p>
		<span class="text-white f12 ml40">（最低不得少于1000宇币）</span>
	</div>
    <div style="width:256px;margin: 125px auto 0;text-align: center; ">
        <input type="button" name="name" value="提交" class="btn_l f18 ms" id="s_purchase" onclick="sendLoanMsg('${dataMap.user_id}');">
        <input type="button" name="name" value="取消" class="btn_g f18 ms" onclick="cl();">
    </div>
</div>

<script>
	 jeDate({
         dateCell: "#end_time",
         isinitVal: true,
         isTime: true, //isClear:false,
         minDate: "2014-09-19 00:00:00"
     })
</script>



