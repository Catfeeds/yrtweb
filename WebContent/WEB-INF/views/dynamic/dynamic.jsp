<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-个人动态</title>
<link href="${ctx}/resources/css/dynamics.css" rel="stylesheet" />
</head>
<c:set var="currentPage" value="DYNAMIC"/>
<body>
<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
        <!--导航 start-->
        <%@ include file="../common/naver.jsp" %>    
        <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
          <div class="dt_div">
            <ul class="dt">
                <li onclick="location.href='${ctx}/dynamic/new'"><span class="dt_txt ms">最新动态</span></li>
                <li><span class="dt_txt ms active">关注列表</span></li>
                <li onclick="location.href='${ctx}/dynamic/me'"><span class="dt_txt ms">我的动态</span></li>
            </ul>
            <div class="clearit"></div>
            <form id="dongtaiForm" action="${ctx}/dynamic/saveDyn">
            <div id="dongtai" errorType="2" class="fx_windows">
                <textarea valid="require len(0,280)" data-text="动态" id="text" name="text"></textarea>
                <div id="upl" ></div>
                <div id="uplv" ></div>
                <div class="tools clearfix">
                    <span onclick="showHideUPL('#upl')" class="pic_up ms f14 text-white pull-left">图片</span>
                    <span  onclick="showHideUPL('#uplv')" class="vid_up ms f14 text-white pull-left">视频</span>
                    <input type="button" onclick="$.ajaxSubmit('#dongtaiForm','#dongtai',resHandler)" value="发表" class="publish ms  f20" />
                </div>
            </div>
            </div>
            </form>
            <div id="dynList" class="fx_info ">
                <div id="dynModel" data-tpl="dynamic" style="display: none;"  class="dyn_region clearfix mt10">
                    <div class="avatar">
                        <a data-user-id class="text-white" target="_blank"><img data-head-img src="${el:headPath()}{{head_icon}}" /></a>
                    </div>
                    <div class="cont">
                        <h4 class="nickname f16"><a data-user-id class="text-white" target="_blank">{{usernick}}</a></h4>
                        <span data-id="isme" class="drop">
                        </span>
                        <div class="clearit"></div>
                        <label class="help-inline mt10" data-id="role_name"></label>
                        <p class="f14 text-white">{{text}}</p>
                        <div data-id="imageVideo" class="pic_exh clearfix">
                        </div>
                        <div class="time">
                            <span data-id="create_time"></span>
                        </div>
                        <div class="pl">
                            <span data-id="iscomment" onclick="showHideDiv('[data-control=huifu]',this);getComments('{{id}}',this)" style="cursor: pointer;color:#fff;">评论<span class="ml10 text-white">{{comCount}}</span></span>
                            <span data-id="ispraise" title="赞" flag="1" onclick="doPraise('{{id}}',this);" style="cursor: pointer;" class="praise ml15 text-white">{{praise_count}}</span>
                        </div>
                    </div>
                    <div class="clearit"></div>
                    <div data-control="huifu" errorType="2" style="display: none;" class="plk">
                        <div class="avatar_p">
                            <img data-headhref src="${ctx}/upload/${headimg}" style="width: 60px;height: 60px;" />
                        </div>
                        <textarea name="content" valid="require len(0,280)" data-text="评论"></textarea>
                        <input type="button" onclick="reply_comment('{{id}}',this)" value="评论" class="pl_btn ms f16 pull-right mt10"/>
                        <div class="clearit"></div>
                        <!--评论-->
	                    <div data-container="commentList">
	                    <div class="pl_list" data-tpl="comment" style="display:none;">
	                        <div class="pull-left">
	                            <img data-head-img src="${el:headPath()}{{head_icon}}" style="width: 32px;height: 32px;" />
	                        </div>
	                        <div class="pull-left" style="width:820px; margin-left: 10px;">
	                            <p class="text-white">
	                                <span class="pl_id"><a data-user-id class="pl_id" target="_blank">{{usernick}}</a></span>：{{content}}
	                            </p>
	                            <span data-id="create_time" class="mt10"></span>
	                            <a data-id="reply" onclick="" class="recall">回复</a>
	                            <div class="clearit"></div>
	                        </div>
	                        <div class="clearit"></div>
	                    </div>
	                    </div>
                    </div>
                </div>

            </div>
            <div id="loadMore" class="loading" onclick="loadMore(this)" style="cursor: pointer;">
		        <a>加载更多>></a>
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
    <div id="showVideo" style="z-index: 120;"><img id="playSWF" src="${ctx}/resources/images/close.png"/><div id="a1" class="showvdo"></div></div>
    <%@ include file="../common/footer.jsp" %>
    <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
   	<script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
   	<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
   	<script type="text/javascript">
   	
   	jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }
   	
  //发布说说的控件初始化
	var uploadeOpts1 = {
		uploaderType: 'imgUploader',
		itemWidth: 80,
		itemHeight: 80,
		fileNumLimit: 4,
		fileSingleSizeLimit: 2*1024*1024, /*1M*/
		fileVal: 'file',
		server: '${ctx}/imageVideo/uploadFile?filetype=picture',
		toolbar:{
			del: true
		}
	}
	$('#upl').fileUploader($.extend({},uploadeOpts1,{inputName:'image'}));
	$('#upl').hide();
	
	var uploadeOpts2 = {
		uploaderType: 'vdoUploader',
		//showVideo:showVideo,
		itemWidth: 80,
		itemHeight: 80,
		fileNumLimit: 1,
		fileSingleSizeLimit: 20*1024*1024, /*1M*/
		fileVal: 'file',
		server: '${ctx}/imageVideo/uploadFile?filetype=video',
		toolbar:{
			del: true
		}
	}
	$('#uplv').fileUploader($.extend({},uploadeOpts2,{inputName:'video'}));
	$('#uplv').hide();
	
	var btn = $("#playSWF");
    btn.click(function () {
        $("#showvdo").html("");
        $('#showVideo').hide();
        $(".login_masker").hide();
    });
   	
   	function showHideUPL(did){
		if($(did).css('display') == 'none' || $(did).css('display') == ''){
			$(did).show();
		}else{
			$(did).hide();
		}
	}
   	
   	function showHideDiv(sec,dom){
		var parent = $(dom).parents('[data-tpl]');
		var div = parent.find(sec);
		parent.removeAttr('style');
		if(div.css('display') == 'none' || div.css('display') == ''){
			div.css('display','block');
		}else{
			div.css('display','none');
		}
		div.siblings('[data-control]').hide();
	}
   	
   	function resHandler(result){
   			if(result.state=='success'){
   				layer.msg("发布成功",{icon: 1});
   				$("#text").val("");
   				window.location.reload();
   			}else{
	   			layer.msg("发布失败",{icon: 2});
   			}
   	}
   	
   	var dynList = new List({
   		url:'${ctx}/dynamic/datas',
			sendData:{
				currentPage:1,
				pageSize :5
	        },
	     	listDataModel:$('#dynModel').get(0).outerHTML,
	     	listContainer:'#dynList',
	     	dynamicVMHandler:function(one){
	     		var vm = $(dynList.options.listDataModel);
	     		vm.css('display','block');
	     		if(one.create_time){
   	     			vm.find('[data-id=create_time]').text(Filter.formatDate(one.create_time,'yyyy-MM-dd hh:mm:ss'));
   	     		}
	     		if(one.dtype!=0){
		     		if(one.role_name){
		     			var rn = one.role_name.split(',');
		     			var html = "";
		     			for (var i = 0; i < rn.length; i++) {
		     				html+=("<span>"+rn[i]+"</span>&emsp;");
		     			}
		     			vm.find('[data-id=role_name]').html(html);
		     		}
		     		vm.find('[data-user-id]').attr("href",base+'/center/'+one.user_id);
     			}else{
     				vm.find('[data-user-id]').attr("href",base+'/team/detail/'+one.user_id+'.html');
     				vm.find('[data-id=ispraise]').remove();
     				vm.find('[data-id=iscomment]').remove();
     			}
	     		if(one.isme){
	     			vm.find('[data-id=isme]').html("<div class='tools'><a style='cursor: pointer;' onclick=removeDyn('"+one.id+"',this)>删除</a></div>");
	     		}
	     		if(one.ispraise){
	     			vm.find('[data-id=ispraise]').attr('title','取消点赞');
	     		}
	     		if(one.image){
	     			var img = one.image.split(',');
	     			var html="";
	     			for (var i = 0; i < img.length; i++) {
	     				if(img[i]){
		     				html+='<div class="user_pic">';
		     				html+='<img onclick="showImage(this)" src="${ctx}/upload/'+img[i]+'" />';
		     				html+='</div>';
	     				}
	     			}
	     			vm.find('[data-id=imageVideo]').html(html);
	     		}
	     		if(one.video){
	     			var img = one.video.substring(0,one.video.lastIndexOf('.'))+".jpg";
	     			var html ='<div class="user_pic">';
	     			html+='<a onclick="createVideo(\''+one.video+'\',\''+one.create_time+'\')" class="video"></a>';
     				html+='<img onclick="createVideo(\''+one.video+'\',\''+one.create_time+'\')" src="${ctx}/upload/'+img+'" />';
     				html+='</div>';
	     			vm.find('[data-id=imageVideo]').append(html);
	     		}
	     		return vm.get(0).outerHTML;
	     	},
	     	afterRenderList:function(c,v,d){
	     		var imgs = c.find('[data-head-img]');
	     		imgs.each(function(){
	     			var error = false;
	     	        if (!this.complete) {
	     	            error = true;
	     	        }

	     	        if (typeof this.naturalWidth != "undefined" && this.naturalWidth == 0) {
	     	            error = true;
	     	        }
	     	       if(error){
	     	    	   $(this).attr("src",base+"/resources/images/headimg.png");
	     	            /* $(this).bind('error.replaceSrc',function(){
	     	                this.src = base+"/resources/images/avatar_1.jpg";

	     	                $(this).unbind('error.replaceSrc');
	     	            }).trigger('load'); */
	     	        }
	     		});
	     	}
   	});
   	dynList.loadListData().done(function(data){
		isPageEnd(data.data.page);
		dynList.renderList(data.data.page.items,'reloade_resetScroll');
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
   	
   	function showImage(dom){
   		var img = $(dom);
   		var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
        var maxW = 1000;
        var maxH = 560;
        if (iw / ih >= maxW / maxH) {
            if (iw > maxW) {
                ih = maxW / iw * ih;
                iw = maxW;
            }
        } else {
            if (ih > maxH) {
                iw = maxH / ih * iw;
                ih = maxH;
            }
        }    
        var imgHTML = '<img src="' + img.attr('src') + '" style="width:100%"/>';
        layer.open({
            type: 1,
            title: false,
            closeBtn: true,
            area: [iw + 'px', ih + 'px'],
            skin: 'layui-layer-nobg', //没有背景色
            shadeClose: true,
            content: imgHTML
        });
   	}
   	
   	function isPageEnd(page){
		if(page.currentPage*page.pageSize>page.totalCount){
			$('#loadMore').hide();
		}else{
			$('#loadMore').show();
		}
	}
   	
   	function loadMore(btn){
   		dynList.options.sendData.currentPage++;
   		dynList.loadListData().done(function(data){
			isPageEnd(data.data.page);
			if(data.data.page.items&&data.data.page.items.length!=0){
				dynList.renderList(data.data.page.items,'append');
			}else{
				$(btn).hide();
			}
    	});
	}
   	
   	function removeDyn(did,dom){
   		layer.confirm('确定要删除这篇动态么？', {
    	    btn: ['确定','取消'], //按钮
    	    shade: false //不显示遮罩
    	}, function(){
    		$.ajaxSec({
    			type: 'POST',
    			url: '${ctx}/dynamic/deleteDyn',
    			data: {id: did},
    			success: function(data){
    				if(data.state == 'success'){
						layer.msg("删除成功",{icon: 1});
						$(dom).parents('[data-tpl]').remove();
					}else{
						layer.msg("删除失败",{icon: 2});
					}
    			},
    			error: $.ajaxError
    		});
    	}, function(){});
   	}
   	
   	function doPraise(dynId,dom){
   		var flag = $(dom).attr("flag");
   		if(flag==1){
   			$(dom).attr("flag",0);
	   		$.ajaxSec({
				type: 'POST',
				url: '${ctx}/dynamic/praiseDyn',
				data: {dynamic_id: dynId},
				success: function(data){
					if(data.state == 'success'){
						$(dom).text(data.data.praiseCount);
						if(data.data.flag==1){
							$(dom).attr('title','取消点赞');
						}else{
							$(dom).attr('title','赞');
						}
					}else{
						layer.msg("操作失败",{icon: 2});
					}
					$(dom).attr("flag",1);
				},
				error: $.ajaxError
			});
   		}
   	}
   	
  	//回复说说和获取回复列表
	var commenter = new Object();
  	function reply_comment(did,dom){
  		var huifu = $(dom).parents('[data-control=huifu]');
		var list = commenter[did];
		$.ajaxSec({
			context:huifu,
			type: 'POST',
			url: '${ctx}/dynamic/replyComment',
			data: {dynamic_id: did,content:huifu.find('[name=content]').val()},
			success: function(data){
				if(data.state == 'success'){
					list.options.sendData.currentPage = 1;
					list.loadListData().done(function(data){
						layer.msg("回复成功",{icon: 1});
						huifu.find('[name=content]').val('');
						list.iniPageControl(data.data.page);
						list.renderList(data.data.page.items,'reloaded');
					});
				}
			},
			error: $.ajaxError
		});
  	}
  	
  	function reply_user(nick,dom){
  		var huifu = $(dom).parents('[data-control=huifu]');
  		huifu.find('[name=content]').val("回复 "+nick+"：")
  	}
   	
   	var comment_tpl = $('[data-tpl=comment]').get(0).outerHTML;
	$('[data-tpl=comment]').remove();
   	function getComments(did,dom){
   		var container = $(dom).parents('[data-tpl]').find('[data-container=commentList]');
   		if(!commenter[did]){
   			commenter[did] = new List({
				url:'${ctx}/dynamic/queryComments',
	   			sendData:{
	   				currentPage:1,
	   				pageSize :5,
	   				dynId:did
	   	        },
	   	     	listDataModel:comment_tpl,
	   	     	listContainer:container,
	   	     	dynamicVMHandler:function(one){
		   	     	var vm = $(commenter[did].options.listDataModel);
		   	     	vm.css('display','block');
		   	     	if(one.create_time){
	   	     			vm.find('[data-id=create_time]').text(Filter.formatDate(one.create_time,'yyyy-MM-dd hh:mm:ss'));
	   	     		}
		   	     	if(one.id){
			   	     	vm.find('[data-id=reply]').attr('onclick','reply_user("'+one.usernick+'",this)');
		   	     	}
		   	     	vm.find('[data-user-id]').attr("href",base+'/center/'+one.user_id);
	   	     		return vm.get(0).outerHTML;
	   	     	},
	   	     	afterRenderList:function(c,v){
	   	     		c.parents('[data-tpl]').removeAttr('style');
					/* c.parents('[data-tpl]').css({
						height:c.parents('[data-tpl]').height()+c.parents().find('[data-control]').get(0).scrollHeight+'px'
					}); */
	   	     	}
			});
			commenter[did].loadListData().done(function(data){
				commenter[did].iniPageControl(data.data.page);
				commenter[did].renderList(data.data.page.items,'reloaded');
			});
   		}
   	}
   	</script>
</body>
</html>