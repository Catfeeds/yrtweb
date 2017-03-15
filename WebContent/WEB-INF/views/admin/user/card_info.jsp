<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>    
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<!-- 全局变量 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 用户名片信息 -->
      <!--功能-->
      <div class="function_areas">
          <a href="#" class="fun_a">关注</a>
          <a href="#" class="fun_a">私信</a>
          <a href="#" class="fun_a">邀请</a>
      </div>
      <!--信息-->
      <div class="card_info">
          <img src="${el:headPath()}${reMap.head_icon}" alt="" class="card_head" />
          <dl class="card_details">
              <dt><span class="card_name">${reMap.usernick }</span></dt>
              <dd>
              	  <c:choose>
              	  	<c:when test="${reMap.sex}">
	                  <span class="boy"></span>
              	  	</c:when>
              	  	<c:otherwise>
              	  	  <span class="girl"></span>
              	  	</c:otherwise>
              	  </c:choose>
                  <span class="ml5">|</span>
                  <span class="text-gray-s_999 ml10 f12">
                  		<c:choose>
                   			<c:when test="${!empty reMap.position}">
                     				<yt:dict2Name nodeKey="p_position" key="${reMap.position}"></yt:dict2Name>
                   			</c:when>
                   			<c:otherwise>
                   				暂无
                   			</c:otherwise>
                   		</c:choose>
                  </span>
                  <span class="ml5">|</span>
                  <span class="text-gray-s_999 ml10 f12">
                  	<c:choose>
                  		<c:when test="${!empty reMap.player_num}">
		                  	${reMap.player_num}号
                  		</c:when>
                  		<c:otherwise>
                  			暂无
                  		</c:otherwise>
                  	</c:choose>
                  </span>
              </dd>
              <dd><span class="f12 text-gray-s_999">
              			<c:choose>
              				<c:when test="${!empty reMap.team_name}">
              					${reMap.team_name}
              				</c:when>
              				<c:otherwise>
              					暂无
              				</c:otherwise>
              			</c:choose>
              	  </span>
              </dd>
          </dl>
          <div class="clearit"></div>
      </div>
      <!--战斗力-->
      <div class="comat">
          <ul>
              <li>身价&emsp;${reMap.current_price}<span class="ml5 text-gray-s_333">|</span></li>
              <li>能力&emsp;${reMap.score}&emsp;认可&emsp;${reMap.accept}%</li>
          </ul>
      </div>
