(function ($) {
    var W = WidgetFactory;
    var _ = WebUploader;
    var Uploader = _.Uploader;
    var errorInfo;
    var forPredict = new Uploader();
    var runtimeType = forPredict.predictRuntimeType();
    forPredict.destroy();

    $(window).unload(function(){
        for(var i in W.widgets){
            if(W.widgets[i].name == 'fileUploader'){
                $('[cs-data-uid='+W.widgets[i].uid+']').fileUploader('stopUpload');
            }
        }
    });

    $.fn.fileUploader = function (options, args) {
        //静态配置
        var defaults = {
            swf: '/resources/fileupload/webuploader/Uploader.swf',
            threads: 1,
            chunked: false,
            onError: function () {
                errorInfo = [].slice.call(arguments, 0);
                if (errorInfo[0] == 'Q_EXCEED_NUM_LIMIT') {
                    //layer.alert('超过数量限制，文件添加不成功！', 0);
                	layer.msg('超过数量限制，文件添加不成功！',{icon: 0});
                } else if (errorInfo[0] == 'F_EXCEED_SIZE') {
                    //layer.alert('超过文件大小限制，文件添加不成功！', 0);
                    layer.msg('超过文件'+(options.fileSingleSizeLimit/(1024*1024))+'M大小限制，文件添加不成功！',{icon: 0});
                } else if (errorInfo[0] == 'Q_TYPE_DENIED') {
                    //layer.alert('不支持该文件类型，文件添加不成功！', 0);
                    layer.msg('不支持该文件类型，文件添加不成功！',{icon: 0});
                }
            },
            auto: true
        }
        return this.each(function () {
            var _self = $(this), widget;
            var commandExecutor = {
                destroy: function () {
                    _self.removeAttr(W.uidName);
                    _self.empty();
                    widget.destroy();
                },
                stopUpload: function(){
                    widget.dom.uploader.stop();
                }
            };
            if (_beforeIni()) {
                _ini();
                _iniOver();
            }
            function _beforeIni() {
                if (typeof options != 'string') {
                    if (_self.attr(W.uidName)) {
                        return false;
                    } else {
                        //新建控件
                        var name, opts, paramGroup, dom, model;
                        name = 'fileUploader';
                        var compress = { width:1000,height:1000,quality: 90};
                        if(options.noCompress){
                        	compress = false;
                        }
                        if (options.uploaderType == 'imgUploader') {
                            opts = $.extend({
                                thumb: {
                                    quality: 90,
                                    allowMagnify: true,
                                    crop: false,
                                    type: 'image/jpeg'
                                },
                                compress:compress,
                                accept: {
                                    title: 'Images',
                                    extensions: 'jpg,jpeg,png,gif',
                                    mimeTypes: 'image/*'
                                },
                                fileSingleSizeLimit: 1 * 1024 * 1024,
                                toolbar: {
                                    edit: {
                                        width: 400,
                                        height: 400
                                    },
                                    move: true,
                                    del: true
                                }
                            }, defaults, options);
                            _self.addClass('imgUploader');
                            _self.addClass('fileUploader-picker-styleA');
                        }
                        if (options.uploaderType == 'vdoUploader') {
                            opts = $.extend({
                                thumb: {
                                    quality: 90,
                                    allowMagnify: true,
                                    crop: false,
                                    type: 'image/jpeg'
                                },
                                compress:{
                                    width:1000,
                                    height:1000,
                                    quality: 90
                                },
                                accept: {
                                    title: 'Videos',
                                    extensions: 'asx,asf,mpg,wmv,3gp,mp4,mov,avi,flv',
                                    mimeTypes: 'video/*'
                                },
                                fileSingleSizeLimit: 1 * 1024 * 1024,
                                toolbar: {
                                    edit: {
                                        width: 400,
                                        height: 400
                                    },
                                    move: true,
                                    del: true
                                }
                            }, defaults, options);
                            _self.addClass('imgUploader');
                            _self.addClass('fileUploader-picker-styleA');
                        }
                        paramGroup = {
                            
                        };
                        dom = {
                            picker: null,
                            uploader: null,
                            items: new Array()
                        };
                        model = {
                            it: '<div class="fileUploader-item"><img src=""/><input name="' + opts.inputName + '" type="hidden"/></div>',
                            processbar: '<div class="fileUploader-processbar"><div></div><span>0%</span></div>',
                            load: '<div class="fileUploader-loading"></div>'
                        };

                        widget = W.create(name, opts, paramGroup, dom, model);
                        _self.attr(W.uidName, widget.uid);

                        //上传按钮配置|添加|渲染
                        widget.opts.pick = {
                            id: '#filePicker-' + widget.uid,
                            multiple: options.multiple ? options.multiple : false 
                        }
                        widget.dom.picker = $('<div id="filePicker-' + widget.uid + '"></div>');
                        widget.dom.picker.css({
                            width: opts.itemWidth,
                            height: opts.itemHeight
                        });
                        _self.append(widget.dom.picker);
                        //修正浮动产生的布局影响
                        _self.append('<div style="clear:both;height:0;font-size:0;overflow:hidden;"></div>');

                        return widget.uid;
                    }
                } else {
                    var command = options;
                    if (_self.attr(W.uidName)) {
                        //装载控件
                        var uid = _self.attr(W.uidName);
                        widget = W.get(uid);
                        //字符串命令的处理接口，args可以是数组参数，也可以是单个参数
                        if (commandExecutor[command]) {
                        	if(args){
                        		commandExecutor[command].apply(this, args);
                        	}else{
                        		commandExecutor[command].apply(this, [null]);
                        	}
                        }
                    } else {
                    }
                    return false;
                }
            }
            function _iniOver() {
                widget.update();
                var uid = $('#dynamicImg').attr("cs-data-uid");
                var afterInit = widget.opts.afterInit;
                afterInit?afterInit.apply(this,[uid]):null;
            }
            function _ini() {
                widget.dom.uploader = new Uploader(widget.opts);
                if (_self.html() != '') {
                    _self.children('.fileUploader-item').each(function () {
                        var uit = _createUploadItem($(this),null);
                        if (widget.opts.uploaderType == 'imgUploader') {
                            var img = uit.it.find('img');
                            img.imagesLoaded(function () {
                                _fixImageWH(uit.it, img);
                                _bindClickImage(img,widget.opts);
                                _createToolbar(uit);
                            });
                        }
                        if (widget.opts.uploaderType == 'vdoUploader') {
                            var img = uit.it.find('img');
                            img.imagesLoaded(function () {
                                _fixImageWH(uit.it, img);
                                _bindClickVideo(img,'',widget.opts);
                                _createToolbar(uit);
                            });
                        }
                    });
                    if (widget.opts.fileNumLimit == _self.children('.fileUploader-item').size()) {
                        _hidePicker(widget.dom.picker);
                    }
                }
                widget.dom.uploader.on('fileQueued', _addFile);
                widget.dom.uploader.on('uploadProgress', _uploadProgress);
                widget.dom.uploader.on('uploadSuccess', _uploadSuccess);
            }
            function _addFile(file) {
            	var addBefore = widget.opts.addBefore;
                _createUploadItem(null, file);
                addBefore?addBefore.apply(this,[]):null;
            }
            function _uploadProgress(file, percentage) {
                var a = _getIdxByFile(file);
                var per = Math.round(percentage * 100) + "%";
                if (!widget.dom.items[a].processbar) {
                    widget.dom.items[a].processbar = $(widget.model.processbar);
                    widget.dom.items[a].it.append(widget.dom.items[a].processbar);
                }
                widget.dom.items[a].processbar.find('span').text(per);
                widget.dom.items[a].processbar.find('div').css({ width: per });
                if (per == '100%' && !widget.dom.items[a].load) {
                    widget.dom.items[a].processbar.hide();
                    widget.dom.items[a].load = $(widget.model.load);
                    widget.dom.items[a].it.append(widget.dom.items[a].load);
                }
            }
            function _uploadSuccess(file, response) {
                var a = _getIdxByFile(file);
                var img = widget.dom.items[a].it.find('img');
                widget.dom.items[a].response = response;
                widget.dom.items[a].it.find('input').val(response.data.src);
                widget.dom.items[a].it.find('input').attr('name',widget.opts.inputName);
                widget.dom.items[a].processbar.remove();
                widget.dom.items[a].processbar = null;
                var after = widget.opts.afterRender;
                
                img.imagesLoaded().done(function () {
                    _fixImageWH(widget.dom.items[a].it, img);
                    if (widget.opts.uploaderType == 'vdoUploader') {
                    	_bindClickVideo(img,response.data.src,widget.opts);
                    }else{
                    	_bindClickImage(img,widget.opts);
                    }
                    _createToolbar(widget.dom.items[a]);
                    widget.dom.items[a].load.hide();
                });
                img.attr('src', response.data.url);
                after?after.apply(this,[response.data]):null;
            }
            function _createUploadItem(it,file) {
                var uit = new Object();
                if (it) {
                    uit.it = it;
                    uit.file = null;
                } else {
                    uit.it = $(widget.model.it);
                    uit.file = file;
                    widget.dom.picker.before(uit.it);
                    if (widget.opts.fileNumLimit == _self.children('.fileUploader-item').size()) {
                        _hidePicker(widget.dom.picker);
                    }
                    uit.processbar = $(widget.model.processbar);
                    uit.it.append(uit.processbar);
                }
                uit.it.css({
                    width: widget.opts.itemWidth,
                    height: widget.opts.itemHeight
                });
                widget.dom.items.push(uit);
                return uit;
            }
            function _getIdxByFile(file) {
                var a = -1;
                for (var i in widget.dom.items) {
                    if (widget.dom.items[i].file == file) {
                        a = i;
                        break;
                    }
                }
                return a;
            }
            function _getIdxByItem(uit) {
                var a = -1;
                for (var i in widget.dom.items) {
                	if(widget.dom.items[i].file!=null && widget.dom.items[i].file!=''){
                		if (widget.dom.items[i].file.id == uit.file.id) {
                			a = i;
                			break;
                		}
                	}
                }
                return a;
            }
            function _fixImageWH(parent, img) {
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
            function _bindClickImage(img,opts) {
                var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
                img.unbind('click');
                var bindClickImage = opts.bindClickImage;
                img.click(function () {
                	if(bindClickImage){
                		bindClickImage(this);
                		return;
                	}
                    var t = $(this);
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
                    var imgHTML = '<img src="' + t.attr('src') + '" style="width:100%"/>';
                    /*$.layer({
                        type: 1,
                        title: false,
                        border: [0],
                        closeBtn: [0, true],
                        shadeClose: true,
                        area: [iw + 'px', ih + 'px'],
                        page: {
                            html: imgHTML
                        }
                    });*/
                    layer.open({
                        type: 1,
                        title: false,
                        closeBtn: true,
                        area: [iw + 'px', ih + 'px'],
                        skin: 'layui-layer-nobg', //没有背景色
                        shadeClose: true,
                        content: imgHTML
                    });
                });
            }
            function _bindClickVideo(img,vsrc,opts){
            	var iw = img.get(0).naturalWidth, ih = img.get(0).naturalHeight;
                img.unbind('click');
                var ext = vsrc.substring(vsrc.lastIndexOf("."));
                opts.showVideo?null:layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
                img.click(function () {
                	if(opts.checkVideo){
        				opts.showVideo.apply(this,[img.attr("src")]);
                	}else{
                		layer.msg('视频审核周期约15分钟，审核通过后可播放该视频',{icon: 4,area:'400px'});
                	}
                });
            }
            function _hidePicker(picker){
                picker.css('margin-left',"-9999px");
            }
            function _removeUIT(uit) {
                var a = _getIdxByItem(uit);
                if (a != -1) {
                    widget.dom.items.splice(a, 1);
                }
                uit.it.remove();
                if (uit.file) {
                    widget.dom.uploader.removeFile(uit.file, true);
                }
                widget.dom.picker.css('margin-left', 'auto');
                uit = null;
            }
            function _replaceUIT(uit) {
                $.ajax({
                    cache: false,
                    async: false,
                    type: 'POST',
                    dataType: 'json',
                    data: { "src": uit.it.find('input').val()},
                    url: base + "/imageVideo/deleteFile2"
                });
            }
            function _createToolbar(uit) {
                var toolbar_op = widget.opts.toolbar;
                uit.toolbar = $('<div class="fileUploader-toolbar fileUploader-toolbar-type1"></div>');
                uit.it.append(uit.toolbar);
                uit.it.mouseenter(function () { uit.toolbar.show(); });
                uit.it.mouseleave(function () { uit.toolbar.hide(); });
                if (uit.file && toolbar_op.edit && runtimeType == 'html5') {
                    var edit = $('<span class="fileUploader-toolbar-type1-edit" title="编辑"></span>');
                    uit.toolbar.append(edit);
                    edit.click(function () {
                        _createImageEditor(uit);
                    });
                }
                if (toolbar_op.move) {
                    var ml = $('<span class="fileUploader-toolbar-type1-ml" title="左移"></span>');
                    var mr = $('<span class="fileUploader-toolbar-type1-mr" title="右移"></span>');
                    uit.toolbar.append(ml);
                    uit.toolbar.append(mr);
                    ml.click(function () {
                        if (uit.it.prev('.fileUploader-item').size() != 0) {
                            uit.it.prev().before(uit.it);
                        } else {
                            //layer.alert('已经是第一张了！', 0);
                            layer.msg('已经是第一张了！',{icon: 0});
                        }
                    });
                    mr.click(function () {
                        if (uit.it.next('.fileUploader-item').size() != 0) {
                            uit.it.next().after(uit.it);
                        } else {
                            //layer.alert('已经最后一张了！', 0);
                            layer.msg('已经最后一张了！',{icon: 0});
                        }
                    });
                }
                if (toolbar_op.del) {
                	var afterDelete = widget.opts.afterDelete;
                    var del = $('<span class="fileUploader-toolbar-type1-del" btn-role="delete" title="删除"></span>');
                    uit.toolbar.append(del);
                    del.click(function () {
                        $.ajax({
                            cache: false,
                            async: false,
                            type: 'POST',
                            dataType: 'json',
                            data: { "src": uit.it.find('input').val() },
                            url: base + "/imageVideo/deleteFile",
                            success: function () {
                                _removeUIT(uit);
                                afterDelete?afterDelete.apply(this,[uit]):null;
                            },
                            error: function () {
                                //layer.alert('删除失败', 0);
                                layer.msg('删除失败',{icon: 2});
                            }
                        });
                    });
                }
            }

            function _createImageEditor(uit) {
                var width = widget.opts.toolbar.edit.width;
                var height = widget.opts.toolbar.edit.height;
                var editorLayer = $.layer({
                    type: 1,
                    title: false,
                    border: [0],
                    closeBtn: [0, true],
                    shadeClose: true,
                    area: [width + 'px', height + 'px'],
                    page: {
                        html: '<div id="imageEditor" class="imageEditor"><div class="imageEditor-editpane"><div class="imageEditor-image-shield"></div><img class="imageEditor-image"/></div><div class="imageEditor-toolbar"><span class="imageEditor-toolbar-canScale">可滚轮缩放</span><span class="imageEditor-toolbar-canDrag">可鼠标拖动</span><a class="imageEditor-toolbar-small">缩小</a><a class="imageEditor-toolbar-big">放大</a><a class="imageEditor-toolbar-save">保存</a></div></div>'
                    }
                });
                var editorContainer = $('#imageEditor');
                var shield = editorContainer.find('.imageEditor-image-shield');
                var picture = editorContainer.find('.imageEditor-image');
                var toolbar = editorContainer.find('.imageEditor-toolbar');

                editorContainer.css({
                    width: width,
                    height: height,
                    position: 'relative'
                });
                editorContainer.mouseenter(function () {
                    toolbar.show();
                });
                editorContainer.mouseleave(function () {
                    toolbar.hide();
                });

                shield.css({
                    width: '100%',
                    height: '100%'
                });
                shield.mousedown(function () {
                    $('body').bind('mousemove', function (ev) {
                        if (x == null) {
                            x = ev.pageX;
                        } else {
                            if (x != ev.pageX) {
                                mx += (ev.pageX - x);
                                shield.css({
                                    left: mx
                                });
                                picture.css({
                                    left: mx
                                });
                                x = ev.pageX;
                            }
                        }
                        if (y == null) {
                            y = ev.pageY;
                        } else {
                            if (y != ev.pageY) {
                                my += (ev.pageY - y);
                                shield.css({
                                    top: my
                                });
                                picture.css({
                                    top: my
                                });
                                y = ev.pageY;
                            }
                        }
                    });
                });
                shield.mousewheel(function (ev) {
                    ev.preventDefault();
                    _changePer(ev.deltaY, 5);
                });
                $('body').mouseup(function () {
                    $('body').unbind('mousemove');
                    x = null;
                    y = null;
                });

                var style = uit.it.find('img').attr('style');
                var fangxiang;
                picture.attr('src', uit.it.find('img').attr('src'));
                picture.attr('style', style);
                
                for(var i in style.split(';')){
                    if(style.split(';')[i].split(':')[0] == 'width'){
                        if(style.split(';')[i].split(':')[1] == ' auto'){
                            fangxiang = true;
                        }else{
                            fangxiang = false;
                        }
                    }
                }

                toolbar.find('a').click(function () {
                    if ($(this).hasClass('imageEditor-toolbar-small')) {
                        _changePer(-1, 10);
                    } else if ($(this).hasClass('imageEditor-toolbar-big')) {
                        _changePer(1, 10);
                    } else if ($(this).hasClass('imageEditor-toolbar-save')) {
                        _save();
                    }
                });

                uit.editorLayer = editorLayer;

                var per = 100;
                var x = null, y = null;
                var mx = picture.position().top, my = picture.position().left;

                function _changePer(b, s) {
                    per += (b * s);
                    if (fangxiang) {
                        picture.css({
                            height: per + '%'
                        });
                        shield.css({
                            width: picture.width(),
                            height: picture.height()
                        });
                    } else {
                        picture.css({
                            width: per + '%'
                        });
                        shield.css({
                            width: picture.width(),
                            height: picture.height()
                        });
                    }
                }

                function _save() {
                    var cropdata = {
                        x: picture.position().left,
                        y: picture.position().top,
                        width: width,
                        height: height,
                        scale: picture.width() / picture.get(0).naturalWidth
                    };
                    var image, deferred;
                    deferred = _.Deferred();
                    image = new _.Lib.Image();
                    deferred.always(function () {
                        image.destroy();
                        image = null;
                    });
                    image.once('error', deferred.reject);
                    image.once('load', function () {
                        image.crop(cropdata.x, cropdata.y, cropdata.width, cropdata.height, cropdata.scale);
                    });
                    image.once('complete', function () {
                        var blob, size;
                        try {
                            blob = image.getAsBlob();
                            size = new _.File(blob).size;
                            uit.file.source = blob;
                            uit.file.size = blob.size;
                            uit.file.trigger('resize', blob.size, size);
                            uit.file._info && image.info(uit.file._info);
                            uit.file._meta && image.meta(uit.file._meta);
                            layer.close(editorLayer);
                            _replaceUIT(uit);
                            widget.dom.uploader.retry(uit.file);
                            deferred.resolve();
                        } catch (e) {
                            deferred.resolve();
                        }
                    });
                    image.loadFromBlob(uit.file.source);
                    return deferred.promise();
                }
            }
        });
    }
})(jQuery);
