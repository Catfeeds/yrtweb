<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/common.jsp" %>
<ul>
	<c:forEach items="${rt.items}" var="mydress" varStatus="var">
		<li <c:choose><c:when test="${var.index == 2 || var.index == 5}">style="margin-right: 0px;"</c:when></c:choose>>
		<div <c:choose><c:when test="${var.index <3}">class="template1"</c:when><c:otherwise>class="template1 mt"</c:otherwise></c:choose>>		
				<div class="templateCommon"><img src="${filePath}/${mydress.img_src}" style="height: 135px;width: 194px;"></div>
				<div class="t_info" style="text-align: center;">
				   	
				   	<c:choose>
						<c:when test="${mydress.is_per == 0}">
						   	<a href="javascript:void(0)" onclick="buyDress(${mydress.d_id},'${mydress.name}',${mydress.money})"><span class="text-yellow pull-right mr10">永久获取</span></a>
						   	<c:choose>
								<c:when test="${mydress.endTime > 0}">
									<p><span class="text-white ml10">剩余期限:${mydress.endTime}天</span></p>
									<c:choose>
								       <c:when test="${mydress.status == 0}">
								       		<a href="javascript:void(0);"><p><span class="text-white ml10">换装</span></p></a>
				      		       	   </c:when>
								       <c:when test="${mydress.status == 1}">
								       		<a href="javascript:void(0);"><p><span class="text-white ml10">取消换装</span></p></a>
								       </c:when>
								    </c:choose>	
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);"><span class="text-yellow pull-left ml10">续费</span></a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${mydress.is_per == 1}">
							<c:choose>
						       <c:when test="${mydress.status == 0}">
						       		<a href="javascript:void(0);"><p><span class="text-white ml10">换装</span></p></a>
		      		       	   </c:when>
						       <c:when test="${mydress.status == 1}">
						       		<a href="javascript:void(0);"><p><span class="text-white ml10">取消换装</span></p></a>
								   	
						       </c:when>
						    </c:choose>	
				       	</c:when>
				    </c:choose>
				    <div class="clearit"></div>	 
				</div>
			</div>
		</li>
	</c:forEach>
</ul>
<div class="turnPage">
	<ul>
		<c:choose>
		 <c:when test="${rt.pageCount!=0}">
		  <c:choose>
		    <c:when test="${rt.currentPage!=1}"><li style="width: 56px!important;"> <a href="javascript:void(0)" onclick="loadListPage(1)">首页</a></li> <li> <a href="javascript:void(0)" onclick="loadListPage(${rt.currentPage-1})">${rt.currentPage-1}</a></li> <li><b>${rt.currentPage}</b></li></c:when>
		    <c:when test="${rt.currentPage==1}"><li style="width: 56px!important;"> <a href="javascript:void(0)">首页</a></li><li><b>1</b></li> </c:when>
		  </c:choose>
		  <c:choose>
		    <c:when test="${rt.currentPage!=rt.pageCount}"> <li><a href="javascript:void(0)" onclick="loadListPage(${rt.currentPage+1})">${rt.currentPage+1}</a></li>
		      <c:choose>
		        <c:when test="${(rt.currentPage+2)<rt.pageCount}"> <li><i>...</i></li> </c:when>
		      </c:choose>
		      <c:choose>
		        <c:when test="${(rt.currentPage+1)!=rt.pageCount}"> <li><a href="javascript:void(0)"  onclick="loadListPage(${rt.pageCount})">${rt.pageCount}</a></li> </c:when>
		      </c:choose>
		      <li style="width: 56px!important;"><a href="javascript:void(0)" onclick="loadListPage(${rt.pageCount})">末页</a></li>
		    </c:when>
		 	<c:otherwise><li style="width: 56px!important;"><a href="javascript:void(0)" >末页</a></li></c:otherwise>
		  </c:choose>
		 </c:when>
		</c:choose>	
	</ul>
</div>
<script>
	//装扮id,购买永久价格，单价/月
	function buyDress(id,name,money){
		alert(1);
		var url = base+"/account/rebuyDress/"+id;
		$.ajax({
			type:"POST",
			url:url,
			data:{"d_id":id,"name":name,"sumAmount":money},
			dataType:"JSON",
			success:function(data){
				if(data.state=="success"){
					layer.msg(data.message.success[0],{icon:1});
					setInterval(function(){
						//跳转到消费记录
						window.location = base+"/account/costRecord";
					},1000);
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
			}
		});
	}
</script>