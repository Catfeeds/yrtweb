$(function(){
	/*上传控件初始化*/
	var uploadeOpts1 = {
		uploaderType: 'imgUploader',
		itemWidth: 185,
		itemHeight: 100,
		fileNumLimit: 1,
		fileSingleSizeLimit: 2*1024*1024, /*1M*/
		fileVal: 'file',
		server: base+'/imageVideo/uploadFile?filetype=picture',
		toolbar:{
			del: true
		}
	};
	$('#photo1').fileUploader($.extend({},uploadeOpts1,{inputName:'img_src'}));
	$('#photo2').fileUploader($.extend({},uploadeOpts1,{inputName:'ano_img_src'}));
	
});

function updateBaseInfo(){
	$.ajax({
		context:$("#baseinfo"),
		type:"POST",
		url:base+"/certificat/save?random="+Math.random(),
		data:$("#baseinfo").serializeObject(),
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				window.location = base+"/certificat/IDinfo";
			}
		}
	});
}
