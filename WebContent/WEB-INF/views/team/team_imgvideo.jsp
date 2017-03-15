<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="filePath" value="${ctx}/upload" />   
<p>
	<span>图片</span>
		<span>
			<a href="javascript:void(0);" class="moreMembers" id="imageBtn"></a>
		</span>
</p>
<!--图片层-->
<div class="updata_pic">
    <div class="wrap">
        <div class="updata_pic" id="team_images" style="padding-top: 10px;padding-bottom: 10px;">
            <ul class="clearfix">
                <li data-tpl="team_image">
                    <img layer-pid="" layer-src="" alt="" num="" style="cursor: pointer; width:105px;height:115px;" src="/resources/images/demo_pic3.jpg"/>
                </li>
                <li data-tpl="team_add_image" onclick="openUpTImgs('image')">
                <div class="" style="width: 105px;height: 117px;background: url(/resources/images/p_addimg.png) no-repeat;cursor: pointer;"></div>
                </li>
            </ul>
        </div>
    </div>
</div>
<!--视频层-->
<p>
	<span>视频</span>
		<span>
			<a href="javascript:void(0);" class="moreMembers" id="videoBtn"></a>
		</span>
</p>
<div id="team_videos" class="updata_video" style="padding-top: 10px;padding-bottom: 10px;">
    <ul>
        <li data-tpl="team_video">
        <a class="video"></a>
        <img style="cursor: pointer;" src="/upload/picture/201508/2912592677vw.png" />
        </li>
        <li data-tpl="team_add_video" onclick="openUpTImgs('video')">
        <div class="" style="width: 105px;height: 117px;background: url(/resources/images/p_addvdo.png) no-repeat;cursor: pointer;"></div>
        </li>
    </ul>
   <div class="clearit"></div>
</div>
<script type="text/javascript">

function create_iorv(imgs,type,isme){
	//var images = $("#team_images").find("[data-tpl=team_image]");
	//var videos = $("#team_videos").find("[data-tpl=team_video]");
	var images = $('<li data-tpl="team_image" onmouseover="showTools(this)" onmouseout="hideTools(this)"><div id="image_tools" class="tools" style="display: none;"><span class="p_removeer"></span></div><img layer-pid="" layer-src="" alt="" num="" style="cursor: pointer; width:105px;height:115px;" src="/resources/images/demo_pic3.jpg"/></li>');
	var videos = $('<li data-tpl="team_video" onmouseover="showTools(this)" onmouseout="hideTools(this)"><div id="image_tools" class="tools" style="display: none;"><span class="p_removeer"></span></div><a class="video"></a><img style="cursor: pointer;" src="/upload/picture/201508/2912592677vw.png" /></li>');
	var img_li = images.length>0?images.get(0).outerHTML:null;
	var vdo_li = videos.length>0?videos.get(0).outerHTML:null;
	var data_ul = type=='image'?$("#team_images").find("ul"):$("#team_videos").find("ul");
	data_ul.empty();
	for(var i in imgs){
		var imodel =  type=='image'?$(img_li):$(vdo_li);
		var src = type=='image'?imgs[i].f_src:imgs[i].f_src.substring(0,imgs[i].f_src.lastIndexOf("."))+".jpg";
		imodel.find('img').attr("src",filePath+"/"+src);
		if('video'==type){
			imodel.find('img').attr("onclick",'createVideo("'+imgs[i].f_src+'","'+imgs[i].create_time+'")');
			imodel.find('.video').attr("onclick",'createVideo("'+imgs[i].f_src+'","'+imgs[i].create_time+'")');
			if(isme)
			imodel.find(".p_removeer").attr("onclick","deleteFile('${ctx}/imageVideo/removeFile','"+imgs[i].id+"','video')");
			else
				imodel.find("#image_tools").remove();
		}else{
			if(isme)
			imodel.find(".p_removeer").attr("onclick","deleteFile('${ctx}/imageVideo/removeFile','"+imgs[i].id+"','image')");
			else
				imodel.find("#image_tools").remove();
		}
		//imodel.find('input').attr("value",imgs[i].src);
		data_ul.append(imodel);
	}
}
function load_team_img_video(url,pageSize,type){
	var img_add_li = $("#team_images").find("[data-tpl=team_add_image]").get(0).outerHTML;
	var vdo_add_li = $("#team_videos").find("[data-tpl=team_add_video]").get(0).outerHTML;
	$.post(url,{team_id:$("#teaminfo_id").val(),type:type,pageSize:pageSize},function(result){
		var flag = false;
		if(result.state=='success'){
			var datas = result.data.page.items;
			if(datas.length>0){
				create_iorv(datas,type,result.data.isme);
				flag = true;
			}
		}
		var data_ul = type=='image'?$("#team_images").find("ul"):$("#team_videos").find("ul");
		if(type=='image'){
			if(!result.data.isme&&(!flag)){
				$("#imageBtn").remove();
				data_ul.empty().append('<li><span style="margin-left: 340px;">暂无图片</span></li>');
			}else{
				$("#imageBtn").attr('onclick','window.open("'+base+'/imageVideoTeam/photo?team_id='+$("#teaminfo_id").val()+'")');
				if(result.data.isme){
					(!flag)?data_ul.empty().append(img_add_li):data_ul.append(img_add_li);
				}
			}
			layer.ready(function(){
		        layer.photos({
		            photos: '#team_images'
		        });
		    });
		}else{
			if(!result.data.isme&&(!flag)){
				$("#videoBtn").remove();
				data_ul.empty().append('<li><span style="margin-left: 340px;">暂无视频</span></li>');
			}else{
				$("#videoBtn").attr('onclick','window.open("'+base+'/imageVideoTeam/video?team_id='+$("#teaminfo_id").val()+'")');
				if(result.data.isme){
					(!flag)?data_ul.empty().append(vdo_add_li):data_ul.append(vdo_add_li);
				}
			}
		}
	});
}


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

function showTools(dom){
	$(dom).find("#image_tools").show();
}
function hideTools(dom){
	$(dom).find("#image_tools").hide();
}

function deleteFile(url,id,type){
	var msg = "确定要删除这张图片吗？";
	if(type=='video'){
		msg = "确定要删除这个视频吗？";
	}
	yrt.confirm(msg, {
	    btn: ['确定','取消'] //按钮
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: id,type:type},
			success: function(result){
				if(result.state=='success'){
					yrt.msg("删除成功",{icon: 1});
					load_team_img_video(base+'/team/queryTeamImages',5,type);
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
	if("video"==fileType){
    	load_team_img_video(base+'/team/queryTeamImages',5,'video');
    	layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
	}else{
		load_team_img_video(base+'/team/queryTeamImages',5,'image');
	}
}

</script>
