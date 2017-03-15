<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝贝基础信息</title>
</head>
<body>
	<form id="babyInfo">
		<table align="center">
			<input type="hidden" name="id" value="${baby.id}"/>
			<input type="hidden" name="user_id" value="${session_user_id}"/>
			<tr>
				<td>星座</td>
				<td>
					<select name="constellation" valid="require">
						<option value="白羊座" <c:if test="${baby.constellation eq '白羊座'}">selected</c:if>>白羊座</option>
						<option value="金牛座" <c:if test="${baby.constellation eq '金牛座'}">selected</c:if>>金牛座</option>
						<option value="双子座" <c:if test="${baby.constellation eq '双子座'}">selected</c:if>>双子座</option>
						<option value="巨蟹座" <c:if test="${baby.constellation eq '巨蟹座'}">selected</c:if>>巨蟹座</option>
						<option value="狮子座" <c:if test="${baby.constellation eq '狮子座'}">selected</c:if>>狮子座</option>
						<option value="处女座" <c:if test="${baby.constellation eq '处女座'}">selected</c:if>>处女座</option>
						<option value="天秤座" <c:if test="${baby.constellation eq '天秤座'}">selected</c:if>>天秤座</option>
						<option value="天蝎座" <c:if test="${baby.constellation eq '天蝎座'}">selected</c:if>>天蝎座</option>
						<option value="射手座" <c:if test="${baby.constellation eq '射手座'}">selected</c:if>>射手座</option>
						<option value="摩羯座" <c:if test="${baby.constellation eq '摩羯座'}">selected</c:if>>摩羯座</option>
						<option value="水瓶座" <c:if test="${baby.constellation eq '水瓶座'}">selected</c:if>>水瓶座</option>
						<option value="双鱼座" <c:if test="${baby.constellation eq '双鱼座'}">selected</c:if>>双鱼座</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>身高</td>
				<td>
					<input type="text" value="${baby.height}" name="height" valid="require"/>
				</td>
			</tr>
			<tr>
				<td>体重</td>
				<td>
					<input type="text" value="${baby.weight}" name="weight" valid="require"/>
				</td>
			</tr>
			<tr>
				<td>胸围</td>
				<td>
					<input type="text" value="${baby.chest}" name="chest" valid="require"/>
				</td>
			</tr>
			<tr>
				<td>腰围</td>
				<td>
					<input type="text" value="${baby.waist}" name="waist" valid="require"/>
				</td>
			</tr>
			<tr>
				<td>臀围</td>
				<td>
					<input type="text" value="${baby.hip}" name="hip" valid="require"/>
				</td>
			</tr>
			<tr>
				<td>喜爱俱乐部</td>
				<td>
					<input type="text" value="${baby.love_team}" name="love_team" />
				</td>
			</tr>
			<tr>
				<td>自我介绍</td>
				<td>
					<input type="text" value="${baby.intro}" name="intro"/>
				</td>
			</tr>
			<tr>
				<td>所获成就</td>
				<td>
					<input type="text" value="${baby.achievement}" name="achievement"/>
				</td>
			</tr>
			<tr>
				<td>爱好</td>
				<td>
					<input type="text" value="${baby.hobby}" name="hobby"/>
				</td>
			</tr>
			<tr>
				<td>上传照片</td>
				<td>
					<c:choose>
						<c:when test="${!empty imgs}">
							<c:forEach items="${imgs}" var="img" varStatus="num">
								<div id="photo${num.index+1}" valid="requireUpload" style="float: left;">
                           			<div class="fileUploader-item">
	                           			<img src="${filePath}/${img}" width="72" height="72">
	                           			<input type="hidden" name="images_url" value="${img}">
                         			</div>
	                        	</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div id="photo1" valid="requireUpload" style="float: left;">
					                      	 
		                   	</div>
							<div id="photo2" valid="requireUpload" style="float: left;">
					                      	 
		                   	</div>
							<div id="photo3" valid="requireUpload" style="float: left;">
					                      	 
		                   	</div>
							<div id="photo4" valid="requireUpload" style="float: left;">
					                      	 
		                   	</div>
						</c:otherwise>
					</c:choose>
				</td>
				<%-- <td>
					<div>
			            <img src="${ctx}/resources/images/add_pic.jpg" width="76px;" height="76px;" onclick="addMoreImg(this)">          	 
                   	</div>
				</td> --%>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="提交" onclick="submitInfo()"/>
				</td>
			</tr>
		</table>	
	</form>
	  	<%@ include file="../common/footer.jsp" %>
	  	<script type="text/javascript">
		  	var photoSize = '$({baby.images_url}'.split(",").length;
		  	var currentPhotoNum =eval(photoSize)+1;
	  	
			$(function(){
			  	/*上传控件初始化*/
				 uploadeOptsCoach = {
					uploaderType: 'imgUploader',
					itemWidth: 72,
					itemHeight: 72,
					fileNumLimit: 1,
					fileSingleSizeLimit: 2*1024*1024, /*2M*/
					fileVal: 'file',
					server: base+'/imageVideo/uploadFile?filetype=picture',
					toolbar:{
						del: true
					}
				};
	
				$('#photo1').fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  	
				$('#photo2').fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  	
				$('#photo3').fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  	
				$('#photo4').fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  

				for ( var i=1;i<=eval(photoSize);i++) {
					$('#photo'+i).fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));
				}
				
				/* var p_index=5;
				function addMoreImg(dom){
						if(p_index>=9){
							layer.alert("最多只能上传8张");
							return false;
						}
						var div='<div id="photo'+p_index+'" valid="requireUpload" style="float: left;"></div>';
						$("#addImgArea").append(div);
						$('#photo'+p_index).fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  	
						p_index++;
				} */
			});

	  	
			function submitInfo(){
				$.ajaxSec({
					context:$("#babyInfo"),
					type:"POST",
					url:base+"/baby/saveOrUpdate?random="+Math.random(),
					data:$("#babyInfo").serialize(),
					dataType:"JSON",
					success:function(data){
						if(data.state=="success"){
							layer.msg(data.message.success[0],{icon: 1});
						}else{
							layer.msg(data.message.error[0],{icon: 2});
						}
					},
				});
			
			}
	  	</script>
</body>
</html>