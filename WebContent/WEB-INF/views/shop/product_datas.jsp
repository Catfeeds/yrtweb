<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:if test="${empty page.items}">
<p align="center" class="text-white f16" style="margin-top: 20px;">商品正在进驻，请稍后...</p>
</c:if>
<c:if test="${!empty page.items}">
<c:forEach items="${page.items}" var="pro">
<div class="sqzhanshi">
    <div class="biaoqian">
        <span><fmt:formatNumber value="${pro.data_single_price}" pattern="##0"/>宇币</span>
    </div>
    <img src="${el:headPath()}${pro.product_header}" alt="" class="img" style="cursor: pointer;" onclick="location.href='${ctx}/shop/product/${pro.data_id}'" />
    <div class="duo_jj">
        <p class="jj" style="cursor: pointer;" onclick="location.href='${ctx}/shop/product/${pro.data_id}'">${pro.product_title}</p>
        <p class="jj_2 song">总需：${pro.data_total_count}&ensp;人次</p>
        <div class="setbacks_bg">
            <div class="setbacks" style="width: ${(pro.data_count/pro.data_total_count)*100}%;"></div>
        </div>
        <div class="mt25">
            <dl class="pull-left">
                <dt><span class="jj_2">${pro.data_count}</span></dt>
                <dd><span class="jj_2 song">已参与人次</span></dd>
            </dl>
            <dl class="pull-right">
                <dt><span class="jj_2">${pro.data_total_count-pro.data_count}</span></dt>
                <dd><span class="jj_2 song">剩余人次</span></dd>
            </dl>
            <div class="clearfix"></div>
        </div>
        <c:if test="${pro.product_hot eq '1'}">
        <span class="top_hot"></span>
        </c:if>
        <input type="button" name="name" value="立即夺宝" class="gou_btn" onclick="toBuy('${pro.data_id}');"/>
    </div>
</div>
</c:forEach>
</c:if>
<div class="clearfix"></div>
<c:if test="${page.totalCount > 12}">
<div class="page_div" style="float: right;margin-right: 35px;">
<c:choose>
<c:when test="${page.pageCount!=0}">
<ul class="pagination">
	<c:choose>
		<c:when test="${page.currentPage!=1}">
		<li data-command="prev" onclick="load_products('#product_list','${page.currentPage-1}','${params.category_id}')"><a>上一页</a></li>
        <li data-page-num="${page.currentPage-1}" onclick="load_products('#product_list','${page.currentPage-1}','${params.category_id}')"><a>${page.currentPage-1}</a></li>
        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
		</c:when>
		<c:when test="${page.currentPage==1}">
		<li data-command="prev"><a>上一页</a></li>
        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
        </c:when>
	</c:choose>
	<c:choose>
		<c:when test="${page.currentPage!=page.pageCount}">
		<li data-page-num="${page.currentPage+1}" onclick="load_products('#product_list','${page.currentPage+1}','${params.category_id}')"><a>${page.currentPage+1}</a></li>
		<c:choose>
            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
           </c:choose>
           <c:choose>
            <c:when test="${(page.currentPage+1)!=page.pageCount}">
            <li data-page-num="${page.pageCount}" onclick="load_products('#product_list','${page.pageCount}','${params.category_id}')"><a>${page.pageCount}</a></li>
            </c:when>
        </c:choose>
        <li data-command="next" onclick="load_products('#product_list','${page.currentPage+1}','${params.category_id}')"><a>下一页</a></li>
		</c:when>
		<c:otherwise>
    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
    	</c:otherwise>
	</c:choose>
</ul>
</c:when>
</c:choose>
</div>
<div class="clearfix"></div>
</c:if>
<script type="text/javascript">
$("#total_count").text('（共 ${page.totalCount} 件相关商品）');
</script>