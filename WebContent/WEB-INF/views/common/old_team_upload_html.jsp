<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <meta charset="utf-8" />
    <!--IE 浏览器运行最新的渲染模式下-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--国产浏览器高速模式-->
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
    <link href="${ctx}/resources/fileupload/fileUploader.css" rel="stylesheet" />
    <style>
        .updiv {
            position: relative;
            width: 700px;
            border: 1px solid #e5e5e5;
        }
        .uptitle span {
            font-size: 12px;
            font-weight: bold;
            margin-left: 10px;
        }
        .uppic_s {
            height: 120px;
            margin-top: 20px;
            margin-left:75px;
        }
        .uppic_s .uppic_s_list {
            float: left;
            width: 105px;
            margin-left: 30px;
            margin-top: 35px;
        }
        .uppic_s_list img {
            width: 105px;
            height: 115px;
        }
        .clearit {
            clear: both;
            height: 0;
            font-size: 0;
            overflow: hidden;
        }
        .up_shuoming {
            width: 100%;
            height: 50px;
            line-height: 50px;
            border-top: 1px solid #e5e5e5;
        }
        .ms {
            font-family: "Microsoft YaHei";
        }
    </style>
  	<script type="text/javascript">
	var base = '${ctx}';
	var filePath = base+"/upload";
	</script>
</head>
<body>
	<div class="updiv">
		<input id="file_type" type="hidden" value="${type}"/>
		<form id="up_file_form" action="${ctx}/imageVideoTeam/saveImgOrVideos">
		<input type="hidden" id="team_id" name="team_id" value="${team_id}"/>
        <input type="hidden" id="type" name="type" value="1"/>
        <div class="uppic_s">
            
        </div>
        </form>
        <div class="up_shuoming" style="line-height: normal;">
            <span id="restCountMsg" rest="0" class="pull-left ml15">
                您现在还可上传 2 张照片，是否需要购买展示包(一次最多只能上传 5 张图片)
            </span>
            <c:choose>
            	<c:when test="${type=='image'}">
            	<span class="pull-left ml10" style="color: red;">（文件大小不能超过 2 M，上传格式：jpg,jpeg,png,gif）</span>
            	</c:when>
            	<c:otherwise>
            <span class="pull-left ml10" style="color: red;">（文件大小不能超过 20 M，上传格式：asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv）</span>
            	</c:otherwise>
            </c:choose>
            <input type="button" id="up_save_image" value="保存上传" class="pull-right mr15 mt10" style="margin-top:-6px;padding: 8px 16px; background: #01b6ed; border: none; cursor: pointer; color: white;" />
        </div>
    </div>
<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
<script src="${ctx}/resources/layer/layer.js"></script>
<script src="${ctx}/resources/js/base.js"></script>
<script src="${ctx}/resources/js/validation.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/yt.ext.js"></script>
<script src="${ctx}/resources/fileupload/webuploader/webuploader.js"></script>
<script src="${ctx}/resources/fileupload/fileUploader.js"></script>
<script type="text/javascript">
var footMsg = "";
function search_rest_count(file_type){
	$.ajaxSec({
		type: 'POST',
		url: base+'/imageVideoTeam/restCount',
		data: {team_id : $("#team_id").val(),type: file_type},
		success: function(data){
			if(data.state == 'success'){
				var restCount = parseInt(data.data.data.restCount)>0?data.data.data.restCount:0;
				create_uploadImg(file_type,(restCount>5?5:restCount));
				$("#restCountMsg").attr("rest",restCount);
				$("#restCountMsg").text("您现在还可上传 "+restCount+footMsg);
			}else{
				layer.msg("操作失败",{icon: 2});
			}
		},
		error: $.ajaxError
	});
}

function create_uploadImg(file_type,num){
	var utype = file_type=="image"?"imgUploader":"vdoUploader";
	var stype = file_type=="image"?"picture":"video";
	var fsize = file_type=="image"?2*1024*1024:20*1024*1024;
	var uploadOpt = {
		uploaderType: utype,
		itemWidth: 100,
		itemHeight: 100,
		fileNumLimit: num,
		fileSingleSizeLimit: fsize, /*1M*/
		fileVal: 'file',
		server: '${ctx}/imageVideo/uploadFile?filetype='+stype,
		toolbar:{
			del: true
		},
		bindClickImage:function(obj){
			window.parent.showImage(obj);
		},
		showVideo:function(vhtml){
			window.parent.showVideo(vhtml);
		},
		afterRender:function(){
			var count = $("#restCountMsg").attr("rest");
			$("#restCountMsg").text("您现在还可上传 "+(parseInt(count)-1)+footMsg);
			$("#restCountMsg").attr("rest",(parseInt(count)-1));
		},
		afterDelete:function(){
			var count = $("#restCountMsg").attr("rest");
			$("#restCountMsg").text("您现在还可上传 "+(parseInt(count)+1)+footMsg);
			$("#restCountMsg").attr("rest",(parseInt(count)+1));
		}
	}
	$('.uppic_s').fileUploader($.extend({},uploadOpt,{inputName:'images'}));
}

function upFileHandler(data){
	if(data.state=='success'){
		layer.msg("上传成功",{icon: 1});
		window.parent.closeTOpen($("#file_type").val());
	}else{
		layer.msg("请选择上传文件或等待上传完毕",{icon: 2});
	}
}

function check_file_type(file_type){
	if("video"==file_type){
		$("#type").val("2");
		$("#up_save_image").val("保存上传视频");
		footMsg = " 个视频，是否需要购买展示包(一次最多只能上传 5 个视频)";
	}else{
		$("#type").val("1");
		$("#up_save_image").val("保存上传图片");
		footMsg = " 张照片，是否需要购买展示包(一次最多只能上传 5 张图片)";
	}
	search_rest_count(file_type);
}

$(function(){
	var file_type = $("#file_type").val();
	check_file_type(file_type);
	$("#up_save_image").click(function () {
		$.ajaxSec({
			type: 'POST',
			url: base+'/imageVideoTeam/restCount',
			data: {team_id : $("#team_id").val(),type: file_type},
			success: function(data){
				if(data.state == 'success'){
					var restCount = parseInt(data.data.data.restCount)>0?data.data.data.restCount:0;
					var inum = $(".uppic_s").find("input[name=images]").length;
					if(restCount>=inum){
						$.ajaxSubmit('#up_file_form','#up_file_form',upFileHandler)
					}else{
						var m = file_type=="image"?" 张图片":" 个视频";
						layer.msg("上传失败,您还能上传 "+restCount+m,{icon: 2});
					}
				}else{
					layer.msg("操作失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
		//$.ajaxSubmit('#up_file_form','#up_file_form',upFileHandler)
	});
})

</script>
</body>
</html>
