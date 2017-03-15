<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-俱乐部视频</title>
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link href="${ctx}/resources/css/photoAlbum.css" rel="stylesheet" />
<style type="text/css">
#picture {
    width: 900px;
    padding: 15px;
    border: 1px solid rgb(229, 229, 229);
    float: left;
    margin-top: 20px;
    margin-left: 30px;
    display: none;
}
</style>
</head>
<c:set var="currentPage" value="CENTER"/>
<body>
	<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <!--导航-->
        <div class="wrapper" style="margin-top: 116px;">
            <div class="photos mt20" style="">
                <div class="p_title">
                    <span class="f14 ml20 ms text-white fw">俱乐部视频</span>
                </div>
                <div class="photo">
                	<form id="pictureForm" action="${ctx}/imageVideoTeam/saveImgOrVideos">
                	<input type="hidden" id="team_id" name="team_id" value="${team_id}"/>
                	<input type="hidden" name="type" value="2"/>
                    <div id="picture">
                    </div>
                    </form>
                    <span class="pull-left ml30 mt10 text-white" rest="0" id="restCountMsg" style="display: none;"></span>
                    <span class="pull-left ml10 mt10" id="ti_shi_msg" style="color: red;display: none;">（文件大小不能超过 20 M，上传格式：asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv）</span>
                    <div class="clearit"></div>
                    <dl data-id="isme" class="mt20 ml75 pull-left">
                        <dt></dt>
                        <dd id="click_btn" class="mt20">
                            <input type="button" flag="0" value="上传视频" class="uppicbtn" />
                            <input type="button" flag="0" value="在俱乐部展示" class="guanlibtn" />
                        </dd>
                    </dl>
                    <div class="clearit"></div>
                    <!-- 照册内容栏 -->
                    <div class="photo_cont clearfix" id="JS_photo">
                        <div id="photo_list" class="photo_div" style="margin-left: 80px;">
                            <div id="photo_model" class="item">
                                <div class="item_img">
                                    <div data-tool class="tools">
                                        <label class="pull-left ml10 zhanshi"><input type="checkbox" data-id="show_center" onchange="show_center(this,'{{id}}')" name="show_center" value="1" class="" /><span class="text-white f12">展示</span> </label>
                                        <span title="删除" onclick="deleteFile('${ctx}/imageVideoTeam/removeFile','{{id}}')" class="yt_removeer"></span>
                                        <div class="clearit"></div>
                                    </div>
                                    <a style="cursor: pointer;">
                                    <a class="video" onclick="createVideo('{{src}}','{{create_time}}')"></a>
                                    <img onclick="createVideo('{{src}}','{{create_time}}')" data-id="src" src="">
                                    </a>
                                </div>
                            </div>
                            <div class="clearit"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">

function appendPicBox(imgs){
	var picBox = $("#picBox").find("ul").empty();
	var listBox = $("#listBox").find("ul").empty();
	for(var i in imgs){
		var html = '<li>';
		html+=('<a href="#" target="_blank"><img src="'+filePath+'/'+imgs[i].src+'" alt="" /></a>')
		html+='</li>';
		picBox.append(html);
		
		var listHtml = '<li><img width="118" height="64" src="'+filePath+'/'+imgs[i].src+'" alt="" /></li>';
		listBox.append(html);
	}
	picBox.append('<div class="clearit"></div>');
	listBox.append('<div class="clearit"></div>');
}

var photoList = new List({
	url:base+'/imageVideoTeam/images',
	sendData:{
		currentPage:1,
		pageSize : 8,
		team_id : $("#team_id").val(),
		type : 2
    },
   	listDataModel:$('#photo_model').get(0).outerHTML,
   	listContainer:'#photo_list',
   	dynamicVMHandler:function(one){
   		var vm = $(photoList.options.listDataModel);
   		vm.css('display','block');
   		if(one.if_show=="1"){
   			vm.find('[data-id=show_center]').attr("checked","checked");
   		}
   		if(one.src){
   			var t_src = one.src.substring(0,one.src.lastIndexOf("."))+".jpg";
   			vm.find('[data-id=src]').attr("src",filePath+'/'+t_src);
   		}
   		return vm.get(0).outerHTML;
   	},
   	afterRenderList:function(c,v,data){
   		$('#photo_list').append('<div class="clearit"></div>');
   		appendPicBox(data);
   	}
});

