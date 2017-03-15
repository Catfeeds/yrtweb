<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp"%>
<title>宇任拓-动态</title>
<link href="${ctx}/resources/css/dynamics.css" rel="stylesheet" />
<link href="${ctx}/resources/css/photowindow.css" rel="stylesheet" />
</head>
<c:set var="currentPage" value="DYNAMIC" />
<body>
	<div class="warp">
	 <div class="masker" style="z-index: 0">
    </div>
		<!--头部-->
		<%@ include file="../common/header.jsp"%>
		<!--导航 start-->
		<%@ include file="../common/naver.jsp"%>
		<!--导航 end-->
 <div class="wrapper" style="margin-top: 116px;">

            <div class="chat_room">
                <ul class="the_world">
                    <li id="c_news" class="active"><span>最新</span></li>
                    <li id="c_followers" ><span>关注</span></li>
                    <li id="c_my" ><span>我的</span></li>
                    <div class="clearit"></div>
                </ul>
                <div class="clearit"></div>
                <div class="d_fenge"></div>
                <div class="chat_info">
                    <button class="btn toEnd" style="display: none;" data-item="10">toEnd</button>
                    <div class="frame d_content" id="smart" style="height: auto;">
                       
                        <ul class="items">
					  	<c:forEach items="${_topDy}" var="_item">
                            <li><div class="comment">
                                    <span class="stick song">[置顶]</span>
                                    <span style="cursor: pointer;" onclick="window.open('${ctx}/center/${_item.user_id}')" class="index_person">${_item.user_name}：</span>
                                    <span class="index_txt">
                                        ${_item.text} 
                                        <c:if test="${_item.image_src!=null}">
                                        <a href="javascript:showphoto('${_item.image_src }');" class="pic_tag">图</a>
                                        </c:if>
                                    </span>

                                    <div class="clearit"></div>
                                </div>
                            </li>
						</c:forEach>
                        </ul>
                    </div>
                    <div style="width: 100%;margin-top: 25px; border-bottom: 15px solid #181818;"></div>
                    <div class="scrollbar_two mt20" style="height:460px;">
                        <div class="handle">
                            <div class="mousearea"></div>
                        </div>
                    </div>
                    <div class="frame d_content" id="smart_two" style="margin-top: 20px;height: 430px;">
                        <ul id="padding_ul" class="items"></ul>
                    </div>
                    <div class="t_line"></div>
                    <form id="dongtaiForm" action="${ctx}/dynamicv1/saveDyn">
	                    <div class="to_speak">
	                        <textarea valid="require len(0,280)" data-text="动态" id="text" name="text"></textarea>
	                        <style></style>
	                        <div class="issued">
	                            <input type="button" onclick="sendDynamic()" value="发布" class="btn_re pull-right ms f14" />
	                            <img src="${ctx}/resources/images/in_pic.png" alt="插入图片" class="in" />
	                            <div class="clearit"></div>
	                            <div class="pic_in">
	                                <div class="in_close"></div>
	                                <div style="width:100%;">
	                                    <span class="pull-left mt10 ml10 text-white">本地上传</span>
	                                    <div class="clearit"></div>
	                                    <ul id="dynamicImg" class="add"></ul>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    </form>
                </div>
            </div>
        </div>

   
    <div class="mybox">
        <div class="closebtn" ></div>
        <div class="slide_img">
            <span id="prev" class="abtn prev"></span>
            <span id="next" class="abtn next"></span>
            <span id="prevTop" class="abtn prev"></span>
            <span id="nextTop" class="abtn next"></span>
            <div id="picBox" class="picBox"><ul class="cf"></ul></div>
            <div id="listBox" class="listBox"><ul class="cf"></ul></div>
        </div>
    </div>
    </div>
	<%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/js/plugins.js"></script>
    <script src="${ctx}/resources/js/sly.js"></script>
    <script src="${ctx}/resources/js/textAreaCount.js"></script>
    <script src="${ctx}/resources/js/lightbox.js" type="text/javascript"></script>
    <script type="text/javascript">
	var show_last_time=0;
	var islogin = "${_userid}"!=""?true:false;
	var data_tp = "${_toPage}";
	var UserCSS={"team":"index_club","baby":"index_baby","user":"index_person","coach":"index_coach","player":"index_person","agent":"index_person","user":"index_person"};
	var loadNewAjax = null;
    var addToWindow = function(o){
    	var msg=[];
    	var url="";
    	var class_txt = "index_txt";
    	var class_name = "index_person";
    	if(o.msg_type=="sys"){
    		class_name = "index_sys";
    		class_txt = "index_txt sysred";
    		o.user_name = "系统";
    	}else if(o.msg_type=="msg"){
    		class_txt = "index_txt";
    		class_name = UserCSS[o.user_type];
    		
    		url = "window.open('${ctx}/center/"+o.user_id+"')";
    	}

    	if(o.msg_me){
    		class_name = "index_me";
    		o.user_name = "我";
    	}
    	
    	msg.push('<li><div class="comment"><span style="cursor: pointer;" onclick="'+url+'" class="'+class_name+'">'+o.user_name+'：</span>');
    	msg.push('<span class="'+class_txt+'">');
		msg.push(o.text);
        if(o.isImages){
       		msg.push('<a href="javascript:showphoto(\''+o.image_src+'\');" class="pic_tag">图</a>');
        }
        if(o.msg_me){
            msg.push('<a href="javascript:setTop(\''+o.dynamic_id+'\');" class="pic_top">顶</a> ');
        }
        msg.push('</span><div class="clearit"></div></div></li>');
        show_last_time = o.createtime;
		$("#padding_ul").append(msg.join(''));
		var div = document.getElementById('smart_two');
		div.scrollTop = div.scrollHeight;
    };
    var loadFirstDynamic = function(p){
    	$.ajax({
    		type : "POST",
    		url : "${ctx}/dynamicv1/def",
    		data : p,
    		dataType : "json",
    		contentType : "application/json",
    		success : function(items) {
    			$("#padding_ul").empty();
    			for(i in items){
    				addToWindow(items[i]);
    			}
    			if(items.length>0){
	    			addchat("#smart_two");
	    			$(".toEnd").trigger("click");
    			}
    			loadNewMsg('{"lastTime":'+show_last_time+',"loadData":"'+data_tp+'"}');
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
    };
    var init_page=function(){
        loadFirstDynamic('{"loadData":"'+data_tp+'"}');
        $("#c_news").removeClass("active");
        $("#c_my").removeClass("active");
        $("#c_followers").removeClass("active");
        $("#c_"+data_tp).addClass("active");
    };

    var loadNewMsg = function(p){

		if(loadNewAjax!=null){
	    	loadNewAjax.abort();
		}
    	loadNewAjax=$.ajax({
    		type : "POST",
    		url : "${ctx}/dynamicv1/loadNewMsg",
    		data : p,
    		dataType : "json",
    		contentType : "application/json",
    		success : function(items) {
    			for(i in items){
    				addToWindow(items[i]);
    			}
    			//addchat("#smart_two");
    			if(items.length>0){
        			$(".toEnd").trigger("click");
    			}
    			loadNewMsg('{"lastTime":'+show_last_time+',"loadData":"'+data_tp+'"}');
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
    };
    
var resHandler=	function (result){
	if(result.state==0){
		layer.msg(result.message,{icon: 1});
		$("#text").val("");
		init_dynamicImg();
	}else{
		layer.msg(result.message,{icon: 2});
	}
};

	var setTop=function(id){
    	$.ajax({
    		type : "POST",
    		url : "${ctx}/dynamicv1/operTop",
    		data : '{"dynamic_id":"'+id+'"}',
    		dataType : "json",
    		contentType : "application/json",
    		success : function(data) {
    			window.location.reload();
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
	};
	var sendDynamic = function(){
		/* if(!islogin){
			layer.msg("请登录后再试",{icon: 2});
			return 0;
		} */
		
		var txt =  $.trim($('#text').val());
		var submit_ = false;
		if(txt.length>0){
			submit_ = true;
		}else{
			var imgs = $("input[name='image']");
			if(imgs.length>0){
				submit_ = true;
			}
		}
		
		if(submit_){
			$.ajaxSubmit('#dongtaiForm','#dongtai',resHandler);
		}else{
			layer.msg("请填写发布内容",{icon: 2});
		}
	}
	
	 $('#text').keypress(function(e) { 
	       if(e.which == 13) { 
	    	   sendDynamic();
	    	   return false;
	       } 
	}); 
	
	function appendPicBox(str){
		var picBox = $("#picBox").find("ul").empty();
		var listBox = $("#listBox").find("ul").empty();
		var imgs = str.split(",");
		for(var i in imgs){
			var src = filePath+'/'+imgs[i];
			picBox.append( '<li><div class="show_s"><img src="'+src+'" alt="" /></div></li>');
			listBox.append('<li><img height="64" src="'+src+'" alt="" /></li>');
		}
		picBox.append('<div class="clearit"></div>');
		listBox.append('<div class="clearit"></div>');
		load_lightBox();
    	$(".mybox").center();
	}
	
	function init_dynamicImg(){

		$('#dynamicImg').attr("cs-data-uid","");
		$('#dynamicImg').empty();
	    //发布说说的控件初始化
	  	$('#dynamicImg').fileUploader($.extend({},{
	  		uploaderType: 'imgUploader',
	  		itemWidth: 50,
	  		itemHeight: 50,
	  		fileNumLimit: 4,
	  		fileSingleSizeLimit: 6*1024*1024, /*6M*/
	  		fileVal: 'file',
	  		server: '${ctx}/imageVideo/uploadFile?filetype=picture',
	  		toolbar:{
	  			del: true
	  		}
	  	},{inputName:'image'}));
	    
	    $('#dynamicImg').find(".webuploader-container").css("border","none");
		$('#dynamicImg').find(".webuploader-pick").css("background"," url('${ctx}/resources/images/in_add.png') no-repeat scroll center center");
	
	}
    
        $(".in").click(function () {
            $(".pic_in").show();
            $('#dynamicImg').find(".webuploader-container").css("border","none");
    		$('#dynamicImg').find(".webuploader-pick").css("background"," url('${ctx}/resources/images/in_add.png') no-repeat scroll center center");
        });

        $(".in_close").click(function () {
            $(".pic_in").hide();
        });

        $(document).ready(function () {
            $("#text").textAreaCount({ maxlength: 140, speed: 15 });

            $(".mybox").center().hide();
            $(".masker").height($(document).height());
        });
        $("#c_news").click(function () {
        	window.location.href="${ctx}/dynamicv1?to_page=news"; 
        	data_tp = "news";
        	init_page();
        });
        $("#c_followers").click(function () {
        	window.location.href="${ctx}/dynamicv1?to_page=followers"; 
        	data_tp = "followers";
        	init_page();
        });
        $("#c_my").click(function () {
        	window.location.href="${ctx}/dynamicv1?to_page=my"; 
        	data_tp = "my";
        	init_page();
        });
        
        function addchat(id) {
            var $frame = $(id);
            var $slidee = $frame.children('ul').eq(0);
            var $wrap = $frame.parent();

            // Call Sly on frame
            $frame.sly({
                itemNav: 'basic',
                smart: 1,
                activateOn: 'click',
                mouseDragging: 1,
                touchDragging: 1,
                releaseSwing: 1,
                startAt: 3,
                scrollBar: $wrap.find('.scrollbar_two'),
                scrollBy: 1,
                pagesBar: $wrap.find('.pages'),
                activatePageOn: 'click',
                speed: 300,
                elasticBounds: 1,
                easing: 'easeOutExpo',
                dragHandle: 1,
                dynamicHandle: 1,
                clickBar: 1,
            });
            $wrap.find('.toEnd').on('click', function () {
                var item = $(".chat_info").data('item');
                $frame.sly('toEnd', item);
            });
        }

        function hidephoto() {
            $(".mybox").fadeOut();
            $(".masker").fadeOut();
        }
        function showphoto(str){
        	appendPicBox(str);
            $(".mybox").fadeIn();
            $(".masker").height($(document).height()).fadeIn();
            
        }

        $(".closebtn").click(function () {
            hidephoto();
        });
        $(".masker").click(function () {
            hidephoto();
        });
        
        init_page();
        
        if(!islogin){
        	$('#text').val("请登录");
        }else{
        	$('#text').val("");
            init_dynamicImg();
        }
    </script>
</body>
</html>