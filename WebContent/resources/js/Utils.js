/**
 * 超长字符串截取显示
 * @param str
 * @param size
 * @returns
 */
function getSubStr(str,size){
	if((typeof str) == "undefined" || str == ""){
		return "";
	}
	var len = (typeof size) == "undefined"?10:size;
	if(str.length < len){
		return str;
	}else{
		str =  str.substring(0,len) + "...";
	}
	return str;
	
}

/**
 * 字符串转JSON
 * @param str
 * @returns
 */

function str2Json(o){
	if((typeof o) == "undefined" || o == ""){
		return ;
	}
	return  eval('('+o+')');
}

/**
 * JSON转字符串
 * @param str
 * @returns
 */

function json2Str(o){
	var r = [];
	if(typeof o == "string"){
		return "\""+o.replace(/([\'\"\\])/g,"\\$1").replace(/(\n)/g,"\\n").
		replace(/(\r)/g,"\\r").replace(/(\t)/g,"\\t")+"\"";
	}
	if(typeof o == "undefined"){
		return "undefined";
	}
	if(typeof o == "object"){
		if(o == null){
			return "null";
		}else if(!o.sort){
			for(var i in o){
				r.push(i+ ":" +json2Str(o[i]));
			}
			r = "{" +r.join()+ "}";
		}else{
			for(var i=0;i<o.length;i++){
				r.push(json2Str(o[i]));
			}
			r = "[" +r.join()+ "]";
		}
		return r;
	}
	return o.toString();
}

/**
 * 判断字符串是否为空
 * @param str
 * @returns
 */
function null2str(str){
	if((typeof str) == "undefined"){
		return "";
	}
	return str;
}

/**
 * 指定生成随机数范围
 * @param under 上限 over 下限 type 数据类型
 */
function fRandomBy(under, over, type){
	if(type == "int"){
		switch(arguments.length){ 
	    	case 2: return parseInt(Math.random()*under+1); 
	    	case 3: return parseInt(Math.random()*(over-under+1) + under); 
	    	default: return 0; 
	    } 
	}else if(type == "float"){
		switch(arguments.length){ 
    	case 2: return parseFloat(Math.random()*under+1.00); 
    	case 3: return parseFloat(Math.random()*(over-under+1.00) + under); 
    	default: return 0.00; 
    } 
	}
}
