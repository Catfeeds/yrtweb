<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="../../common/common.jsp" %>
<c:choose>
	<c:when test="${!empty honors }">
		<c:set var="honorSize" value="${fn:length(honors)}"/>
		<c:forEach items="${honors }" var="honor" varStatus="num">
		<div class="career_1" style="position: relative;">
			<form id="honorInfo">
				<input type="hidden" name="id" value="${honor.id}"/>
				<input type="hidden" name="user_id" value="${honor.user_id}"/>
				<!-- <input type="button" onclick="saveHonor(this,'/coach/saveOrUpdateHonor')" class="yt_save"/> -->  
				<span class="yt_del ml10 pull-right" onclick="deleteHonor('${honor.id}')" title="删除"></span> 
				<span class="yt_saver_s pull-right" onclick="saveHonor(this,'/coach/saveOrUpdateHonor')" title="保存"></span>
				<table class="carer_info">
					<tr>
						<td class="w120">
				              <span class="f12 text-white">荣誉名称：</span>
				          </td>
						 <td style="text-indent:0;">
						 	<span class="f12 text-white">
						 		<input type="text" name="name" class="shuju" value="${honor.name}" valid="require len(1,60)"/>
						 	</span>
						</td>
					</tr>
					<tr>
						<td valign="top"><span class="text-white">荣誉图片:</span></td>
			            <td colspan="2" style="text-indent:0;">
			                <div class="zhengshu">
			                    <ul>
			                        <li>
			                        	<div id="photo${num.index+1}" valid="requireUpload">
			                        		<c:if test="${!empty honor.images_url}">
                                   				<div class="fileUploader-item">
			                            			<img src="${filePath}/${honor.images_url}" width="193" height="133">
			                            			<input type="hidden" name="images_url" value="${honor.images_url}">
			                         			</div>
                                   			</c:if>
			                        	</div>
		                        	</li>
			                    </ul>
			                    <div class="clearit"></div>
			                </div>
			            </td>
					</tr>
					<tr>
						<td class="w120">
			              <span class="f12 text-white">荣誉描述:</span>
			            </td>
						<td colspan="3" style="text-indent:0;">
							<span class="f12"><textarea style="width: 450px;height: 60px;" name="describle">${honor.describle}</textarea></span>
						</td>
					</tr>
				</table>
			</form>
		</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
	<div class="career_1">
		<form id="honorInfo">
			<span class="yt_saver_s pull-right" onclick="saveHonor(this,'/coach/saveOrUpdateHonor')"></span> 
				<table class="carer_info">
					<tr>
						<td style="width:115px;">所获荣誉名称:</td>
						<td style="text-indent:0;">
							<input type="text" name="name" value="" valid="require len(1,60)"/>
						</td>
					</tr>
					<tr>
						<td valign="top"><span>荣誉图片:</span></td>
			            <td colspan="2">
			                <div class="zhengshu">
			                    <ul>
			                        <li>
			                      	 <div id="photo1" valid="requireUpload">
			                      	 
			                      	 </div>
			                        </li>
			                    </ul>
			                    <div class="clearit"></div>
			                </div>
			            </td>
					</tr>
					<tr>
						<td>荣誉描述:</td>
						<td colspan="3" style="text-indent:0;">
							<textarea style="width: 450px;height: 60px;" name="describle">${honor.describle}</textarea>
						</td>
					</tr>
				</table>
		</form>
	</div>	
	</c:otherwise>
</c:choose>
<div id="honorMore"></div>
<input type="button" name="name" value="" class="pull-right yt_add ms f16" onclick="addMoreHonor()"/>
<div class="clearit"></div>
<script src="${ctx }/resources/fileupload/webuploader/webuploader.js"></script>
<script src="${ctx }/resources/fileupload/fileUploader.js"></script>
<script type="text/javascript">
var photoSize = '${honorSize}';
var currentPhotoNum =eval(photoSize)+1;
var uploadeOptsCoach=null;
$(function(){
	/*上传控件初始化*/
	 uploadeOptsCoach = {
		uploaderType: 'imgUploader',
		itemWidth: 193,
		itemHeight: 133,
		fileNumLimit: 1,
		fileSingleSizeLimit: 2*1024*1024, /*1M*/
		fileVal: 'file',
		server: base+'/imageVideo/uploadFile?filetype=picture',
		toolbar:{
			del: true
		}
	};

	//新添加时初始化一张图片
	if(photoSize==null || photoSize==''){
		photoSize=1;
	}	
	for ( var i=1;i<=eval(photoSize);i++) {
		$('#photo'+i).fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));
	}
	
});

//添加更多荣誉
function addMoreHonor(){
	var html ='<div class="career_1" style="position: relative;">';
		html+='<form id="honorInfo">';
		html+='<span class="yt_saver_s pull-right" onclick="saveHonor(this,'+"'/coach/saveOrUpdateHonor'"+')"></span>';
		html+='<table>';
		html+='<tr><td>所获荣誉名称:</td><td><input type="text" name="name" value="" valid="require len(1,60)"/></td></tr>';
		html+='<tr><td valign="top"><span>荣誉图片:</span></td><td colspan="2">';
		html+='<div class="zhengshu">';
		html+='<ul><li>';
		html+='<div id="photo'+currentPhotoNum+'" valid="requireUpload"></div>';
		html+='</li></ul><div class="clearit"></div>';
		html+='</div></td></tr>';
		html+='<tr><td>荣誉描述:</td><td style="text-indent:0"><textarea style="width: 450px;height: 60px;" name="describle">${honor.describle}</textarea></td></tr>';
		html+='</table></form>';
		html+='</div>';
		$("#honorMore").append(html);
		//初始化图片上传控件
		$('#photo'+currentPhotoNum).fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));	
}
</script>