<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:if test="${!empty page.items}">
<c:forEach items="${page.items}" var="pd">
<table>
    <tr>
        <td><span>期号 ${pd.data_sn}</span></td>
        <td><img src="${el:headPath()}${pd.product_header}" alt="" style="cursor: pointer;" /></td>
        <td>
            <dl>
                <dt><span>恭喜<span class="text-info ml10">${pd.usernick}</span>获得了本期商品</span></dt>
                <dd><span class="text-red">本期参与：${pd.data_count}人次</span></dd>
            </dl>
        </td>
        <td>
            <dl>
                <dt><span>幸运号码：<span class="text-red">${pd.data_win_num}</span></span></dt>
                <dd><span>揭晓时间：<fmt:formatDate value="${pd.data_finish_time}" pattern="yyyy-MM-dd HH:mm:ss" /></span></dd>
                <dd><span>夺宝时间：${el:long2Date(pd.order_pay_num)}</span></dd>
            </dl>
        </td>
        <td>
           <a href="${pageContext.request.contextPath}/shop/product/${pd.data_id}" target="_blank" class="text-info">查看详情</a>
       	</td>
    </tr>
</table>
</c:forEach>
</c:if>
<div class="clearfix"></div>
<c:if test="${page.totalCount > 10}">
<div class="page_div" style="float: right;margin-right: 35px;">
<c:choose>
<c:when test="${page.pageCount!=0}">
<ul class="pagination">
	<c:choose>
		<c:when test="${page.currentPage!=1}">
		<li data-command="prev" onclick="load_datas('indiana_past','${params.data_id}','${page.currentPage-1}')"><a>上一页</a></li>
        <li data-page-num="${page.currentPage-1}" onclick="load_datas('indiana_past','${params.data_id}','${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
		</c:when>
		<c:when test="${page.currentPage==1}">
		<li data-command="prev"><a>上一页</a></li>
        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
        </c:when>
	</c:choose>
	<c:choose>
		<c:when test="${page.currentPage!=page.pageCount}">
		<li data-page-num="${page.currentPage+1}" onclick="load_datas('indiana_past','${params.data_id}','${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
		<c:choose>
            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
           </c:choose>
           <c:choose>
            <c:when test="${(page.currentPage+1)!=page.pageCount}">
            <li data-page-num="${page.pageCount}" onclick="load_datas('indiana_past','${params.data_id}','${page.pageCount}')"><a>${page.pageCount}</a></li>
            </c:when>
        </c:choose>
        <li data-command="next" onclick="load_datas('indiana_past','${params.data_id}','${page.currentPage+1}')"><a>下一页</a></li>
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