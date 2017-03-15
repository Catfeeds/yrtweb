(function(){
	var list_num = 0;
    String.prototype.replaceAll = function(s1, s2) {
    	return this?this.replace(new RegExp(s1, "gm"), s2):null;  
    };
    var List = Class.create({
        initialize:function(options){
            this.options = options;
            this.id = list_num;
            list_num++;
        },
        add:function(dataDom){
        	var Curl = this.options.Curl;
        	var addAfter = this.options.addAfter;
        	$.ajax({
        		context:dataDom,
        		url:Curl,
        		type:'POST',
        		cache:false,
        		dataType:'json',
        		success:function(data){
        			addAfter.apply(this,[data]);
        		}
        	});
        },
        loadListData:function(sendData){
        	var _this = this;
            this.options.sendData = $.extend({},this.options.sendData,sendData);
            var before = this.options.beforeLoadListData;
            var after = this.options.afterLoadListData;
            before?before.apply(this,[this.options.url,this.options.sendData]):null;
            return $.ajax({
                url:this.options.url+'?list_id='+_this.id,
                data: this.options.sendData,
                type:'POST',
                cache:false,
                dataType:'json'
            }).done(function(data){
                after?after.apply(this,[data]):null;
            });
        },
        renderList:function(data,renderWay,orderby){
            var container = $(this.options.listContainer);
            var map = this.options.listDataMap;
            var views = [];
            if(renderWay == 'reloade_resetScroll'){
            	window.scrollTo(0,0);
                container.empty();
                container.css('height','auto');
            }
            if(renderWay == 'reloaded') {
                container.empty();
            }
            if("desc"==orderby&&data.length>0){
            	var datadesc = [];
            	for(var i=data.length-1; i >= 0; i--){
            		var index = data.length-i-1;
            		datadesc[index]=data[i];
            	}
            	data=datadesc;
            }
            for(var i in data){
                /*特殊逻辑的拦截处理函数*/
            	var dynamicVM;
                if(this.options.dynamicVMHandler) {
                	dynamicVM = this.options.dynamicVMHandler(data[i]);
                }

                var dm = dynamicVM || this.options.listDataModel;
                /*值替换*/
                for(var j in data[i]){
                    //var rep = typeof data[i][j] == 'undefined'?'null':data[i][j];
                	var rep = typeof data[i][j] != 'undefined'&&data[i][j]!=null?data[i][j]:'';
                    if(j=='usernick' && data[i]['anony_status']=='YES'){
                    	dm = dm.replaceAll('{{'+j+'}}','匿名');
                    }else{
                    	dm = dm.replaceAll('{{'+j+'}}',rep);
                    }
                }
                var oths = dm.match(new RegExp('{{.*}}','gi'));
	   	        for(var k in oths){
   	        		dm = dm.replaceAll(oths[k],'');
	   	        }
                /*映射值替换*/
                for(var j in data[i]){
                    try{
                        var rep = typeof map[j][data[i][j]] == 'undefined'?'null':map[j][data[i][j]];
                        dm = dm.replaceAll('@{' + j + '}@',rep);
                    }catch(error){}
                }
                /*解析IF*/
                var ifs = dm.match(new RegExp('<!if .*>.*</!if>'));
                for(var j in ifs){
                    var r = parseInt(j);
                    if(!r&&r!=0){
                        break;
                    }
                    var ifend = ifs[j].indexOf('>');
                    var ifended = ifs[j].indexOf('</!if>');
                    var judge = ifs[j].substring(5,ifend);
                    if(window.eval(judge)){
                        dm = dm.replaceAll(ifs[j],ifs[j].substring(ifend+1,ifended));
                    }else{
                        dm = dm.replaceAll(ifs[j],'');
                    }
                }
                dm = $(dm);
                views.push(dm);
            }
            var before = this.options.beforeRenderList;
            var after = this.options.afterRenderList;

            before?before.apply(this,[container,views]):null;
            for(var i in views){
                if(renderWay != 'prepend') {
                    container.append(views[i]);
                }else{
                    container.prepend(views[i]);
                }
            }
            container.imagesLoaded(function(){
                after?after.apply(this,[container,views,data]):null;
            });
        },
        iniPageControl:function(p){
        	var _this = this;
        	var opts = _this.options;
        	var container = $(_this.options.listContainer);
        	var pagination = $('#pagination-'+_this.id);
        	var pageGroup = 4;
        	var a,b,c;
        	if(pagination.size()==0){
        		pagination = $('<div id="pagination-'+_this.id+'" style="line-height:34px;margin-top:20px;"><span style="float:left;margin-left:30px;" data-id="totalpage"></span><ul class="pagination" style="float:right;margin:0;"></ul><div class="clear"></div></div>');
        		pagination.insertAfter(container);
        	}
        	if(p.totalCount != 0){
    			_iniPageNum();
        	}else{
        		/*没有匹配到任何数据*/
        		pagination.remove();
        	}
        	function _iniPageNum(flag){
        		if(opts.totalCount == p.totalCount){
            		a = opts.totalpage;
            	}else{
            		a = opts.totalpage = Math.ceil(p.totalCount/p.pageSize);
            	}
            	pagination.find('[data-id=totalpage]').text('共'+a+'页');
        		b = opts.sendData.currentPage;
        		c = pagination.find('.pagination');
        		c.empty('');
        		if(a != 1){
        			var prevmore = false;
        			var nextmore = false;
        			c.append('<li data-command="prev"><a>上一页</a></li>');
        			c.append('<li data-page-num="1"><a>1</a></li>');
        			if(flag == 'prev'){
        				b = b - pageGroup + 1;
        			}
        			for(var i=b,j=0;i<=a;i++){
        				if(i!=1){
	        				if(j==pageGroup){
	                			if(i<=a-1 && !nextmore){
	                				c.append('<li data-command="nextmore"><a>...</a></li>');
	                				nextmore = true;
	                			}
	                			c.append('<li data-page-num="'+a+'"><a>'+a+'</a></li>');
	                			break;
	                		}else{
	                			if(b>2 && !prevmore){
	                				c.append('<li data-command="prevmore"><a>...</a></li>');
	                				prevmore = true;
	                			}
	                			c.append('<li data-page-num="'+i+'"><a>'+i+'</a></li>');
	                			j++;
	                		}
        				}
                	}
                	c.append('<li data-command="next"><a>下一页</a></li>');
                	c.find('li').each(function(){
                		if(parseInt($(this).find('a').text()) == opts.sendData.currentPage){
                			$(this).addClass('active');
                		}
                	});
                	c.find('li').click(function(e){
                		e.preventDefault();
                		var li = $(this);
                		var dm = li.attr('data-command');
                		if(dm){
                			if(dm == 'prev'){
                				if(opts.sendData.currentPage > 1){
                					opts.sendData.currentPage--;
                					_this.loadListData().done(function(data){
                						_this.renderList(getListArr(data.data.page),'reloaded');
                						var cur = c.find('li[data-page-num='+opts.sendData.currentPage+']');
                						if(cur.size()==0){
                							_iniPageNum('prev');
                						}else{
                							cur.addClass('active').siblings('li').removeClass('active');
                						}
                					});
                				}
                			}else if(dm == 'next'){
                				if(opts.sendData.currentPage < a){
                					opts.sendData.currentPage++;
                					_this.loadListData().done(function(data){
                						_this.renderList(getListArr(data.data.page),'reloaded');
                						var cur = c.find('li[data-page-num='+opts.sendData.currentPage+']');
                						if(cur.size()==0){
                							_iniPageNum('next');
                						}else{
                							cur.addClass('active').siblings('li').removeClass('active');
                						}
                					});
                				}
                			}else if(dm == 'more'){
                				
                			}
                		}else{
                			if(!li.hasClass('active')){
        	        			opts.sendData.currentPage = parseInt(li.find('a').text());
        	        			_this.loadListData().done(function(data){
        							_this.renderList(getListArr(data.data.page),'reloaded');
        						});
        	        			li.addClass('active').siblings().removeClass('active');
                			}
                		}
                	});
        		}
        	}
        },
        iniPageControl2:function(p){
        	var _this = this;
        	var opts = _this.options;
        	var container = $(_this.options.listContainer);
        	var pagination = $('#pagination-'+_this.id);
        	var pageGroup = 4;
        	var a,b,c;
        	if(pagination.size()==0){
        		pagination = $('<div class="clear"></div><div id="pagination-'+_this.id+'"><ul class="the_paging"></ul><div class="clear"></div></div>');
        		pagination.insertAfter(container);
        	}
        	if(p.totalCount != 0){
    			_iniPageNum();
        	}else{
        		/*没有匹配到任何数据*/
        		pagination.remove();
        	}
        	function _iniPageNum(flag){
        		if(opts.totalCount == p.totalCount){
            		a = opts.totalpage;
            	}else{
            		a = opts.totalpage = Math.ceil(p.totalCount/p.pageSize);
            	}
            	pagination.find('[data-id=totalpage]').text('共'+a+'页');
        		b = opts.sendData.currentPage;
        		c = pagination.find('.the_paging');
        		c.empty('');
        		if(a != 1){
        			var prevmore = false;
        			var nextmore = false;
        			c.append('<li data-command="mprev"><a class="p_home" style="cursor: pointer;"></a></li>');
        			c.append('<li data-command="prev"><a class="p_perv" style="cursor: pointer;"></a></li>');
        			c.append('<li data-page-num="1"><a>1</a></li>');
        			if(flag == 'prev'){
        				b = b - pageGroup + 1;
        			}
        			for(var i=b,j=0;i<=a;i++){
        				if(i!=1){
	        				if(j==pageGroup){
	                			if(i<=a-1 && !nextmore){
	                				c.append('<li data-command="nextmore"><a>...</a></li>');
	                				nextmore = true;
	                			}
	                			c.append('<li data-page-num="'+a+'"><a>'+a+'</a></li>');
	                			break;
	                		}else{
	                			if(b>2 && !prevmore){
	                				c.append('<li data-command="prevmore"><a>...</a></li>');
	                				prevmore = true;
	                			}
	                			c.append('<li data-page-num="'+i+'"><a>'+i+'</a></li>');
	                			j++;
	                		}
        				}
                	}
                	c.append('<li data-command="next"><a class="p_next" style="cursor: pointer;"></a></li>');
                	c.append('<li data-command="mnext"><a class="p_end" style="cursor: pointer;"></a></li>');
                	c.find('li').each(function(){
                		if(parseInt($(this).find('a').text()) == opts.sendData.currentPage){
                			$(this).find('a').addClass('active');
                		}
                	});
                	c.find('li').click(function(e){
                		e.preventDefault();
                		var li = $(this);
                		var dm = li.attr('data-command');
                		if(dm){
                			if(dm == 'prev'){
                				if(opts.sendData.currentPage > 1){
                					opts.sendData.currentPage--;
                					_this.loadListData().done(function(data){
                						_this.renderList(getListArr(data.data.page),'reloaded');
                						var cur = c.find('li[data-page-num='+opts.sendData.currentPage+']');
                						if(cur.size()==0){
                							_iniPageNum('prev');
                						}else{
                							cur.find('a').addClass('active');
                							cur.siblings('li').find('a').removeClass('active');
                						}
                					});
                				}
                			}else if(dm == 'mprev'){
                				if(opts.sendData.currentPage > 1){
                					opts.sendData.currentPage = 1;
                					_this.loadListData().done(function(data){
                						_this.renderList(getListArr(data.data.page),'reloaded');
                						var cur = c.find('li[data-page-num='+opts.sendData.currentPage+']');
                						if(cur.size()==0){
                							_iniPageNum('prev');
                						}else{
                							cur.find('a').addClass('active');
                							cur.siblings('li').find('a').removeClass('active');
                						}
                					});
                				}
                			}else if(dm == 'next'){
                				if(opts.sendData.currentPage < a){
                					opts.sendData.currentPage++;
                					_this.loadListData().done(function(data){
                						_this.renderList(getListArr(data.data.page),'reloaded');
                						var cur = c.find('li[data-page-num='+opts.sendData.currentPage+']');
                						if(cur.size()==0){
                							_iniPageNum('next');
                						}else{
                							cur.find('a').addClass('active');
                							cur.siblings('li').find('a').removeClass('active');
                						}
                					});
                				}
                			}else if(dm == 'mnext'){
                				if(opts.sendData.currentPage < a){
                					opts.sendData.currentPage = a;
                					_this.loadListData().done(function(data){
                						_this.renderList(getListArr(data.data.page),'reloaded');
                						var cur = c.find('li[data-page-num='+opts.sendData.currentPage+']');
                						if(cur.size()==0){
                							_iniPageNum('next');
                						}else{
                							cur.find('a').addClass('active');
                							cur.siblings('li').find('a').removeClass('active');
                						}
                					});
                				}
                			}else if(dm == 'more'){
                				
                			}
                		}else{
                			if(!li.hasClass('active')){
        	        			opts.sendData.currentPage = parseInt(li.find('a').text());
        	        			_this.loadListData().done(function(data){
        							_this.renderList(getListArr(data.data.page),'reloaded');
        						});
        	        			li.find('a').addClass('active');
        	        			li.siblings().find('a').removeClass('active');
                			}
                		}
                	});
        		}
        	}
        }
    });
    function getListArr(d){
    	for(var i in d){
    		if(isArray(d[i])){
    			return d[i];
    		}
    	}
    }
    function isArray(obj) { 
    	return Object.prototype.toString.call(obj) === '[object Array]'; 
    } 
    window.List = List.prototype.constructor;
})();