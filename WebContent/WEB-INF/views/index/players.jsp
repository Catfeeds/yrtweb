<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<c:set var="qc" value="st,lw,rw"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/>
<div class="carousel-container">
    <div class="new_light">
                        </div>
    <div id="icarousel">
    <c:forEach items="${page.items}" var="player" varStatus="status">
        <div class="slide">
            <div class="pic_d">
                <div class="player_masker"></div>
                <div class="auction_super">
                    <div class="name ms f16">${player.usernick }</div>
                    <span class="po ms f12" style="letter-spacing:0;">${player.position }</span>
                    <!--中锋标记-->
                    <div class="player_cf" onclick="window.location='${ctx}/center/${player.user_id}'">
                        <c:choose>
                       		<c:when test="${!empty player.position_str}">
	                         	<c:forEach items="${fn:split(player.position_str,',')}" var="pos" end="0">
	                         		<c:choose>
	                         			<c:when test="${player.level > 0}">
	                         				<c:choose>
			                         			<c:when test="${fn:contains(qc, pos)}">
			                         				<img src="${ctx}/resources/images/player_y_fw1.png" />
			                         			</c:when>
			                         			<c:when test="${fn:contains(zc, pos)}">
			                         				<img src="${ctx}/resources/images/player_y_cf1.png" />
			                         			</c:when>
			                         			<c:when test="${fn:contains(hc, pos)}">
			                         				<img src="${ctx}/resources/images/player_y_ga1.png" />
			                         			</c:when>
			                         			<c:when test="${fn:contains(sm, pos)}">
			                         				<img src="${ctx}/resources/images/player_y_gk1.png" />
			                         			</c:when>
			                         		</c:choose>
	                         			</c:when>
	                         			<c:otherwise>
											<c:choose>
			                         			<c:when test="${fn:contains(qc, pos)}">
			                         				<img src="${ctx}/resources/images/player_fw1.png" />
			                         			</c:when>
			                         			<c:when test="${fn:contains(zc, pos)}">
			                         				<img src="${ctx}/resources/images/player_cf1.png" />
			                         			</c:when>
			                         			<c:when test="${fn:contains(hc, pos)}">
			                         				<img src="${ctx}/resources/images/player_ga1.png" />
			                         			</c:when>
			                         			<c:when test="${fn:contains(sm, pos)}">
			                         				<img src="${ctx}/resources/images/player_gk1.png" />
			                         			</c:when>
			                         		</c:choose>
	                         			</c:otherwise>
	                         		</c:choose>
	                         	</c:forEach>
                       		</c:when>
                       		<c:otherwise>
                       			<c:choose>
	                       			<c:when test="${player.level > 0}">
		                             	<img src="${ctx}/resources/images/player_y_gk1.png" />
                       				</c:when>
                       			</c:choose>
                       			<c:otherwise>
                       					<img src="${ctx}/resources/images/player_gk1.png" />
                       			</c:otherwise>
                       		</c:otherwise>
                       	</c:choose>
                    </div>
                    <div class="cf_forward">
                        <img src="${el:headPath()}${player.head_icon}" />
                    </div>
                    <dl class="attr">
                        <dt><span class="ms"><fmt:formatNumber value="${player.age}" pattern="0"/>&nbsp;岁</span></dt>
                        <dd><span class="ms"><fmt:formatNumber value="${player.height}" pattern="0"/>&nbsp;CM</span></dd>
                        <dd><span class="ms"><fmt:formatNumber value="${player.weight}" pattern="0"/> &nbsp;KG</span></dd>
                    </dl>
                    <dl class="quote ms">
                        <dt><span>能&emsp;力</span><span class="text-orange ml10">${player.score}</span></dt>
                        <dd><span>当前身价</span></dd>
                        <dd><span class="text-orange">${player.current_price}</span><span class="ml10">宇币</span></dd>
                    </dl>
                    <div class="ability" style="display: none;">
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
            </div>
        </div>
    </c:forEach>
    </div>
</div>
