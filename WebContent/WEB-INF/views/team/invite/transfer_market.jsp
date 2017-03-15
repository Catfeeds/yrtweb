<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="mt30 ml25">
	<c:choose>
		<c:when test="${params.type eq 1}">
    <a href="javascript:transfer_market(2,1)" class="mysell">我的售出</a>
    <a href="javascript:transfer_market(1,1)" class="mybuy active">我的购入</a>
		</c:when>
		<c:otherwise>
    <a href="javascript:transfer_market(2,1)" class="mysell active">我的售出</a>
    <a href="javascript:transfer_market(1,1)" class="mybuy">我的购入</a>
		</c:otherwise>
	</c:choose>
</div>

<table class="buytab">
    <tr>
	    <th><span>球员</span></th>
        <th><span>价格</span></th>
        <th><span>${params.type eq 1?'售出俱乐部':'购买俱乐部'}</span></th>
        <th><span>交易日期</span></th>
        <th><span>状态</span></th>
    </tr>
    <c:choose>
   	<c:when test="${!empty page.items}">
   	<c:forEach items="${page.items}" var="item" varStatus="status">
   	<tr>
        <td><span>${empty item.username?item.usernick:item.username}</span></td>
        <td><span>${item.price}</span></td>
        <td><span>${params.type eq 1?item.sell_name:item.buy_name}</span></td>
        <td><span><fmt:formatDate value='${item.deal_time}' pattern='yyyy-MM-dd'/></span></td>
        <td>
   			<c:choose>
   				<c:when test="${item.status eq 0}">
   					<c:choose>
   						<c:when test="${params.type eq 1}">	
		   					<input type="button" name="name" value="撤消出价" class="btn_g" onclick="cancelBuy('${item.id}')"/>
   						</c:when>
   						<c:otherwise>
   							<input type="button" onclick="fn_confirm('${item.id}',1,'${item.buy_name}','${empty item.username?item.usernick:item.username}')" value="同意" class="btn_l" />
			                <input type="button" onclick="fn_confirm('${item.id}',2,'${item.buy_name}','${empty item.username?item.usernick:item.username}')" value="拒绝" class="btn_g" />
   						</c:otherwise>
   					</c:choose>	
   				</c:when>
   				<c:otherwise>
   					<span class="text-gray-s_666 f14">${item.status eq 1?'交易成功':'交易失败'}</span>
   				</c:otherwise>
   			</c:choose>	
        </td>
    </tr>
    </c:forEach>
   	</c:when>
   	<c:otherwise>
   	<tr>
   		<td colspan="5">
   		<span class="text-gray-s_666 f14">${params.type eq 1?'暂无购入记录':'暂无出售记录'}</span>
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
			<li data-command="prev" onclick="transfer_market('${params.type}','${page.currentPage-1}')"><a>上一页</a></li>
	        <li data-page-num="${page.currentPage-1}" onclick="transfer_market('${params.type}','${page.currentPage-1}')"><a>${page.currentPage-1}</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
			</c:when>
			<c:when test="${page.currentPage==1}">
			<li data-command="prev"><a>上一页</a></li>
	        <li data-page-num="${page.currentPage}" class="active"><a>${page.currentPage}</a></li>
	        </c:when>
		</c:choose>
		<c:choose>
			<c:when test="${page.currentPage!=page.pageCount}">
			<li data-page-num="${page.currentPage+1}" onclick="transfer_market('${params.type}','${page.currentPage+1}')"><a>${page.currentPage+1}</a></li>
			<c:choose>
	            <c:when test="${(page.currentPage+2)<page.pageCount}"><li><a>...</a></li></c:when>
            </c:choose>
            <c:choose>
	            <c:when test="${(page.currentPage+1)!=page.pageCount}">
	            <li data-page-num="${page.pageCount}" onclick="transfer_market('${params.type}','${page.pageCount}')"><a>${page.pageCount}</a></li>
	            </c:when>
	        </c:choose>
	        <li data-command="next" onclick="transfer_market('${params.type}','${page.currentPage+1}')"><a>下一页</a></li>
			</c:when>
			<c:otherwise>
	    	<li class="disabled"><li data-command="next"><a>下一页</a></li></li>
	    	</c:otherwise>
		</c:choose>
	</ul>
	</c:when>
</c:choose>
<div class="clearit"></div>
<script type="text/javascript">
function fn_confirm(id,type,tname,pname){
	var msg = "是否同意"+tname+"购买"+pname+"的交易请求？";
	if(type==2){
		msg = "是否拒绝"+tname+"购买"+pname+"的交易请求？";
	}
	yrt.confirm(msg, {
	    btn: ['是','否'], //按钮
	    shade: true
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/teamInvite/updateMsg',
			data: {id:id,type:type},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					yrt.msg("操作成功",{icon: 1});
					setTimeout(function(){
						transfer_market(2,1)
					},1400);
				}else{
					yrt.msg(result.message.error[0],{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

function cancelBuy(id){
	yrt.confirm('确定要撤销吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: true
	}, function(){
    	$.ajaxSec({
			type: 'POST',
			url: base+"/teamInvite/cancelBuy",
			data: {"id":id},
			dataType:"json",
			success: function(data){
				if(data.state=='error'){
					yrt.msg(data.message.error[0],{icon:2});
				}else{
					yrt.msg(data.message.success[0],{icon:1});
					transfer_market(1,1);
				}
			},
			error: $.ajaxError
		});	
	});
}
</script>