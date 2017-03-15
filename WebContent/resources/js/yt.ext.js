
/**
 * js扩展
 * @author GL
 */
(function($){
	$.extend({
		ajaxSec:function(op,errorFun){
			$.ajax({
				context:null||op.context,
				type: op.type || 'GET',
				url: op.url,
				data: op.data,
				cache: false,
				async: op.async || false,
				dataType:op.dataType||'json',
				success: function(result){
					var data = $.jsonEval(result);
					if(data.loginState){
						//layer.msg("未登录",{icon: 0});
						$.openLogin(errorFun);
						return;
					}else if(data.secState){
						if(op.secMsg){
							layer.msg(op.secMsg,{icon: 0});
						}else{
							layer.msg("没有权限",{icon: 0});
						}
					}else{
						op.success(data);
					}
				},
				error: $.ajaxError
			});
		},
		loadSec:function(context,url,params,callback){
			if(arguments.length > 2) {
		        if (typeof params == 'function') {
		            callback = params;
		            params = {};
		        }
		    }
		    $(context).load( url, params, function (response,status,xhr) {
		    	var resp = $.jsonEval(response);
		    	if(resp&&resp.loginState&&resp.loginState==2){
		    		$(context).css('display','none');
					$.openLogin();
					return;
				}else if(resp&&resp.secState){
					//layer.msg("没有权限",{icon: 0});
					$(context).load("/login/accessDenied");
				}
		    	//删除所有tips
		    	layer.closeAll('tips');
		        if(typeof callback != 'undefined'){
		            callback.call(this);
		        }
		    });
		},
		ajaxSubmit:function(formid,context,callback,errorFun){
			if(arguments.length > 1) {
		        if (typeof context == 'function') {
		            callback = context;
		            context = null;
		        }
		    }
			$.ajaxSec({
				context:null||$(context),
				type: 'POST',
				url: $(formid).attr("action"),
				data: $(formid).serializeObject(),
				cache: false,
				secMsg:null||$(formid).attr("secMsg"),
				success: function(result){
					callback?callback(result):null;
				},
				error: $.ajaxError
			},errorFun);
		},
		ajaxError:function(xhr,ajaxOptions,thrownError){
			//alert("Http status: " + xhr.status + "," + xhr.statusText + "\najaxOptions: " + ajaxOptions + "\nthrownError:"+thrownError + "\n" +xhr.responseText);
			//alert("操作失败");
			layer.msg('系统错误,请稍后再试',{icon: 2});
		},
		jsonEval:function(data) {
			try{
				if ($.type(data) == 'string')
					return eval('(' + data + ')');
				else return data;
			} catch (e){
				return {};
			}
		},
		openLogin:function(errorFun){
			registerShow();
			if(typeof errorFun != 'undefined'){
				errorFun.call(this);
	        }
		},
		fixImageWH:function(dom){
			var parent = $(dom);
			var img = parent.find("img");
			if(img&&img.length>0){
				var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
			    if (iw / ih > parent.width() / parent.height()) {
			        img.css({
			            width: '100%',
			            height: 'auto'
			        });
			    } else {
			        img.css({
			            width: 'auto',
			            height: '100%'
			        });
			    }
			}
		}
	});
})(jQuery);

var yrt = {
	did: '',
	title: '确认信息',
	btn: ['&#x786E;&#x5B9A;','&#x53D6;&#x6D88;'],
	shade:true,
	cwidth:'60%',
	getDid: function (){
		return (+new Date()).toString( 32 );
	},
	open: function(options){
		var did = this.did = this.getDid();
		var temp = '<div id="dialog_'+did+'" class="custom_windows"><div id="closeBtn_'+did+'" class="closeBtn_1"></div></div>';
		var tnode = $(temp);
		var title = '<div class="custom_title"><span class="f16 text-white ms">'+options.title+'</span></div>';
		var content = '<div id="dialog_content_'+did+'" class="custom_content"></div>';
		var btn = '<div class="custom_area"><input type="button" id="dialog_yes_'+did+'" value="'+options.btn[0]+'" class="custom_btn" /><input type="button" id="dialog_no_'+did+'" value="'+options.btn[1]+'" class="custom_cannelbtn ml15" /></div>'
		var cnode = $(content);
		cnode.append(this.checkHtml(options));
		tnode.append(title);
		tnode.append(cnode);
		tnode.append(btn);
		$('body').append(tnode);
		$('body').prepend('<div class="yrtmasker"></div>');
		this.success(did,options);
	},
	confirm: function(content, options, yes, cancel){ 
		var type = typeof options === 'function';
        if(type){
            cancel = yes;
            yes = options;
        }
        return this.open($.extend({
        	title:this.title,
            content: content,
            cwidth:this.cwidth,
            shade:this.shade,
            btn: this.btn,
            yes: yes,
            cancel: cancel
        }, type ? {} : options));
	},
	success: function(did,options){
		var This = this;
		$("#closeBtn_"+did).click(function () {
			This.close(did);
		});
		$("#dialog_yes_"+did).click(function () {
			options.yes?options.yes.apply(this,[did]):null;
		});
		$("#dialog_no_"+did).click(function () {
			options.cancel?options.cancel.apply(this,[did]):null;
			This.close(did);
		});
		if(options.shade){
			var height = $(document).height();
			$(".yrtmasker").css({ "height": height }).fadeIn();
			$(".yrtmasker").click(function () {
				This.close(did);
			});
		}
		this.show(did);
	},
	show: function(did){
		$("#dialog_"+did).center().show();
	},
	close: function(did){
		$("#dialog_"+did).remove();
		$(".yrtmasker").remove();
	},
	checkHtml: function(options){
		var content = options.content;
		if(content){
			var text = content.replace(/(^\s*)|(\s*$)/g, "");
			if(text.indexOf('<')>=0){
				return content;
			}else{
				return '<p class="f16 text-white ms" style="width:'+options.cwidth+'">'+text+'</p>'
			}
		}
	},
	msg: function(msg,opts){
		layer.msg(msg,opts);
		this.close(this.did);
	}
}

