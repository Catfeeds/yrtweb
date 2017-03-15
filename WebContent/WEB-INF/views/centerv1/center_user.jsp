<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<div class="new_p_info">
    <div class="new_p_head">
       
         <div class="clearit"></div>
        <!-- <a style="cursor: pointer;" data-id="headimg" onclick="change_head_img()"> -->
       		<c:if test="${not empty level && level > 0}">
       			 <span class="yaoren"></span>
       		</c:if>
        	<img id="head_image_img_0" src="${el:headPath()}${userinfo.head_icon}" alt="" class="new_head" />
        <!-- </a>	 -->
        <c:if test="${!empty sp}">
	        <span class="ban1"></span>
        </c:if>
    </div>
     <div class="new_gfd">
            <dl>
                <dt><span class="text-white">${dynCount.bgznum}</span></dt>
                <dd><span class="text-gray-s_999" onclick="window.location='${ctx}/user/fansList/${userinfo.id}'" style="cursor: pointer;">粉丝</span></dd>
            </dl>
            <dl>
                <dt><span class="text-white">${dynCount.gznum}</span></dt>
                <dd><span class="text-gray-s_999" onclick="window.location='${ctx}/user/focusList/${userinfo.id}'" style="cursor: pointer;">关注</span></dd>
            </dl>
            <dl>
                <dt><span class="text-white">${dynCount.dtnum}</span></dt>
                <dd><span class="text-gray-s_999">动态</span></dd>
            </dl>
            <c:if test="${isme=='1'}">
            <a href="javascript:void(0)" id="setting" class="new_btn_l" style="padding: 6px 42px;" onclick="edit_user()">编辑资料</a>
            </c:if>
        </div>
</div>
<div class="new_player_info">
	<c:if test="${isme!='1'}">
	<c:if test="${!empty market}">
	<div class="buys">
	      <a href="${ctx}/playerTrade/list?league_id=1&pid=${userinfo.id}" style="">快捷购买</a>
	</div>
	</c:if>
	</c:if>
    <table class="new_tab">
        <tr>
            <td class="td_head">
                <span class="text-info f18 fw ms">${userinfo.usernick }</span>
                <span class="text-white ml45">${userinfo.province}${userinfo.city}${userinfo.area}</span>
                <div class="clearit"></div>
            </td>
            <td rowspan="2">
                <ul class="shenjia">
                    <li><span class="text-sj ms fw f14" title="参加联赛，踢出身价">身价值</span>
                    	<span class="ml5 text-sj2 ms fw f14">
                    		<c:choose>
                    			<c:when test="${!empty userinfo.current_price}">
                    				${userinfo.current_price}
                    			</c:when>
                    			<c:otherwise>
                    			  	  暂无
                    			</c:otherwise>
                    		</c:choose>
                    	</span>
                   	</li>
                   	 <li><span class="text-ml ms fw f14" title="获得礼物，提升魅力">魅力值</span>
                    	<span class="ml5 text-ml2 ms fw f14">
                    		<c:choose>
                    			<c:when test="${userinfo.usercp!=0}">
                    				${userinfo.usercp}
                    			</c:when>
                    			<c:otherwise>
                    				暂无
                    			</c:otherwise>
                    		</c:choose>
                    	</span>
                   	</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
                <ul class="xm">
                    <li><span class="text-white">
                    		<c:choose>
                    			<c:when test="${!empty userinfo.username}">
                    				姓名：${userinfo.username}
                    			</c:when>
                    			<c:otherwise>
                    				<c:choose>
                    					<c:when test="${session_user_id eq userinfo.id }">
		                    				<a href="${ctx}/certificat/IDinfo" class="text-white">【请实名认证】</a>
                    					</c:when>
                    					<c:otherwise>
                    						未实名认证
                    					</c:otherwise>
                    				</c:choose>
                    			</c:otherwise>
                    		</c:choose>
                    	</span>
                    </li>
                    <li>
                    	<c:choose>
                    		<c:when test="${userinfo.sex}">
                    			<span class="boy"></span>
                    		</c:when>
                    		<c:otherwise>
                    			<span class="girl"></span>
                    		</c:otherwise>
                    	</c:choose>
                    </li>
                    <li><span class="text-white"><fmt:formatNumber value="${userinfo.age}" pattern="#0"/>岁</span></li>
                    <li><span class="text-white">生日：${userinfo.borndate}</span></li>
                    <div class="clearit"></div>
                </ul>
            </td>
        </tr>
    </table>
    <p class="sign mt10">签名：${userinfo.signature}</p>
    <div class="gift_area">
        <ul>
        	<c:choose>
        		<c:when test="${!empty gifts}">
        			<c:forEach items="${gifts}" var="gi">
       					<li>
			                <div class="my_gift">
			                    <div class="charm">
			                        <dl>
			                            <dt>魅力</dt>
			                            <dd>+${gi.charm_value}</dd>
			                        </dl>
			                    </div>
			                    <span class="num">${gi.quantity}</span>
			                    <img src="${ctx}/${gi.image_src}">
			                </div>
			            </li>
        			</c:forEach>
        		</c:when>
        		<c:otherwise>
        		<c:choose>
        			<c:when test="${userinfo.id == session_user_id }">
        				<div style="border: 1px solid #333;" class="no_data">
		                    <span class="text-gray-s_999 f16 ms">还没有人赠送礼物</span>
		                    <a class="new_btn_l" href="javascript:sendGift()">赠礼</a>
		                </div>
        			</c:when>
        			<c:otherwise>
        				<div style="border: 1px solid #333;" class="no_data">
                            <span class="text-gray-s_999 f16 ms">给我 <a class="text-orange" href="javascript:sendGift()">赠礼</a> 吧，我会关注你的哦</span>
                        </div>
        			</c:otherwise>
        		</c:choose>
        		</c:otherwise>
        	</c:choose>
        </ul>
    </div>
</div>
<script>
//礼物魅力值显示
$(".my_gift").mouseover(function () {
    $(this).find(".charm").show();
}).mouseout(function () {
    $(this).find(".charm").hide();
});
</script>