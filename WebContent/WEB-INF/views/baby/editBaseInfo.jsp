<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="el" uri="/WEB-INF/tld/fileUtils.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<link href="${ctx}/resources/css/center.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝贝信息编辑</title>
<link href="${ctx}/resources/css/videoList.css" rel="stylesheet" />
<c:set var="currentPage" value="BABYINDEX"/>
</head>
<body>
 <div class="warp">
 		<div class="masker"></div>
         <!--头部-->
		 <%@ include file="../common/header.jsp" %>
		 <!--导航 start-->
	     <%@ include file="../common/naver.jsp" %>    
	     <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
            <!--页面主体-->
            <div class="container">
                <div class="ft_baby">
                    <span class="bb_name pull-left ml60 mt30 ms f24">
                       ${user.usernick }
                    </span>
                    <%-- <div class="invi_div">
                        <span class="baby_info text-white">${info_count}</span>
                        <input type="button" name="name" value="我的邀请" class="myinvi_btn ms f14  mr15  mt25" onclick="window.open('${ctx}/baby/toTeamBaby')"/>
                    </div>
                    <input type="button" name="name" value="我的代言" class="invi_btn pull-right  ms f14  mr15  mt25" onclick="window.open('${ctx}/babyIn/toInListDatas/${user.id}')"/> --%>
                    <div class="clearit"></div>
                    <div class="mybox">
                        <div class="slide_img">
                            <div id="picBox" class="picBox">
                                <ul class="cf">
                                    <li>
                                        <div class="bb_content" style="border: none;">
                                            <div class="bb_info">
                                                <!-- <span class="bb_edit move"></span> -->
                                                <span class="bb_save move" onclick="submitInfo()"></span>
                                                <span class="te fw">YRT<span class="te2">BABY</span><span class="text-gray ml10">宝贝</span> </span>
                                                <div class="clearit"></div>
												<form id="babyInfo">
                                                <table class="bb_tab">
                                                <input type="hidden" name="id" value="${baby.id}"/>
												<input type="hidden" name="user_id" value="${session_user_id}"/>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                昵&emsp;&emsp;称 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                       		 <span>${user.usernick }</span>
                                                        </td>
                                                    </tr>
                                                   <!--  <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                生&emsp;&emsp;日 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="name" value="" />
                                                        </td>
                                                    </tr> -->
                                                    <tr>
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
                                                    <!-- <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                所在城市 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="name" value="" /><span class="ml10 text-error">*</span>
                                                        </td>
                                                    </tr> -->
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                身&emsp;&emsp;高 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <input type="text" value="${baby.height}" name="height" valid="require numberNotZero"/><span class="ml10 text-error">*</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                体&emsp;&emsp;重 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <input type="text" value="<fmt:formatNumber value="${baby.weight}" pattern="0"/>" name="weight" valid="require numberNotZero"/><span class="ml10 text-error">*</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                胸&emsp;&emsp;围 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                           <input type="text" value="<fmt:formatNumber value="${baby.chest}" pattern="0"/>" name="chest" valid="require numberNotZero"/><span class="ml10 text-error">*</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                腰&emsp;&emsp;围 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <input type="text" value="<fmt:formatNumber value="${baby.waist}" pattern="0"/>" name="waist" valid="require numberNotZero"/><span class="ml10 text-error">*</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                臀&emsp;&emsp;围 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <input type="text" value="<fmt:formatNumber value="${baby.hip}" pattern="0"/>" name="hip" valid="require numberNotZero"/><span class="ml10 text-error">*</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                身&emsp;&emsp;价 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <input type="text" value="${ps.price}" name="price" valid="require numberNotZero"/><span class="ml10 text-error">*</span>
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
                                                    </tr>

                                                    <tr>
                                                        <td class="w105" valign="top">
                                                            <span class="bb_text f14 ms fw">
                                                                所获成就 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <textarea class="tt"  name="achievement">${baby.achievement}</textarea>
                                                           
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105">
                                                            <span class="bb_text f14 ms fw">
                                                                爱&emsp;&emsp;好 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <input type="text" value="${baby.hobby}" name="hobby"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="w105" valign="top">
                                                            <span class="bb_text f14 ms fw">
                                                                个性签名 /
                                                            </span>
                                                        </td>
                                                        <td>
                                                        <textarea class="tt"  name="intro">${baby.intro}</textarea>
                                                         
                                                        </td>
                                                    </tr>
                                                </table>
												</form>
                                            </div>
                                            <div class="bb_pic">
                                                <c:forEach items="${images}" var="img" begin="0" end="0">
	                                                <img src="${el:filePath(img.f_src,img.to_oss)}" style="max-width: 498px;height: 645px;float: right" />
                                            	</c:forEach>
                                            </div>
                                            <div class="clearit"></div>
                                        </div>
                                    </li>

                                    <div class="clearit"></div>
                                </ul>
                            </div>

                        </div>
                        <div class="pingjia" style="border: none;">
                            <input type="button" onclick="openUpImgs('image')" value="上传美照" class="myinvi_btn ml110" style="margin-left:40px;"/>
                            <input type="button" onclick="openUpImgs('video')" value="上传视频" class="myinvi_btn ml10"/>
                        </div>
                        <div id="baby_img_div" class="baby_pl" style="border: none;">
                            <ul id="image_list" class="bb_zhanshi">
                                <li id="image_model" style="position: relative;display: none;">
                                 <div style="position:absolute; width: 100%;height: 25px;line-height: 25px;background: #969494;opacity: .7;
