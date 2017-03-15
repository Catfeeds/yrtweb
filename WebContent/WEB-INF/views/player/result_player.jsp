<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<jsp:useBean id="nowDate" class="java.util.Date"/> 
<c:set var="qc" value="st,lw,rw,lf,rf"/>
<c:set var="zc" value="cam,lm,rm,cm,cdm,lcm,rcm,lcb,rcb"/>
<c:set var="hc" value="lb,cb,rb"/>
<c:set var="sm" value="gk"/>
<ul class="a_list" style="margin-top: -25px;">
<c:forEach items="${rf.items}" var="player"> 
<li>
    <div class="auction_super">
        <div class="name ms f24">${player.usernick}</div>
        <span class="po ms f14">
   			<c:if test="${!empty player.position}">
		      	<c:forEach items="${fn:split(player.position,',')}" var="pos" end="0">
		   			<yt:dict2Name nodeKey="p_position" key="${pos}"></yt:dict2Name>
		      	</c:forEach>
   			</c:if>
        </span>
        <!--中锋标记-->
        <div class="player_cf"  onclick="window.location='${ctx}/center/${player.user_id}'">
	    	<c:choose>
	   			<c:when test="${!empty player.position}">
	   				<c:choose>
                    	<c:when test="${player.level > 0}">
			   				<c:choose>
				     			<c:when test="${fn:contains(qc, player.position)}">
				     				<img src="${ctx}/resources/images/player_y_fw.png" />
				     			</c:when>
				     			<c:when test="${fn:contains(zc, player.position)}">
				     				<img src="${ctx}/resources/images/player_y_cf.png" />
				     			</c:when>
				     			<c:when test="${fn:contains(hc, player.position)}">
				     				<img src="${ctx}/resources/images/player_y_ga.png" />
				     			</c:when>
				     			<c:when test="${fn:contains(sm, player.position)}">
				     				<img src="${ctx}/resources/images/player_y_gk.png" />
				     			</c:when>
				     			<c:otherwise>
				            		<img src="${ctx}/resources/images/player_y_gk.png" />
				      			</c:otherwise>
			     			</c:choose>
			     		</c:when>
			     		<c:otherwise>
			     			<c:choose>
				     			<c:when test="${fn:contains(qc, player.position)}">
				     				<img src="${ctx}/resources/images/player_fw.png" />
				     			</c:when>
				     			<c:when test="${fn:contains(zc, player.position)}">
				     				<img src="${ctx}/resources/images/player_cf.png" />
				     			</c:when>
				     			<c:when test="${fn:contains(hc, player.position)}">
				     				<img src="${ctx}/resources/images/player_ga.png" />
				     			</c:when>
				     			<c:when test="${fn:contains(sm, player.position)}">
				     				<img src="${ctx}/resources/images/player_gk.png" />
				     			</c:when>
				     			<c:otherwise>
				            		<img src="${ctx}/resources/images/player_gk.png" />
				      			</c:otherwise>
			     			</c:choose>
			     		</c:otherwise>
			     	</c:choose>	
	   			</c:when>
				<c:otherwise>
					<c:choose>
                    	<c:when test="${player.level > 0}">
							<img src="${ctx}/resources/images/player_y_cf.png" />
						</c:when>
						<c:otherwise>
							<img src="${ctx}/resources/images/player_cf.png" />
						</c:otherwise>
					</c:choose>	
	    		</c:otherwise>
	   		</c:choose>			
   		</div>
        <div class="numbers">
            <dl>
                <dt><span>理想球衣号</span></dt>
                <dd>
                	<c:forEach items="${fn:split(player.love_num,',')}" var="lnum">
                       <div class="num">${lnum}</div>
                  	</c:forEach>
                </dd>
            </dl>
        </div>
       	<c:if test="${player.if_league eq 1}">
       		<span class="lstag"></span>
       	</c:if>
       	<c:if test="${!empty player.sp_id}">
   			<span class="ban1"></span>
   		</c:if>
        <div class="cf_forward">
            <img src="${el:headPath()}${player.head_icon}"/>
        </div>
        <dl class="attr">
            <dt><span class="ms">
            	<%-- <c:choose>
            		<c:when test="${!empty player.borndate}">
	            		{fn:substringBefore((nowDate.time-player.borndate.time)/1000/60/60/24/365,'.')} 岁
            		</c:when>
            		<c:otherwise>
            			保密
            		</c:otherwise>
            	</c:choose> --%>
            	${player.age} 岁
            	</span>
            </dt>
            <dd><span class="ms">${player.height}CM</span></dd>
            <dd><span class="ms">${player.weight}KG</span></dd>
        </dl>
        <dl class="quote ms" style="text-align: left;left:30px;top:200px;">
            <dt><span>能&emsp;力</span><span class="text-orange ml10">${player.score}</span></dt>
            <dd><span>身&emsp;价</span>
            	<c:choose>
            		<c:when test="${!empty player.current_price}">
		            	<span class="text-orange ml10"><fmt:formatNumber value="${player.current_price}" pattern="#0"/></span><span class="ml10">宇币</span>
            		</c:when>
            		<c:otherwise>
            			<span class="ml10">暂无</span>
            		</c:otherwise>
            	</c:choose>
            </dd>	
            <dd class="the_center"><span>
            	<c:choose>
            		<c:when test="${!empty player.team_id}">
		            	<yt:id2NameDB beanId="teamInfoService" id="${player.team_id}"></yt:id2NameDB>
            		</c:when>
            		<c:otherwise>
            			自由球员
            		</c:otherwise>
            	</c:choose>
            	
            </span></dd>
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

            <div class="auc_div">
            	<c:choose>
			    	<c:when test="${!empty session_user_id}">
		            	<c:choose>
			               	<c:when test="${!empty player.f_user_id}">
				                <input type="button" name="name" value="取消关注" class="btn_ll ms" onclick="focus_user(this,'${player.user_id}',true,'${rf.currentPage}');"/>
			               	</c:when>
			               	<c:otherwise>
			               		<input type="button" name="name" value="关注" class="btn_ll ms" onclick="focus_user(this,'${player.user_id}','','${rf.currentPage}');"/>
			               	</c:otherwise>
			            </c:choose>
			         </c:when>
			         <c:otherwise>
			         		<input type="button" name="name" value="关注" class="btn_ll ms" onclick="layer.msg('请登录后操作!',{icon: 2});"/>
			         </c:otherwise>   
				</c:choose>
                <input type="button" name="name" value=" " class="setting" />
                <div class="tools_b">
                    <dl>
                        <dd><span><a href="javascript:void(0)" class="text-white a_tool" onclick="invite_user(this,'${player.user_id}');">邀&emsp;请</a></span></dd>
                        <dd><span><a href="javascript:void(0)" onclick="openMsg('${player.user_id}','${player.usernick}');" class="text-white a_tool">私&emsp;信</a></span></dd>
                    </dl>
                </div>
            </div>
        </div>
    </li>
    </c:forEach>
    <div class="clearit"></div>
