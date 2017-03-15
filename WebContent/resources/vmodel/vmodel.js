(function(){
	String.prototype.replaceAll = function(s1, s2) {
    	return this?this.replace(new RegExp(s1, "gm"), s2):null;  
    };
    var Vmodel = Class.create({
    	initialize:function(options){
            this.options = options;
        },
        loadData:function(sendData){
        	var _this = this;
            this.options.sendData = $.extend({},this.options.sendData,sendData);
            var before = this.options.beforeLoadListData;
            var after = this.options.afterLoadListData;
            before?before.apply(this,[this.options.url,this.options.sendData]):null;
            return $.ajax({
                url:this.options.url,
                data: this.options.sendData,
                type:'POST',
                cache:false,
                dataType:'json'
            }).done(function(data){
                after?after.apply(this,[data]):null;
            });
        },
        renderModel:function(data,renderWay){
        	this.datas = data;
        	 var container = $(this.options.modelContainer);
	    	 var views = [];
	    	 if(renderWay == 'reloaded') {
	             container.empty();
	         }
	    	 /*特殊逻辑的拦截处理函数*/
	    	 var dynamicVM;
	         if(this.options.dynamicVMHandler) {
	         	dynamicVM = this.options.dynamicVMHandler(data);
	         }
	         var dm = dynamicVM || this.options.modelTemp;
	         /*值替换*/
	         for(var i in data){
	             var rep = typeof data[i] != 'undefined'&&data[i]!=null?data[i]:'';
	             dm = dm.replaceAll('{{'+i+'}}',rep);
	         }
	         var oths = dm.match(new RegExp('{{.*}}','gi'));
	         for(var k in oths){
	        	 dm = dm.replaceAll(oths[k],'');
	         }
	         
	         /*解析IF*/
             var ifs = dm.match(new RegExp('<jif .*>.*</jif>'));
             for(var j in ifs){
                 var r = parseInt(j);
                 if(!r&&r!=0){
                     break;
                 }
                 var ifend = ifs[j].indexOf('>');
                 var ifended = ifs[j].indexOf('</jif>');
                 var judge = ifs[j].substring(5,ifend);
                 var text = ifs[j].substring(ifend+1,ifended);
            	 if(window.eval(judge)){
            		 if(text.indexOf(',')>0){
            			 text = text.substring(0,text.indexOf(','));
            		 }
                     dm = dm.replaceAll(ifs[j],text);
                 }else{
                	 if(text.indexOf(',')>0){
	        			 text = text.substring(text.indexOf(',')+1,text.length);
	        			 dm = dm.replaceAll(ifs[j],text);
	        		 }else{
	        			 dm = dm.replaceAll(ifs[j],'');
	        		 }
                 }
             }
	         
	         dm = $(dm);
	         views.push(dm);
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
        backModel:function(){
        	this.renderModel(this.datas,'reloaded')
        }
    }); 
    window.Vmodel = Vmodel.prototype.constructor;
})();