filter: alpha(opacity = 70);bottom:0;display: none;">
                                     <span class="bb_removeer" onclick="removeImg('{{id}}')"></span>
                                 </div>
                                <img layer-pid="{{id}}" data-id="f_src" layer-src="${filePath}/{{f_src}}" alt="图片名" num="" src="${filePath}/{{f_src}}" style="width: 100px;height: 130px;cursor: pointer;">
                                </li>
                            </ul>
                        </div>
                        <div class="clearit"></div>
                        <div id="baby_vdo_div" class="baby_pl" style="border: none;">
                            <ul id="video_list" class="bb_zhanshi">
                                <li id="video_model" style="display: none;">
                                	<div style="position: relative;">
                                		<div id="vrmove" style="position:absolute; width: 100%;height: 25px;line-height: 25px;background: #969494;opacity: .7;
filter: alpha(opacity = 70);bottom:0;display: none;">
                                     <span class="bb_removeer" onclick="removeVdo('{{id}}')"></span>
                                 </div>
                                         <img data-id="video" src="${ctx}/resources/images/video_p.png" onclick="show_video('{{f_src}}','{{create_time}}','{{id}}','{{role_type}}')" alt="Alternate Text" style="position: absolute;width: 32px;height: 32px;top: 49px;left: 89px;cursor: pointer;" />
	                                	<img onclick="show_video('{{f_src}}','{{create_time}}','{{id}}','{{role_type}}')" data-id="src" src="" style="width: 210px;height: 130px;">
                                     </div>
                               	</li>
                            </ul>
                        </div>
                        <div class="clearit"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="video_detail" id="video_detail" style="display: none;">
	<div class="closeVideoDeatail"></div>
	<!-- <div class="videoTitle">
		<span class="text-white f20">广州俱乐部VS杭州俱乐部</span>
	</div> -->
	<div class="commentIcon">
		<span>
			<a class="goodComment" flag="1" title="赞" data-id="goodbtn" onclick="do_praise(1,this,'video')" style="cursor: pointer;"></a>
		</span>
		<span class="text-white ml20" data-id="good">0</span>
		<span class="ml15">
			<a class="badComment" flag="1" title="踩" data-id="badbtn" onclick="do_praise(2,this,'video')" style="cursor: pointer;"></a>
		</span>
		<span class="text-white ml25" data-id="bad">0</span>
	</div>
	<div id="a1" class="videoplay pull-left">
	</div>
	<div class="comment pull-left">
		
		<div class="load">
			<a id="load_more"></a>
		</div>
		<div id="commentList" class="commentBox">
 		<div id="commentModel" class="ml10 mt10" style="display: none;">
 			<div class="pull-left">
 				<img src="${el:headPath()}{{head_icon}}" class="other"/>
 			</div>
 			<div class="pull-left ml15">
 				<p>
 					<span class="text-gray" style="cursor: pointer;" data-id="usernick"></span>
 					<span data-id="create_time" class="text-gray ml10"></span>
 				</p>
 				<p class="text-white mt5 w225">{{content}}</p>
 			</div>
 			<div class="clearfix"></div>
 		</div>
		</div>
		<form id="commentsForm" errorType="2" action="${ctx}/imageVideo/saveComments">
		<input type="hidden" id="iv_id" name="iv_id" value=""/>
		<input type="hidden" id="roleType" name="roleType" value=""/>
  		<div class="publishComment">
  			<img src="${el:headPath()}${user_img}" class="publishHead"/>
			<textarea valid="require len(0,200)" data-text="评论" id="msg_content" name="content"></textarea>
			<input type="button" onclick="send_comments()" value="发表" class="publisBtn"/>
		</div>
		</form>
	</div>
