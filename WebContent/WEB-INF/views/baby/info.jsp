<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/center.css" rel="stylesheet" />
<title>成为宝贝</title>
<c:set var="currentPage" value="BABYINDEX"/>
<style>
 .bb_active_title {
     width: 210px;
     height: 38px;
     line-height: 38px;
     margin: 0 auto;
     text-align: center;
     background: url(${ctx}/resources/images/ping.png) center;
 }
 .up_avatar {
     width: 100%;
     padding-top: 25px;
     padding-bottom: 25px;
     border-bottom: 1px solid #666;
 }

 .up_avatar a {
     float: left;
     margin-left: 460px;
     margin-top: 50px;
 }

 .active_info {
     width: 100%;
     line-height: 32px;
 }

 .active_up li {
     float: left;
     margin-right: 10px;
     margin-top: 10px;
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
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <div class="ft_baby">
                    <div class="bb_active_title">
                        <span class="text-white f16 ms">成为宝贝</span>
                    </div>
                    <!--上传头像-->
                    <div class="up_avatar">
                        <a href="#">
                            <img src="${el:headPath()}${user.head_icon}" style="width: 70px;height: 70px;" />
                        </a>
                        <div class="clearit"></div>
                    </div>
                    <div class="active_info">
                    <form id="babyInfo">
                        <table class="bb_tab" style="margin-left: 200px;margin-top: 50px; width: 740px;">
                        <input type="hidden" name="id" value="${baby.id}"/>
						<input type="hidden" name="user_id" value="${session_user_id}"/>
                            <tr>
                                <td class="w105">
                                    <span class="bb_text f14 ms fw">
                                        胸&emsp;&emsp;围 /
                                    </span>
                                </td>
                                <td>
                                    <input type="text" value="<fmt:formatNumber value="${baby.chest}" pattern="0"/>" name="chest" valid="require numberNotZero"/>
                                    <span class="ml10 text-error">*</span>
                                </td>
                                <td class="w105">
                                    <span class="bb_text f14 ms fw">
                                        腰&emsp;&emsp;围 /
                                    </span>
                                </td>
                                <td>
                                    <input type="text" value="<fmt:formatNumber value="${baby.waist}" pattern="0"/>" name="waist" valid="require numberNotZero"/>
                                    <span class="ml10 text-error">*</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="w105">
                                    <span class="bb_text f14 ms fw">
                                        身&emsp;&emsp;高 /
                                    </span>
                                </td>
                                <td>
                                    <input type="text" value="<fmt:formatNumber value="${baby.height}" pattern="0"/>" name="height" valid="require numberNotZero"/><span class="ml15 text-error">*</span>
                                </td>
                                <td class="w105">
                                    <span class="bb_text f14 ms fw">
                                        臀&emsp;&emsp;围 /
                                    </span>
                                </td>
                                <td>
                                    <input type="text" value="<fmt:formatNumber value="${baby.hip}" pattern="0"/>" name="hip" valid="require numberNotZero"/>
                                    <span class="ml10 text-error">*</span>
                                </td>

                            </tr>

                            <tr>
                                <td class="w105">
                                    <span class="bb_text f14 ms fw">
                                        体&emsp;&emsp;重 /
                                    </span>
                                </td>
                                <td>
                                   <input type="text" value="<fmt:formatNumber value="${baby.weight}" pattern="0"/>" name="weight" valid="require numberNotZero"/>
                                   <span class="ml10 text-error">*</span>
                                </td>
                                <td class="w105">
                                    <span class="bb_text f14 ms fw">
                                        身&emsp;&emsp;价 /
                                    </span>
                                </td>
                                <td>
                                	<input type="text" value="${baby.price}" name="price" valid="require numberNotZero"/>
                                    <span class="ml10 text-error">*</span>
                                </td>
                            </tr>
                            <tr>
                            	<td class="w105">
                                    <span class="bb_text f14 ms fw">
                                        喜爱球队 /
                                    </span>
                                </td>
                                <td>
                                    <input type="text" value="${baby.love_team}" name="love_team" />
                                </td>
                                <td class="w105">
                                    <span class="bb_text f14 ms fw">
                                        星&emsp;&emsp;座 /
                                    </span>
                                </td>
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
                            	 <td class="w105" valign="top">
                                    <span class="bb_text f14 ms fw">
                                        所获成就 /
                                    </span>
                                </td>
                                <td>
                                    <textarea class="tt mt5" name="achievement">${baby.achievement}</textarea>
                                </td>
                            	 <td class="w105" valign="top">
                                    <span class="bb_text f14 ms fw">
                                        爱&emsp;&emsp;好 /
                                    </span>
                                </td>
                                <td>
                                    <textarea class="tt mt5" name="hobby">${baby.hobby}</textarea>
                                </td>
                            </tr>
                            <tr>
                            <td class="w105" valign="top">
                                    <span class="bb_text f14 ms fw">
                                        个性签名 /
                                    </span>
                                </td>
                                <td>
                                    <textarea class="tt mt5" name="intro">${baby.intro}</textarea>
                                </td>
                            </tr>
                            <c:if test="${empty baby }">
								<tr>
									<td class="w105" valign="top">
                                    <span class="bb_text f14 ms fw ">
                                      	上传照片 /
                                    </span>
                              		</td>
									<td colspan="3">
										 <div class="active_up">
										 	<ul>
										 		<li>
										 			<div id="photo1" valid="requireUpload" style="float: left;"></div>
										 		</li>
										 		<li>
										 			<div id="photo2" valid="requireUpload" style="float: left;"></div>
										 		</li>
										 		<li>
										 			<div id="photo3" valid="requireUpload" style="float: left;"></div>
										 		</li>
										 		<li>
										 			<div id="photo4" valid="requireUpload" style="float: left;"></div>
										 		</li>
										 	</ul>
										 </div>
									</td>
								</tr>
							</c:if>
                        </table>
                        </form>
                        <div style="width: 600px;margin: 20px auto;text-align: center;">
                            <input type="button" name="name" value="确认" class="invi_btn f14 ms" onclick="submitInfo()"/>
                            <input type="button" name="name" value="取消" class="invi_btn f14 ms ml15" onclick="window.location='${ctx}/babyIhome/index'"/>
                        </div>
                       
                    </div>
                </div>
            </div>
        </div>
    </div>
	  	<%@ include file="../common/footer.jsp" %>
	  	<script type="text/javascript">
			$(function(){
			  	/*上传控件初始化*/
				 uploadeOptsCoach = {
					uploaderType: 'imgUploader',
					itemWidth: 72,
					itemHeight: 72,
					fileNumLimit: 1,
					fileSingleSizeLimit: 50*1024*1024, /*2M*/
					fileVal: 'file',
					server: base+'/imageVideo/uploadFile?filetype=baby_picture',
					toolbar:{
						del: true
					}
				};
	
				$('#photo1').fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  	
				$('#photo2').fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  	
				$('#photo3').fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  	
				$('#photo4').fileUploader($.extend({},uploadeOptsCoach,{inputName:'images_url'}));  
				
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
							setTimeout(function(){
								window.location = base+"/baby/base/baby/"+data.data.data.id;
							},1000);
						}else{
							layer.msg(data.message.error[0],{icon: 2});
						}
					},
				});
			
			}
	  	</script>
</body>
</html>