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
            margin-left:15px;
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
        .fun_p_div {
            width: 100%;
            margin: 10px auto;
        }
    </style>
  	<script type="text/javascript">
	var base = '${ctx}';
	var filePath = base+"/upload";
	</script>
</head>
<body>
	<div class="updiv">
		<input id="add_state" type="hidden" value="1"/>
		<c:choose>
			<c:when test="${role_type=='TEAM'}">
			<form id="up_file_form" action="${ctx}/imageVideo/saveTeamImgOrVideos">
			</c:when>
			<c:otherwise>
			<form id="up_file_form" action="${ctx}/imageVideo/saveImgOrVideos">
			</c:otherwise>
		</c:choose>
		<input id="file_type" type="hidden" name="type" value="${type}"/>
		<input type="hidden" id="oth_user_id" value="${user_id}"/>
        <input type="hidden" id="up_role_type" name="role_type" value="${role_type}"/>
        <c:if test="${not empty role_name}">
        	<div class="fun_p_div">
	            <span class="sf ml15">当前身份：</span>
	            <span class="sf">${role_name}</span>
	        </div>
        </c:if>
        <c:if test="${not empty roles}">
        	<div class="fun_p_div">
	            <span class="sf ml15">选择身份：</span>
	            <select id="crole_type" class="select ml10" onchange="change_role_type(this)">
	            	<c:forEach items="${roles}" var="r" varStatus="status">
	                <option value="${r.role_str}">${r.role_name}</option>
	                </c:forEach>
	            </select>
	        </div>
        </c:if>
        <c:choose>
        	<c:when test="${type eq 'video'}">
        	<!-- <table class="the_info" style="margin-top: 20px;">
			    <tr>
			        <td class="w100" rowspan="4">
			            <span>视频标题：</span>
			            <span><input type="text" name="usernick" value="" valid="require" class="shuju" maxlength="15" /></span>
			        </td>
		        </tr>
	        </table> -->
	        
	        <div style="margin-top: 20px;margin-left: 15px;">
	         <span>视频标题：</span>
	         <span><input type="text" name="title" value="" valid="require" class="shuju" style="width: 120px;" maxlength="15" /></span>
	        </div>
        	<div class="uppic_s" style="height: 276px;">
        	</div>
        	</c:when>
        	<c:otherwise>
        	<div class="uppic_s">
        	</div>
        	</c:otherwise>
        </c:choose>
        </form>
        <div class="up_shuoming">
            <span id="restCountMsg" rest="0" class="pull-left ml15">
                您现在还可上传 2 张照片，是否需要购买展示包(一次最多只能上传 5 张图片)
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
var footMsg = "";
function search_rest_count(file_type){
	$.ajaxSec({
		type: 'POST',
		url: base+'/player/restCount',
		data: {type: file_type},
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
	var fpath = "${fpath}";
	var utype = file_type=="image"?"imgUploader":"vdoUploader";
	var stype = file_type=="image"?fpath+"_picture":fpath+"_video";
	var fsize = file_type=="image"?2*1024*1024:40*1024*1024;
	var iwh = file_type=="image"?100:200;
	num = file_type=="image"?num:1;
	var uploadOpt = {
		uploaderType: utype,
		itemWidth: iwh,
		itemHeight: iwh,
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
		addBefore:function(){
			$("#add_state").val(0);
		},
		afterRender:function(){
			$("#add_state").val(1);
		}
	}
	$('.uppic_s').fileUploader($.extend({},uploadOpt,{inputName:'images'}));
}

function upFileHandler(data){
	if(data.state=='success'){
		layer.msg("上传成功",{icon: 1});
		window.parent.closePOpen($("#file_type").val());
	}else{
		layer.msg("请选择上传文件",{icon: 2});
	}
}

function check_file_type(file_type){
	if("video"==file_type){
		$("#type").val("2");
		$("#up_save_image").val("保存上传视频");
		footMsg = "视频不能超过 40 M，一次只能上传 1 个视频，上传格式：asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv";
	}else{
		$("#type").val("1");
		$("#up_save_image").val("保存上传图片");
		footMsg = "图片不能超过 2 M，一次只能上传 5 个图片，上传格式：jpg,jpeg,png,gif";
	}
	$("#restCountMsg").text(footMsg);
	create_uploadImg(file_type,5)
	//search_rest_count(file_type);
}

function change_role_type(dom){
	if($(dom)&&$(dom).length>0){
		var rt = $(dom).val();
		$("#up_role_type").val(rt.substring(rt.indexOf("_")+1));
	}
}

$(function(){
	var file_type = $("#file_type").val();
	check_file_type(file_type);
	change_role_type("#crole_type");
	var rtype = $("#up_role_type").val();
	var curl = rtype=='TEAM'?base+'/team/secTeam':base+'/center/checkUserRole';
	$("#up_save_image").click(function () {
		if($("#add_state").val()==1){
			$.ajaxSec({
				type: 'POST',
				url: curl,
				data: {type: file_type},
				success: function(data){
					$.ajaxSubmit('#up_file_form','#up_file_form',upFileHandler)
				},
				error: $.ajaxError
			});
		}else{
			layer.msg("请等待文件上传完毕",{icon: 0});
		}
		
		//$.ajaxSubmit('#up_file_form','#up_file_form',upFileHandler)
	});
})

</script>
</body>
</html>
