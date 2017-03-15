<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@ include file="../common/common.jsp" %>
    <title>球员库</title>
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/master.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/league.css" rel="stylesheet" />
</head>
<body>
    <div class="warp">
	<%@ include file="../common/header.jsp" %>       
	<%@ include file="../common/naver.jsp" %> 
        <div class="wrapper" style="margin-top: 116px;">
            <div class="registration">
                <div class="title_new">
                    <span class="active f16 ms ml20" id="all" onclick="allSearch('${session_user_id}')">所有球员</span>
                    <c:if test="${!empty session_user_id}">
	                    <span class=" f16 ms ml20">|</span>
	                    <span class=" f16 ms ml20" id="foc" onclick="focusSearch('${session_user_id}')" >关注球员</span>
	                </c:if>    
                </div>
                <form action="" method="post" id="searchForm">
                    <input type="hidden" name="s_user_id" id="s_user_id" value=""/>
	                <div class="search_terms">
	                    <div class="mt15 ml20">
	                        <span class="text-gray-s_999">昵称</span>
	                        <input type="text" name="usernick" value="${usernick}" class="txt ml10" />
	                        <span class="text-gray-s_999 ml10">擅长位置</span>
	                        <select style="" name="position">	
	                            <option value="">请选择</option>
	                        	<optgroup label="前场位置">
	                                <option value="rw" <c:if test="${params.position eq 'rw'}">selected</c:if>>右边锋</option>
	                                <option value="lw" <c:if test="${params.position eq 'lw'}">selected</c:if>>左边锋</option>
	                                <option value="st" <c:if test="${params.position eq 'st'}">selected</c:if>>中锋</option>
	                                <option value="lf" <c:if test="${params.position eq 'lf'}">selected</c:if>>左前锋</option>
	                                <option value="rf" <c:if test="${params.position eq 'rf'}">selected</c:if>>右前锋</option>
	                            </optgroup>
	                            <optgroup label="中场位置">
	                                <option value="cam" <c:if test="${params.position eq 'cam'}">selected</c:if>>前腰</option>
	                                <option value="cdm" <c:if test="${params.position eq 'cdm'}">selected</c:if>>后腰</option>
	                                <option value="lm" <c:if test="${params.position eq 'lm'}">selected</c:if>>左前卫</option>
	                                <option value="rm" <c:if test="${params.position eq 'rm'}">selected</c:if>>右前卫</option>
	                                <option value="cm" <c:if test="${params.position eq 'cm'}">selected</c:if>>中前卫</option>
	                                <option value="lcm" <c:if test="${params.position eq 'lcm'}">selected</c:if>>左中场</option> 
	                                <option value="rcm" <c:if test="${params.position eq 'rcm'}">selected</c:if>>右中场</option> 
	                                <option value="lcb" <c:if test="${params.position eq 'lcb'}">selected</c:if>>左中卫</option> 
	                                <option value="rcb" <c:if test="${params.position eq 'rcb'}">selected</c:if>>右中卫</option>   
	                            </optgroup>
	                            <optgroup label="后场位置">
	                                <option value="lb" <c:if test="${params.position eq 'lb'}">select
	                                ed</c:if>>左后卫</option>
	                                <option value="cb" <c:if test="${params.position eq 'cb'}">selected</c:if>>中后卫</option>
	                                <option value="rb" <c:if test="${params.position eq 'rb'}">selected</c:if>>右后卫</option>
	                            </optgroup>
	                            <optgroup label="守门">
	                                <option value="gk" <c:if test="${params.position eq 'gk'}">selected</c:if>>守门员</option>
	                            </optgroup>
                    		</select>
	                        <span class="text-gray-s_999 ml10">年龄</span>
	                        <select name="age">
	                            <option value="">不限</option>
	                            <option value="0,11" <c:if test="${params.age eq '0,11'}">selected</c:if>>11岁以下</option>
	                            <option value="11,16" <c:if test="${params.age eq '11,16'}">selected</c:if>>11岁至16岁</option>
	                            <option value="17,22" <c:if test="${params.age eq '17,22'}">selected</c:if>>17岁至22岁</option>
	                            <option value="23,28" <c:if test="${params.age eq '23,28'}">selected</c:if>>23岁至28岁</option>
	                            <option value="28" <c:if test="${params.age eq '28'}">selected</c:if>>28岁以上</option>
	                        </select>
	                        <span class="text-gray-s_999 ml10">惯用脚</span>
                        		<yt:dictSelect name="cfoot" nodeKey="cfoot" value="${params.cfoot}"></yt:dictSelect>
	                        <span class="text-gray-s_999 ml10">类别</span>
	                           	<select id="level" name="level">
	                           		<option value="">请选择</option>
	                           		<option value="0">普通球员</option>
	                           		<option value="1">妖人球员</option>
	                           	</select>
	                        <span class="text-gray-s_999 ml10">城市</span>
		                        <select id="s_province" name="province"></select>
		                        <select id="s_city" name="city"></select>
	                        <input type="button" name="name" value="搜索" class="btn_l" onclick="userSearch(0);"/>
	                    </div>
	                    <div class="tiaojian">
	                        <span class="text-gray-s_999">排序：</span>
	                        <span onclick="getSort('score_sort','#score_sort');">综合能力</span><span id="score_sort" style="color:#fff;"></span>	
			                <input type="hidden" name="score_sort" class="ich" value="${params.score_sort}"/>
	                       
	                        <span class="text-gray-s_999">|</span>
		                    <span onclick="getSort('age_sort','#age_sort');">年龄</span><span id="age_sort" style="color:#fff;"></span>	
				            <input type="hidden" name="age_sort" class="ich" value="${params.age_sort}"/>
			                
	                        <span class="text-gray-s_999">|</span>
	                      	<span onclick="getSort('w_sort','#w_sort');">体重</span><span id="w_sort" style="color:#fff;"></span>	
				          	<input type="hidden" name="w_sort" class="ich" value="${params.w_sort}"/>
	                        
	                        <span class="text-gray-s_999">|</span>
	                        <span onclick="getSort('h_sort','#h_sort');">身高</span><span id="h_sort" style="color:#fff;"></span>	
				          	<input type="hidden" name="h_sort" class="ich" value="${params.h_sort}"/>
	                    </div>
	                </div>
                </form>
                <div class="qiuyuanku" id="speciallist"></div>
                <div class="auction_area" id="userlist"></div>
            </div>
        </div>
    </div>
	<%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/js/own/playerlist.js"></script>
    <script src="${ctx}/resources/js/area.js"></script>
    <script type="text/javascript">
        new PCAS('province', 'city');

        jQuery.fn.center = function () {
            this.css("position", "absolute");
            this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
            this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
            return this;
        }
    </script>
</body>
</html>
    