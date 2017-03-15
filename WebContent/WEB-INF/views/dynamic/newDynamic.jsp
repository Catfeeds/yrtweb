<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp" %>
<title>宇任拓-最新动态</title>
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
                <li><span class="dt_txt ms active">最新动态</span></li>
                <li onclick="location.href='${ctx}/dynamic'"><span class="dt_txt ms">关注列表</span></li>
                <li onclick="location.href='${ctx}/dynamic/me'"><span class="dt_txt ms">我的动态</span></li>
            </ul>
            <div class="clearit"></div>
            <div id="dynCount" class="fx_windows" style="background:url(images/);">
                <!-- <div class="gz">
                    <dl>
                        <dt><span class="f24 ms text-white" data-id="gznum">0</span></dt>
                        <dd class="mt5"><span class="text-gray ms">关注</span></dd>
                    </dl>
                </div>
                <div class="fs">
                    <dl>
                        <dt><span class="f24 ms text-white" data-id="bgznum">0</span></dt>
                        <dd class="mt5"><span class="text-gray ms">粉丝</span></dd>
                    </dl>
                </div>
                <div class="wdt">
                    <dl>
                        <dt><span class="f24 ms text-white" data-id="dtnum">0</span></dt>
                        <dd class="mt5"><span class="text-gray ms">我的动态</span></dd>
                    </dl>
                </div> -->
                <div class="clearit"></div>
            </div>
            </div>
            <div id="dynList" class="fx_info ">
                <div id="dynModel" data-tpl="dynamic"  class="dyn_region clearfix mt10">
                    <div class="avatar">
                        <a data-user-id class="text-white" target="_blank"><img data-head-img src="${el:headPath()}{{head_icon}}" /></a>
                    </div>
                    <div class="cont">
                        <h4 class="nickname f16 text-white"><a data-user-id class="text-white" target="_blank">{{usernick}}</a></h4>
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
                            <img data-head-img src="${ctx}/upload/${headimg}" style="width: 60px;height: 60px;" />
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
	                                <span class="pl_id">{{usernick}}</span>：{{content}}
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
    <div id="showVideo" ><img id="playSWF" src="${ctx}/resources/images/close.png"/><div id="a1" class="showvdo"></div></div>
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
		itemWidth: 80,
		itemHeight: 80,
		fileNumLimit: 1,
		fileSingleSizeLimit: 30*1024*1024, /*1M*/
		fileVal: 'file',
		server: '${ctx}/imageVideo/uploadFile?filetype=video',
		toolbar:{
			del: true
		}
	}
	$('#uplv').fileUploader($.extend({},uploadeOpts2,{inputName:'video'}));
	$('#uplv').hide();
	
	function showVideo(video){
		
	}
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
   		if(result.state){
   			if(result.state=='success'){
   				$("#text").val("");
				window.location.reload();
   			}
   		}else{
   			layer.msg(result,{icon: 2});
   		}
   	}
   	
   	/* function renderDynCount(param){
   		if(param){
   			var dyn = $("#dynCount");
   			dyn.find('[data-id=gznum]').text(param.gznum);
   			dyn.find('[data-id=bgznum]').text(param.bgznum);
   			dyn.find('[data-id=dtnum]').text(param.dtnum);
   		}
   	} */
   	
   	var dynList = new List({
   		url:'${ctx}/dynamic/newDatas',
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
     			}else{
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
	     		vm.find('[data-user-id]').attr("href",base+'/center/'+one.user_id);
	     		return vm.get(0).outerHTML;
	     	},
	     	afterRenderList:function(c){
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
   		/* renderDynCount(data.data.dynCount); */
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