function load_photo_list(){
	photoList.loadListData().done(function(data){
		if(data.state=='success'&&data.data.page.items.length>0){
			photoList.iniPageControl(data.data.page);
			photoList.renderList(data.data.page.items,'reloade_resetScroll');
		}else{
			$('#photo_list').empty().append('<span class="text-white">没有上传视频</span>');
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

function create_uploadVdo(num){
	var uploadeOpts1 = {
		uploaderType: 'vdoUploader',
		showVideo:function(){},
		itemWidth: 80,
		itemHeight: 80,
		fileNumLimit: num,
		fileSingleSizeLimit: 20*1024*1024, /*1M*/
		fileVal: 'file',
		server: '${ctx}/imageVideo/uploadFile?filetype=video',
		toolbar:{del: true},
		afterRender:function(){
			var count = $("#restCountMsg").attr("rest");
			$("#restCountMsg").text("您现在还可上传 "+(parseInt(count)-1)+" 个视频，是否需要购买展示包");
			$("#restCountMsg").attr("rest",(parseInt(count)-1));
		},
		afterDelete:function(){
			var count = $("#restCountMsg").attr("rest");
			$("#restCountMsg").text("您现在还可上传 "+(parseInt(count)+1)+" 个视频，是否需要购买展示包");
			$("#restCountMsg").attr("rest",(parseInt(count)+1));
		}
	}
	$('#picture').fileUploader($.extend({},uploadeOpts1,{inputName:'images'}));
}


function search_rest_count(){
	$.ajaxSec({
		type: 'POST',
		url: base+'/imageVideoTeam/restCount',
		data: {team_id : $("#team_id").val(),type: "video"},
		success: function(data){
			if(data.state == 'success'){
				var restCount = parseInt(data.data.data.restCount)>0?data.data.data.restCount:0;
				create_uploadVdo(restCount);
				$("#restCountMsg").attr("rest",restCount);
				$("#restCountMsg").text("您现在还可上传 "+restCount+" 个视频，是否需要购买展示包");
			}else{
				layer.msg("操作失败",{icon: 2});
			}
		},
		error: $.ajaxError
	});
}


$(function(){
	load_photo_list();
	
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
	$(".uppicbtn").click(function () {
		var flag = $(this).attr("flag");
		if(flag=="1"){
			$.ajaxSubmit('#pictureForm','#pictureForm',resHandler)
			
		}else{
			$("#click_btn").prepend('<input type="button" onclick="cancel_photo()" flag="0" value="取消" class="cancel_photo" />');
	    	$(".uppicbtn").val("保存");
	    	$(this).attr("flag","1");
	    	search_rest_count();
	    	$("#picture").show();
	    	$("#restCountMsg").show();
	    	$("#ti_shi_msg").show();
		}
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
		$(".uppicbtn").val("上传视频");
		$(".uppicbtn").attr("flag","0");
		$("#picture").hide();
		$("#restCountMsg").hide();
		$("#ti_shi_msg").hide();
		$("#picture").html("");
		$("#picture").removeAttr("cs-data-uid");
		load_photo_list();
		layer.msg('上传成功',{icon: 1});
		$(".cancel_photo").remove();
		layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
	}else{
		layer.msg('请选择上传文件或等待上传完毕',{icon: 2});
	}
}

function show_center(dom,id){
	var state = dom.checked?"sure":"cancel";
	$.ajaxSec({
		type: 'POST',
		url: base+'/imageVideoTeam/showCenter',
		data: {id: id,team_id : $("#team_id").val(),type: "2",state:state},
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
	layer.confirm('确定要删除这个视频吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: id,type:"video"},
			success: function(result){
				if(result.state=='success'){
					layer.msg("删除成功",{icon: 1});
					load_photo_list();
				}else{
					layer.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

function showVideo(video){
	
}
var btn = $("#playSWF");
btn.click(function () {
    $("#showvdo").html("");
    $(".login_masker").hide();
    $('#showVideo').hide();
});

function createVideo(video,ctime){
	if(check_create_time(ctime,15)){
		layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
		return;
	}
	var flashvars = {
        f: filePath+'/'+video,
        c: 0,
        b: 1
    };
    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1', 'ckplayer_a1', '600', '400', false, flashvars);
  	$(".login_masker").height($(document).height()).fadeIn();
	$(".login_masker").show();
	$('#showVideo').center().show();
}
</script>
</body>
</html>