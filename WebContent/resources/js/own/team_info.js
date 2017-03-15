$(function(){

	/*上传控件初始化*/
	var uploadeOpts = {
		uploaderType: 'imgUploader',
		itemWidth: 185,
		itemHeight: 100,
		fileNumLimit: 1,
		fileSingleSizeLimit: 1*1024*1024, /*1M*/
		fileVal: 'file',
		server: base+'/imageVideo/uploadFile?filetype=team_picture',
		toolbar:{
			del: true
		}
	};
	$('#photo').fileUploader($.extend({},uploadeOpts,{inputName:'logo'}));
	
	//球员选择添加按钮控件
	  $("#addBtn").click(function() {
		  var leftOption = $("#left").find("option:selected");
		  if((typeof leftOption.attr("value")) == 'undefined'){ 
			  layer.msg("请选择需要邀请的球员",{icon: 0});
		  }else{
			  var clone = leftOption.clone();
			  $("#right").append(clone);
			  var players = leftOption.val()+","+$("#players").val();
			  var players_name = leftOption.text()+","+$("#players_name").val();
			  if($("#players").val() == ""){
				  players =  players.replace(",","");
				  players_name =  players_name.replace(",","");
			  }
			  $("#players").val(players);
			  $("#players_name").val(players_name);
			  leftOption.remove();
		  }
	   });
	//球员选择删除按钮控件
	  $("#delBtn").click(function() {
		  var rightOption = $("#right").find("option:selected");
		  if((typeof rightOption.attr("value") == 'undefined')){ 
			  layer.msg("请选择需要删除的球员",{icon: 0});
		  }else{
			  var clone = rightOption.clone();
			  $("#left").append(clone);
			  var players = $("#players").val();
			  var players_name = $("#players_name").val();
			  if(players.indexOf(",") < 0){
				  players = "";
				  players_name = "";
			  }else{
				  if(players.indexOf(rightOption.val()) == 0){ 
					  players = players.replace(rightOption.val()+",","");
					  players_name = players_name.replace(rightOption.val()+",","");
				  }else{
					  players = players.replace(","+rightOption.val(),"");
					  players_name = players_name.replace(","+rightOption.text(),"");
				  }
			  }
			  $("#players").val(players);
			  rightOption.remove();
		  }
	   });
});
/**
 * 更新球队信息
 */
function updateTeam(){
	var s_province = $("#s_province").val();
	var s_city = $("#s_city").val();
	if(s_province == "" || s_city == ""){
		layer.msg("所属城市不能为空",{icon: 2});
		return;
	}
	var jsonData = $("#baseinfo").serializeObject();
	$.ajaxSec({
		context:$("#baseinfo"),
		type:"POST",
		url:base+"/team/saveOrUpdate",
		data:jsonData,
		dataType:"JSON",
		success:function(data){
			if(data.state=="error"){
				layer.msg(data.message.error[0],{icon: 2});
			}else{
				layer.msg("保存成功",{icon: 1});
				window.location=base+"/team/detail/"+data.data.user_id+'.html';
			}
		}
	});
}

function addBtn(){
  	 $('.invitation').css('display','block');
  	//获取遮罩高度并显示
 	$(".masker").height($(document).height());
 	$('.masker').fadeIn();			
  }
function inviteBtn(){
  	 $('.invitation').css('display','none');
  	$(".masker").fadeOut();//隐藏遮罩层
  	$("#showName").html($("#players_name").val());		
}