jQuery.fn.center = function () {
    this.css("position", "absolute");
    this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
    this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
    return this;
}

function registerShow() {
	if(!$("#login_masker")||$("#login_masker").length<=0){
		window.parent.registerShow();
		return;
	}
    $("#login_masker").height($(document).height());
    $("#login_masker").show();
    $("#ajax_login").center().fadeIn();
    setLoginCookie();
}
function reregisterHide() {
    $("#login_masker").hide();
    $("#ajax_login").hide();
    $("#showVideo").hide();
}
$(".login_masker").click(function() {
    reregisterHide();
});
$("#ax_close").click(function() {
    reregisterHide(); 
});
function loginSubmit(dom){  
    var form = $(dom).serializeObject();  
    var pwd = $(dom).find("input[type='password']").val();
    form.password = $.md5(form.password);
    $.ajax({
		context:$(dom),
		type: 'post',
		url: base+"/ajaxLogin",
		data: form,
		dataType:'json',
		success: function(result){
			setLoginCookie();
			if(result.loginState == 1){  
				if(result.captcha==1){
					layer.msg('验证码错误',{icon: 2});
				}else{
					layer.msg('用户名或密码错误',{icon: 2});
				}
			}else if (result.loginState == 0){  
				reregisterHide();
				window.location.reload();
	        }  
		},
		error: $.ajaxError
	});
}  

function setLoginCookie(){
	 if($.cookie("j") == null){
	    	$.cookie("j", "1"); 
 	 }else{
 		 var j = parseInt($.cookie("j"));  
          if(j > 3){
	    		$("#j_ajax_captcha").css("display","block");
	       		$("#captchaImgAjax").css("display","block");
	       		$("#w_ajax_captcha").css("display","block");
	       		$("#j_ajax_captcha").attr("valid","require");
	       		$("#captcha_ajax_flag").val("false");
	       		$("#j_ajax_captcha").attr("src",base+"/jcaptcha.jpg");
	       		refreshCaptcha();
          }
 	}
}

/*获取cookie*/  
function getCookie(){  
	 var j = $.cookie("j")?parseInt($.cookie("j")):1;
    if(j > 3){
   		$("#j_ajax_captcha").css("display","block");
   		$("#captchaImgAjax").css("display","block");
   		$("#w_ajax_captcha").css("display","block");
   		$("#j_ajax_captcha").attr("valid","require");
   		$("#captcha_ajax_flag").val("false");
    }else{
    	 j = j + 1;
    	 $.cookie("j", j);
    }
}  
function refreshCaptcha(){
	$('#captchaImgAjax').hide().attr('src',base+'/jcaptcha.jpg?' + Math.floor(Math.random() * 100)).fadeIn();
}

function check_create_time(ctime,mi){
	var now = new Date();
	var c = new Date(ctime);
	var dlong = now.getTime() - c.getTime();
	var minutes=Math.floor(dlong/(60*1000))
	if(minutes<parseInt(mi)){
		return true;
	}
}

function check_user_role(){
	var flag = false;
	$.ajaxSec({
		type: 'POST',
		url: base+'/center/checkUserRole',
		success: function(result){
			if(result.state=='success'){
				flag = true;
			}
		},
		error: $.ajaxError
	});
	return flag;
}
//微信分享显示图片
$("<div style='margin:0 auto;width:0px;height:0px;overflow:hidden;'><img src='/resources/images/LOGO400.png'></div>").prependTo("body");
