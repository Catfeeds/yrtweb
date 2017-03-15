<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传</title>
<link href="${ctx}/resources/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx}/resources/css/style.css" type="text/css" rel="stylesheet">
<script src="${ctx}/resources/js/ajaxfileupload.js"= type="text/javascript"></script>
<script src="${ctx}/resources/js/yt.fileupload.js" type="text/javascript"></script>
</head>
<body>
	<div>
		<div>
			<a href="#" onclick="showCont('video')" class="update" id="upload_video_button">上传视频</a>
			<a href="#" onclick="showCont('picture')" id="upload_img_button">上传图片</a>
		</div>

		<div class="yxbox">
			<h2>
				<a href="#" class="fr" onclick="closeCont();">关闭</a>上传文件
			</h2>
			<div class="pd15">
				<form name="uploadForm" id="upload_form" action="#" method="post"
					enctype="multipart/form-data">
					<p class="mb20">
						<input type="file" name="file" id="fileToUpload" title="请选择要上传的文件"
							onchange="fSubmit();">
					</p>
					<div class="br" style="display: none;" id="progress_all">
						<ul>
							<li>
								<div class="process clearfix" id="process">
									<span class="progress-box"> <span class="progress-bar"
										style="width: 0%;" id="progress_bar"></span>
									</span> <span id="progress_percent">0%</span>
								</div>
								<div class="info" id="info">
									已上传：<span id="has_upload">0</span>MB 速度：<span id="upload_speed">0</span>KB/s
								</div>
								<div class="info" id="success_info" style="display: none;">
									<input id="suc_file" type="text" disabled="disabled"/>
									<a href="#" onclick="deleteFile()">删除</a>
								</div>
							</li>
						</ul>
					</div>
				</form>
			</div>
		</div>
		<div id="TB_overlayBG">&nbsp;</div>
</body>
</html>