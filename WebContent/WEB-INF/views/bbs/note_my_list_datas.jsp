<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />   
<% String nowday = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); %>
	<c:choose>
		<c:when test="${empty rf.items}">
			<table class="bottab">
				<tr>
					<td colspan="4" style="text-align: center;color: red;">
					   <c:choose>
					      <c:when test="${not empty focus }">
					                                    您关注的用户暂无发布任何帖子信息...
					      </c:when>
					      <c:otherwise>
					                                   您暂无发布任何帖子信息..
					      </c:otherwise>
					   </c:choose>
					</td>
				</tr>
			</table>	
		</c:when>
		<c:otherwise>
			<table class="bottab">
			<c:forEach items="${rf.items}" var="item" varStatus="num">
                <tr>
                <c:if test="${ifLeader eq true}">	
                 <td class="w50">
                        <a href="javascript:void(0);" class="sting"></a>
                        <div class="bztool">
                            <ul>
                                <li>
                                   <c:if test="${item.if_top == 1 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_top',2,'${item.plate_id }')">取消置顶</a>
                                   </c:if>
                                   <c:if test="${item.if_top == 2 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_top',1,'${item.plate_id }')">置顶</a>
                                   </c:if>
                                </li>
                                <li>
                                   <c:if test="${item.if_pick == 1 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_pick',2,'${item.plate_id }')">取消精华</a>
                                   </c:if>
                                   <c:if test="${item.if_pick == 2 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_pick',1,'${item.plate_id }')">精华</a>
                                   </c:if>
                                </li>
                                <li>
                                   <c:if test="${item.if_lock == 1 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_lock',2,'${item.plate_id }')">取消锁定</a>
                                   </c:if>
                                   <c:if test="${item.if_lock == 2 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_lock',1,'${item.plate_id }')">锁定</a>
                                   </c:if>
                                </li>
                                <li>
                                   <c:if test="${item.if_show == 1 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_show',2),'${item.plate_id }'">屏蔽</a>
                                   </c:if>
                                   <c:if test="${item.if_show == 2 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_show',1),'${item.plate_id }'">取消屏蔽</a>
                                   </c:if>
                                </li>
                                <li>
                                   <c:if test="${item.if_del == 2 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_del',1),'${item.plate_id }'">删除</a>
                                   </c:if>
                                   <c:if test="${item.if_del == 1 }">
                                      <a href="javascript:void(0);" onclick="setNoteTop('${item.id}','if_del',2),'${item.plate_id }'">取消删除</a>
                                   </c:if>
                                </li>
                            </ul>
                        </div>
                    </td>
                    </c:if>
                    <td class="w90"><span class="louceng" title="楼层数">${item.sumFloor+1}</span></td>
                    <td class="w500">
                        <a class="motif" href="${ctx}/bbs/noteDetails/${item.id}">${item.title }</a>
                        <c:if test="${item.if_pick ==1}">
	                        <span class="jing">精</span>
                        </c:if>
                        <fmt:formatDate value="${item.create_time}" var="dateday" pattern="yyyy-MM-dd"/>
                        <c:set value="<%=nowday %>" var="now"/>
                        <c:if test="${dateday eq now}">
                      	    <span class="xin">新</span>
                        </c:if>
                        <c:if test="${item.if_lock ==1}">
                      	    <span class="suo">锁</span>
                        </c:if>
                        <c:if test="${item.if_image ==1}">
                      	    <span class="bbs_img">&emsp;</span>
                        </c:if>
                        <c:if test="${item.if_video ==1}">
                      	    <span class="bbs_video">&emsp;</span>
                        </c:if>
                    </td>
                    <td class="w160">
                        <dl>
                            <dt>
                            	<span class="writers" title="主题作者：${item.usernick}" onmouseover="showUserInfo('${item.user_id}','#down_player_${num.index}')" onmouseout="hideUserInfo('#down_player_${num.index}')">${item.usernick}</span>
                            	<span id="jl">
                                    <!--名片-->
                                    <div class="card" id="down_player_${num.index}">
                                       
                                    </div>
                                </span>
                           	</dt>
                            <dd>
                            	<span class="times ml20">
                            		<fmt:formatDate value="${item.create_time}" pattern="HH:mm:ss"/>
                            	</span>
                           	</dd>
                        </dl>
                    </td>
                    <td class="w160">
                        <dl>
                            <dt><span class="reflex" onmouseover="showUserInfo('${item.user_id}','#down_player_${num.index}')" onmouseout="hideUserInfo('#down_player_${num.index}')">${item.last_reply_usernick }</span></dt>
                            <dd>
                            	<span class="times ml20">
                            		<fmt:formatDate value="${item.last_reply_time}" pattern="HH:mm:ss"/>
                            	</span>
                           	</dd>
                        </dl>
                    </td>
                </tr>
 			</c:forEach>
 			</table>
            <div class="page_div">
               <ul class="pagination">
				   	<li><label class="index">第${rf.currentPage}页/共${rf.pageCount}页</label> </li>
				   	<li><label class="sum">共计${rf.totalCount}条</label> </li>
					<li><a href="javascript:void(0)" onclick="loadMyNotes(1);">首页</a></li>
						<c:choose>
							<c:when test="${rf.currentPage-1>0}">
								<li><a href="javascript:void(0)" onclick="loadMyNotes(${rf.currentPage-1});">上一页</a></li>
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
								<li><a href="javascript:void(0)" onclick="loadMyNotes(${rf.currentPage+1});">下一页</a></li>
							</c:otherwise>
						</c:choose>	
					<li><a href="javascript:void(0)" onclick="loadMyNotes(${rf.pageCount});">最后一页</a></li>
					<li><input type="text" name="pIndex" id="pIndex" value="" class="ipt"/></li> 
					<li><a href="javascript:void(0)" onclick="loadMyNotes();">跳转</a></li> 
				</ul>
            </div>
		</c:otherwise>
	</c:choose>
<script type="text/javascript">
$(".sting").each(function() {
    $(this).click(function() {
        $(this).next().show();
    });
});
$(document).click(function (e) {
    if (!$(".bztool").is(':has(' + e.target.localName + ')') && e.target.id != 'sting') {
        $(".bztool").hide();
    }
});
</script>