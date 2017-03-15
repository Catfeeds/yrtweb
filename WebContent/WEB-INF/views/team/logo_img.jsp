<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
	<c:set var="filePath" value="${ctx}/upload" />
	<script type="text/javascript">
		var base = '${pageContext.request.contextPath}';
		var filePath = base+"/upload";
	</script>
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
    <link href="${ctx}/resources/layer/skin/layer.css" rel="stylesheet">
    <link href="${ctx}/resources/css/caijian/bootstrap.min.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/caijian/cropper.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/caijian/main.css" rel="stylesheet" />
</head>
<body>
        <div class="container" style="width: 640px;">
            <div class="edit_title">

                <p class="mt10 ml10 f18 ms">展现出LOGO的最佳形象</p>

                <div class="edit_z">

                    <p class="ml10 f12 fw">调整头像</p>
                    <p class="f12 ml10 text-santand w100">拖拽方框，更改头像位置和尺寸。</p>
                    <div class="pic_win">

                        <div onclick="up_new_imgage(this)" style="cursor: pointer;" class="img-container">
                            <img src="" alt="请上传图片" />
                        </div>
                    </div>
                    <div class="pic_preview" style="display: none;">
                        <div class="docs-preview clearfix">
                            <div class="img-preview preview-lg"></div>
                            <div class="img-preview preview-md"></div>
                            <div class="img-preview preview-sm"></div>
                        </div>
                    </div>
                    <div class="clearit"></div>
                </div>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-primary" data-method="reset" title="Reset">
                    <span class="docs-tooltip" data-toggle="tooltip">
                        <span class="fa fa-refresh">重置</span>
                    </span>
                </button>
                <label id="up_label" class="btn btn-primary btn-upload" for="inputImage" title="">
                    <input type="file" class="sr-only" onchange="changeHeadImg()" id="inputImage" name="file" accept="image/*">
                    <span class="docs-tooltip" data-toggle="tooltip" title="">
                        <span class="fa fa-upload">浏览</span>
                    </span>
                </label>
                <label class="btn btn-primary btn-upload" for="inputButton" title="">
                	<input type="hidden" id="head_img_temp" value=""/>
                    <input type="button" class="sr-only" onclick="save_head_img()" id="inputButton"/>
                    <span class="docs-tooltip" data-toggle="tooltip" title="">
                        <span class="fa fa-upload">确定</span>
                    </span>
                </label>
            </div>

            <div class="modal fade docs-cropped" id="getCroppedCanvasModal" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle" role="dialog" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="getCroppedCanvasTitle">图片结果</h4>
                        </div>
                        <div class="modal-body"></div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <a class="btn btn-primary" id="download" download="result.png" href="javascript:void(0);">下载</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>




        <script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
		<script src="${ctx}/resources/layer/layer.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/yt.ext.js"></script>
        <script src="${ctx}/resources/css/caijian/tooltip.min.js"></script>
        <script src="${ctx}/resources/css/caijian/bootstrap.min.js"></script>
        <script src="${ctx}/resources/css/caijian/cropper.js"></script>
        <script src="${ctx}/resources/css/caijian/cropper.main.js"></script>
        <script src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript">
function save_head_img(){
	var head_img = $("#head_img_temp").val();
	if(head_img){
		var data = $image.cropper("getData");
		$.ajaxSec({
			type:'POST',
			url: base+'/team/saveLogoImg',
			data: {head_img:head_img,x:data.x,y:data.y,width:data.width,height:data.height},
			cache: false,
			dataType:'json',
			success: function(result){
				if(result.state=='success'){
					window.parent.closeIframe(result.data.filename);
				}else{
					layer.msg(data.message.error[0],{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}else{
		layer.msg("请先上传头像",{icon: 2});
	}
}

function up_new_imgage(dom){
	var src = $(dom).find("img").attr("src");
	if(!src){
		$("#up_label").trigger("click");
	}
}
</script>
</body>
</html>
