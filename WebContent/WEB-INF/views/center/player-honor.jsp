<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--荣誉层-->
<div data-control="player_honor" date="tab" style="display: none;">
    <div id="honor_images" class="career_1" style="display: none;">
    	<ul class="clearfix" id="honor_list_temp" style="display: none;">
            <li id="honor_model_temp">
                <div class="guding">
                    <span class="yt_removeer" data-btn onclick="deleteHonor('${ctx}/player/deleteHonor','{{id}}')" title="删除"></span><span class="yt_editer mt10" title="编辑" data-btn onclick="edit_honor('{{id}}')"></span>
                    <div class="readme">
                        <span class="f12">{{describle}}</span>
                    </div>
                    <img title="{{name}}" src="" data-id="image_src" data-src="{{image_src}}" />
                </div>
            </li>
        </ul>
        <div class="mysly">
           <a href="javascript:void(0);" class="prev"></a>
           <a href="javascript:void(0);" class="next"></a>
           <div class="frame oneperframe" id="honor_oneperframe">
               <ul class="clearfix" id="honor_list">
                   <li id="honor_model">
                       
                   </li>
               </ul>
           </div>
       </div>
    </div>
    <div id="honorEdit" class="career_1" style="display: none;">
    	<form id="honorEditFrom" action="${ctx}/player/saveOrUpdateHonor" method="post">
    	<input type="hidden" name="id" value="{{id}}"/>
    	<input type="hidden" id="state" value="0"/>
    	<table class="carer_info">
			<tbody>
				<tr>
	              <td colspan="3"></td>
	              <td align="right"><span title="保存" id="honorEditBtn" onclick="$.ajaxSubmit('#honorEditFrom','#honorEditFrom',honorFormHandler)" class="pull-right yt_save"></span></td>
	          </tr>
				<tr>
					<td style="width: 115px;">所获荣誉名称:</td>
					<td style="text-indent:0;">
						<input type="text" valid="require len(1,60)" value="{{name}}" name="name">
					</td>
				</tr>
				<tr>
					<td valign="top"><span>荣誉图片:</span></td>
		            <td style="text-indent:0;width: 80px;">
		                <div id="honor_image" valid="requireUpload"></div>
		            </td>
				</tr>
				<tr>
					<td valign="top">荣誉描述:</td>
					<td style="text-indent:0;" colspan="3">
						<textarea name="describle" style="width: 450px;height: 60px;">{{describle}}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
    </div>
    <div id="honorModel" class="career_1">
    </div>
    <input type="button" data-button value="" onclick="edit_honor(null,this)" class="pull-right yt_add ms f16" />
    <div class="clearit"></div>
</div>
<script type="text/javascript">
var honorList;
function expand_honor(){
	honorList = new List({url:base+'/player/info',sendData:{oth_user_id:$("#oth_user_id").val(),type:'honor'},listDataModel:$('#honor_model_temp').get(0).outerHTML,listContainer:'#honor_list',
		dynamicVMHandler:function(one){
		var vm = $(honorList.options.listDataModel);
	   	vm.css('display','block');
	   	var imgSrc = vm.find("[data-id=image_src]").attr("data-src");
	   	vm.find("[data-id=image_src]").attr("src",filePath+"/"+imgSrc);
	   	return vm.get(0).outerHTML;
	}});
	load_honor_list();
}

function load_honor_list(){
	honorList.loadListData().done(function(data){
		if(data.state=='success'&&data.data.data){
			if(data.data.data.length>=5){
				$('#player_more').find("[data-control=player_honor]").find("[data-button]").remove();
			}
			honorList.renderList(data.data.data,'reloaded');
			$("#honor_images").show();
			init_loadImage("#honor_oneperframe");
		}else{
			$("#honor_images").hide();
			if(data.data.isme){
				$('#player_more').find("[data-control=player_honor]").find("[data-button]").val("添加");
				//edit_honor();
			}
		}
		if(!data.data.isme){
			$("#honor_images").find('[data-btn]').remove();
			$('#player_more').find("[data-control=player_honor]").find("[data-button]").remove();
		}
	});
}


