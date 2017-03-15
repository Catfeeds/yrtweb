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
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/webuploader/webuploader.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/webuploader/image-upload/style.css">
  	<script type="text/javascript">
	var base = '${ctx}';
	var filePath = base+"/upload";
	</script>
</head>
<body>
<div id="wrapper">
    <div id="container">
        <!--头部，相册选择和格式选择-->
        <div id="uploader">
            <div class="queueList">
                <div id="dndArea" class="placeholder">
                    <div id="filePicker"></div>
                    <p>可以多选图片，单次上传最多可选10张</p>
                </div>
            </div>
            <div class="statusBar" style="display:none;">
                <div class="progress">
                    <span class="text">0%</span>
                    <span class="percentage"></span>
                </div><div class="info"></div>
                <div class="btns">
                    <div id="filePicker2"></div><div class="uploadBtn">保存上传图片</div>
                </div>
            </div>
        </div>
    </div>
</div>
<form id="baby_img_form" action="${ctx}/imageVideo/saveImgOrVideos" method="post">
<input type="hidden" name="role_type" value="${role_type}"/>
<input type="hidden" name="type" value="image"/>
</form>
<script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript" src="${ctx}/resources/webuploader/webuploader.js"></script>
<script type="text/javascript" src="${ctx}/resources/webuploader/image-upload/upload.js"></script>
<script src="${ctx}/resources/layer/layer.js"></script>
  <script src="${ctx}/resources/js/base.js"></script>
  <script src="${ctx}/resources/js/validation.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/yt.ext.js"></script>
<script type="text/javascript">
function reloadBabyImgs(data){
	if(data.state=='success'){
		layer.msg("上传成功",{icon: 1});
	}else{
		layer.msg("上传失败",{icon: 2});
	}
	window.parent.closePOpen();
}
</script>
</body>
</html>
