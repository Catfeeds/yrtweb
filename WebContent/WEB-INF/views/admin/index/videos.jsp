<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>首页管理</a></li>
		<li><a>视频管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				</h2>
				<h2><a onclick="add_index_video()" style="cursor: pointer;">添加视频栏位</a><span class="break"></span>
				</h2>
			</div>
			<div class="box-content">
				<table class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>标题</th>
							  <th>上传者</th>
							  <th>视频所属</th>
							  <th>上传路径</th>
							  <th>展示排序</th>
							  <th>点赞数</th>
							  <th>状态</th>                                          
							  <th>创建时间</th>
							  <th>操作</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="video" varStatus="status">
						<tr>
							<td>${video.title}</td>
							<td>${video.ivname}</td>
							<td>
								<c:choose>
									<c:when test="${video.role_type eq 'USER'}">球迷</c:when>
									<c:when test="${video.role_type eq 'PLAYER'}">球员</c:when>
									<c:when test="${video.role_type eq 'TEAM'}">俱乐部</c:when>
									<c:when test="${video.role_type eq 'BABY'}">宝贝</c:when>
									<c:when test="${video.role_type eq 'LEAGUE'}">联赛</c:when>
								</c:choose>  
							</td>
							<td>
								<c:choose>
									<c:when test="${empty video.f_src}">无视频</c:when>
									<c:otherwise>
							<a style="cursor: pointer;color: red;" onclick="showVideo('${el:filePath(video.f_src,video.to_oss)}')">点击播放</a>
									</c:otherwise>
								</c:choose>  
							</td>
							<td>${status.index+1}</td>
							<td>${video.praise_count}</td>
							<td>
								<c:choose>
									<c:when test="${video.f_status eq 0}">不可用</c:when>
									<c:when test="${video.f_status eq 1}">可用</c:when>
								</c:choose>  
							</td>
							<td><fmt:formatDate value="${video.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
							<a class="btn btn-info" title="" onclick="select_iv_info('${video.iid}')">
								<i class="fa fa-search-plus"> 选择视频</i> 
							</a>
							<a class="btn btn-danger" title="" onclick="ListPage.remove('${ctx}/admin/index/deleteField','${video.iid}')">
								<i class="fa fa-trash-o "> 删除栏位</i> 
							</a>
							</td>
						</tr>
						</c:forEach>
					  </tbody>
				 </table>  
				 <%@include file="../common/paginate.jsp" %>
			</div>
		</div>
	</div><!--/col-->
</div><!--/row-->
<style>
.showvdo {
    position: relative;
}

#playSWF {
    position: absolute;
    width: 20px;
    height: 20px;
    right: 0px;
    top: -18px;
    cursor: pointer;
}
</style>
<div id="showVideo" ><img id="playSWF" src="${ctx}/resources/images/close.png"/><div id="a1" class="showvdo"></div></div>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">
jQuery.fn.center = function () {
	var h = this.height() == 0? 400 :this.height();
    this.css("position", "absolute");
    this.css("top", ($(window).height() - h) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}
var btn = $("#playSWF");
btn.click(function () {
    $("#showvdo").html("");
    $(".masker").hide();
    $('#showVideo').hide();
});

function showVideo(src){
	var flashvars = {
	        f: src,
	        c: 0,
	        b: 1
	    };
	    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1', 'ckplayer_a1', '600', '400', false, flashvars);
	  	$(".masker").height($(document).height()).fadeIn();
		$(".masker").show();
		$('#showVideo').center().show();
}
function add_index_video(){
	layer.confirm('是否确认添加首页视频栏位？', {
	    btn: ['是','否'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/admin/index/addField',
			data: {type:'video'},
			cache: false,
			success: function(result){
				if (result.state=='success') {
					layer.msg("添加成功",{icon: 1});
					ListPage.enter();
                } else {
                	layer.msg("添加失败",{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}

var iframeIvInfo;
function select_iv_info(iid){
	iframeIvInfo = layer.open({
	    type: 2,
	    title: '选择俱乐部',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/index/dialog?id='+iid+'&type=video' //iframe的url
	}); 
}

function changeIv(iid,ivid){
	if(iid&&ivid){
		$.ajaxSec({
			type: 'POST',
			url: '${ctx}/admin/index/addFieldValue',
			data: {id:iid,oth_id:ivid,type:'video'},
			cache: false,
			success: function(result){
				layer.close(iframeIvInfo);
				if (result.state=='success') {
					layer.msg("添加成功",{icon: 1});
					ListPage.enter();
                } else {
                	layer.msg("添加失败",{icon: 2});
                }
			},
			error: $.ajaxError
		});
	}
}
</script>

