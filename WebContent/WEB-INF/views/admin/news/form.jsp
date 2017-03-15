<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />
<link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet"/>
<div>
	<hr>
	<ul class="breadcrumb">
		<li><a>联赛信息管理</a></li>
		<li><a>编辑新闻</a></li>
	</ul>
	<hr>
</div>
<div class="row">	
	<div class="col-lg-12">
		<div class="box">
			<form id="newsEditForm" method="post" class="form-horizontal">
			<input type="hidden" name="id" value="${news.id}"/>
			<input type="hidden" name="n_state" value="${news.n_state}"/>
			<fieldset class="col-sm-12">
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">类&emsp;&emsp;型</span>
					<input style="width: 20px;" value="1" type="radio" name="type" <c:if test="${news.type==1|| (empty news.type)}">checked="checked"</c:if> class="form-control">新闻
					<input style="width: 20px;" value="2" type="radio" name="type" <c:if test="${news.type==2}">checked="checked"</c:if> class="form-control">公告
					
				</div>	
			</div>		
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">标&emsp;&emsp;题</span>
					<input type="text" name="title" value="${news.title}" valid="require len(1,200)" class="form-control">
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">封&emsp;&emsp;面</span>
					<div id="index_img_src">
                 		<c:if test="${!empty news.cover_img}">
               			<div class="fileUploader-item">
                  			<img src="${el:headPath()}${news.cover_img}">
                  			<input type="hidden" name="cover_img" value="${news.cover_img}">
               			</div>
             			</c:if>
                   	</div>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">是否突出</span>
					<select class="form-control" id="is_special" name="is_special" >
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
					<script type="text/javascript">$("#is_special").val('${empty news.is_special?0:news.is_special}')</script>
				</div>	
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">排&emsp;&emsp;序</span>
					<input type="text" name="show_num" value="${empty news.show_num?0:news.show_num}" valid="require number" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4" style="width: 60%;">
					<span class="input-group-addon">内&emsp;&emsp;容</span>
					<textarea id="news_content" name="content" style="width:100%;height:200px">${news.content}</textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">内容是否有图片或视频</span>
					<input style="width: 20px;" value="0" type="radio" name="hava_iv" <c:if test="${news.hava_iv==0|| (empty news.hava_iv)}">checked="checked"</c:if> class="form-control">没有
					<input style="width: 20px;" value="1" type="radio" name="hava_iv" <c:if test="${news.hava_iv==1}">checked="checked"</c:if> class="form-control">有
					
				</div>	
			</div>	
			<div class="form-group">
				<div class="input-group date col-sm-4">
					<span class="input-group-addon">关联联赛</span>
					<select class="form-control" name="model_id">
						<option value="">请选择</option>
						<c:forEach items="${leagueList}" var="league">
							<option value="${league.id}" <c:if test="${league.id eq news.model_id}">selected</c:if>>${league.name}</option>
						</c:forEach>
					</select>
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
			<div class="form-actions">
			<a class="btn btn-primary" onclick="ListPage.submit()">保存</a>
			<a class="btn" onclick="ListPage.paginate()">返回</a>
			</div>
			</fieldset>
			</form>
		</div>
	</div><!--/col-->
</div><!--/row-->
<script src="${ctx }/resources/fileupload/webuploader/webuploader.js"></script>
<script src="${ctx }/resources/fileupload/fileUploader.js"></script>
<script type="text/javascript">
if(ue){
	ue.destroy();
}
var ue = UE.getEditor('news_content');
var uploadeOptsIndex = {
	uploaderType: 'imgUploader',
	itemWidth: 80,
	itemHeight: 80,
	fileNumLimit: 1,
	fileSingleSizeLimit: 2*1024*1024, /*1M*/
	fileVal: 'file',
	server: base+'/imageVideo/uploadFile?filetype=index_picture',
	toolbar:{
		del: true
	}
};
$('#index_img_src').fileUploader($.extend({},uploadeOptsIndex,{inputName:'cover_img'}));

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