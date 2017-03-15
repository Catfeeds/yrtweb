<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
					<ul class="att">
						<c:forEach items="${rf.items}" var="item">
		                    <li>
		                        <div class="att_list">
		                           <div class="att_centent">
		                            <div class="att_list_l">
		                                <img src="${filePath}/${item.icon}" style="cursor: pointer;" onclick="window.location='${ctx}/center/${item.user_id}'"/>
		                            </div>
		                            <div class="att_list_r">
		                                <dl style="position: relative;">
		                                    <dt><span class="text-white f14 att_name" style="cursor: pointer;" onclick="window.location='${ctx}/center/${item.user_id}'">${item.nick}</span></dt>
		                                    <!-- <dd><span class="text-white">贝利马利斯球队球员</span></dd> -->
		                                    <dd class="mt5">
		                                     <c:choose>
		                                    	<c:when test="${!empty item.f_status}">
		                                    		<%-- <span class="canenl_att" onclick="unfocus('${item.user_id}','${item.type}')">取消关注</span> --%>
		                                    		<span class="canenl_att">已关注</span>
		                                    	</c:when>
		                                    	<c:when test="${empty item.f_status}">
		                                    		<span class="canenl_att" onclick="focusUser('${item.user_id}')">关注</span>
		                                    	</c:when>
		                                    </c:choose>		
		                                    <span class="canenl_att ml10" onclick="openMsg('${item.id}','${item.nick}')">私信</span>
		                                    </dd>
		                                </dl>
		                            </div>
		                            <div class="clearit"></div>
		                            </div>
		                        </div>
		                    </li>
						</c:forEach>
	                     <div class="clearit"></div>
	                  </ul>
	                   <ul class="pagination" style="float:right;margin-top:35px;margin-right: 65px;">
				    	<c:choose>
				    		<c:when test="${rf.pageCount!=0}">
				    			<c:choose>
									<c:when test="${rf.currentPage!=1}"> 
										<li data-command="prev"><a href="javascript:void(0)" onclick="loadFocusDatas(1)">首页</a></li>
										<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadFocusDatas(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
										<li class="active"><a>${rf.currentPage}</a></li> 
									</c:when>
									<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
								</c:choose>
								<c:choose>
								<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadFocusDatas(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
								<c:choose>
								<c:when test="${(rf.currentPage+2)<rf.pageCount}"> <li><a>...</a></li> </c:when>
								</c:choose>
								<c:choose>
								<c:when test="${(rf.currentPage+1)!=rf.pageCount}"> <li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadFocusDatas(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
								</c:choose>
								<li data-command="next"><a href="javascript:void(0)" onclick="loadFocusDatas(${rf.pageCount})">末页</a></li> </c:when>
								</c:choose>
				    		</c:when>
				    	</c:choose>
				    </ul>	
				    
<script>
//关注
function focusUser(user_id){
	 $.ajax({
		 type:"POST",
		 url:base+"/user/focus",
		 data:{"f_user_id":user_id,f_type:0},
		 dataType:"json",
		 success:function(data){
			 if(data.state=="success"){
				 layer.msg("关注成功！",{icon:1});
				 loadFocusDatas('${rf.currentPage}');
			 }else{
				 layer.msg("关注失败！",{icon:2});
			 }
		 }
	 })
}
</script>				    