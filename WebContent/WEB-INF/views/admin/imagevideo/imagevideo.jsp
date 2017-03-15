<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<%@include file="../common/common.jsp" %>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a href="">联赛信息管理</a></li>
		<li>
			<a onclick="ListPage.form('/admin/league/leagueOpt?id=${league_id}','#leagueForm','/admin/league/saveLeague','${league_id}')" style="cursor: pointer;">
				<yt:id2NameDB beanId="leagueService" id="${league_id}"></yt:id2NameDB>
			</a>
		</li>
		<li><a href="">联赛图片视频管理</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header">
				<h2><i style="cursor: pointer;" title="刷新" onclick="ListPage.enter()" class="fa fa-refresh"></i><span class="break"></span></h2>
				<h2><a onclick="ListPage.form('${ctx}/admin/ivleague/formJsp','#ivleagueEditForm','${ctx}/admin/ivleague/saveOrUpdate')" style="cursor: pointer;">添加图片或视频</a><span class="break"></span></h2>
				<h2><a onclick="ListPage.enter({context:'#content',url:'${ctx}/admin/league/leagueOpt?id=${league_id}',searchForm:'#searchForm'});" style="cursor: pointer;">返回</a><span class="break"></span></h2>
			</div>
			<div class="box-content">
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm">
						<div class="dataTables_filter" id="DataTables_Table_0_filter">
							<label>标题: <input type="text" name="title" value="${params.title}"></label>
							<label>类型: 
								<select id="iv_type" name="type">
									<option value="">全部</option>	
									<option value="image">图片</option>	
									<option value="video">视频</option>	
								</select>
								<script type="text/javascript">$("#iv_type").val("${!empty params.type?params.type:''}");</script>
							</label>
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
				<table id="league_iv_table" class="table table-bordered table-striped table-condensed">
					  <thead>
						  <tr>
							  <th>图片视频ID</th>
							  <th>联赛</th>
							  <th>标题</th>
							  <th>赞</th>
							  <th>踩</th>
							  <th>点击量</th>
							  <th>展示</th>
							  <th>类型</th>
							  <th>操作</th>                                          
						  </tr>
					  </thead>   
					  <tbody>
					  	<c:forEach items="${page.items}" var="iv">
						<tr>
							<td>${iv.id}</td>
							<td>${iv.name}</td>
							<td>${iv.title}</td>
							<td>${iv.praise_count}</td>
							<td>${iv.unpraise_count}</td>
							<td>${iv.click_count}</td>
							<td>
							<div style="width: 60px;height: 60px;cursor: pointer;">
							<c:if test="${iv.type=='image'}">
							<img src="${el:filePath(iv.f_src,iv.to_oss)}" onclick="showImage(this)"/>
							</c:if>
							<c:if test="${iv.type=='video'}">
							<img src="${el:filePath(iv.v_cover,iv.to_oss)}" onclick="showVideo('${el:filePath(iv.f_src,iv.to_oss)}')" title="点击播放"/>
							</c:if>
							</div>
							</td>
							<td>
								<c:if test="${iv.type=='image'}">图片</c:if>
								<c:if test="${iv.type=='video'}">视频</c:if>
							</td>
							<td>
								<a class="btn btn-info" title="修改" onclick="ListPage.form('${ctx}/admin/ivleague/formJsp?type=${iv.type}','#ivleagueEditForm','${ctx}/admin/ivleague/saveOrUpdate','${iv.id}')">
									<i class="fa fa-edit "> 编辑</i>  
								</a>
								<a class="btn btn-danger" title="删除" onclick="ListPage.remove('${ctx}/admin/ivleague/delete?type=${iv.type}','${iv.id}')">
									<i class="fa fa-trash-o "> 删除</i> 
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
	fixImageWH("#league_iv_table");
})
</script>
