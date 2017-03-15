<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-球员视频</title>
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link href="${ctx}/resources/css/photoAlbum.css" rel="stylesheet" />
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
</head>
<c:set var="currentPage" value="CENTER"/>
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
                    <span class="f14 ml20 ms text-white fw">球员视频</span>
                    <input type="hidden" id="oth_user_id" value="${oth_user_id}"/>
                </div>
                <div class="photo">
                	<form id="pictureForm" action="${ctx}/imageVideo/saveImgOrVideos">
                	<input type="hidden" name="role_type" value="${role_type}"/>
                	<input type="hidden" name="type" value="videor"/>
                    <div id="picture">
                    </div>
                    </form>
                    <span class="pull-left ml30 mt10 text-white" rest="0" id="restCountMsg" style="display: none;"></span>
                    <span class="pull-left ml10 mt10" id="ti_shi_msg" style="color: red;display: none;">（文件大小不能超过 20 M，上传格式：asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv）</span>
                    <div class="clearit"></div>
                    <dl data-id="isme" class="mt20 ml30 pull-left">
                        <dt></dt>
                        <dd id="click_btn" class="mt20">
                            <input type="button" flag="0" value="上传视频" class="uppicbtn" onclick="openUpPImgs('video')"/>
                            <input type="button" flag="0" value="在个人中心展示" class="guanlibtn" />
                        </dd>
                    </dl>
                    <div class="clearit"></div>
                    <!-- 照册内容栏 -->
                    <div class="photo_cont clearfix" id="JS_photo">
                        <div id="photo_list" class="photo_div" style="margin-left: 30px;">
                            <div id="photo_model" class="item">
                                <div class="item_img">
                                    <div data-tool class="tools" style="display: none;">
                                        <label class="pull-left ml10 zhanshi"><input type="checkbox" data-id="show_center" onchange="show_center(this,'{{id}}')" name="show_center" value="1" class="" /><span class="text-white f12">展示</span> </label>
                                        <span title="删除" onclick="deleteFile('${ctx}/imageVideo/removeFile','{{id}}')" class="yt_removeer"></span>
                                        <div class="clearit"></div>
                                    </div>
                                    <a style="cursor: pointer;">
                                    <a class="video" onclick="show_video('${filePath}/{{f_src}}','{{create_time}}','{{id}}','{{role_type}}')"></a>
                                    <img onclick="show_video('${filePath}/{{f_src}}','{{create_time}}','{{id}}','{{role_type}}')" src="${filePath}/{{v_cover}}" data-id="src" >
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
    <div class="video_detail" id="video_detail" style="display: none;">
	<div class="closeVideoDeatail"></div>
	<!-- <div class="videoTitle">
		<span class="text-white f20">广州俱乐部VS杭州俱乐部</span>
	</div> -->
	<div class="commentIcon">
		<span>
			<a class="goodComment" flag="1" title="赞" data-id="goodbtn" onclick="do_praise(1,this,'video')" style="cursor: pointer;"></a>
		</span>
		<span class="text-white ml20" data-id="good">0</span>
		<span class="ml15">
			<a class="badComment" flag="1" title="踩" data-id="badbtn" onclick="do_praise(2,this,'video')" style="cursor: pointer;"></a>
		</span>
		<span class="text-white ml25" data-id="bad">0</span>
	</div>
	<div id="a1" class="videoplay pull-left">
	</div>
	<div class="comment pull-left">
		
		<div class="load">
			<a id="load_more"></a>
		</div>
		<div id="commentList" class="commentBox">
 		<div id="commentModel" class="ml10 mt10" style="display: none;">
 			<div class="pull-left">
 				<img src="${el:headPath()}{{head_icon}}" class="other"/>
 			</div>
 			<div class="pull-left ml15">
 				<p>
 					<span class="text-gray" style="cursor: pointer;" data-id="usernick"></span>
 					<span data-id="create_time" class="text-gray ml10"></span>
 				</p>
 				<p class="text-white mt5 w225">{{content}}</p>
 			</div>
 			<div class="clearfix"></div>
 		</div>
		</div>
		<form id="commentsForm" errorType="2" action="${ctx}/imageVideo/saveComments">
		<input type="hidden" id="iv_id" name="iv_id" value=""/>
		<input type="hidden" id="roleType" name="roleType" value=""/>
  		<div class="publishComment">
  			<img src="${el:headPath()}${user_img}" class="publishHead"/>
			<textarea valid="require len(0,200)" data-text="评论" id="msg_content" name="content"></textarea>
			<input type="button" onclick="send_comments()" value="发表" class="publisBtn"/>
		</div>
		</form>
	</div>
