/*表单都是以AJAX方式提交所以引入这个文件可以对表单进行拦截验证*/
/* Ajax全局配置 */
(function(){
    var validation = {
        account: function(){
            var str = $(this).val();
            if (new RegExp('^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z]+$').test(str)) {
                return false;
            } else {
                if (new RegExp('^[1][3|5|7|8][0-9]{9}$').test(str)) {
                    return false;
                } else {
                    return '必须输入正确的手机号码或者邮箱';
                }
            }
        },
        require: function() {
            var str = $(this).val();
            if(str!=null)
            	str = str.replace(/[\r\n]/g,"");
            if (!str || str == "" || new RegExp('^[ ]+$').test(str)) {
                return '不能为空';
            } else {
                return false;
            }
        },
        requireCheck:function(){
        	var checked = $(this).prop('checked');
            if(checked){
            	return false;
            }else{
            	return '必须勾选该项';
            }
        },
        requireUpload: function() {
            if ($(this).find('input[type=hidden]').size() == 0) {
                return '至少上传一张图片';
            } else {
                return false;
            }
        },
        email: function(){
            var str = $(this).val();
            if (new RegExp('^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z]+$').test(str)) {
                return false;
            } else {
                return '必须输入正确的邮箱地址';
            }
        },
        mobile: function(){
            var str = $(this).val();
            if (new RegExp('^[1][3|5|7|8][0-9]{9}$').test(str)) {
                return false;
            } else {
                return '必须输入正确的手机号码';
            }
        },
        vcode: function(){
            var str = $(this).val();
            if (new RegExp('[^0-9\.]').test(str)) {
                return '请输入6位数字验证码';
            } else {
                if(str.length!=6){
                    return '请输入6位数字验证码'
                }else {
                    return false;
                }
            }
        },
        len: function (m, n) {
            var str = $(this).val();
            var len = str.replace(new RegExp('[^\x00-\xff]', 'g'), "aa").length;
            if (m) {
                m = parseInt(m);
                if (len < m) {
                    return '最少输入' + m + '个字符,一个汉字等于两个字符！';
                }
            }
            if (n) {
                n = parseInt(n);
                if (len > n) {
                    return '最多输入' + n + '个字符,一个汉字等于两个字符！';k
                }
            }
            return false;
        },
        pwdEqual:function(sec){
            if($(sec).val() == $(this).val()){
                return false;
            }else{
                return '两次密码输入不一致，请重新输入!'
            }
        },
        spChar: function () {
            var str = $(this).val();
            if (new RegExp('[^\a-\z\A-\Z0-9\u4E00-\u9FA5\uFE30-\uFFA0\,\.\;\:\"\'\!\?]').test(str)) {
                return '只能输入中英文及常用标点符号，不能包含空格';
            } else {
                return false;
            }
        },
        pwd: function () {
            var str = $(this).val();
            if (new RegExp('^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,32}$').test(str)) {
                return false;
            } else {
                return '至少6个字符，最多32个字符，只能输入英文，数字，常用符号。（不能包含下划线和空格）';
            }
        },
        sfz: function () {
            var str = $(this).val();
        	if (new RegExp('^[0-9]{17}[0-9]|[xX]{1}$').test(str)) {
                return false;
            } else {
                return '必须输入正确的身份证号码';
            }
        },
        sfz2:function(m, n){
        	var str = $(this).val();
            var len = str.replace(new RegExp('[^\x00-\xff]', 'g'), "aa").length;
            if (m) {
                m = parseInt(m);
                if (len < m) {
                    return '最少输入' + m + '位数字或字符！';
                }
            }
            if (n) {
                n = parseInt(n);
                if (len > n) {
                    return '最多输入' + n + '位数字或字符！';
                }
            }
            return false;
        },
        number: function () {
            var str = $(this).val();
            if (new RegExp('[^0-9\.]').test(str)) {
                return '只能输入数值';
            } else {
                return false;
            }
        },
        numberScope: function (min,max) {
            var str = $(this).val();
            if (new RegExp('[^0-9]').test(str)) {
                return '只能输入大于0的数值';
            } else {
            	if(parseInt(str)<min||parseInt(str)>max){
            		return '请输入大于'+min+"和小于"+max+"的数值";
            	}
                return false;
            }
        },
        numberFloatScope: function (min,max) {
            var str = $(this).val();
            if (new RegExp('[^0-9\.]').test(str)) {
                return '只能输入大于0的数值';
            } else {
            	if(parseFloat(str)<min||parseFloat(str)>max){
            		return '请输入大于'+min+"和小于"+max+"的数值";
            	}
                return false;
            }
        },
        numberByZero: function(){
        	var str = $(this).val();
            if (new RegExp('[^0-9]').test(str)) {
                return '只能输入正整数!';
            } else {
            	return false;
            }
        },
        numberNotZero: function(){
        	var str = $(this).val();
            if (new RegExp('[^0-9]').test(str)) {
                return '只能输入大于0的正整数!';
            } else {
            	if(parseInt(str)>0){
            		return false;
            	}else{
            		return '只能输入大于0的正整数!';
            	}
            }
        },
        better2num:function(dom){
        	if(dom){
        		var num = $(dom).val();
        		var tnum = $(this).val();
        		if(parseInt(tnum)<parseInt(num)){
        			if($(this).attr('error-msg')){
        				return $(this).attr('error-msg');
        			}else{
        				return "当前数字不能小于上个数字";
        			}
        		}
        	}
        	return false;
        },
        singleCheck:function(){
        	var flag = true;
        	$(this).find('[type=radio]').each(function(){
        		var checked = $(this).prop('checked');
        		if(checked){
        			flag = false;
        			return false;
        		}
        	});
        	if(flag){
        		return '至少需要勾选一个';
        	}else{
        		return false;
        	}
        },
        oneCheck:function(){
        	var flag = true;
        	$(this).find('[type=checkbox]').each(function(){
        		var checked = $(this).prop('checked');
        		if(checked){
        			flag = false;
        			return false;
        		}
        	});
        	if(flag){
        		return '至少需要勾选一个';
        	}else{
        		return false;
        	}
        },
        price:function(len){
        	var str = $(this).val();
        	if(str!=''){
	        	if (new RegExp('[^0-9\.]').test(str)) {
	                return '价格只能输入正整数';
	            }
	        	if(parseInt(str) == 0){
	        		return '价格不能设置为0';
	        	}
	        	if(len){
	        		if(str.length > len){
	        			return '价格设置不能超过'+len+'位数';
	        		}
	        	}
        	}
        	return false;
        },
        zhekou:function(){
        	var str = $(this).val();
			//if (!new RegExp(/^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/).test(str)) {
        	if(str != 0){
        		if (!new RegExp(/^0\.[0-9]*[1-9]$/).test(str)) {
        			return '折扣只能输入大于0小于1的小数，小数点后只能保留两位数字！-';
        		}
        		if(parseFloat(str)<=0||parseFloat(str)>=10){
        			return '折扣只能输入大于0小于1的小数，小数点后只能保留两位数字！1';
        		}
        		if(str.length>4){
        			return '折扣只能输入大于0小于1的小数，小数点后只能保留两位数字！4';
        		}
        	}
        	return false;
        }
    };
    $.ajaxSetup({
        beforeSend:function(xhr,opts){
            var context = opts.context;
            var errorType = 1;
            if(context){
            	if(context.attr('errorType')) errorType = context.attr('errorType');
                var result = false;
                context.find('[valid]').each(function(){
                	if($(this).is(":hidden")){
                		return true;
                	}
                    var valids = $(this).attr('valid').split(' ');
                    var errorName = $(this).attr('data-text')?$(this).attr('data-text'):'';
                    var haveUpload = 0;
                    for(var i in valids){
                        var funcname,args;
                        if(valids[i].indexOf('(')!=-1){
                            var a = valids[i].indexOf('(');
                            var b = valids[i].indexOf(')');
                            funcname = valids[i].substring(0,a);
                            args = valids[i].substring(a+1,b).split(',');
                        }else{
                            funcname = valids[i];
                        }
                        if(args){
                        	result = validation[funcname].apply(this,args);
                        }else{
                        	result = validation[funcname].apply(this);
                        }
                        if(result){
                        	if(funcname=='requireUpload'){
                        		haveUpload = 1;
                        	}
                            break;
                        }
                    }
                    if(result){layer.closeAll('loading');
                        /*layer.tips(result,this,{
                            guide: 2,
                            style: ['background-color:#c00; color:#fff', '#c00'],
                            time: 1
                        });*/
                    	if(errorType==1){
                    		if(haveUpload){
                    			var tipsIndex = layer.tips(result,this,{
                    				tips: [2, '#c00'],
                    				time: 3000
                    			});
                    		}else{
                    			var tipsIndex = layer.tips(result,this,{
                    				tips: [2, '#c00'],
                    				time: 0
                    			});
                    			$(this).one('focus',function(){
//                            layer.closeTips();
                    				layer.close(tipsIndex);
                    			});
                    		}
                    		var t = $(this).offset().top-100;
                            $('body,html').animate({
                                scrollTop:t+'px'
                            });
                    	}else{
                    		layer.msg(errorName+result,{icon: 2});
                    	}
                        return false;
                    }
                });
                if(result){
                    return false;
                }
            }
            return true;
        }
    });
    
    $.extend({
    	submitLogin:function(formid,context,callback){
			if(arguments.length > 1) {
		        if (typeof context == 'function') {
		            callback = context;
		            context = null;
		        }
		    }
			if($(context)){
				/*var params = $(formid).serializeObject();
				console.debug(params);*/
				var result = false;
				$(context).find('[valid]').each(function(){
					 var valids = $(this).attr('valid').split(' ');
					 var errorName = $(this).attr('data-text')?$(this).attr('data-text'):'';
					 for(var i in valids){
		                    var funcname,args;
		                    if(valids[i].indexOf('(')!=-1){
		                        var a = valids[i].indexOf('(');
		                        var b = valids[i].indexOf(')');
		                        funcname = valids[i].substring(0,a);
		                        args = valids[i].substring(a+1,b).split(',');
		                    }else{
		                        funcname = valids[i];
		                    }
		                    if(funcname){
		                    	if(args){
		                    		result = validation[funcname].apply(this,args);
		                    	}else{
		                    		result = validation[funcname].apply(this);
		                    	}
		                    }
		                    if(result){
		                        break;
		                    }
		                }
		                if(result){
		                	callback?callback(errorName+result):null;
		                	return false;
		                }
				});
				if(result){
					return false;
				}
			}
			$(formid).submit();
		}
    });
    window.validBeforeAjax = function(sec){
    	var context = $(sec);
    	if(context){
            var result = false;
            context.find('[valid]').each(function(){
            	if($(this).is(":hidden")){
            		return true;
            	}
                var valids = $(this).attr('valid').split(' ');
                for(var i in valids){
                    var funcname,args;
                    if(valids[i].indexOf('(')!=-1){
                        var a = valids[i].indexOf('(');
                        var b = valids[i].indexOf(')');
                        funcname = valids[i].substring(0,a);
                        args = valids[i].substring(a+1,b).split(',');
                    }else{
                        funcname = valids[i];
                    }
                    if(args){
                    	result = validation[funcname].apply(this,args);
                    }else{
                    	result = validation[funcname].apply(this);
                    }
                    if(result){
                        break;
                    }
                }
                if(result){
                	var tipsIndex = layer.tips(result,this,{
                    	tips: [2, '#c00']
                    });
                    $(this).one('mouseenter',function(){
                    	layer.close(tipsIndex);
                    });
                    var astatus = context.attr("astatus");
                    if(!astatus){
                    	var t = $(this).offset().top-100;
                    	$('body,html').animate({
                    		scrollTop:t+'px'
                    	});
                    }
                    return false;
                }
            });
            if(result){
                return false;
            }
        }
        return true;
    } 
    jQuery.valid_oth = function(dom,iflayer){
    	var result = false;
    	if($(dom).attr('valid')){
    		var valids = $(dom).attr('valid').split(' ');
            for(var i in valids){
                var funcname,args;
                if(valids[i].indexOf('(')!=-1){
                    var a = valids[i].indexOf('(');
                    var b = valids[i].indexOf(')');
                    funcname = valids[i].substring(0,a);
                    args = valids[i].substring(a+1,b).split(',');
                }else{
                    funcname = valids[i];
                }
                if(args){
                	result = validation[funcname].apply(dom,args);
                }else{
                	result = validation[funcname].apply(dom);
                }
                if(result){
                    break;
                }
            }
            if(result&&iflayer){
            	var tipsIndex = layer.tips(result,dom,{
                	tips: [2, '#c00']
                });
                $(dom).one('mouseenter',function(){
                	layer.close(tipsIndex);
                });
                return result;
            }
    	}
    	return result;
    }
    jQuery.valid_funname = function(dom,funcname,args){
    	var result = false;
    	if(args){
        	result = validation[funcname].apply(dom,args);
        }else{
        	result = validation[funcname].apply(dom);
        }
    	return result;
    }
})();