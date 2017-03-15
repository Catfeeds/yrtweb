<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	if("w.yrt9527.com".equals(request.getServerName())){
		response.sendRedirect("http://11uniplay.com/");
		return;
	}
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="../ajaxlogin.jsp" %>
<div class="feedback">
                <div class="fe_title">
                    <div class="closeBtn_1"></div>
                    <span class="f20 ms text-white">意见反馈</span>
                </div>
                <div class="fromlist">
                	<form id="feedBackForm">
                    <table>
                        <tr>
                            <td class="l"><span class="f14">姓&emsp;&emsp;名</span></td>
                            <td class="r"><input type="text" name="name" value="" valid="require" class="w300 ml10" /></td>
                        </tr>
                        <tr>
                            <td class="l"><span class="f14">联系电话</span></td>
                            <td class="r"><input type="text" name="phone" value="" valid="require mobile" class="w300 ml10" /></td>
                        </tr>
                        <tr>
                            <td class="l"><span class="f14">邮箱地址</span></td>
                            <td class="r"><input type="text" name="email" value="" class="w300 ml10" /></td>
                        </tr>
                        <tr>
                            <td class="l" valign="top"><span class="f14">反馈意见</span></td>
                            <td class="r">
                                <textarea name="content" valid="require"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="l"><span class="f14">上传图片</span></td>
                            <td class="r">
                                <div id="feedBackphoto" valid="requireUpload" class="ml10">
                                
					            </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input type="button" name="name" value="提交" onclick="submitFeedback()"  class="submit mt35 ms" />
                            </td>

                        </tr>
                    </table>
                    </form>
                </div>
            </div>
<div class="header">
    <div class="top clearfix">
        <!--logo-->
        <a href="${ctx}/"><img src="${ctx}/resources/images/logo3.png" style="float:left;margin-top:25px; width: 120px;height: 49px;"/></a>
        <div class="pull-left clearfix mt35">
        	 <div class="search_res">
                <!-- 搜索结果展示 -->
             </div>
            <!--搜索条-->
            <input type="text" id="searchUserNick" value="" placeholder="球员/俱乐部/宝贝" maxlength="27" onclick="searDatasByNick()" onkeyup="searDatasByNick()" class="search ml15"/>
            <input type="button" name="name" value="" class="search_btn" onclick="searDatasByNick()"/>
            <input type="button" name="name" value="筛选条件" class="ms f14 tools_btn" style="visibility: hidden;">
            
        </div>
        <!--登录区-->
        <div class="userinfo">
             <c:choose>
        		<c:when test="${empty session_user_id}">
        		    <!--登录条-->
		            
        		    <a href="javascript:void(0);" class="rl mt10 text-white" onclick="my();">我的夺宝</a>
                    <a href="javascript:window.location='${ctx}/register/registerAccount'" class="rl mt10 mr15 text-white">免费注册</a>
                    <a href="javascript:window.location='${ctx}/login'" class="rl mt10 mr15"  style="color:#2881ff;">请登录</a>
        		    <div class="clearit"></div>
        		</c:when>
        		<c:otherwise>
        			<dl>
        				<dt>
        				<div style="float: left;position: relative; background: #1c301c;width:335px; padding: 2px 5px;border-radius: 6px;text-align:right;">
			        		<span class="text-white user_h" onclick="location.href='${ctx}/center'" style="cursor: pointer;">${session_usernick}</span>
		           			<a href="${ctx}/login/loginOut" class="text-white">[退出]</a>
                            <a href="${ctx}/shop/orderList" class="text-white">我的夺宝 |</a>
                             <span class="shop_index" id="shop_case_png" style="display: none;"></span>
                            <a href="${ctx}/message" class="text-white">即时消息 |</a>
                            <span class="msg_index" id="msg_case_png" style="display: none;"></span>
                            <a href="${ctx}/message/toSysMsgListPage" class="text-white">系统消息</a>
                            <span class="sys_index" id="sys_case_png" style="display: none;"></span>
                         </div>
			        	<div class="clearit"></div>
			   			</dt>
			   			<dd class="mt5">
                            <div class="look" id="status_1">
                                <a href="#" class="property" id="show_s" onclick="showAmount();">点击显示当前财富值</a>
                            </div>
                            <div class="look" id="status_2">
                                <span href="#" class="property">财富：<span class="text-yellow" id="amountUser"></span><span class="ml5">宇币</span> <a href="${ctx}/account/recharge" target="_blank" style="color:#ca324c;">充值</a></span>
                                <a href="#" class="text-gray-s_666" id="hide_s" onclick="hideAmount();">隐藏</a>
                            </div>
                        </dd>
			   		</dl>	
        		</c:otherwise>
        	</c:choose>
        	 <div class="clearit"></div>
         </div>
    </div>
</div>
<script type="text/javascript">

	
</script>
