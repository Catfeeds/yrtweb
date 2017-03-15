<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑联赛图片视频</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="ivleagueEditForm" method="post" class="form-horizontal">
			<input type="hidden" id="iv_id" name="id" value="${ivleagues.id}"/>
			<input type="hidden" id="role_type" name="role_type" value="LEAGUE"/>
			<input type="hidden" name="v_cover" id="v_cover" value="${ivleagues.v_cover}"/>
			<input type="hidden" name="click_count" value="${ivleagues.click_count}"/>
			<input type="hidden" name="praise_count" value="${ivleagues.praise_count}"/>
			<input type="hidden" name="unpraise_count" value="${ivleagues.unpraise_count}"/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">上传类型</span>
					<input <c:if test="${!empty ivleagues.id}">disabled="disabled"</c:if> style="width: 20px;" value="image" onchange="change_type('image')" type="radio" name="type" <c:if test="${ivleagues.type=='image'|| (empty ivleagues.type)}">checked="checked"</c:if> class="form-control">图片
					<input <c:if test="${!empty ivleagues.id}">disabled="disabled"</c:if>style="width: 20px;" value="video" onchange="change_type('video')" type="radio" name="type" <c:if test="${ivleagues.type=='video'}">checked="checked"</c:if> class="form-control">视频
				</div>	
			</div>	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">联&emsp;&emsp;赛</span>
					<select class="form-control" id="league_sel" name="user_id" valid="require">
						<c:forEach items="${leagues}" var="lg">
						<option value="${lg.id}">${lg.name}</option>
						</c:forEach>
					</select>
					<script type="text/javascript">$("#league_sel").val('${ivleagues.user_id}')</script>
				</div>	
			</div>
			<!-- <div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">分&emsp;&emsp;组</span>
					<select class="form-control" id="group_sel" name="group_id"  valid="require">
						<option value=""></option>
					</select>
				</div>	
			</div> -->
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">标&emsp;&emsp;题</span>
					<input type="text" name="title" value="${ivleagues.title}" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span id="upload_msg" class="input-group-addon">上传图片</span>
					<div id="img_video_src" valid="requireUpload">
                 		<c:if test="${!empty ivleagues.f_src}">
	               			<div class="fileUploader-item">
	               				<c:choose>
		               				<c:when test="${ivleagues.type eq 'video'}">
	               				<img src="${el:filePath(ivleagues.v_cover,ivleagues.to_oss)}">
		               				</c:when>
		               				<c:otherwise>
	               				<img src="${el:filePath(ivleagues.f_src,ivleagues.to_oss)}">
		               				</c:otherwise>
	               				</c:choose>
	                  			<input type="hidden" name="images" value="${ivleagues.f_src}">
	               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">首页展示</span>
					<input style="width: 20px;" value="1" type="radio" name="if_show" <c:if test="${ivleagues.if_show==1}">checked="checked"</c:if> class="form-control">展示
					<input style="width: 20px;" value="0" type="radio" name="if_show" <c:if test="${ivleagues.if_show==0 || (empty ivleagues.if_show)}">checked="checked"</c:if> class="form-control">不展示
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否可用</span>
					<input style="width: 20px;" value="1" type="radio" name="f_status" <c:if test="${ivleagues.f_status==1 || (empty ivleagues.f_status)}">checked="checked"</c:if> class="form-control">是
					<input style="width: 20px;" value="0" type="radio" name="f_status" <c:if test="${ivleagues.f_status!=1 && (!empty ivleagues.f_status)}">checked="checked"</c:if> class="form-control">否
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4" style="width: 60%;">
					<span class="input-group-addon">描&emsp;&emsp;述</span>
					<textarea name="describle" style="width:51%;height:100px">${ivleagues.describle}</textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-8">
					<span class="input-group-addon">俱乐&emsp;部</span>
					<input type="hidden" id="teaminfo_ids" name=teamIds value="${tids}"/>
					<input type="text" id="teaminfo_names" value="${tnames}" class="form-control" style="width: 87%;">
					<a class="btn btn-primary" onclick="select_team_info()">选择</a>
					<a class="btn" onclick="clear_team_info()">重置</a>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否发送给俱乐部</span>
					<input style="width: 20px;" value="0" type="radio" name="if_send" <c:if test="${empty ivleagues.if_send || ivleagues.if_send=='0'}">checked="checked"</c:if> class="form-control">否
					<input style="width: 20px;" value="1" type="radio" name="if_send" <c:if test="${ivleagues.if_send=='1'}">checked="checked"</c:if> class="form-control">是
				</div>
			</div>
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submitByMore()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
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
<script src="${ctx }/resources/fileupload/webuploader/webuploader.js"></script>
<script src="${ctx }/resources/fileupload/fileUploader.js"></script>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	change_type('${ivleagues.type}',true);
})
function change_type(val,flag){
	if(!flag){
		$("#img_video_src").empty().attr("cs-data-uid","");
	}
	var num = 10;
	if($("#iv_id").val()){
		num = 1;
	}
	if(val=='video'){
		$("#upload_msg").text("上传视频");
		create_upload_video(num);
	}else{
		$("#upload_msg").text("上传图片");
		create_upload_img(num);
	}
}

