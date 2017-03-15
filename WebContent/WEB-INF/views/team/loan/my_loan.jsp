<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="yt" uri="/WEB-INF/tld/dictSelect.tld"%>
<div class="points">
    <div class="mt30 ml25">
        <a href="javascript:loan_application(1,1)" class="mybuy active">我的出租</a>
        <a href="javascript:loan_application(2,1)" class="mysell">我的租借</a>
    </div>

    <table class="buytab">
        <c:choose>
	   	<c:when test="${!empty page.items}">
	   	<tr>
            <th><span>球员</span></th>
            <th><span>所属俱乐部</span></th>
            <th><span>租金</span></th>
            <th><span>到期时间</span></th>
            <th><span>发起时间</span></th>
            <th><span>确认时间</span></th>
            <th><span>操作</span></th>
        </tr>
	   	<c:forEach items="${page.items}" var="item" varStatus="status">
	   	<tr>
            <td><span id="player_name_${item.id}"><yt:userName id="${item.user_id}"></yt:userName></span></td>
            <td><span><yt:id2NameDB beanId="teamInfoService" id="${item.loan_teaminfo_id}"></yt:id2NameDB></span></td>
            <td><span>${item.price}</span></td>
           
            <td><span><fmt:formatDate value='${item.end_time}' pattern='yyyy-MM-dd HH:mm:ss'/></span></td>
            <td><span><fmt:formatDate value='${item.create_time}' pattern='yyyy-MM-dd HH:mm:ss'/></span></td>
            
            <td><span><fmt:formatDate value='${item.closing_time}' pattern='yyyy-MM-dd HH:mm:ss'/></span></td>
            <td>
            	<c:choose>
            		<c:when test="${item.status eq 2}">
            		<c:if test="${item.if_ok eq 0}"><span class="text-gray-s_666 f14">已拒绝</span></c:if>
            		<c:if test="${item.if_ok eq 1}"><span class="text-gray-s_666 f14">已成交</span></c:if>
            		</c:when>
            		<c:otherwise>
            		<c:if test="${item.if_lose eq 1}"><span class="text-gray-s_666 f14">已失效</span></c:if>
            		<c:if test="${item.if_lose eq 0}">
                <input type="button" class="btn_g" onclick="loan_manage('${item.id}',3)" value="撤消请求">
            		</c:if>
            		</c:otherwise>
            	</c:choose>
            </td>
        </tr>
	    </c:forEach>
	   	</c:when>
	   	<c:otherwise>
	   	<tr>
	   		<td colspan="5">
	   		<span class="text-gray-s_666 f14">暂无租借记录</span>
	   		</td>
	   	</tr>
	   	</c:otherwise>
	    </c:choose>
    </table>

    <c:choose>
		<c:when test="${page.pageCount!=0}">
		<ul class="pagination" style="float:right;margin-right: 30px;">
			<c:choose>
				<c:when test="${page.currentPage!=1}">
				<li data-command="prev" onclick="loan_application('${params.type}','${page.currentPage-1}')"><a>上一页</a></li>
		        <li data-page-num="${page.currentPage-1}" onclick="loan_application('${params.type}','${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
		        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
				</c:when>
				<c:when test="${page.currentPage==1}">
				<li data-command="prev"><a>上一页</a></li>
		        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
		        </c:when>
			</c:choose>
			<c:choose>
				<c:when test="${page.currentPage!=page.pageCount}">
				<li data-page-num="${page.currentPage+1}" onclick="loan_application('${params.type}','${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
				<c:choose>
		            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
	            </c:choose>
	            <c:choose>
		            <c:when test="${(page.currentPage+1)!=page.pageCount}">
		            <li data-page-num="${page.pageCount}" onclick="loan_application('${params.type}','${page.pageCount}')"><a>${page.pageCount}</a></li>
		            </c:when>
		        </c:choose>
		        <li data-command="next" onclick="loan_application('${params.type}','${page.currentPage+1}')"><a>下一页</a></li>
				</c:when>
				<c:otherwise>
		    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
		    	</c:otherwise>
			</c:choose>
		</ul>
		</c:when>
	</c:choose>
    <div class="clearit"></div>
</div>
<script type="text/javascript">

</script>
