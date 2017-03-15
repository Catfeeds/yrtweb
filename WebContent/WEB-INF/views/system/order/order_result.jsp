<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <c:choose>
	<c:when test="${!empty rf.items}">
	<table class="sp_info">
		<tr>
	        <th style="width: 50%;">商品信息</th>
	        <th style="width: 25%;">期号</th>
	        <th style="width: 25%;">操作</th>
	    </tr>
	    <c:forEach items="${rf.items}" var="o">
	    <tr>
	        <td>
	        	<img src="${el:headPath()}${o.product_header}"/>
	            <dl>
	                <dt style="width: 290px;">
	                	<a href="/shop/product/${o.data_id}" target="blank" class="text-white no_line f14">
	                		<span class="f14 no_line">${o.product_title}</span>
	            		</a>
	                </dt>
	                <dd><span class="f12">订单号：${o.order_sn}</span></dd>
	                <dd><span class="f12">总需：${o.data_total_count}人次</span></dd>
	                <dd><span class="f12">获奖者：</span><span class="id"><yt:userName id="${o.data_win_user}"/></span><span>（本期参与${o.data_count}人/次）</span></dd>
	                <dd><span class="f12">幸运代码：</span><span class="id_num">${o.data_win_num}</span></dd>
	                <dd><span class="f12">揭晓时间：<fmt:formatDate value="${o.data_finish_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span></dd>
	            </dl>
	        </td>
	        <td align="center">
	            <span class="block">${o.data_sn}</span>
	            <span class="block"><yt:dict2Name nodeKey="order_status" key="${o.order_status}"></yt:dict2Name></span>
	        </td>
	        <td align="center">
	            <dl class="ctrlos">
	                <dt><span>我参与了${o.order_count}人次</span>&ensp;<a href="#" class="text-info" onclick="showNum('${o.order_id}');">查看</a></dt>
	                <c:choose>
	                	<c:when test="${o.data_status eq '4' || o.data_status eq '3' }">
			                <dd><input type="button" name="name" value="参与最新" class="canyuBtn" onclick="toNew('${o.product_id}')"/></dd>
	                	</c:when>
	                	<c:otherwise>
	                		<dd><input type="button" name="name" value="追加人次" class="canyuBtn" onclick="toNew('${o.product_id}')"/></dd>
	                	</c:otherwise>
	                </c:choose>
	            </dl>
	        </td>
	    </tr>
	    </c:forEach>
	</table>
	<ul class="pagination" style="float:right;margin-top:0px;">
	   	<li><label class="index">第${rf.currentPage}页/共${rf.pageCount}页</label> </li>
	   	<li><label class="sum">共计${rf.totalCount}条</label> </li>
		<li><a href="javascript:void(0)" onclick="orderSearch(0);">首页</a></li>
			<c:choose>
				<c:when test="${rf.currentPage-1>0}">
					<li><a href="javascript:void(0)" onclick="orderSearch(${rf.currentPage-1});">上一页</a></li>
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
					<li><a href="javascript:void(0)" onclick="orderSearch(${rf.currentPage+1});">下一页</a></li>
				</c:otherwise>
			</c:choose>	
		<li><a href="javascript:void(0)" onclick="orderSearch(${rf.pageCount});">最后一页</a></li>
		<li><input type="text" name="pIndex" id="pIndex" value="" class="ipt"/></li> 
		<li><a href="javascript:void(0)" onclick="orderSearch();">跳转</a></li> 
	</ul>
	</c:when>
	<c:otherwise>
		<table class="sp_info">	
		<tr>
	        <th style="width: 50%;">商品信息</th>
	        <th style="width: 25%;">期号</th>
	        <th style="width: 25%;">操作</th>
	    </tr>
	    <tr>
	       <td colspan="3" align="center">
	            <img src="${ctx}/resources/images/no_have.png" style="width: 754px;height: 326px;"/>
	            <a href="${ctx}/shop/index" name="name" class="canyuBtn" target="blank">点击立刻参与</a>
	       </td>
	    </tr>
	</table>
	</c:otherwise>
</c:choose>
<script>
function  li(classa) {
	$(classa).each(function () {
        var maxwidth = 42;
        if ($(this).text().length > maxwidth) {
            $(this).text($(this).text().substring(0, maxwidth));
            $(this).html($(this).html() + '...');
        }
    });   
}
li(".no_line");
</script>