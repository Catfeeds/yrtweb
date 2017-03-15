<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-俱乐部相册</title>
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link href="${ctx}/resources/css/photoAlbum.css" rel="stylesheet" />
</head>
<c:set var="currentPage" value="TEAMDETAIL"/>
<body>
	<div class="warp">
		<div class="masker"></div>
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <!--导航-->
        <div class="wrapper" style="margin-top: 116px;">
            <div class="photos mt20" style="">
                <div class="p_title">
                    <span class="f14 ml20 ms text-white fw">俱乐部相册</span>
                </div>
                <div class="photo">
                	<form id="pictureForm" action="${ctx}/imageVideo/saveTeamImgOrVideos">
                	<input type="hidden" id="team_id" name="team_id" value="${team_id}"/>
                	<input type="hidden" name="role_type" value="${role_type}"/>
                	<input type="hidden" name="type" value="image"/>
                    <div id="picture">
                    </div>
                    </form>
                    <span class="pull-left ml30 mt10 text-white" rest="0" id="restCountMsg" style="display: none;"></span>
                    <span class="pull-left ml10 mt10" id="ti_shi_msg" style="color: red;display: none;">（文件大小不能超过 2 M，上传格式：jpg,jpeg,png,gif）</span>
                    <div class="clearit"></div>
                    <dl data-id="isme" class="mt20 ml75 pull-left">
                        <dt></dt>
                        <dd id="click_btn" class="mt20">
                            <input type="button" flag="0" value="上传照片" class="uppicbtn" onclick="openUpTImgs('image')" />
                            <input type="button" flag="0" value="在俱乐部展示" class="guanlibtn" />
                        </dd>
                    </dl>
                    <div class="clearit"></div>
                    <!-- 照册内容栏 -->
                    <div class="photo_cont clearfix" id="JS_photo">
                        <div id="photo_list" class="photo_div" style="margin-left: 80px;">
                            <div id="photo_model" class="item">
                                <div class="item_img">
                                    <div data-tool class="tools" style="display: none;">
                                        <label class="pull-left ml10 zhanshi"><input type="checkbox" data-id="show_center" onchange="show_center(this,'{{id}}')" name="show_center" value="1" class="" /><span class="text-white f12">展示</span> </label>
                                        <span title="删除" data-btn onclick="deleteFile('${ctx}/imageVideo/removeFile','{{id}}')" class="yt_removeer"></span>
                                        <div class="clearit"></div>
                                    </div>
                                    <a style="cursor: pointer;"><img data-id="f_src" layer-type="image" layer-pid="{{id}}" layer-src="${filePath}/{{f_src}}" alt="" num="" src="${filePath}/{{f_src}}"></a>
                                </div>
                            </div>
                            <div class="clearit"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
<script type="text/javascript">
var imgnum = 0;
var t_isme = 0;
var photoList = new List({
	url:base+'/team/queryTeamImages',
	sendData:{
		currentPage:1,
		pageSize : 8,
		team_id : $("#team_id").val(),
		type:'image'
    },
   	listDataModel:$('#photo_model').get(0).outerHTML,
   	listContainer:'#photo_list',
   	dynamicVMHandler:function(one){
   		var vm = $(photoList.options.listDataModel);
   		vm.css('display','block');
   		if(one.if_show=="1"){
   			vm.find('[data-id=show_center]').attr("checked","checked");
   		}
   		imgnum++;
   		vm.find("[data-id=f_src]").attr("num",imgnum);
   		if(one.to_oss == 1){
   			vm.find("[data-id=f_src]").attr("layer-src",ossPath+one.f_src).attr("src",ossPath+one.f_src);
   		}
   		return vm.get(0).outerHTML;
   	},
   	afterRenderList:function(c,v,data){
   		imgnum = 0;
   		$('#photo_list').append('<div class="clearit"></div>');
   		$("#JS_photo").find("[data-id=totalpage]").addClass("text-white");
   		if(!t_isme){
   			$('.photo').find('[data-id=isme]').remove();
			$('.photo').find('[data-tool]').remove();
   		}else{
   			$('.photo').find('[data-tool]').show();
   		}
   		layer.ready(function(){
   			layer.photos({
   	            photos: '#photo_list'
   	        });
	    });
   	}
});

function load_photo_list(){
	photoList.loadListData().done(function(data){
		t_isme = data.data.isme;
		if(data.state=='success'&&data.data.page.items.length>0){
			photoList.iniPageControl(data.data.page);
			photoList.renderList(data.data.page.items,'reloade_resetScroll');
		}else{
			$('#photo_list').empty().append('<span class="text-white">没有上传图片</span>');
		}
		if(!data.data.isme){
			$('.photo').find('[data-id=isme]').remove();
			$('.photo').find('[data-tool]').remove();
		}
	});
}

jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}

