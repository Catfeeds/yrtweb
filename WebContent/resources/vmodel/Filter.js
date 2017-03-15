(function(){
	Date.prototype.Format = function (fmt) { //author: meizz 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}
	window.Filter = new Object();
	Filter.formatDate = function(str,format){
		/*Y,M,D,H,m,S*/
		var a = str.split(',')[0];
		var b = str.split(',')[1];
		var c = a.split(' ')[0];
		var d = a.split(' ')[1];
		var e = b.split(' ')[0];
		var f = b.split(' ')[1];
		var g = b.split(' ')[2];
		var h = b.split(' ')[3];
		
		var hourJudge = h;
		
		var year=parseInt(f),
		month=c,
		day=parseInt(d),
		hour=parseInt(g.split(':')[0]),
		minite=parseInt(g.split(':')[1]),
		second=parseInt(g.split(':')[2]);
		
		switch(month){
			case 'Jan': month=1;break;
			case 'Feb': month=2;break;
			case 'Mar': month=3;break;
			case 'Apr': month=4;break;
			case 'May': month=5;break;
			case 'Jun': month=6;break;
			case 'Jul': month=7;break;
			case 'Aug': month=8;break;
			case 'Sep': month=9;break;
			case 'Oct': month=10;break;
			case 'Nov': month=11;break;
			case 'Dec': month=12;break;
		};
		
		if(hourJudge == 'PM'){
			hour+=12;
		}
		
		var dt = new Date();
		dt.setFullYear(year);
		dt.setMonth(month-1);
		dt.setDate(day);
		dt.setHours(hour);
		dt.setMinutes(minite);
		dt.setSeconds(second);
		
		return dt.Format(format);
	}
})();