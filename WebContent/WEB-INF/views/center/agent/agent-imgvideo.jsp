<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="career">
    <span class="pull-left ml15 text-gray f16">照片</span><span id="agent_imageBtn" style="color:gray;cursor: pointer;" class="pull-right text-gray-s_666">More</span>
    <div class="clearit"></div>
</div>
<div class="updata_pic">
    <div class="wrap">
        <div class="updata_pic" id="agent_images">
            <ul class="clearfix">
                <li data-tpl="agent_image">
                    <img onclick="showImage(this)" style="cursor: pointer;" src="/resources/images/demo_pic3.jpg" />
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="career">
    <span class="pull-left ml15 text-gray f16">视频</span><span id="agent_videoBtn" style="color:gray;cursor: pointer;" class="pull-right text-gray-s_666">More</span>
    <div class="clearit"></div>
</div>
<div class="updata_pic">
    <div class="wrap">
		<div id="agent_videos" class="updata_video">
		    <ul class="clearfix">
		        <li data-tpl="agent_video">
		        <a class="video"></a>
		        <img style="cursor: pointer;" src="/upload/picture/201508/2912592677vw.png" />
		        </li>
		    </ul>
		</div>
</div>
</div>
<script type="text/javascript">

var img_li = $("#agent_images").find("[data-tpl=agent_image]").get(0).outerHTML;
var vdo_li = $("#agent_videos").find("[data-tpl=agent_video]").get(0).outerHTML;
function create_iorv(imgs,type){
	var data_ul = type=='image'?$("#agent_images").find("ul"):$("#agent_videos").find("ul");
	data_ul.empty();
	for(var i in imgs){
		var imodel =  type=='image'?$(img_li):$(vdo_li);
		var src = type=='image'?imgs[i].src:imgs[i].src.substring(0,imgs[i].src.lastIndexOf("."))+".jpg";
		imodel.find('img').attr("src",filePath+"/"+src);
		if('video'==type){
			imodel.find('img').attr("onclick",'createVideo("'+imgs[i].src+'")');
			imodel.find('.video').attr("onclick",'createVideo("'+imgs[i].src+'")');
		}
		//imodel.find('input').attr("value",imgs[i].src);
		data_ul.append(imodel);
	}
}

function load_agent_img_video(url,pageSize,type){
	$.post(url,{oth_user_id:$("#oth_user_id").val(),pageSize:pageSize},function(result){
		var flag = false;
		if(result.state=='success'){
			var datas = result.data.data.items;
			if(datas.length>0){
				create_iorv(datas,type);
				flag = true;
			}
		}
		if(type=='image'){
			$("#agent_imageBtn").attr('onclick','window.open("'+base+'/agent/photo?oth_user_id='+$("#oth_user_id").val()+'")');
			(!flag)?$("#agent_images").find("ul").empty().append('<li><span style="margin-left: 340px;">暂无图片</span></li>'):null;
			(!result.data.isme&&(!flag))?$("#agent_imageBtn").remove():null;
		}else{
			$("#agent_videoBtn").attr('onclick','window.open("'+base+'/agent/video?oth_user_id='+$("#oth_user_id").val()+'")');
			(!flag)?$("#agent_videos").find("ul").empty().append('<li><span style="margin-left: 340px;">暂无视频</span></li>'):null;
			(!result.data.isme&&(!flag))?$("#agent_videoBtn").remove():null;
		}
	});
}
$(function(){
	load_agent_img_video(base+'/agent/images',6,'image');
	load_agent_img_video(base+'/agent/videos',4,'video');
	//init_loadImage_2('#forcecentered');
})
</script>
