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
	        <th>商品信息</th>
            <th>期号</th>
            <th>夺宝状态</th>
            <th>操作</th>
	    </tr>
	    <c:forEach items="${rf.items}" var="o">
	    <tr>
	        <td>
	        	<img src="${el:headPath()}${o.product_header}"/>
	            <dl class="sec">
                    <dt style="width: 200px;"><a href="/shop/product/${o.data_id}" target="blank" class="text-white no_line f14">${o.product_title}</a></dt>
                    <dd><span class="f12">订单号：${o.order_sn}</span></dd>
                    <dd><span class="f12">总需：${o.data_total_count}人次</span></dd>
                    <dd>
                        <div class="db_rate">
                            <div class="db_rater" style="width:${o.data_count/o.data_total_count*100}%;"></div>
                        </div>
                    </dd>
                    <dd><span class="f12">已完成${o.data_count}人次，</span><span class="f12">剩余${o.data_total_count - o.data_count}</span></dd>
                </dl>
	        </td>
	        <td align="center">
	           <span class="block">${o.data_sn}</span>
	        </td>
	        <td align="center">
	           <span class="text-success f16">正在进行</span>
	        </td>
	        <td align="center">
	           <dl class="ctrlos">
	               <dt><input type="button" name="name" value="参与最新" class="canyuBtn" onclick="toNew('${o.product_id}')"/></dt>
	               <dd><a href="#" class="text-info look_the" onclick="showNum('${o.order_id}')">查看夺宝号码</a></dd>
	           </dl>
	        </td>
	    </tr>
	    </c:forEach>
	</table>
	<ul class="pagination" style="float:right;margin-top:0px;">
	   	<li><label class="index">第${rf.currentPage}页/共${rf.pageCount}页</label> </li>
	   	<li><label class="sum">共计${rf.totalCount}条</label> </li>
		<li><a href="javascript:void(0)" onclick="orderInSearch(0);">首页</a></li>
			<c:choose>
				<c:when test="${rf.currentPage-1>0}">
					<li><a href="javascript:void(0)" onclick="orderInSearch(${rf.currentPage-1});">上一页</a></li>
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
					<li><a href="javascript:void(0)" onclick="orderInSearch(${rf.currentPage+1});">下一页</a></li>
				</c:otherwise>
			</c:choose>	
		<li><a href="javascript:void(0)" onclick="orderInSearch(${rf.pageCount});">最后一页</a></li>
		<li><input type="text" name="pIndex" id="pIndex" value="" class="ipt"/></li> 
		<li><a href="javascript:void(0)" onclick="orderInSearch();">跳转</a></li> 
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
        var maxwidth = 27;
        if ($(this).text().length > maxwidth) {
            $(this).text($(this).text().substring(0, maxwidth));
            $(this).html($(this).html() + '...');
        }
    });   
}
li(".no_line");
</script>