</div>
   <%@ include file="../common/footer.jsp" %>
   <script src="${ctx}/resources/vmodel/List.js" type="text/javascript"></script>
    <script src="${ctx}/resources/vmodel/Filter.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
    <script src="${ctx}/resources/js/own/index_new.js"></script>
   <script type="text/javascript">
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
		var iframeImages;
		function openUpImgs(type){
			var msg = type=="video"?"视频":"美照";
			var areas = type=="video"?['390px', '440px']:['700px', '440px'];
			var url = base+ (type=="video"?base+'/common/uploadHtml?type='+type+'&role_type=BABY':'/baby/uploadImageHtml');
			iframeImages = layer.open({
			    type: 2,
			    title: '上传'+msg,
			    shadeClose: true,
			    shade: [0],
			    area: areas,
			    content: url //iframe的url
			}); 
		}
		
		var img_num = 1;
		var baby_img_list = new List({
			url:base+'/baby/queryBabyImages',
			sendData:{
				currentPage:1,
				pageSize : 16,
				type:'image'
		    },
		   	listDataModel:$('#image_model').get(0).outerHTML,
		   	listContainer:'#image_list',
		   	dynamicVMHandler:function(one){
		   		var vm = $(baby_img_list.options.listDataModel);
		   		vm.css('display','block');
		   		vm.find("img").attr("num",img_num++);
		   		if(one.to_oss == 1){
		   			vm.find("[data-id=f_src]").attr("layer-src",ossPath+one.f_src).attr("src",ossPath+one.f_src);
		   		}
		   		return vm.get(0).outerHTML;
		   	},
		   	afterRenderList:function(c,v,data){
		   		$('#image_list').append('<div class="clearit"></div>');
		   		var lis = $('#image_list').find("li");
		   		lis.hover(function(e){
		   			if(e.type=='mouseenter'){
		   				$(this).find("div").show();
		   			}else{
		   				$(this).find("div").hide();
		   			}
	   			});
		   		layer.ready(function(){
			        layer.photos({
			            photos: '#image_list'
			        });
			    });
		   	}
		});
		
		function load_baby_img(){
			baby_img_list.loadListData().done(function(data){
				if(data.state=='success'&&data.data.page.items.length>0){
					baby_img_list.iniPageControl(data.data.page);
					baby_img_list.renderList(data.data.page.items,'reloaded');
				}else{
					//$('#baby_img_div').empty().append('<span>没有上传图片</span>');
				}
				/* if(!data.data.isme){
					$('.photo').find('[data-id=isme]').remove();
					$('.photo').find('[data-tool]').remove();
				} */
			});
		}
		
		function closePOpen(type){
			layer.close(iframeImages);
			if(type&&"video"==type){
				load_baby_vdo();
			}else{
			load_baby_img();
			}
			$('.warp').scrollTop( $('body')[0].scrollHeight );
		}
		
		function removeImg(imgid){
			yrt.confirm('确定要删除这张图片吗？', {
			    btn: ['确定','取消'], //按钮
			    shade: true
			}, function(){
				$.ajaxSec({
					type: 'POST',
					url: base+'/imageVideo/removeFile',
					data: {id: imgid,type:"image"},
					success: function(result){
						if(result.state=='success'){
							yrt.msg("删除成功",{icon: 1});
							load_baby_img();
						}else{
							yrt.msg("删除失败",{icon: 2});
						}
					},
					error: $.ajaxError
				});
			}, function(){});
		}
		
		function removeVdo(vid){
			yrt.confirm('确定要删除这个视频吗？', {
			    btn: ['确定','取消'], //按钮
			    shade: true
			}, function(){
				$.ajaxSec({
					type: 'POST',
					url: base+'/imageVideo/removeFile',
					data: {id: vid,type:"video"},
					success: function(result){
						if(result.state=='success'){
							yrt.msg("删除成功",{icon: 1});
							load_baby_vdo();
						}else{
							yrt.msg("删除失败",{icon: 2});
						}
					},
					error: $.ajaxError
				});
			}, function(){});
		}
		
		var baby_vdo_list = new List({
			url:base+'/baby/queryBabyImages',
			sendData:{
				currentPage:1,
				pageSize : 4,
				type:'video'
		    },
		   	listDataModel:$('#video_model').get(0).outerHTML,
		   	listContainer:'#video_list',
		   	dynamicVMHandler:function(one){
		   		var vm = $(baby_vdo_list.options.listDataModel);
		   		vm.css('display','block');
		   		if(one.f_src){
		   			var t_src = one.f_src.substring(0,one.f_src.lastIndexOf("."))+".jpg";
		   			vm.find('[data-id=src]').attr("src",filePath+'/'+t_src);
		   		}
		   		if(one.to_oss == 1){
		   			vm.find("[data-id=video]").attr("onclick","show_video('"+ossPath+one.f_src+"','"+one.create_time+"','"+one.id+"','"+one.role_type+"')")
		   			vm.find("[data-id=src]").attr("onclick","show_video('"+ossPath+one.f_src+"','"+one.create_time+"','"+one.id+"','"+one.role_type+"')").attr("src",ossPath+one.v_cover);
		   		}
		   		return vm.get(0).outerHTML;
		   	},
		   	afterRenderList:function(c,v,data){
		   		$('#video_list').append('<div class="clearit"></div>');
		   		var lis = $('#video_list').find("li");
		   		lis.hover(function(e){
		   			if(e.type=='mouseenter'){
		   				$(this).find("#vrmove").show();
		   			}else{
		   				$(this).find("#vrmove").hide();
		   			}
	   			});
		   	}
		});
		
		function load_baby_vdo(){
			baby_vdo_list.loadListData().done(function(data){
				if(data.state=='success'&&data.data.page.items.length>0){
					baby_vdo_list.iniPageControl(data.data.page);
					baby_vdo_list.renderList(data.data.page.items,'reloaded');
				}else{
					//$('#baby_vdo_div').empty();//.append('<span style="color:white;">没有上传视频</span>');
				}
				/* if(!data.data.isme){
					$('.photo').find('[data-id=isme]').remove();
					$('.photo').find('[data-tool]').remove();
				} */
			});
		}
		$(".closeVideoDeatail").click(function () {
		    $("#a1").html("");
		    $(".masker").hide();
		    $("#msg_content").val("");
		    $('#video_detail').hide();
		});
		create_commont_list();
		
		$(function(){
			
			load_baby_img();
			load_baby_vdo();
			layer.config({
			    extend: '/extend/layer.ext.js'
			}); 
		})
		
		
   </script>   
</html>