function create_upload_img(num){
	var uploadeOptsImg = {
		uploaderType: 'imgUploader',
		itemWidth: 80,
		itemHeight: 80,
		fileNumLimit: num,
		fileSingleSizeLimit: 2*1024*1024, /*1M*/
		fileVal: 'file',
		multiple:true,
		server: base+'/imageVideo/uploadFile?filetype=league_picture',
		toolbar:{
			del: true
		}
	};
	$('#img_video_src').fileUploader($.extend({},uploadeOptsImg,{inputName:'images'}));
}
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
function create_upload_video(num){
	var uploadeOptsImg = {
		uploaderType: 'vdoUploader',
		itemWidth: 80,
		itemHeight: 80,
		fileNumLimit: num,
		fileSingleSizeLimit: 500*1024*1024, /*1M*/
		fileVal: 'file',
		server: base+'/imageVideo/uploadFile?filetype=league_video',
		toolbar:{del: true},
		checkVideo:true,
		showVideo:function(src){
			var flashvars = {
		        f: src.substring(0,src.lastIndexOf('.'))+".flv",
		        c: 0,
		        b: 1
		    };
		    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1', 'ckplayer_a1', '600', '400', false, flashvars);
		  	$(".masker").height($(document).height()).fadeIn();
			$(".masker").show();
			$('#showVideo').center().show();
		},
		afterRender:function(data){
			$("#v_cover").val(data.src.substring(0,data.src.lastIndexOf('.'))+".jpg");
		}
	};
	$('#img_video_src').fileUploader($.extend({},uploadeOptsImg,{inputName:'images'}));
}

function query_groups(dom,gid){
	$.ajaxSec({
		type: 'POST',
		url: base+'/admin/leagueGroup/queryGroupByLid',
		data: {lid: $(dom).val()},
		success: function(data){
			if(data.data.groups&&data.data.groups.length>0){
				$("#group_sel").empty();
				for(i in data.data.groups){
					if(gid&&gid==data.data.groups[i].id){
						$("#group_sel").append('<option selected="selected" value="'+data.data.groups[i].id+'">'+data.data.groups[i].name+'</option>');
					}else{
						$("#group_sel").append('<option value="'+data.data.groups[i].id+'">'+data.data.groups[i].name+'</option>');
					}
				}
			}else{
				$("#group_sel").empty().append('<option value=""></option>');
			}
		},
		error: $.ajaxError
	});
}

var iframeTeamInfo;
function select_team_info(){
	iframeTeamInfo = layer.open({
	    type: 2,
	    title: '选择俱乐部',
	    shadeClose: true,
	    shade: [0],
	    area: ['1330px', '640px'],
	    content: base+'/admin/ivleague/dialog' //iframe的url
	}); 
}

function changeTeam(tids,tnames){
	layer.close(iframeTeamInfo);
	var ids = $("#teaminfo_ids").val();
	ids = ids?ids+","+tids:tids;
	var names = $("#teaminfo_names").val();
	names = names?names+","+tnames:tnames;
	$("#teaminfo_ids").val(uniqueArray(ids.split(",")));
	$("#teaminfo_names").val(uniqueArray(names.split(",")));
}

function uniqueArray(arr){
	temp = new Array();
	for(var i=0;i<arr.length;i++){
		if(!contains(temp,arr[i])){
			temp.length+=1;
			temp[temp.length-1]=arr[i];
		}
	}
	return temp.join(",");
}

function contains(a,e){
	for(var j=0;j<a.length;j++){
		if(a[j]==e){
			return true;
		}
	}
	return false;
}

function clear_team_info(){
	$("#teaminfo_ids").val('');
	$("#teaminfo_names").val('');
}



</script>
