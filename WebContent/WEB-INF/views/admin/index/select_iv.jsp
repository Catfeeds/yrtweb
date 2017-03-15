<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<%@include file="../common/common.jsp" %>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span>
				<span onclick="select_iv()" class="label label-primary" style="cursor: pointer;padding: 8px 12px;"><span style="font-size: 14px;">+</span> 确认选择</span>
				</h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<input type="hidden" name="type" value="${params.type}">
						<input type="hidden" id="select_type" name="stype" value="${stype}">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>标题: <input type="text" name="title" value="${params.title}"></label>
							<label>上传者: <input type="text" name="ivname" value="${params.ivname}"></label>
							<label>角色类型: 
								<select id="s_role_type" name="role_type">
									<option value="">全部</option>	
									<option value="USER">球迷</option>
									<option value="PLAYER">球员</option>
									<option value="TEAM">俱乐部</option>
									<option value="BABY">宝贝</option>
									<option value="LEAGUE">联赛</option>
								</select>
								<script type="text/javascript">$("#s_role_type").val('${params.role_type}');</script>
							</label>
							<label>是否可用: 
								<select id="s_f_status" name="f_status">
									<option value="">请选择</option>	
									<option value="0">不可用</option>	
									<option value="1">可用</option>	
								</select>
								<script type="text/javascript">$("#s_f_status").val("${!empty params.f_status?params.f_status:''}");</script>
							</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<a onclick="ListPage.search()" class="btn btn-success">
								<i class="fa">查询</i>                                     
							</a>
							<a onclick="ListPage.resetSearch()" class="btn">
								<i class="fa">重置</i>                                        
							</a>
						</div>
						</form>
					</div>
				</div>
				<hr style="margin:2px;height:1px">
				<table id="iv_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
						  	  <th>选择</th>
							  <th>标题</th>
							  <th>上传人</th>
							  <th>角色类型</th>
							  <th>上传路径</th>
							  <th>点赞数</th>
							  <th>文件大小</th> 
							  <th>描述</th>
							  <th>状态</th>
							  <th>创建时间</th>
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="video">
						<tr>
							<td>
							<c:choose>
								<c:when test="${empty stype || stype=='1'}">
								<input style="width: 20px;" value="${video.id}" name="ivId" type="radio" class="">
								</c:when>
								<c:otherwise>
									<input style="width: 20px;" value="${video.id}" name="ivId" type="checkbox" class="">
								</c:otherwise>
							</c:choose>
							</td>
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
							<c:if test="${params.type=='image'}">
							<div style="width: 60px;height: 60px;cursor: pointer;">
							<img src="${el:filePath(video.f_src,video.to_oss)}" onclick="showImage(this)"/>
							</div>
							</c:if>
							<c:if test="${params.type=='video'}">
							<a style="cursor: pointer;color: red;" onclick="showVideo('${el:filePath(video.f_src,video.to_oss)}')">点击播放</a>
							</c:if>
							</td>
							<td>${video.praise_count}</td>
							<td>${video.f_size}</td>
							<td>${video.describle}</td>
							<td>
								<c:choose>
									<c:when test="${video.f_status eq 0}">不可用</c:when>
									<c:when test="${video.f_status eq 1}">可用</c:when>
								</c:choose>  
							</td>
							<td><fmt:formatDate value="${video.create_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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

function fixImageWH(dom) {
	var parent = $(dom);
	var img = parent.find("img");
    var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
    if (iw / ih > parent.width() / parent.height()) {
        img.css({
            width: '100%',
            height: 'auto'
        });
    } else {
        img.css({
            width: 'auto',
            height: '100%'
        });
    }
}

$(function(){
	fixImageWH("#iv_table");
})
</script>