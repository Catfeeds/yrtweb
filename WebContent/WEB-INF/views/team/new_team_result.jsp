<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <div class="closeBtn_1" onclick="closeWin()"></div>
            <div class="title">
            	 <c:choose>
                	<c:when test="${games.status ==0 }">
                	  <span class="f16 ms">录入比分</span>
                	</c:when>
                	<c:when test="${games.status ==3 }">
                	  <span class="f16 ms">等待确认</span>
                	</c:when>
                </c:choose>
            </div>
            <style>
            </style>
            <div class="input_score">
                <table>
                    <tr>
                        <td>
                            <dl>
                            	<c:choose>
                            		<c:when test="${games.status==0 }">
                            			<dt><input type="text" id="initiate_score" name="initiate_score" value="" class="mt10" /></dt>
                            		</c:when>
                            		<c:otherwise>
		                                <dt>
		                                	<span class="f30 ms">${games.initiate_score}</span>
		                                	<%-- <input type="text" id="initiate_score" readonly="readonly" name="initiate_score" value="${games.initiate_score }" class="mt10" /> --%>
	                                	</dt>
                            		</c:otherwise>
                            	</c:choose>
                                <dd><span>${games.t_name }</span></dd>
                            </dl>

                        </td>
                        <td><img src="${ctx}/resources/images/vsImg.png" alt="" style="display:inline-block; width: 94px;height: 43px;margin-top: 5px;" /></td>
                        <td>
                            <dl>
                            	<c:choose>
                            		<c:when test="${games.status==0 }">
                            			<dt><input type="text" id="respond_score" name="respond_score" value="" class="mt10" /></dt>
                            		</c:when>
                            		<c:otherwise>
		                                <dt>
		                                	<span class="f30 ms">${games.respond_score }</span>
		                                	<%-- <input type="text" id="respond_score" readonly="readonly" name="respond_score" value="${games.respond_score }" class="mt10" /> --%>
	                                	</dt>
                            		</c:otherwise>
                            	</c:choose>
                                <dd><span>${games.r_name}</span></dd>
                            </dl>
                        </td>
                    </tr>
                </table>
                <p>
                    <fmt:formatDate value="${games.game_time}" pattern="yyyy-MM-dd"/>
                </p>
                <p>
                    ${games.position}
                </p>
                <div class="mt20"></div>
                <div class="l_fenge mt20"></div>
                <c:choose>
                	<c:when test="${games.status ==0 }">
		                <input type="button" name="name" value="上传" onclick="submitScore('${games.id}','${teaminfo_id}')" class="btn_l mt40 f16 ms" style="margin-left: 152px;">
		                <input type="button" name="name" value="取消" class="btn_g mt40 f16 ms ml20" onclick="closeWin()">
                	</c:when>
                	<c:when test="${games.status ==3 }">
                		<p class="mt20 text-gray-s_999">
		                  	  是否同意将此比分作为本场比赛的最终得分
		                </p>
                		<input type="button" name="name" value="确认" onclick="confirmCore('${games.id}',1)" class="btn_l mt20 f16 ms" style="margin-left: 189px;">
		                <input type="button" name="name" value="拒绝" class="btn_g mt20 f16 ms ml20" onclick="confirmCore('${games.id}',0)">
                	</c:when>
                </c:choose>
            </div>