var uploadHonorImg = {
	uploaderType: 'imgUploader',
	itemWidth: 80,
	itemHeight: 80,
	fileNumLimit: 1,
	fileSingleSizeLimit: 2*1024*1024, /*1M*/
	fileVal: 'file',
	server: '${ctx}/imageVideo/uploadFile?filetype=picture',
	toolbar:{
		del: true
	}
}
function init_upload_image(img){
	$(img).fileUploader($.extend({},uploadHonorImg,{inputName:'image_src'}));
}

var p_honor = $('#honorEdit').eq(0).get(0).innerHTML;

function edit_honor(hid,dom){
	$(dom).val("");
	var flag = true;
	$("#honorModel").find("input[id='state']").each(function(){
		if($(this).val()==0){
			flag = false;
			return;
		}
	});
	if(!flag){
		layer.msg("请先保存当前所添加的荣誉!",{icon: 2});
		return;
	}
	if(hid){
		var guid = (+new Date()).toString( 32 );
		var player_honor_edit = new Vmodel({url:base+'/player/getPlayer',sendData:{id:hid,type:'honor'},modelContainer:"#honorModel",modelTemp:$('#honorEdit').eq(0).get(0).outerHTML,dynamicVMHandler:function(one){
			var vm = $(player_honor_edit.options.modelTemp);
			vm.css('display','block');
			vm.find("form").attr("id","honorEditFrom_0");
			var html = '<div class="fileUploader-item">';
			html+='<img src="'+filePath+'/'+one.image_src+'">';
			html+='<input type="hidden" name="image_src" value="'+one.image_src+'">';
			html+='</div>';
			vm.find("#honor_image").append(html);
			vm.find("#honor_image").attr("id","honor_image_"+guid);
			vm.find("#honorEditBtn").attr("onclick","$.ajaxSubmit('#honorEditFrom_0','#honorEditFrom_0',honorFormHandler)");
			return vm.get(0).innerHTML;
		}});
		player_honor_edit.loadData().done(function(data){
			if(data.state=='success'&&data.data.data){
				player_honor_edit.renderModel(data.data.data,'reloaded');
				init_upload_image("#honor_image_"+guid);
			}else{
				layer.msg("加载失败",{icon: 2});
			}
		});
	}else{
		p_honor = $(p_honor).css('display','block').get(0).outerHTML;
		p_honor = p_honor.replaceAll('{{id}}','');
		p_honor = p_honor.replaceAll('{{name}}','');
		p_honor = p_honor.replaceAll('{{describle}}','');
		var nmodel = $(p_honor);
		nmodel.attr("id","honorEditFrom_0");
		nmodel.find("#honorEditBtn").attr("onclick","$.ajaxSubmit('#honorEditFrom_0','#honorEditFrom_0',honorFormHandler)");
		nmodel.find("#honor_image").attr("id","honor_image_0");
		$("#honorModel").empty().append(nmodel);
		init_upload_image("#honor_image_0");
	}
}

function honorFormHandler(result){
	if(result.state=='success'){
		$("#honorModel").empty();
		layer.msg("保存成功",{icon: 1});
		load_honor_list();
	}else{
		layer.msg("保存失败",{icon: 2});
	}
}

function deleteHonor(url,hid){
	layer.confirm('确定要删除这条荣誉吗？', {
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		$.ajaxSec({
			type: 'POST',
			url: url,
			data: {id: hid},
			success: function(result){
				if(result.state=='success'){
					layer.msg("删除成功",{icon: 1});
					load_honor_list();
				}else{
					layer.msg("删除失败",{icon: 2});
				}
			},
			error: $.ajaxError
		});
	}, function(){});
}
</script>

