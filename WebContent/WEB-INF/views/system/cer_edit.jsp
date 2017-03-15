<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>实名认证</title>
<c:set var="currentPage" value="CERIDCARD"/>
</head>
<body>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../common/header.jsp" %>
	<!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>  
		<div class="wrapper" style="margin-top: 30px;">
			 <!--页面主体-->
	            <div class="container ms">
	                <div class="middle">
	                	<%@include file="left.jsp" %>
	                	<div class="content ms">
	                        <div class="content_top">
	                            <div class="title ms">
	                                <span class="text-white f16">实名认证</span>
	                            </div>
	                            <div class="b_info">
		                            	<form method="post" id="baseinfo">
			                                <table>
		                               	        <tr>
			                                        <td class="r"><span class="f14">姓名</span></td>
			                                        <td><input type="text" name="name" value="${cer.name}" class="w160" style="" valid="require len(0,10)"/></td>
			                                    </tr>
		                               	        <tr>
			                                        <td class="r"><span class="f14">身份证号</span></td>
			                                        <td><input type="text" name="id_card" value="${cer.id_card }" class="w160" style="" valid="require sfz()"/></td>
			                                    </tr>
			                                    <tr>
			                                        <td class="r"><span class="f14">身份证正面</span></td>
			                                        <td>
			                                        	<div id="photo1" valid="requireUpload">
			                                        			<c:if test="${!empty cer.img_src}">
			                                        				<div class="fileUploader-item">
								                            			<img src="${el:headPath()}${fn:split(cer.img_src,',')[0]}">
								                            			<input type="hidden" name="img_src" value="${fn:split(cer.img_src,',')[0]}">
								                         			</div>
			                                        			</c:if>
						                           		</div>
			                                        </td>
			                                    </tr>
			                                    <tr>
			                                        <td class="r"><span class="f14">身份证反面</span></td>
			                                        <td>
			                                        	<div id="photo2" valid="requireUpload">
			                                        			<c:if test="${!empty cer.img_src}">
			                                        				<div class="fileUploader-item">
								                            			<img src="${el:headPath()}${fn:split(cer.img_src,',')[1]}">
								                            			<input type="hidden" name=ano_img_src value="${fn:split(cer.img_src,',')[1]}">
								                         			</div>
			                                        			</c:if>
						                           		</div>
			                                        </td>
			                                    </tr>
			                                    <tr>
			                                        <td></td>
			                                        <td>
			                                            <input type="button"  value="申请" class="savebtn ms f14" onclick="updateBaseInfo()"/>
			                                        </td>
			                                    </tr>
			                                </table>
	                                	</form>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </div>	
		</div>
</div>		
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript" src="${ctx }/resources/js/own/cer_info.js"></script>
</html>