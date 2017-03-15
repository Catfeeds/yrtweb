<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
							<c:choose>
                        		<c:when test="${!empty isAgent and (oth_user_id eq session_user_id)}">
                                   <div class="pull-right mt45">
                                   <input type="button" class="signbtn ms" value="签约球员" name="name" onclick="gotoPlayerList()">
                                   </div>
                        		</c:when>
                        		<c:when test="${!empty playerInfo and !empty oth_isAgent}">
                        		   <div class="pull-right mt45">
	                                   <input type="button" class="signbtn ms" value="申请签约" onclick="signByAgent('${oth_isAgent.id}')">
                                   </div>
                        		</c:when>
                        		<c:otherwise>
                         				<c:if test="${oth_user_id eq session_user_id}">
	                                  	  	<span id="agent_act_btn" flag="0" onclick="activation_btn('agent',this)" class="activation ms text-white">激&emsp;活</span>
                         				</c:if>
                         				<c:if test="${!(oth_user_id eq session_user_id)}">
                         				<span id="agent_act_btn" flag="0" class="activation ms text-white">未激活</span>
                         				</c:if>
                                  	
                        		</c:otherwise>
                        	</c:choose>
                        	<script type="text/javascript">
                        	$(".brokers_info input[type=button]").click(function () {
                                return false;
                            });
                        	</script>