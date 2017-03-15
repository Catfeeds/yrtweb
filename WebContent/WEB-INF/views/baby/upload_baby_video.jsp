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
		<form id="up_file_form" action="${ctx}/baby/saveBabyImages">
		<input type="hidden" name="type" value="2"/>
		<input id="add_state" type="hidden" value="1"/>
        <div class="uppic_s">
            
        </div>
        </form>
        <div class="up_shuoming">
            <span id="restCountMsg" rest="0" class="pull-left ml15">
                <!-- 文件大小不能超过 30 M,单次上传可选5个视频上传(格式：asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv) -->
                视频不能超过30 M，一次只能上传 5 个视频，上传格式：asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv
            </span>
            <input type="button" id="up_save_image" value="保存上传" class="pull-right mr15 mt10" style="padding: 8px 16px; background: #01b6ed; border: none; cursor: pointer; color: white;" />
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

function create_uploadImg(){
	var uploadOpt = {
		uploaderType: "vdoUploader",
		itemWidth: 100,
		itemHeight: 100,
		fileNumLimit: 5,
		fileSingleSizeLimit: 30*1024*1024, /*1M*/
		fileVal: 'file',
		server: '${ctx}/imageVideo/uploadFile?filetype=babyvideo',
		toolbar:{
			del: true
		},
		showVideo:function(vhtml){
			window.parent.showVideo(vhtml);
		},
		addBefore:function(){
			$("#add_state").val(0);
		},
		afterRender:function(){
			$("#add_state").val(1);
		}
	}
	$('.uppic_s').fileUploader($.extend({},uploadOpt,{inputName:'baby_image'}));
}

function upFileHandler(data){
	if(data.state=='success'){
		layer.msg("上传成功",{icon: 1});
		window.parent.closeOpen("video");
	}else{
		layer.msg("请选择上传文件",{icon: 2});
	}
}

$(function(){
	create_uploadImg();
	$("#up_save_image").click(function () {
		if($("#add_state").val()==1){
			$.ajaxSubmit('#up_file_form','#up_file_form',upFileHandler)
		}else{
			layer.msg("请等待文件上传完毕",{icon: 0});
		}
	});
})

</script>
</body>
</html>