</div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
    <script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
    <script src="${ctx}/resources/js/own/index_new.js"></script>
<script type="text/javascript">

$(".closeVideoDeatail").click(function () {
	    $("#a1").html("");
	    $(".masker").hide();
	    $("#msg_content").val("");
	    $('#video_detail').hide();
	});
var t_isme = 0;
var photoList = new List({
	url:base+'/player/videos',
	sendData:{
		currentPage:1,
		pageSize : 8,
		oth_user_id : $("#oth_user_id").val()
    },
   	listDataModel:$('#photo_model').get(0).outerHTML,
   	listContainer:'#photo_list',
   	dynamicVMHandler:function(one){
   		var vm = $(photoList.options.listDataModel);
   		vm.css('display','block');
   		if(one.if_show=="1"){
   			vm.find('[data-id=show_center]').attr("checked","checked");
   		}
   		if(one.to_oss == 1){
   			vm.find(".video").attr("onclick","show_video('"+ossPath+one.f_src+"','"+one.create_time+"','"+one.id+"','"+one.role_type+"')")
   			vm.find("[data-id=src]").attr("onclick","show_video('"+ossPath+one.f_src+"','"+one.create_time+"','"+one.id+"','"+one.role_type+"')").attr("src",ossPath+one.v_cover);
   		}
   		return vm.get(0).outerHTML;
   	},
   	afterRenderList:function(c,v,data){
   		$('#photo_list').append('<div class="clearit"></div>');
   		$("#JS_photo").find("[data-id=totalpage]").addClass("text-white");
   		create_commont_list();
   		if(!t_isme){
   			$('.photo').find('[data-id=isme]').remove();
			$('.photo').find('[data-tool]').remove();
   		}else{
   			$('.photo').find('[data-tool]').show();
   		}
   	}
});

function load_photo_list(){
	photoList.loadListData().done(function(data){
		t_isme = data.data.isme;
		if(data.state=='success'&&data.data.page.items.length>0){
			photoList.iniPageControl(data.data.page);
			photoList.renderList(data.data.page.items,'reloade_resetScroll');
		}else{
			$('#photo_list').empty().append('<span>没有上传视频</span>');
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
		url: base+'/player/restCount',
		data: {type: "video"},
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
			layer.msg('请先保存当前上传视频',{icon: 2});
			return;
		}
		if(flag=="1"){
			$(".guanlibtn").val("在个人中心展示");
	     $(".item_img .tools").find(".zhanshi").hide();
	     $(this).attr("flag","0");
	     load_photo_list();
		}else{
	     $(".guanlibtn").val("保存");
	     $(".item_img .tools").find(".zhanshi").show();
	     $(this).attr("flag","1");
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

/* function resHandler(data){
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
	}else{
		layer.msg('请选择上传文件或等待上传完毕',{icon: 2});
	}
} */

function show_center(dom,id){
	var state = dom.checked?"sure":"cancel";
	$.ajaxSec({
		type: 'POST',
		url: base+'/player/showCenter',
		data: {id: id,type: "video",state:state},
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
	yrt.confirm('确定要删除这个视频吗？', {
	    btn: ['确定','取消'] //按钮
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: id,type:"video"},
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

var iframePImages;
function openUpPImgs(type){
	var area = type=='image'?['704px', '240px']:['390px', '460px'];
	$.ajaxSec({
		type: 'POST',
		url: base+'/center/checkUserRole',
		success: function(data){
			var msg = type=="image"?"图片":"视频";
			iframePImages = layer.open({
			    type: 2,
			    title: '上传'+msg,
			    shadeClose:true,
			    shade: [0.6],
			    zIndex:5,
			    area: area,
			    content: base+'/common/uploadHtml?user_id='+$("#oth_user_id").val()+'&type='+type+'&role_type=USER' //iframe的url
			}); 
		},
		error: $.ajaxError
	});
}

function closePOpen(fileType){
	layer.close(iframePImages);
	load_photo_list();
	layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
}
</script>
</body>
</html>