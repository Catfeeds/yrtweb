<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<form action="" method="post" id="babyForm">
<div class="closeBtn_1" onclick="cl();"></div>
	<div class="bb_title">
	    <span class="f20 ms text-white">邀请助威</span>
	</div>
	<div class="bb_xx">
	    <div class="bb_touxiang">
	        <img src="${el:headPath()}${user.head_icon}" class="pull-left ml150 mt30" />
	        <dl class="pull-left mt60 ml15">
	            <dt><span class="text-white f20 ms">${user.usernick}</span></dt>
	            <dd class="mt5"></dd>
	        </dl>
	        <div class="clearit"></div>
	    </div>
			<input type="hidden" id="baby_user_id" name="baby_user_id" value="${user.id}"/>
		    <div class="bb_info_day">
		        <table>
		            <tr>
		                <td><span class="bb_text f16 ms fw">&emsp;助威比赛 /</span></td>
		                <td>
		                	<select class="ml10" onchange="gameshow()" id="game_id">
	                        		<option value="">请选择</option>${listGame}
	                        	<c:forEach items="${listGame}" var="game">
	                        		<option value="${game.id}">${game.initiate_teaminfo_name}(主) VS ${game.respond_teaminfo_name}(客)</option>
								</c:forEach>
	                        </select>
		                </td>
		            </tr>
		            <tr>
		                <td><span class="bb_text f16 ms fw">&emsp;助威时间 /</span></td>
		                <td>
		                	<span class="ml10 f14 ms text-white" id="cheer_time_s"></span>
			      			<input type="hidden" name="cheer_time" id="cheer_time" value=""/>
			      		</td>
		            </tr>
		            <tr>
		                <td><span class="bb_text f16 ms fw">&emsp;助威地点 /</span></td>
		                <td>
		                	<span class="ml10 f14 ms text-white" id="cheer_address_s"></span>
			                <input type="hidden" name="cheer_address"  id="cheer_address" value=""/>
		                </td>
		            </tr>
		            <tr>
		                <td><span class="bb_text f16 ms fw">助威俱乐部 /</span></td>
		                <td>
		                	<span class="ml10 f14 ms text-white" id="team_name_s"></span>
			            	<input type="hidden" name="team_name" id="team_name" value=""/>
				            <input type="hidden" name="logo" id="logo" value=""/>
			            </td>
		            </tr>
		        </table>
		    </div>
	    <div class="fenge"></div>
	    <div class="bb_info_day" style="width: 320px;">
	        <table class="ml30">
	             <tr>
                     <td><span class="bb_text f16 ms fw">&emsp;联系人 /</span></td>
                     <td><input type="text" name="contact_person" value="" class="ml10" valid="require len(1,30)"/><span class="text-santand ml5">*</span></td>
                 </tr>
                 <tr>
                     <td><span class="bb_text f16 ms fw">联系电话 /</span></td>
                     <td><input type="text" name="contact_phone" value="" class="ml10" valid="require mobile"/><span class="text-santand ml5">*</span></td>
                 </tr>
                 <tr>
                     <td valign="top"><span class="bb_text f16 ms fw">备&emsp;&emsp;注 /</span></td>
                     <td><textarea class="beizhu" name="remark"></textarea></td>
                 </tr>
                 <tr>
                     <td>
                         <input type="button" name="name" value="邀请" class="invi_btn ml10" onclick="saveCheerBaby();"/>
                     </td>
                     <td>
                         <input type="button" name="guanbi" value="取消" class="cheer_btn ml10" onclick="cl();"/>
                     </td>
            	</tr>
	        </table>
	    </div>
	</div>
</form>




















<%-- <form action="" method="post" id="babyForm">
	<input type="hidden" id="teaminfo_id" name="teaminfo_id" value="${teaminfo_id}"/>
	<input type="hidden" id="teamgame_id" name="teamgame_id" value="${teamgame_id}"/>
	<div class="babys_cheer frame" id="cyclepages">
	<ul class="clearfix">
		<c:forEach items="${rf.items}" var="babyTeam">
			<li>
				<input type="hidden" name="baby_ids" value="${babyTeam.user_id}">
				<div style="position: relative;" class="my_select">
				    <img src="${ctx}/resources/images/baby_select.png" alt="" class="b_select" />
				    <div class="babys_info">
				        <span class="f14">${babyTeam.usernick}</span>
				    </div>
			   		<img src="${filePath}/${babyTeam.head_icon}" alt="" class="babys" />
				</div>
			</li>
		</c:forEach>
	</ul>
	    <div class="closeBtn_1"></div>
	    <div class="babys_tab">
	        <table>
	            <tr>
	                <td><span class="f18 ms text-white">&emsp;联系人 /</span></td>
	                <td><input type="text" name="contact_person" value="" class="ml10 w" id="contact_person" /></td>
	            </tr>
	            <tr>
	                <td><span class="f18 ms text-white">联系电话 /</span></td>
	                <td><input type="text" name="contact_phone" value="" class="ml10 w" id="contact_phone" /></td>
	            </tr>
	            <tr>
	                <td valign="top"><span class="f18 ms text-white">备&emsp;&emsp;注 /</span></td>
	                <td>
	                    <textarea class="ml10 mt5 w" id="remark" name="remark"></textarea>
	                </td>
	            </tr>
	            <tr>
	                <td></td>
	                <td>
	                    <input type="button" name="name" value="助威" class="invi_btn mt10 ml10 f14 ms" onclick="saveCheerBaby();"/>
	                    <input type="button" name="name" value="重置" class="cheer_btn mt10 ml10 f14 ms" id="reset" />
	                </td>
	            </tr>
	        </table>
	    </div>
	</div>
</form>	
 --%>

<script type="text/javascript">

jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}

$(".babys_cheer").center();


</script>
