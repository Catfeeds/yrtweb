/**
 * 后台通用Js
 * @author GL
 */
jQuery.prototype.serializeObject=function(){
    var obj=new Object();
    $.each(this.serializeArray(),function(index,param){
        if(!(param.name in obj)){
            obj[param.name]=param.value;
        }
    });
    return obj;
};
jQuery.prototype.serializeObjects=function(){
    var obj = new Object();
    $(this).find('input').each(function(){
    	var type = $(this).attr('type');
    	var name = $(this).attr('name');
    	var value = $(this).val();
    	if(name){
    		if(!value){
    			value = '';
    		}
    		if(type=='text'||type=='hidden'||type=='password'){
    			if(obj[name]){
        			obj[name] += ','+value;
        		}else{
        			obj[name] = value;
        		}
    		}else if(type=='checkbox'||type=='radio'){
    			if($(this).prop('checked')){
    				if(obj[name]){
            			obj[name] += ','+value;
            		}else{
            			obj[name] = value;
            		}
    			}
    		}
    	}
    });
    $(this).find('select').each(function(){
    	var name = $(this).attr('name');
    	var value = $(this).val();
    	if(obj[name]){
			obj[name] += ','+value;
		}else{
			obj[name] = value;
		}
    });
    $(this).find('textarea').each(function(){
    	var name = $(this).attr('name');
    	var value = $(this).val();
    	if(obj[name]){
			obj[name] += ','+value;
		}else{
			obj[name] = value;
		}
    });
    return obj;
};
var ListPage = new Object();
/**
 * 创建列表
 * @author GL
 */
ListPage.enter = function(obj,params){
    if(obj) {
        this.context = obj.context; //元素选择器
        this.url = obj.url;//规定要将请求发送到哪个 URL。
        this.searchForm = obj.searchForm;//查询条件表单
        this.param = params;
        this.iframe_index;
    }
    if(params==null) params= {};
    params.pageSize = 10;
    $.loadSec(this.context,this.url,params,function(){});
};
/**
 * 表格分页
 * @param currPage 列表当前页
 */
ListPage.paginate = function(currPage){
	this.currentPage = currPage||this.currentPage;
//	var params = $.param({currentPage:currPage});
	var params = this.param ? this.param : $(this.searchForm).serializeObject();
	params.currentPage = this.currentPage;
	params.pageSize=10;
	$.loadSec(this.context,this.url,params,function(){});
}
/**
 * 表格查询按钮
 */
ListPage.search = function(){
	var params = this.param = $(this.searchForm).serializeObject();
	params.pageSize=10;
	params.currentPage = this.currentPage = 1;
	$.loadSec(this.context,this.url,params,function(){});
}
/**
 * 表格重置按钮
 */
/*ListPage.resetSearch = function(){
	this.param = {pageSize:10};
	$.loadSec(this.context,this.url,{pageSize:10},function(){});
}*/
ListPage.resetSearch = function(){
	var params = this.param = {pageSize:10};
	var names = $(this.searchForm).find('input[type=hidden]');
	if(names&&names.length>0){
		$.each(names,function(index,param){
			var name = $(this).attr('name');
			var val = $(this).val();
			params[name]=val;
		});
	}
	$.loadSec(this.context,this.url,params,function(){});
}
/**
 * 进入表单
 * @param url 所需进入表单的URL
 * @param formid 表单form
 * @param submitUrl 保存表单的URL
 * @param objId 可选,表单对象ID
 */
ListPage.form = function(url,formid,submitUrl,objId){
	var This = this;
	var params = $.param({id:objId,pageSize:10});
	$.loadSec(this.context,url,params,function(){
    	This.formid = formid;
    	$(formid).attr("action",submitUrl);
    });
};
/**
 * 保存表单按钮
 * flag 是否留在当前页面
 */
ListPage.submit = function(flag){
	var This = this;
	$.ajaxSec({
		context:null||$(this.formid),
		type: 'POST',
		url: $(this.formid).attr("action"),
		data: $(this.formid).serializeObject(),
		cache: false,
		success: function(result){
			if (result.state=='success') {
				layer.msg("保存成功",{icon: 1});
				if(!flag){
					ListPage.paginate(This.currentPage);
				}
			}else{
				if(result.message&&result.message.error[0]){
					layer.msg(result.message.error[0],{icon: 2});
				}else{
					layer.msg("保存失败",{icon: 2});
				}
			}
		},
		error: $.ajaxError
	});
};
/**
 * 保存表单按钮 name多个
 */
ListPage.submitByMore = function(){
	var This = this;
	var lay = layer.load(1,{shade:[0.4,'#fff']});
	$.ajaxSec({
		context:null||$(this.formid),
		type: 'POST',
		url: $(this.formid).attr("action"),
		data: $(this.formid).serializeObjects(),
		cache: false,
		success: function(result){
			layer.close(lay);
			if (result.state=='success') {
				layer.msg("保存成功",{icon: 1});
				ListPage.paginate(This.currentPage);
			}else{
				if(result.message&&result.message.error[0]){
					layer.msg(result.message.error[0],{icon: 2});
				}else{
					layer.msg("保存失败",{icon: 2});
				}
			}
		},
		error: $.ajaxError
	});
};
ListPage.submit_dialog = function(){
	var This = this;
	$.ajaxSec({
		context:null||$(this.formid),
		type: 'POST',
		url: $(this.formid).attr("action"),
		data: $(this.formid).serializeObject(),
		cache: false,
		success: function(result){
			layer.closeAll('dialog');
			if (result.state=='success') {
				layer.closeAll();
				layer.msg("操作成功",{icon: 1});
				ListPage.paginate(This.currentPage);
			}else{
				if(result.message&&result.message.error[0]){
					layer.msg(result.message.error[0],{icon: 2});
				}else{
					layer.msg("操作失败",{icon: 2});
				}
			}
		},
		error: $.ajaxError
	});
}

