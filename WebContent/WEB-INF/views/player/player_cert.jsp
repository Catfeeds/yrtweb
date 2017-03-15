<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>职业球员认证</title>
<link href="${ctx}/resources/css/certification.css" rel="stylesheet" />
<c:set var="currentPage" value="CENTER"/>
<style type="text/css">
 .smrz {
      position: relative;
      width: 740px;
      margin: 0 auto;
      text-align: center;
  }
  .liji {
      position: absolute;
      bottom: 30px;
      padding: 6px 15px;
      background: #f19149;
      border-radius: 6px;
      color: #fff;
      text-decoration: none !important;
  }
  .liji:hover {
      text-decoration: none;
      background: #ff7e1d;
  }

  .liji2 {
      visibility: hidden;
      bottom: 30px;
      padding: 6px 15px;
      background: #f19149;
      color: #fff;
  }
  .qqrz{
  margin-top:40px !important;
      line-height: 24px;
  }
  .qqrz td{
  padding-top: 8px;
  padding-bottom: 8px;
  }
</style>
</head>
<body>
<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %>
         <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
	     <c:choose>
      		<c:when test="${empty user.username}">
       		 <div class="wrapper" style="margin-top: 116px;text-align: center;">
       			 <div class="smrz">
	                <a href="${ctx}/certificat/IDinfo" class="liji">立即实名认证</a>
	                <a href="${ctx}/certificat/IDinfo" class="liji2">立即实名认证</a>
	                <img src="${ctx}/resources/images/smrz.jpg" />
           		 </div>
       		 </div>   
      		</c:when>
         <c:otherwise>		
         <div class="wrapper" style="margin-top: 116px;">
       			<div class="container ms f14">
	               <div class="middle" style="">
	               <div style="width: 100%;height:40px;line-height:40px;text-align:center; background: #222D18;">
	               <span class="text-white">职业球员认证</p>
	               </div>
			             	   
			              			<form id="playerCert">
				              			<table class="qqrz">
				              				<tr>
				              					<td style="text-align: right;"><span class="text-white"> 姓名：</td>
				              					<td>
				              					<span class="text-white f14">${user.username }</span>
				              					<input type="hidden" name="name" value="${user.username }"/>	
				              					</td>
				              				</tr>
				              				<tr>
				              					<td style="text-align: right;"><span class="text-white">身份证：</span></td>
				              					<td>
				              					<span class="text-white">${user.id_card}</span>
				              					<input type="hidden" name="id_card" style="width: 150px;" value="${user.id_card}"/>
				              					</td>
				              				</tr>
				              				<tr>
				              					<td valign="top"><span class="text-white">球员参赛照片：</span></span></td>
				              					<td>
				              						<c:choose>
				              							<c:when test="${empty cer}">
						              						 <div id="photo1" style="float: left;">
					                      	 
				                      						 </div>
				                      						 <div id="photo2" style="float: left;margin-left: 5px;">
					                      	 
					                      				     </div>
					                      				     <div id="photo3" style="float: left;margin-left: 5px;">
					                      	 
				                      						 </div>
				              							</c:when>
				              							<c:otherwise>
				              								<c:forEach items="${imgs}" var="img" varStatus="num">
				              									<div id="photo${num.index+1}" style="float: left;<c:if test="${num.index!=0}">margin-left: 1px;</c:if>">
				              										<div class="fileUploader-item">
								                            			<img src="${el:headPath()}${img}" width="50" height="52">
								                            			<input type="hidden" name="img_src" value="${img}">
								                         			</div>
				              									</div>
				              								</c:forEach>
				              							</c:otherwise>
				              						</c:choose>
				              						<!-- <span>（注：至少上传两张照片，最多五张）</span> -->
				              					</td>
				              				<tr>
				              					<td style="text-align: right;" valign="top"><span class="text-white">参赛证照片：</span></td>
				              					<td>
				              						<c:choose>
				              							<c:when test="${empty cer}">
						              						<div id="photo4">
					                      	 
				                      						</div>
				                      					</c:when>
				                      					<c:otherwise>
				                      						<div id="photo4">
			              										<div class="fileUploader-item">
							                            			<img src="${el:headPath()}${cer.permit_img_src}" width="50" height="52">
							                            			<input type="hidden" name="permit_img_src" value="${cer.permit_img_src}">
							                         			</div>
			              									</div>
				                      					</c:otherwise>
				                      				</c:choose>		
				              					</td>	
				              				</tr>
				              				
				              			</table>	
			              				<div class="confirm">
			              					<input type="button" value="提交" class="btn_st" onclick="submitForm()"/>
			              				</div>
			              			</form>
			               </div>
			            </div>
		         </div>
         	</c:otherwise>
    </c:choose>
</div>
 <%@ include file="../common/footer.jsp" %>   
<script type="text/javascript">
/*上传控件初始化*/
uploadeOptsCoach = {
	uploaderType: 'imgUploader',
	itemWidth: 50,
	itemHeight: 52,
	fileNumLimit: 1,
	fileSingleSizeLimit: 1*1024*1024, /*1M*/
	fileVal: 'file',
	server: base+'/imageVideo/uploadFile?filetype=picture',
	toolbar:{
		del: true
	}
};
$('#photo1').fileUploader($.extend({},uploadeOptsCoach,{inputName:'img_src'}));
$('#photo2').fileUploader($.extend({},uploadeOptsCoach,{inputName:'img_src'}));
$('#photo3').fileUploader($.extend({},uploadeOptsCoach,{inputName:'img_src'}));
$('#photo4').fileUploader($.extend({},uploadeOptsCoach,{inputName:'permit_img_src'}));


function submitForm(){
	$.ajaxSec({
		type:"POST",
		url:base+"/certificat/savePlayerCert",
		data:$("#playerCert").serialize(),
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				layer.msg("提交成功！",{icon: 1});
				window.location = base+"/center";
			}else{
				layer.msg(data.message.error[0],{icon: 2});
			}
		}
	});
}

</script>     
</body>
</html>