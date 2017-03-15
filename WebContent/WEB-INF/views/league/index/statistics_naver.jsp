<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<div class="advert">
	<c:choose>
 		<c:when test="${!empty league.banner_src}">
            <img src="${el:headPath()}${league.banner_src}"/>
 		</c:when>		
 		<c:otherwise>
		    <img src="${ctx}/resources/images/banner_ce.jpg" alt="" />
 		</c:otherwise>
 	</c:choose>	

</div>
<div class="nl_nav">

<ul class="navs">
	<li class="li">
        <span class="s_choice">${league.simple_name}</span>
        <div class="s_select" >
        	<c:forEach items="${leagues}" var="league" varStatus="i">
	            <p id="${league.id}">${league.simple_name}</p>
        	</c:forEach>
        </div>
    </li>
    <li class="li">
        <a href="${ctx}/record/toRecord?league_id=${league.id}" class="anav">赛程</a>
    </li>
    <li class="li">
        <a href="${ctx}/league/integralList?league_id=${league.id}" class="anav">积分</a>
    </li>
    <li class="li">
        <a href="${ctx}/statistics/totalStatistics?league_id=${league.id}" class="anav">排行总览</a>
    </li>
    <li class="li">
        <a href="${ctx}/league/scorerRank?league_id=${league.id}" class="anav">射手榜</a>

    </li>
    <li class="li">
        <a href="${ctx}/league/toPrice?league_id=${league.id}" class="anav">身价榜</a>

    </li>
    <li class="li">
        <a href="${ctx}/league/assistsRank?league_id=${league.id}" class="anav">助攻榜</a>
    </li>
    <li class="li">
        <a href="${ctx}/league/toCard?league_id=${league.id}" class="anav">红黄榜</a>
    </li>
    <div class="clearit"></div>
</ul>
</div>

<script type="text/javascript">
 /* //赛区一
 $(".ui_tip_violet_1[dateindex=0]").css({ "left": "-74px" });
 $(".ui_tip_violet_1[dateindex=0] .arrow_border_top").css({ "left": "14%", "top": "-18px" });
 $(".ui_tip_violet_1[dateindex=0] .arrow_content_top").css({ "left": "14%", "top": "-17px" });
 //赛区二
 $(".ui_tip_violet_1[dateindex=1]").css({ "left": "-278px" });
 $(".ui_tip_violet_1[dateindex=1] .arrow_border_top").css({ "left": "35%", "top": "-18px" });
 $(".ui_tip_violet_1[dateindex=1] .arrow_content_top").css({ "left": "35%", "top": "-17px" });
 //赛区三
 $(".ui_tip_violet_1[dateindex=2]").css({ "left": "-482px" });
 $(".ui_tip_violet_1[dateindex=2] .arrow_border_top").css({ "left": "55%", "top": "-18px" });
 $(".ui_tip_violet_1[dateindex=2] .arrow_content_top").css({ "left": "55%", "top": "-17px" });
 //赛区四
 $(".ui_tip_violet_1[dateindex=3]").css({ "left": "-686px" });
 $(".ui_tip_violet_1[dateindex=3] .arrow_border_top").css({ "left": "76%", "top": "-18px" });
 $(".ui_tip_violet_1[dateindex=3] .arrow_content_top").css({ "left": "76%", "top": "-17px" });

 //显示子菜单
 var len = $(".navs .li").length;
 function clear() {
     for (var i = 0; i < len; i++) {
         $(".ui_tip_violet_1[dateindex=" + i + "]").hide();
     }
 }

 $(".navs .li").each(function () {
     $(this).mouseover(function () {
         clear();
         $(this).find(".ui_tip_violet_1").show();
     });
 });

 //切换子菜单项
 $(".ui_txt").each(function () {
     $(this).click(function () {
         $(this).addClass("active").siblings().removeClass("active");
     });

 }); */
 
 //点击菜单
 var len = $(".li").find(".anav").length;
 $(".li").each(function () {
     $(this).click(function () {
         for (var i = 0; i < len; i++) {
             $(".li").find(".anav").eq(i).removeClass("active");
         }
         $(this).find(".anav").addClass("active");
     });
 });
 
 //下拉菜单切换
 $(".s_choice").click(function(event) {
	 event.stopPropagation();
	 $(".s_select").toggle();
	 return false;
 });
 $(".s_select p").each(function() {
     $(this).click(function() {
         var str = $(this).text();
         var id = $(this).attr("id");
         $(".s_choice").text(str);
         $(".s_select").hide();
         window.location = "${ctx}/record/toRecord?league_id="+id;
     });
 });
 $(document).click(function (event) {
	    var _con = $('.s_select'); 
	    if (!_con.is(event.target) && _con.has(event.target).length === 0) { 
	        $('.s_select').hide(); 
	    }
	});
 
</script>
