<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    

<div class="title" style="text-align: left;">
    <span class="f18 ms ml10">系统消息</span>
</div>
<style>
    .info-tab{
        width:950px;margin:0 auto 20px;;text-align: center;
    }
    .info-tab th{
        padding-top:12px;
        padding-bottom:12px;
        border-bottom: 1px solid #666;
    }
    .info-tab td{
        padding-top:18px;
        padding-bottom:18px;
        border-bottom: 1px solid #666;
    }
    .info-tab td a  {
    color: #3693db;
    }
</style>
<table class="info-tab">
        <tr>
            <th style="width:12%;text-align: center;color: #999;">发送者</th>
            <th style="width:43%;text-align: center;color: #999;">详情</th>
            <th style="width:20%; ">时间</th>
            <th style="width:25%; ">操作</th>
        </tr>
        <c:choose>
            <c:when test="${!empty rf.items}">
                <c:forEach items="${rf.items}" var="msg" varStatus="msgIndex">
                    <tr>
                        <td>
                            <input type="hidden" value="${msg.s_user_id}" />
                            <c:choose>
                                <c:when test="${msg.sys_type == 1}">
                                    【系统消息】
                                </c:when>
                                <c:when test="${msg.sys_type == 2 }">
                                    <!-- 2为个人 -->
                                    【<a href="${ctx}/center/${msg.s_user_id}">
                                        <yt:id2NameDB beanId="userService" id="${msg.s_user_id}" clazz="f12"></yt:id2NameDB>
                                    </a>】
                                </c:when>
                                <c:when test="${msg.sys_type == 3 }">
                                    <!-- 3为俱乐部 -->
                                    【<a href="${ctx}/team/tdetail/${msg.s_user_id}.html">
                                        <yt:id2NameDB beanId="teamInfoService" id="${msg.s_user_id}" clazz="f12"></yt:id2NameDB>
                                    </a>】
                                </c:when>
                            </c:choose>
                        </td>
                        <td align="left">${msg.content}</td>
                        <td><fmt:formatDate value="${msg.create_time}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${(session_user_id eq msg.s_user_id) && msg.status == 1}">

                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${msg.sys_type == 2 }">
                                            <input type="button" id="msgBtn" onclick="openMsg('${msg.s_user_id}','${msg.usernick}');" value="私信" class="btn_msg  ms f14" />
                                        </c:when>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${(msg.type == 'ptaq' || msg.type == 'ptaj' || msg.type == 'atpq' || msg.type == 'atpj'
             	                          || msg.type == 'ttpa' || msg.type == 'ipk'|| msg.type == 'trial'|| msg.type == 'bbout')&& msg.status == 0 }">
                                    <input class="btn_msg  ms f14" type="button" value="同意" onclick="checkMsg('${msg.id}','${user_id}','${msg.s_user_id}','${msg.relate_id}','${msg.type}','yes');" />
                                    <input class="btn_msg  ms f14 refuse_bg" type="button" value="拒绝" onclick="checkMsg('${msg.id}','${user_id}','${msg.s_user_id}','${msg.relate_id}','${msg.type}','no');" />
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${(session_user_id eq msg.s_user_id) && msg.status == 1}">
                                            <input type="button" name="name" value="已阅" class="btn_msg  ms f14 refuse_bg disabled" style="" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${msg.oper_status==1}">
                                                    <input type="button" name="name" value="已同意" class="btn_msg  ms f14 disabled" style="<c:if test=" ${msg.sys_type==3}"></c:if>"/>
                                                </c:when>
                                                <c:when test="${msg.oper_status==2}">
                                                    <input type="button" name="name" value="已拒绝" class="btn_msg  ms f14 refuse_bg disabled" style="<c:if test=" ${msg.sys_type==3}"></c:if>"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="button" name="name" value="已阅" class="btn_msg  ms f14 refuse_bg disabled" style="<c:if test=" ${msg.sys_type==3}"></c:if>"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>

                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr><td style="width:100%;text-align: center;">您还没有任何系统消息</td></tr>
            </c:otherwise>
        </c:choose>
    </table>
<c:if test="${type eq 'LIST'}">
    <ul class="pagination" style="height: 30px;line-height: 30px;width: 100%;text-align: center;padding-left:270px;">
    	<c:choose>
    		<c:when test="${rf.pageCount!=0}">
    			<c:choose>
					<c:when test="${rf.currentPage!=1}"> 
						<li data-command="prev"><a href="javascript:void(0)" onclick="loadSysMsgList(1,'${user_id}','LIST')">首页</a></li>
						<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadSysMsgList(${rf.currentPage-1},'${user_id}','LIST')">${rf.currentPage-1}</a></li>
						<li class="active"><a>${rf.currentPage}</a></li> 
					</c:when>
					<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
				</c:choose>
				<c:choose>
				<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadSysMsgList(${rf.currentPage+1},'${user_id}','LIST')">${rf.currentPage+1}</a></li>
				<c:choose>
				<c:when test="${(rf.currentPage+2)<rf.pageCount}"><li><a>...</a></li> </c:when>
				</c:choose>
				<c:choose>
				<c:when test="${(rf.currentPage+1)!=rf.pageCount}"><li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadSysMsgList(${rf.pageCount},'${user_id}','LIST')">${rf.pageCount}</a></li> </c:when>
				</c:choose>
				<li data-command="next"><a href="javascript:void(0)" onclick="loadSysMsgList(${rf.pageCount},'${user_id}','LIST')">末页</a></li> </c:when>
				</c:choose>
    		</c:when>
    	</c:choose>
    </ul>	
	<div class="clearit"></div>
    <!-- 分页end --> 

</c:if>
<div class="clearit"></div>					