<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<link href="${ctx}/resources/ueditor/third-party/video-js/video-js.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>讯息：${news.title}</title>
</head>
<body>
	<div class="masker"></div>
	<div class="warp">
		<%@ include file="../common/header.jsp" %>    
	 	<%@ include file="../common/naver.jsp" %> 
	 	<div class="wrapper" style="margin-top: 116px;">
            <div class="pic_list">
                <div class="title">
                	<span style="cursor: pointer;" class="text-white f16 ms pull-left ml15" onclick="location.href='${ctx}/'">首页 》 </span>
                    <span style="cursor: pointer;" class="text-white f16 ms" onclick="location.href='${ctx}/news'">讯息中心 》 </span>
                    <span class="text-white f16 ms">${news.title} </span>
                    <div class="clearit"></div>
                </div>
                <div class="news_list">
                    <style>
                    </style>
                    <div class="news_info">
                        <p class="title_p ms">${news.title}</p>
                        <p class="time">时间:<span><fmt:formatDate value="${news.create_time}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></span><!-- <span class="ml10">浏览:109次</span><span class="ml10">作者:双截棍</span> --></p>
                        <div id="new_content" class="content">
                            ${news.content}
                        </div>
                    </div>
                </div>

                <div class="ad_list">
                    <dl>
                        <dd>
                            <img src="${ctx}/resources/images/ad_0004.jpg" />
                        </dd>
                        <dd>
                            <img src="${ctx}/resources/images/ad_0005.jpg" />
                        </dd>
                        <dd>
                            <img src="${ctx}/resources/images/ad_0006.jpg" />
                        </dd>
                    </dl>
                </div>
                <div class="clearit"></div>
            </div>
        </div>
	</div>
<%@ include file="../common/footer.jsp" %>      
<script src="${ctx}/resources/ueditor/ueditor.parse.js" type="text/javascript"></script>
<script src="${ctx}/resources/ckplayer/ckplayer.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	change_video();
})
function create_video(dom,src){
	var w = $(dom).attr('width');
	var h = $(dom).attr('height');
	var uid = (+new Date()).toString( 32 );
	$(dom).replaceWith('<a id="a1_'+uid+'"></a>');
	
	var flashvars = {
        f: src,
        c: 0,
        b: 1
    };
    CKobject.embed('/resources/ckplayer/ckplayer.swf', 'a1_'+uid, 'ckplayer_a1', w, h, false, flashvars);
}
function change_video(){
	var vs = $("#new_content").find("video").hide();
	if(vs&&vs.length>0){
		var num = 0;
		vs.each(function(){
			var src = $(this).attr("src");
			if(src){
				num++;
				if(check_create_time('<fmt:formatDate value="${news.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/>',15)){
					var w = $(this).width();
					var h = $(this).height()
					$(this).before("<div id='ueditor_"+num+"' style='display:inline-block;width:"+w+"px;height:"+h+"px;background-color: #666;'><img src='/resources/images/v0001.png' style='display:inline-block;'/></div>");
					centerImage("#ueditor_"+num);
				}else{
					create_video(this,src);
				}
			}else{
				$(this).remove();
			}
		});
	}
}
function centerImage(dom) {
	var parent = $(dom);
	var img = parent.find("img");
    var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
    if(120 < parent.width()&&ih<parent.height()){
    	var ml = (parent.width()-120)/2 - 25;
    	var mt = (parent.height()-ih)/2;
	    img.css({
	    	'margin-left': ml+'px',
	        'margin-top': mt+'px'
	    });
    }
}
</script>      
</body>
</html>