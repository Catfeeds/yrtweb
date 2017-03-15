$(function(){

	/*上传控件初始化*/
	var uploadeOpts1 = {
		uploaderType: 'imgUploader',
		itemWidth: 86,
		itemHeight: 60,
		fileNumLimit: 1,
		fileSingleSizeLimit: 1*1024*1024, /*1M*/
		fileVal: 'file',
		server: base+'/imageVideo/uploadFile?filetype=picture',
		toolbar:{
			del: true
		}
	};
	$('#photo1').fileUploader($.extend({},uploadeOpts1,{inputName:'head_icon'}));

	//重置
	$("#reset").click(function () {
	    $(".b_info input[type=text]").val("");
	    $(".b_info textarea").val("");
	});	
});

//更新基本信息
function updateBaseInfo(){
	$.ajaxSec({
     	type: 'POST',
     	url: base+"/system/saveBaseInfo?random="+Math.random(),
	    dataType:"JSON",
	    data:$("#baseinfo").serialize(),
	    success: function(data){
		    if(data.state=="success"){
			    layer.msg(data.message.success[0],{icon: 1});
			}else if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}
	    }

	});
}
