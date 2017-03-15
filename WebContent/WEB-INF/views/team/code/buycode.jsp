<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="closeBtn" onclick="closeBtn()"></div>
<div class="buyInviteCode_title">
	<h3 class="text-white f24 text-center">购买球员邀请码</h3>
</div>
<p class="text-gray ml25">提示：其他球员报名通过后，输入邀请码后，可直接进入您的俱乐部，您最多可以再购买
	${count} 个邀请码</p>	
<div class="showCode">
	<div class="pull-left mt35">
		<span class="pull-left"> <img src="${ctx}/resources/images/code.png" class="codeImg" />
		</span> <span class="text-white f18 pull-left ml25 mt20">球员邀请码&nbsp;&nbsp;*</span>
	</div>
	<div class="pull-left codeTable">
		<form action="" method="post" id="buyForm">
			<input type="hidden" name="teaminfo_id" value="${teaminfo_id}"/>
			<input type="hidden" name="price" id="price" value="${activeCode.init_price}"/>
			<input type="hidden" name="count" id="count" value="${count}"/>
			<input type="hidden" name="league_id" id="league_id" value="${league_id}"/>
			<table>
				<tr>
					<th>数量</th>
					<th>单价</th>
					<th>总价</th>
				</tr>
				<tr>
					<td>
						<c:if test="${count ne 0}">
							<select name="total" id="total" onchange="calculate(this,${activeCode.init_price});">
								<c:forEach begin="1" end="${count}" varStatus="i">
									<option value="${i.index}">${i.index}</option>	
								</c:forEach>
							</select>
						</c:if>
					</td>
					<td><span class="f18 text-white" id="">${activeCode.init_price}宇币</span></td>
					<td><span class="f18 text-white" id="showTotal">${activeCode.init_price}</span><span class="f18 text-white">宇币</span></td>
				</tr>
			</table>
		</form>
	</div>
	<div class="pull-left codeBtn">
		<c:if test="${count ne 0}">
			<input type="button" value="购买" class="BuyCodeBtn" onclick="buyCode();"/> 
		</c:if>
		<%-- <input type="button" value="充值" class="chargeCodeBtn" onclick="javscript:window.location='${ctx}/account/recharge'"/> --%>
	</div>
	<div class="clearfix"></div>
</div>
<div class="balance">
	<span class="pull-right">可用余额:<fmt:formatNumber value="${userAmount.real_amount}" pattern="#0"/>宇币</span>
	<div class="clearfix"></div>
</div>
<div class="myCode">
	<h3>我的邀请码</h3>
	<div class="inviteCodes">
		<ul>
			<c:forEach items="${codeList}" var="code">
				<li>
					<div>
						<p class="ableCode">${code.code_str}</p>
						<p class="nouse"><yt:dict2Name nodeKey="if_use" key="${code.if_use}"></yt:dict2Name></p>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>
