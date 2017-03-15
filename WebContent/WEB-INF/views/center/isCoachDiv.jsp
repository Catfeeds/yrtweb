<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 							 <c:choose>
                           		<c:when test="${!empty isCoach}">
	                                    <div class="pull-right" style="margin-right: 25px;">
	                                        <!-- <dl class="mt10">
	                                            <dt>
	                                                <input type="button" name="name" value="+ 关注" class="guanzhubtn ms" />
	                                                <input type="button" name="name" value="上传视频/图片" class="up_pic_videobtn  ms" />
	
	                                            </dt>
	                                            <dd>
	                                                <input type="button" name="name" value="编辑信息" class="edit_actbtn ms" onclick="editCoachInfo()"/>
	                                                <input type="button" name="name" value="激活" class="edit_actbtn ms" />
	                                            </dd>
	                                        </dl> -->
	                                    </div>
                           		</c:when>
                           		<c:otherwise>
                                    	  <c:if test="${oth_user_id eq session_user_id}">
                                  	  	<span id="coach_act_btn" flag="0" onclick="activation_btn('coach',this)" class="activation ms text-white">激&emsp;活</span>
                         				</c:if>
                                   	  	<c:if test="${!(oth_user_id eq session_user_id)}">
                         				<span id="coach_act_btn" flag="0" class="activation ms text-white">未激活</span>
                         				</c:if>
                           		</c:otherwise>
							</c:choose>  