ListPage.dialog = function(title,url,params,width,height){
	var params_str = "?random="+Math.random()+(params?ListPage.urlEncode(params):'')+'&toUrl='+url;
	var w = width?width+'px':'1330px';
	var h = height?height+'px':'640px';
	var area = [w,h];
	this.iframe_index = layer.open({
	    type: 2,
	    title: title,
	    shadeClose: true,
	    shade: [0],
	    area: area,
	    content: base+'/admin/dialog'+params_str //iframe的url
	}); 
}

ListPage.urlEncode = function (param, key, encode) {
  if(param==null) return '';
  var paramStr = '';
  var t = typeof (param);
  if (t == 'string' || t == 'number' || t == 'boolean') {
    paramStr += '&' + key + '=' + ((encode==null||encode) ? encodeURIComponent(param) : param);
  } else {
    for (var i in param) {
      var k = key == null ? i : key + (param instanceof Array ? '[' + i + ']' : '.' + i);
      paramStr += ListPage.urlEncode(param[i], k, encode);
    }
  }
  return paramStr;
};

/**
 * 删除按钮
 * @param deleteUrl 删除url
 * @param objId 须要删除数据的ID
 */
ListPage.remove = function(deleteUrl,objId){
	var This = this;
    if(objId) {
    	layer.confirm('是否删除选中记录？', {
    	    btn: ['是','否'], //按钮
    	    shade: false //不显示遮罩
    	}, function(){
    		$.ajaxSec({
    			type: 'POST',
    			url: deleteUrl,
    			data: {id: objId},
    			cache: false,
    			success: function(result){
    				if (result.state=='success') {
    					layer.msg("删除成功",{icon: 1});
    					ListPage.paginate(This.currentPage);
                    } else {
                    	layer.msg("删除失败",{icon: 2});
                    }
    			},
    			error: $.ajaxError
    		});
    	}, function(){});
    }else{
    	layer.msg('请选中要删除的记录！',{icon: 0});
    }
};

ListPage.confirm = function(msg,url,params){
	var This = this;
	layer.confirm(msg, {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: params,
			cache: false,
			success: function(result){
				if (result.state=='success') {
					layer.msg("操作成功",{icon: 1});
					ListPage.paginate(This.currentPage);
                } else {
                	if(result.message&&result.message.error[0]){
    					layer.msg(result.message.error[0],{icon: 2});
    				}else{
    					layer.msg("操作失败",{icon: 2});
    				}
                }
			},
			error: $.ajaxError
		});
	}, function(){});
}
/**
 * 树形菜单（在需要用的页面引入ztree）
 * @param setting ztree配置
 * @param treeId 创建树的对象id
 * @param url 数据查询
 * @param hideStr 隐藏字段 用于存放选中节点
 */
ListPage.extTree = function(setting,treeId,opts,hideStr){
	$.ajaxSec({
		type: 'POST',
		url: opts.url,
		data: opts.params,
		cache: false,
		success: function(result){
			var resIds = $(hideStr).val();
			var zNodes = result;
			if(resIds&&result&&result.length>0){
				zNodes = [];
	     		var ns = resIds.split(",");
	     		for (var i = 0; i < result.length; i++) {
					var node = result[i];
					if(ns&&ns.length>0){
						for (var j = 0; j < ns.length; j++) {
							if(node.res_id==ns[j]){
								node.checked = true;
								break;
							}
						}
					}
					zNodes.push(node);
				}
	     	}
	     	var treeObj = $.fn.zTree.init($(treeId), setting, zNodes);
	     	treeObj.expandAll(false);
		},
		error: $.ajaxError
	});
}

ListPage.select_tree = function(dom,opts,callBack){
	$(dom).append('<ul id="select_ztree" class="ztree"></ul>');
	var setting = {
		view: {
			showIcon: false
		},
		check: {
			enable: false
		},
		data: {
			key: {
				name: opts.name//"res_name"
			},
			simpleData: {
				enable: true,
				idKey: opts.idKey,//"res_id",
				pIdKey: opts.pIdKey//"res_parentid"
			}
		},
		callback: {
			onClick: callBack
		}
	};
	if(!opts.params) opts.params={};
	ListPage.extTree(setting,"#select_ztree",opts);
	$("#"+opts.input_id).click(function () {
	    $(dom).show();
	});
	$(document).click(function(e) {
		if(!$(dom).is(':has('+e.target.localName+')')&&e.target.id!=opts.input_id){
			$(dom).hide();
		}
	});
}

ListPage.uploadFile = function(wh,limit,size,filetype,tool){
	var tbar = {del: true,move:true};
	if(tool){
		tbar = tool;
	}
	var form_upload = {
   		uploaderType: 'imgUploader',
   		itemWidth: wh,
   		itemHeight: wh,
   		fileNumLimit: limit,
   		fileSingleSizeLimit: size*1024*1024, /*1M*/
   		fileVal: 'file',
   		multiple:true,
   		server: base+'/imageVideo/uploadFile?filetype=' + filetype,
   		toolbar:tbar
   	};
	return form_upload;
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
