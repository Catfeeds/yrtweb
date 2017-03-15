<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/common.jsp" %>
<div class="record1">
<ul>
	<c:choose>
		<c:when test="${empty rf.items}">
			<div class="noRecord" style="margin-left: 225px;">
				<img src="${ctx}/resources/images/noRecord.png" />
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach items="${rf.items}" var="item">
				<c:choose>
				<c:when test="${item.status eq 3}">
				<li onmouseover="showBtn(this)" onmouseout="hideBtn(this)">
				</c:when>
				<c:otherwise>
				<li>
				</c:otherwise>
				</c:choose>
					<div>
						<c:choose>
							<c:when test="${item.status eq 1}">
								<img class="record_status1" src="${ctx}/resources/images/confirm.png">
							</c:when>
							<c:when test="${item.status eq 2}">
								<img class="record_status1" src="${ctx}/resources/images/zuofei2.png">
							</c:when>
							<c:when test="${item.status eq 3}">
								<img class="record_status1" src="${ctx}/resources/images/noConfirm.png">
							</c:when>
						</c:choose>
					</div>
					<div class="cl">
						<div class="invite_top1">
			   				<div class="zhu2 pull-left">
			   					<img src="${el:headPath()}${item.t_logo}"/>
			   					<p class="text-white f12">${item.t_name}</p>
			   				</div>
			   				<div class="pull-left vs1 ml20">
			   					<img src="${ctx}/resources/images/vsImg.png"/>
			   					
			   				</div>
			   				<div class="zhu2 pull-left ml35">
			   					<img src="${el:headPath()}${item.r_logo}"/>
			   					<p class="text-white f12">${item.r_name }</p>
			   				</div>
	 					</div>
 					<div class="clear"></div>
 					<div class="invite_bottom1 mt25">
		   				<span class="ml70"><fmt:formatDate value="${item.create_time}" pattern="yyyy-MM-dd"/></span>
		   				<span class="ml10">
		   				<c:choose>
							<c:when test="${!empty item.initiate_score}">
								${item.initiate_score}
							</c:when>
							<c:otherwise>
								0
							</c:otherwise>
						</c:choose>
						&nbsp;:&nbsp;
						<c:choose>
							<c:when test="${!empty item.respond_score }">
								${item.respond_score }
							</c:when>
							<c:otherwise>
								0
							</c:otherwise>
						</c:choose>
						</span>
		   				<span class="ml35">${item.ball_format}人制</span>
					</div>
					
					<c:if test="${!empty item.users}">
					<div>
  						<p class="text-white f13 text-center ml10">助威宝贝</p>
	  					<div class="babyImg1">
	  						<c:forEach items="${item.users}" var="baby">
	  						<div class="pull-left">
	  							<img src="${el:headPath()}${baby.head_icon}" style="cursor: pointer;" onclick="window.open('${ctx}/baby/base/user/${baby.user_id}.html')" title="去往${baby.usernick}的主页" />
	  							<p class="ml5"><input type="button" value="[评价]" onclick="showBaby('${baby.user_id}','${item.id}')" class="pingjia1"/></p>
	  						</div>
	  						</c:forEach>
	  					</div>
					</div>
					</c:if>
					<c:if test="${empty item.users}">
					<div>
  						<p class="text-white f13 text-center ml10">助威宝贝</p>
	  					<div class="babyImg1">
	  						<div class="noBaby">
       							<div class="baby_h"><img src="${ctx}/resources/images/NoBaby.png" /></div>
       							<p class="text-white wei_p">本场未邀请宝贝</p>
       						</div>
	  					</div>
					</div>
					</c:if>
					
					<div class="score_operate1">
   							<div class="text-center ml25">
   								<input type="button" value="同意" onclick="confirmCore('${item.id}',1)"/>
   								<input type="button" value="拒绝" onclick="confirmCore('${item.id}',0)" class="ml90">
   							</div>
   					</div>
 				</div>	
				</li>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</ul>
</div> 

<div class="clear"></div>
<!-- 分页start -->
	 <ul class="pagination" style="float:right;margin-top:15px;margin-right: 40px;">
    	<c:choose>
    		<c:when test="${rf.pageCount!=0}">
    			<c:choose>
					<c:when test="${rf.currentPage!=1}"> 
						<li data-command="prev"><a href="javascript:void(0)" onclick="loadListPage(1)">首页</a></li>
						<li data-page-num="${rf.currentPage-1}"> <a href="javascript:void(0)" onclick="loadListPage(${rf.currentPage-1})">${rf.currentPage-1}</a></li>
						<li class="active"><a>${rf.currentPage}</a></li> 
					</c:when>
					<c:when test="${rf.currentPage==1}"> <li data-page-num="1" class="active"><a>1</a></li></c:when>
				</c:choose>
				<c:choose>
				<c:when test="${rf.currentPage!=rf.pageCount}"> <li data-page-num="${rf.currentPage+1}"><a href="javascript:void(0)" onclick="loadListPage(${rf.currentPage+1})">${rf.currentPage+1}</a></li>
				<c:choose>
				<c:when test="${(rf.currentPage+2)<rf.pageCount}"><li><a>...</a></li> </c:when>
				</c:choose>
				<c:choose>
				<c:when test="${(rf.currentPage+1)!=rf.pageCount}"><li data-page-num="${rf.pageCount}"><a href="javascript:void(0)"  onclick="loadListPage(${rf.pageCount})">${rf.pageCount}</a></li> </c:when>
				</c:choose>
				<li data-command="next"><a href="javascript:void(0)" onclick="loadListPage(${rf.pageCount})">末页</a></li> </c:when>
				</c:choose>
    		</c:when>
    	</c:choose>
    </ul>	
	<div class="clearit"></div>
    <!-- 分页end -->   
    <script type="text/javascript">
    function showBaby(bid,gid){
    	$.ajaxSec({
			type:'POST',
			url: base+'/babyeval/toEval/'+bid,
			data: {},
			cache: false,
			dataType:'json',
			success: function(result){
				if(result.state=='success'){
					$("#baby_name").text(result.data.data.usernick);
					$("#baby_head_img").attr("src",ossPath+result.data.data.head_icon);
					$("#baby_user_id").val(result.data.data.user_id);
					$("#byby_teamgame_id").val(gid);
					$("#byby_teaminfo_id").val($("#teaminfo_id").val());
			    	$(".baby").css("display","block");
				}else{
					layer.msg('操作失败',{icon: 2});
				}
			},
			error: $.ajaxError
		});
    }
    </script>

