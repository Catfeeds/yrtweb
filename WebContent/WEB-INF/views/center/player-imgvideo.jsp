<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="career">
    <span class="pull-left ml15 fw text-white f16 ms">照片</span><span id="imageBtn" style="cursor: pointer;" class="pull-right text-gray-s_666">more</span>
    <div class="clearit"></div>
</div>

<div class="updata_pic">
    <div class="wrap">

        <div class="updata_pic" id="player_images">
            <ul class="clearfix">
                <li data-tpl="player_image" onmouseover="showTools(this)" onmouseout="hideTools(this)">
                   <div id="image_tools" class="tools" style="display: none;">          
                      <span class="p_removeer"></span>
                   </div>
                    <img layer-pid="" layer-src="" alt="" num="" style="cursor: pointer; width:105px;height:115px;" src="/resources/images/demo_pic3.jpg"/>
                </li>
                <li data-tpl="player_add_image" onclick="openUpPImgs('image')">
                <div class="" style="width: 105px;height: 117px;background: url(/resources/images/p_addimg.png) no-repeat;cursor: pointer;"></div>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="career">
    <span class="pull-left ml15 fw text-white f16 ms">视频</span><span id="videoBtn" style="cursor: pointer;" class="pull-right text-gray-s_666">more</span>
    <div class="clearit"></div>
</div>
<div id="player_videos" class="updata_video">
    <ul>
        <li data-tpl="player_video" onmouseover="showTools(this)" onmouseout="hideTools(this)">
        <div id="image_tools" class="tools" style="display: none;">          
           <span class="p_removeer"></span>
        </div>
        <a class="video"></a>
        <img style="cursor: pointer;" src="/upload/picture/201508/2912592677vw.png" />
        </li>
        <li data-tpl="player_add_video" onclick="openUpPImgs('video')">
        <div class="" style="width: 105px;height: 117px;background: url(/resources/images/p_addvdo.png) no-repeat;cursor: pointer;"></div>
        </li>
    </ul>
   <div class="clearit"></div>
</div>
<script type="text/javascript">

var img_li = $("#player_images").find("[data-tpl=player_image]").get(0).outerHTML;
var vdo_li = $("#player_videos").find("[data-tpl=player_video]").get(0).outerHTML;
var img_add_li = $("#player_images").find("[data-tpl=player_add_image]").get(0).outerHTML;
var vdo_add_li = $("#player_videos").find("[data-tpl=player_add_video]").get(0).outerHTML;
function create_iorv(imgs,type,isme){
	var data_ul = type=='image'?$("#player_images").find("ul"):$("#player_videos").find("ul");
	data_ul.empty();
	var num = 1;
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
			imodel.find('img').attr("layer-pid",imgs[i].id);
			imodel.find('img').attr("layer-src",filePath+"/"+src);
			imodel.find('img').attr("num",num++);
			if(isme){
				imodel.find(".p_removeer").attr("onclick","deleteFile('${ctx}/imageVideo/removeFile','"+imgs[i].id+"','image')");
			}else{
				imodel.find("#image_tools").remove();
			}
		}
		//imodel.find('input').attr("value",imgs[i].src);
		data_ul.append(imodel);
	}
}

function load_player_img_video(url,pageSize,type){
	$.post(url,{oth_user_id:$("#oth_user_id").val(),pageSize:pageSize},function(result){
		var flag = false;
		if(result.state=='success'){
			var datas = result.data.page.items;
			if(datas.length>0){
				create_iorv(datas,type,result.data.isme);
				flag = true;
			}
		}
		var data_ul = type=='image'?$("#player_images").find("ul"):$("#player_videos").find("ul");
		if(type=='image'){
			if(!result.data.isme&&(!flag)){
				$("#imageBtn").remove();
				$("#player_images").find("ul").empty().append('<li><span style="margin-left: 340px;">暂无图片</span></li>');
			}else{
				$("#imageBtn").attr('onclick','window.open("'+base+'/player/photo?oth_user_id='+$("#oth_user_id").val()+'")');
				if(result.data.isme){
					(!flag)?data_ul.empty().append(img_add_li):data_ul.append(img_add_li);
					$("#imageBtn").empty().addClass("yt_editer");
				}
			}
			layer.ready(function(){
		        layer.photos({
		            photos: '#player_images'
		        });
		    });
		}else{
			if(!result.data.isme&&(!flag)){
				$("#videoBtn").remove();
				$("#player_videos").find("ul").empty().append('<li><span style="margin-left: 340px;">暂无视频</span></li>');
			}else{
				$("#videoBtn").attr('onclick','window.open("'+base+'/player/video?oth_user_id='+$("#oth_user_id").val()+'")');
				if(result.data.isme){
					(!flag)?data_ul.empty().append(vdo_add_li):data_ul.append(vdo_add_li);
					$("#videoBtn").empty().addClass("yt_editer");
				}
			}
		}
	});
}
var iframePImages;
function openUpPImgs(type){
	var area = type=='image'?['704px', '240px']:['704px', '440px'];
	$.ajaxSec({
		type: 'POST',
		url: base+'/player/secPlayer',
		success: function(data){
			var msg = type=="image"?"图片":"视频";
			iframePImages = layer.open({
			    type: 2,
			    title: '上传'+msg,
			    shadeClose:true,
			    shade: [0.6],
			    zIndex:5,
			    area: area,
			    content: base+'/common/uploadHtml?user_id='+$("#oth_user_id").val()+'&type='+type+'&role_type=PLAYER' //iframe的url
			}); 
		},
		error: $.ajaxError
	});
}
/* function openUpPImgs(type){
	$.ajaxSec({
		type: 'POST',
		url: base+'/player/restCount',
		data: {type: type},
		success: function(data){
			if(data.state == 'success'){
				var restCount = parseInt(data.data.data.restCount)>0?data.data.data.restCount:0;
				var msg = type=="image"?"图片":"视频";
				var msgError = type=="image"?"张图片":"个视频";
				if(restCount>0){
					iframePImages = layer.open({
					    type: 2,
					    title: '上传'+msg,
					    shadeClose:true,
					    shade: [0.6],
					    zIndex:5,
					    area: ['704px', '240px'],
					    content: base+'/common/uploadHtml?user_id='+$("#oth_user_id").val()+'&type='+type //iframe的url
					}); 
				}else{
					layer.alert("您现在还可上传 0 "+msgError+"，是否需要<a>购买</a>展示包", {btn:'关闭'});
				}
			}else{
				layer.msg("操作失败",{icon: 2});
			}
		},
		error: $.ajaxError
	});
} */
function closePOpen(fileType){
	layer.close(iframePImages);
	if("video"==fileType){
		load_player_img_video(base+'/player/videos',5,'video');
		layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
	}else{
		load_player_img_video(base+'/player/images',5,'image');
	}
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
	layer.confirm(msg, {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: id,type:type},
			success: function(result){
				if(result.state=='success'){
					layer.msg("删除成功",{icon: 1});
					load_player_img_video(base+'/player/'+type+'s',5,type);
				}else{
					layer.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}

$(function(){
	load_player_img_video(base+'/player/images',5,'image');
	load_player_img_video(base+'/player/videos',5,'video');
	//init_loadImage_2('#forcecentered');
	layer.config({
	    extend: '/extend/layer.ext.js'
	}); 
})
</script>