function create_uploadImg(num){
	var uploadeOpts1 = {
		uploaderType: 'imgUploader',
		itemWidth: 80,
		itemHeight: 80,
		fileNumLimit: num,
		fileSingleSizeLimit: 2*1024*1024, /*1M*/
		fileVal: 'file',
		server: '${ctx}/imageVideo/uploadFile?filetype=picture',
		toolbar:{del: true},
		afterRender:function(){
			var count = $("#restCountMsg").attr("rest");
			$("#restCountMsg").text("您现在还可上传 "+(parseInt(count)-1)+" 张照片，是否需要购买展示包");
			$("#restCountMsg").attr("rest",(parseInt(count)-1));
		},
		afterDelete:function(){
			var count = $("#restCountMsg").attr("rest");
			$("#restCountMsg").text("您现在还可上传 "+(parseInt(count)+1)+" 张照片，是否需要购买展示包");
			$("#restCountMsg").attr("rest",(parseInt(count)+1));
		}
	}
	$('#picture').fileUploader($.extend({},uploadeOpts1,{inputName:'images'}));
}


function search_rest_count(){
	$.ajaxSec({
		type: 'POST',
		url: base+'/imageVideoTeam/restCount',
		data: {team_id : $("#team_id").val(),type: "image"},
		success: function(data){
			if(data.state == 'success'){
				var restCount = parseInt(data.data.data.restCount)>0?data.data.data.restCount:0;
				create_uploadImg(restCount);
				$("#restCountMsg").attr("rest",restCount);
				$("#restCountMsg").text("您现在还可上传 "+restCount+" 张照片，是否需要购买展示包");
			}else{
				layer.msg("操作失败",{icon: 2});
			}
		},
		error: $.ajaxError
	});
}


$(function(){
	load_photo_list();
	$(".mybox").center().hide();
	$(".masker").height($(document).height());
	$(".closebtn").click(function () {
	    hidephoto();
	});
	$(".masker").click(function () {
	    hidephoto();
	});
	$(".guanlibtn").click(function () {
		var flag = $(this).attr("flag");
		var flagu = $('.uppicbtn').attr("flag");
		if(flagu=="1"){
			layer.msg('请先保存当前上传图片',{icon: 2});
			return;
		}
		if(flag=="1"){
			$(".guanlibtn").val("在俱乐部展示");
	     $(".item_img .tools").find(".zhanshi").hide();
	     $(this).attr("flag","0");
	     load_photo_list();
		}else{
	     $(".guanlibtn").val("保存");
	     $(".item_img .tools").find(".zhanshi").show();
	     $(this).attr("flag","1");
		}
	});
	layer.config({
	    extend: '/extend/layer.ext.js'
	});
})

function cancel_photo(){
	$('.guanlibtn').attr("flag","0");
	$('.uppicbtn').attr("flag","0");
	$(".uppicbtn").val("上传照片");
	$("#picture").hide();
	$("#restCountMsg").hide();
	$("#ti_shi_msg").hide();
	$("#picture").empty().attr("cs-data-uid","");
	$(".cancel_photo").remove();
}

function resHandler(data){
	if(data.state=='success'){
		$(".uppicbtn").val("上传照片");
		$(".uppicbtn").attr("flag","0");
		$("#picture").hide();
		$("#restCountMsg").hide();
		$("#ti_shi_msg").hide();
		$("#picture").html("");
		$("#picture").removeAttr("cs-data-uid");
		load_photo_list();
		layer.msg('上传成功',{icon: 1});
		
		$(".cancel_photo").remove();
	}else{
		layer.msg('上传失败,请添加图片',{icon: 2});
	}
}

function show_center(dom,id){
	var state = dom.checked?"sure":"cancel";
	$.ajaxSec({
		type: 'POST',
		url: base+'/team/showCenter',
		data: {id: id,team_id : $("#team_id").val(),type: "image",state:state},
		success: function(data){
			if(data.state != 'success'){
				layer.msg(data.data.errorMsg,{icon: 2});
				if(dom.checked){
					$(dom).removeAttr("checked");
				}
			}
		},
		error: $.ajaxError
	});
}

function deleteFile(url,id){
	yrt.confirm('确定要删除这张图片吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: true 
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: id,type:"image"},
			success: function(result){
				if(result.state=='success'){
					yrt.msg("删除成功",{icon: 1});
					load_photo_list();
				}else{
					yrt.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

var iframeTImages;
function openUpTImgs(type){
	$.ajaxSec({
		type: 'POST',
		url: base+'/team/secTeam',
		success: function(data){
			var msg = type=="image"?"图片":"视频";
			iframeTImages = layer.open({
			    type: 2,
			    title: '上传'+msg,
			    shadeClose:true,
			    shade: [0.6],
			    zIndex:5,
			    area: ['704px', '240px'],
			    content: base+'/common/uploadHtml?type='+type+'&role_type=TEAM' //iframe的url
			}); 
		},
		error: $.ajaxError
	});
}
function closePOpen(fileType){
	layer.close(iframeTImages);
	load_photo_list();
}

</script>
</body>
</html>