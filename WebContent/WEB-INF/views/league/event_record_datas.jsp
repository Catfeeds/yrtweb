<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />  
<style>
   .tolbtn{
     
    padding: 4px 12px;
    margin-left: 10px;
    background: #eb6100;
    color: #fff;
    border: none;
    cursor: pointer;
    border-radius: 6px;

   }
</style>  
<table>
    <tr>
        <th style="width: 5%;"><span>分组</span></th>
        <th style="width: 5%;"><span>轮次</span></th>
        <th style="width: 15%;"><span>比赛时间及地点</span></th>
        <th style="width: 15%;"><span>主队</span></th>
        <th style="width: 10%;"><span>比分</span></th>
        <th style="width: 15%;"><span>客队</span></th>
        <th style="width: 5%;"><span>统计</span></th>
    </tr>
    <c:forEach items="${records.items}" var="record">
    <c:choose>
    	<c:when test="${empty record.m_score}">
    <tr style="color: yellow;">
    	</c:when>
    	<c:otherwise>
   	 <tr>
    	</c:otherwise>
    </c:choose>
        <td><span>${record.name}</span></td>
        <td><span>第${record.rounds}轮</span></td>
        <td>
            <dl>
                <dt><span>${record.position}</span></dt>
                <dd><span><fmt:formatDate value='${record.play_time}' pattern='yyyy-MM-dd HH:mm'/></span></dd>
            </dl>
        </td>
        <td><a style="cursor: pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${record.m_teaminfo_id}'">${record.mname}</a></td>
        <c:choose>
	    	<c:when test="${empty record.m_score}">
	    <td><span class="f16 ms">${empty record.m_score?'--':record.m_score}：${empty record.g_score?'--':record.g_score}</span></td>
	    	</c:when>
	    	<c:otherwise>
        <td><span class="text-success f16 ms">${empty record.m_score?'--':record.m_score}：${empty record.g_score?'--':record.g_score}</span></td>
	    	</c:otherwise>
	    </c:choose>
        <td><a style="cursor: pointer;" onclick="javascript:window.location='${ctx}/team/tdetail/${record.g_teaminfo_id}'">${record.gname}</a></td>
        <td>
        	<c:if test="${!empty record.m_score}">
            	<a href="${ctx}/league/statistics?id=${record.id}" class="text-white tolbtn">统计</a>
        	</c:if>
        </td>
    </tr>
    </c:forEach>
</table>
<ul class="pagination" style="float:right;margin-top:15px;margin-right: 15px;">
    	<c:choose>
    		<c:when test="${records.pageCount!=0}">
    			<c:choose>
					<c:when test="${records.currentPage!=1}"> 
						<li data-command="prev"><a href="javascript:void(0)" onclick="load_event_records(1,'${params.group_id}')">首页</a></li>
						<li data-page-num="${records.currentPage-1}"> <a href="javascript:void(0)" onclick="load_event_records(${records.currentPage-1},'${params.group_id}')">${records.currentPage-1}</a></li>
						<li class="active"><a>${records.currentPage}</a></li> 
					</c:when>
					<c:when test="${records.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${records.currentPage!=records.pageCount}"> <li data-page-num="${records.currentPage+1}"><a href="javascript:void(0)" onclick="load_event_records(${records.currentPage+1},'${params.group_id}')">${records.currentPage+1}</a></li>
					<c:choose>
					<c:when test="${(records.currentPage+2)<records.pageCount}"> <li><a>...</a></li> </c:when>
					</c:choose>
					<c:choose>
					<c:when test="${(records.currentPage+1)!=records.pageCount}"> <li data-page-num="${records.pageCount}"><a href="javascript:void(0)"  onclick="load_event_records(${records.pageCount},'${params.group_id}')">${records.pageCount}</a></li> </c:when>
					</c:choose>
					<li data-command="next"><a href="javascript:void(0)" onclick="load_event_records(${records.pageCount},'${params.group_id}')">末页</a></li> 
					</c:when>
				</c:choose>
    		</c:when>
    	</c:choose>
    </ul>
<div class="clearit"></div>