</ul>
                    
<ul class="pagination" style="float:right;margin-top:60px;">
   	<li><label class="index">第${rf.currentPage}页/共${rf.pageCount}页</label> </li>
   	<li><label class="sum">共计${rf.totalCount}条</label> </li>
	<li><a href="javascript:void(0)" onclick="userSearch(0);">首页</a></li>
		<c:choose>
			<c:when test="${rf.currentPage-1>0}">
				<li><a href="javascript:void(0)" onclick="userSearch(${rf.currentPage-1});">上一页</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:void(0)">上一页</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${rf.currentPage+1>rf.pageCount}">
				<li><a href="javascript:void(0)">下一页</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:void(0)" onclick="userSearch(${rf.currentPage+1});">下一页</a></li>
			</c:otherwise>
		</c:choose>	
	<li><a href="javascript:void(0)" onclick="userSearch(${rf.pageCount});">最后一页</a></li>
	<li><input type="text" name="pIndex" id="pIndex" value="" class="ipt"/></li> 
	<li><a href="javascript:void(0)" onclick="userSearch();">跳转</a></li> 
</ul>
<div class="clearit"></div>
<script type="text/javascript">
	//属性切换
	$($(".a_list .auction_super")).each(function () {
	    $(this).mouseover(function () {
	        $(this).find(".quote").hide();
	        $(this).find(".ability").show();
	    });
	}).mouseout(function () {
	    $(this).find(".quote").show();
	    $(this).find(".ability").hide();
	
	});
	
	//设置
	$($(".setting")).each(function () {
	    $(this).click(function () {
	        if ($(this).next(".tools_b").is(":visible")) {
	            $(this).next(".tools_b").hide();
	        } else {
	            $(this).next(".tools_b").show();
	        }
	
	    });
	});
</script>