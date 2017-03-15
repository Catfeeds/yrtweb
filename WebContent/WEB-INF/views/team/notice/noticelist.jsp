<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="../../common/common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>俱乐部公告列表</title>
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/clubLook.css" rel="stylesheet" />
</head>
<body>
    <div class="warp">
        <%@ include file="../../common/header.jsp" %>    
	 	<%@ include file="../../common/naver.jsp" %> 
	 	<div class="notice_info" id="showNoticeArea" style="display: none;">
        </div>
        <div class="notice" id="addNoticeArea" style="display: none;">
        </div>
        <div class="wrapper" style="margin-top: 116px;">
            <div class="club_show">
                <div class="title">
                    <span class="f18 ms ml10">公告</span>
                </div>
                
                <ul class="announcement_list">
                   	<c:choose>
		              <c:when test="${!empty page.items }">
		                  <c:forEach items="${page.items }" var="notice" varStatus="num">
		                     <li>
			                     <p class="pull-left"><a href="javascript:void(0);" onclick="showNotice('${params.teaminfo_id}','${notice.id }')" >${notice.name }</a></p>
			                     <p class="pull-right mr30"><fmt:formatDate value="${notice.create_time}" type="both" pattern="yyyy-MM-dd" /></p>
			                     <div class="clearit"></div>
	                         </li>
		                  </c:forEach>
		              </c:when>
		              <c:otherwise>
		                <li style="text-align: center;"> 暂无公告</li>
		              </c:otherwise>
			        </c:choose>
                </ul>
                <c:choose>
	                
					<c:when test="${page.pageCount!=0}">
						<ul class="pagination" style="float: right; margin-right: 15px;margin-top:15px;">
						    <li data-command="home"><a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=1">首页</a></li>
							<c:choose>
								<c:when test="${page.currentPage!=1}">
									<li data-command="prev"><a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=${page.currentPage-1}">上一页</a></li>
									<li data-page-num="${page.currentPage-1}">
									    <a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=${page.currentPage-1}">${page.currentPage-1}</a>
									</li>
									<li data-page-num="${page.currentPage}" class="active">
									    <a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=${page.currentPage}">${page.currentPage}</a>
									</li>
								</c:when>
								<c:when test="${page.currentPage==1}">
									<li data-command="prev"><a>上一页</a></li>
									<li data-page-num="${page.currentPage}" class="active">
									    <a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=${page.currentPage}">${page.currentPage}</a>
									</li>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${page.currentPage!=page.pageCount}">
									<li data-page-num="${page.currentPage+1}">
									   <a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=${page.currentPage+1}">${page.currentPage+1}</a>
									</li>
									<c:choose>
										<c:when test="${(page.currentPage+2)<page.pageCount}">
											<li><a>...</a></li>
										</c:when>
									</c:choose>
									<c:choose>
										<c:when test="${(page.currentPage+1)!=page.pageCount}">
											<li data-page-num="${page.pageCount}">
											   <a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=${page.pageCount}">${page.pageCount}</a>
											</li>
										</c:when>
									</c:choose>
									<li data-command="next">
									   <a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=${page.pageCount}">下一页</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="disabled"><li data-command="next"><a>下一页</a></li>
									</li>
					    	</c:otherwise>
						</c:choose>
						<li data-command="end"><a href="${ctx}/team/loadNoticeList?team_id=${params.teaminfo_id}&pageSize=10&currentPage=${page.pageCount}">尾页</a></li>
					</ul>
					</c:when>
				</c:choose>
                <div class="clearit"></div></div>    
		   </div>
     </div>
     <%@ include file="../../common/footer.jsp" %>
</body>
<script type="text/javascript">
jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}
function showNotice(teamId,id){
	$.ajax({
		type: 'POST',
		url: base+"/team/showNotice",
		data: {"teaminfo_id":teamId,"id":id},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#showNoticeArea").html(data);
				$("#showNoticeArea").center().show();
			}
		},
		error: $.ajaxError
	});
}

//添加公告信息页面
function addNoticePage(id,nid){
	$.ajax({
		type: 'POST',
		url: base+"/team/addNoticePage",
		data: {"teaminfo_id":id,id:nid},
		dataType:"html",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0]);
			}else{
				$("#addNoticeArea").html(data);
				$("#addNoticeArea").center().show();
			}
		},
		error: $.ajaxError
	});
	
}

//公告修改
function editNotice(id,nid){
	cl();
	addNoticePage(id,nid);
}

function cl() {
    $(".masker").hide();
    $(".select_jersey").hide();
    $("#upload_matchResult").hide();
    $(".notice_info").hide();
    $(".notice_argee").hide();
    $(".notice").hide();
}

//保存公告信息页面
function saveNotice(){
	var jsonData = {
		"teaminfo_id":$("#teaminfo_id").val(),	
		"name" : $("#name").val(),	
		"describle" : $("#describle").val()
	};
	
	$.ajaxSec({
		context:$("#nForm"),
		type: 'POST',
		url: base+"/team/saveNotice",
		data:$("#nForm").serialize(),
		dataType:"json",
		success: function(data){
			if(data.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				layer.msg(data.message.success[0],{icon:1});
				$("#addNoticeArea").hide();
				location.reload();
			}
		},
		error: $.ajaxError
	});
	
}

function delNotice(nid){
	yrt.confirm("是否要删除这条公告？", {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: base+'/team/deleteNotice',
			data: {id: nid},
			success: function(result){
				if(result.state=='success'){
					yrt.msg("删除成功",{icon: 1});
					location.reload();
				}else{
					yrt.msg(result.message.error[0],{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}
</script>
</html>
