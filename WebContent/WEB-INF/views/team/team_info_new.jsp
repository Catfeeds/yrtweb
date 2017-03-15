<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/clubLook.css" rel="stylesheet" />
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link href="${ctx}/resources/css/editClub.css" rel="stylesheet" />

<title>俱乐部信息</title>
<c:set var="currentPage" value="TEAMDETAIL"/>
</head>
<body>
	<div class="masker"></div>
	<!--付费提示-->
    <div class="name_pay">
        <div class="title"><span class="f16 text-white ms">提示</span></div>
        <p class="text-white f16 ms mt30">本次改名需支付<span class="text-orange">30,000</span> 宇币手续费</p>
        <div class="btn_div">
            <input type="button" onclick="change_name_fn('#change_name_form')" value="确认" class="btn_l ms f14 mt20" />
            <input type="button" value="取消" class="btn_g ms f14 ml40 mt20" id="close_pay" />
        </div>
    </div>
	<!--俱乐部改名-->
    <div class="change_name">
        <div class="closeBtn_1"></div>
        <div class="title"><span class="f16 text-white ms">俱乐部更名</span></div>
        <form method="post" id="change_name_form" astatus="1">
        <table>
            <tr>
                <td>
                    <dl class="mt20">
                        <dt><span class="ms f20 text-white">名字</span><input type="text" onblur="check_name_again(this)" flag="0" name="name" value="" valid="require len(4,26)" style="width: 230px;margin-left: 10px;" /><a>检查是否可用</a></dt>
                        <dd><span class="ml50 f12 text-white">（2到13个汉字且不包含非法字符）</span></dd>
                    </dl>

                </td>
            </tr>
            <tr>
                <td>
                    <dl class="mt20">
                        <dt><span class="ms f20 text-white">简称</span><input type="text" onblur="check_name_again(this)" flag="0" name="sim_name" value="" valid="require len(4,12)" style="width: 230px;margin-left: 10px;" /><a>检查是否可用</a></dt>
                        <dd><span class="ml50 f12 text-white">（2到13个汉字且不包含非法字符）</span></dd>
                    </dl>
                </td>
            </tr>
        </table>
        <div class="btn_div">
            <input type="button" value="确认" class="btn_l ms f14 mt20" id="on"/>
            <input type="button" value="取消" class="btn_g ms f14 ml40 mt20" id="close_change"/>
        </div>
    </div>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../common/header.jsp" %>
		  <!--导航 start-->
        <%@ include file="../common/naver.jsp" %>    
        <!--导航 end-->
		<div class="wrapper" style="margin-top: 116px;">
            <div class="l_editer">
            <form method="post" id="baseinfo">
    			<input type="hidden" name="id" value="${team.id}"/>
    			<input type="hidden" id="logo_type" name="logoType" value="0"/>
                <div class="title" style="padding: 0;">
                    <span class="ms f16">编辑设置</span>
                </div>
                <div class="my_edit">
                    <input type="hidden" class="imgFile" value=""  name="logo"/>
            		<input type="hidden" name="logo" value="${team.logo}" id="logo_val" valid="require">
					<c:choose>
						<c:when test="${!empty team.logo}">
							<img src="${el:headPath()}${team.logo}" id="logo_img" width="110" height="110" class="pull-left head" />
						</c:when>
						<c:otherwise>
							<img src="${ctx}/resources/images/xzdh.png" id="logo_img" width="110" height="110" class="pull-left head" />
						</c:otherwise>
					</c:choose>
                    <dl class="name">
                        <dt><span class="ms f20">球队名称</span><input <c:if test="${tl == 0  }">readonly="readonly"</c:if> type="text" name="name" value="${team.name}" class="txt" maxlength="13" valid="require len(4,26)"/>
                        <c:if test="${!empty team.id}">
                        <input type="button" name="name" value="改名" class="btn_l ml10" id="changeName" />
                        </c:if>
                        </dt>
                        <dt><span class="ms f20">简　　称</span><input <c:if test="${tl == 0  }">readonly="readonly"</c:if> type="text" name="sim_name" value="${team.sim_name}" class="txt" maxlength="13" valid="require len(4,12)"/></dt>
                        <c:if test="${!empty team  }">
                           <dd><span class="ms f20">成立时间</span><input type="text" value="<fmt:formatDate value='${team.create_time}' pattern='yyyy-MM-dd' />" class="txt" valid="require"/></dd>
                        </c:if>
                        <dd><span class="ms f20">经&emsp;&emsp;理</span><span class="ms f16 ml15"><yt:id2NameDB beanId="userService" id="${user_id}"></yt:id2NameDB></span></dd>
                    </dl>
                    <div class="clearit"></div>
                    <ul class="my_detail">
                        <li>
                            <span class="f20 ms">&emsp;擅长赛制</span>
                            <yt:dictSelect style="width:180px;height:25px;" clazz="ml10" name="ball_format" nodeKey="ball_format" value="${team.ball_format}" required="require"></yt:dictSelect>
                            <span class="f20 ms ml60">比赛时间</span>
                            <yt:dictSelect clazz="ml10"  style="width:170px;height:25px;" name="play_time" nodeKey="tp_time" value="${team.play_time}" required="require"></yt:dictSelect>
                        </li>
                        <li>
                            <span class="f20 ms">&emsp;所属城市</span>
                            <input type="hidden" id="province" value="${team.province}"/>
                            <input type="hidden" id="city" value="${team.city}"/>
                            <select id="s_province" name="province" class="ml10" style="width:100px;height:25px;"></select>&nbsp;
	                        <select id="s_city" name="city" class="ml10" style="width:200px;height:25px;"></select>&nbsp;
                        </li>
                        <li>
                            <span class="f20 ms ml20">常驻球场</span><input type="text" name="play_position" valid="len(0,50)" value="${team.play_position }" class="txt" style="width:500px;"/>
                        </li>
                        <li>
                            <span class="f20 ms pull-left">俱乐部简介</span>
                            <textarea maxlength="100" name="remark" valid="len(0,2000)">${team.remark}</textarea>
                            <div class="clearit"></div>
                        </li>
                        <li style="margin-top: 5px;border-bottom: 1px solid #666;padding-bottom: 15px;">
	                        <div id="up_remark_imgs" class="four_pic" style="margin-left: 112px;width:100%;" >
                                <c:if test="${!empty team.remark_images}">
                                <c:forEach items="${fn:split(team.remark_images, ',')}" var="rimg" end="2">
		               			<div class="fileUploader-item">
		               				<img src="${el:headPath()}${rimg}">
		                  			<input type="hidden" name="remark_images" value="${rimg}">
		               			</div>
		               			</c:forEach>
		             			</c:if>
                            </div>
                            <div class="clearit"></div>
                            <span style="margin-left: 117px; color: #666;">注：最多上传三张俱乐部图片。</span>
                        </li>
                    </ul>
                    <h3 class="mt40">详 情 设 置</h3>
                    <div class="mt35">
                        <span class="f16 ms">是否接受挑战</span>
						<c:choose>
							<c:when test="${tl == 0}">
								<input class="ml10" name="is_pk" type="hidden" value="${team.is_pk}" />
								<span class="ml5 f16 ms"><yt:dict2Name nodeKey="status" key="${tl}"></yt:dict2Name></span>
							</c:when>
							<c:otherwise>
								<input type="radio" class="ml10" name="is_pk" value="1"
									<c:if test="${empty team.is_pk or team.is_pk eq 1}"> checked</c:if> />
								<span class="ml5 f16 ms">是</span>
								&emsp;
								<input type="radio" class="ml10"  name="is_pk" value="0"
									<c:if test="${team.is_pk eq 0 }"> checked</c:if> />
								<span class="ml5 f16 ms">否</span>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${tl == 0}">
								<span class="ml100 f16 ms">是否允许加入俱乐部</span>
								<span class="ml5 f16 ms"><yt:dict2Name nodeKey="status" key="${team.allow}"></yt:dict2Name></span>
							</c:when>
							<c:otherwise>
								<span class="ml100 f16 ms">是否允许加入俱乐部</span>
		                        <input type="radio" name="allow" class="ml10" value="1" <c:if test="${empty team.is_pk or team.is_pk eq 1}"> checked</c:if>/>
		                        <span class="ml5 f16 ms">是</span>&emsp;
		 						<input type="radio" name="allow" class="ml10" value="0" <c:if test="${empty team || team.is_pk eq 0}"> checked</c:if>/>
		 						<span class="ml5 f16 ms">否</span>
							</c:otherwise>
						</c:choose>
						
                    </div>
                    <div class="btn_div">
						<c:choose>
							<c:when test="${empty team.id}">
								<input type="button" name="save" value="创建" onclick="updateTeam()" class="btn_l ms f16"/>
							</c:when>
							<c:otherwise>
								<input type="button" name="save" value="保存" onclick="updateTeam()" class="btn_l ms f16"/>
							</c:otherwise>
						</c:choose>
						<input type="button" name="cancel" value="取消" class="btn_g ms f16 ml30" onclick="javascript:window.location='${ctx}/team/guide'"/>
                    </div>
                </div>
              </form>
            </div>
        </div>
		<div class="clubLogo ms">
		            <div class="closeBtn_1"></div>
               		<h4 class="text-gray ml10 mt5 f16">俱乐部头像更换</h4>
               		<ul class="mt20 ml20">
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_1.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_2.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_3.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_4.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_5.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_6.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_7.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_8.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_9.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_10.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_11.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_12.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_13.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_14.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_15.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_16.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_17.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_18.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_19.png" />
               			</li>
               			<li>
               				<img src="${ctx}/resources/images/clubLogo_20.png" />
               			</li>
               			<%-- <li>
               				<input type="file" class="imgFile"/>
               				<img src="${ctx}/resources/images/upload.png"/>
               			</li> --%>
               		</ul>
               	
               		
               		<div class="clear" style="height:20px;"></div>
               		<a href="javascript:;" onclick="change_team_img()" class="text-white ml35">+上传自定义头像</a>
               		<div class="text-center mt10">
               			<input type="button" value="确认" class="logoBtn" onclick="checkIcon()"/>
               			<input type="button" value="取消" class="logoBtn_cancel" />
               		</div>
               </div>
</div>		
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript" src="${ctx}/resources/js/area.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/own/team_info.js"></script>
<script type="text/javascript">
	 if('${team.province}' !="" && '${team.city}' !=""){
		new PCAS('province', 'city','${team.province}','${team.city}');
	}else{
		new PCAS('province', 'city');
	} 
	$('.clubLogo').css('display','none');
	//邀请好友关闭按钮
	$(".closeBtn").click(function(){
    	$('.invitation').css('display','none');
    	$('.masker').fadeOut();
    });
	
	 //显示上传俱乐部LOGO
    $("#logo_img").click(function(){
    	 $(".masker").height($(document).height()).fadeIn();
    	 $(".masker").show();
    	$('.clubLogo').center().css('display','block');
    });
    //隐藏上传俱乐部LOGO
     $(".logoBtn_cancel").click(function(){
    	$('.clubLogo').css('display','none');
    });
    
    $(".logoBtn_cancel").click(function(){
    	$(".masker").hide();
    	$('.clubLogo').css('display','none');
    });
    
    //LOGO选中效果
     $(".clubLogo li img").click(function(){
    	$(".clubLogo li img").removeClass("clubLogoChecked");
  		$(this).each(function(){
    			$(this).addClass("clubLogoChecked");
			});
     });	
    
    //选中俱乐部ICON
    function checkIcon(){
    	var img = $(".clubLogoChecked").attr("src");
    	$("#logo_val").val(img);
    	$("#logo_img").attr("src",img);
    	$(".masker").hide();
    	$('.clubLogo').css('display','none');
    	$("#logo_type").val(0);
    }

    jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
        this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
        return this;
    }

    function ctl(){
    	$(".masker").hide();
    	$('.clubLogo').hide();
    }    
    $(".masker").click(function(){
    	//ctl();
    })
     $(".closeBtn_1").click(function(){
    	 $(".masker").hide();
     	$('.clubLogo').hide();
     	$(".change_name").hide();
    })
    
    $("#changeName").click(function() {
        $(".masker").height($(document).height()).fadeIn();
        $(".change_name").center().fadeIn();
        $(".change_name").find("input[type=text]").val("");
    });
    $("#close_change").click(function () {
    	$(".masker").hide();
     	$(".change_name").hide();
    });
    
    $("#on").click(function() {
    	if(!window.validBeforeAjax("#change_name_form")) return;
    	var inps = $(this).parent().parent().find("input[flag='0']");
    	if(inps&&inps.length>0)return;
        $(".name_pay").center().show();
    });
    $("#close_pay").click(function() {
        $(".name_pay").hide();
    });
    
    var iframeTIndex;
    function change_team_img(){
    	 $(".masker").hide();
      	$('.clubLogo').hide();
    	iframeTIndex = layer.open({
    	    type: 2,
    	    title: '编辑俱乐部LOGO',
    	    shadeClose: true,
    	    shade: [0],
    	    area: ['660px', '600px'],
    	    content: base+'/team/changeTeamImg' //iframe的url
    	}); 
    }
    
    function closeIframe(path){
    	layer.close(iframeTIndex);
    	$("#logo_val").val(path);
    	$("#logo_img").attr("src",filePath+"/"+path);
    	$("#logo_type").val(1);
    }
    
    var uploadeOpts = {
   		uploaderType: 'imgUploader',
   		itemWidth: 122,
   		itemHeight: 76,
   		fileNumLimit: 3,
   		fileSingleSizeLimit: 2*1024*1024, /*1M*/
   		fileVal: 'file',
   		server: base+'/imageVideo/uploadFile?filetype=team_picture',
   		toolbar:{
   			del: true,
   			move:true
   		},
   		afterRender:function(){
   			$('#up_remark_imgs').find(".webuploader-container").css("border","none");
   			$('#up_remark_imgs').find(".webuploader-pick").css("background"," url('${ctx}/resources/images/up_edit.png') no-repeat scroll center center");
		}
   	};
   	$('#up_remark_imgs').fileUploader($.extend({},uploadeOpts,{inputName:'remark_images'}));
   	$('#up_remark_imgs').find(".webuploader-pick").parent().css("border","none");
	$('#up_remark_imgs').find(".webuploader-pick").css("background"," url('${ctx}/resources/images/up_edit.png') no-repeat scroll center center");
	
	function check_name_again(dom){
		var flag = check_user_role();
    	if(!flag){
    		$(".masker").hide();
         	$(".change_name").hide();
    		return;
    	}
    	if($.valid_oth(dom,true)) return;
		var name = $(dom).attr("name");
		var params = {};
		if(name=='name'){
			params = {name:$(dom).val()};
		}else if(name=='sim_name'){
			params = {sim_name:$(dom).val()};
		}
		$.ajaxSec({
	     	type: 'POST',
	     	url: base+"/team/checkTeamNameAgain",
		    dataType:"JSON",
		    data:params,
		    success: function(data){
		    	if(data.state=='success'){
					$(dom).attr("flag","1").parent().find("a").text("可用").css("color","#9090f4");
				}else{
					$(dom).attr("flag","0").parent().find("a").text("已存在").css("color","red");
				}
		    }
		});
	}
	
	function change_name_fn(dom){
		var flag = check_user_role();
    	if(!flag){
    		$(".masker").hide();
         	$(".change_name").hide();
         	$(".name_pay").hide();
    		return;
    	}
    	$.ajaxSec({
	     	type: 'POST',
	     	url: base+"/team/changeTeamName",
		    dataType:"JSON",
		    data:$(dom).serializeObject(),
		    success: function(data){
		    	if(data.state=='success'){
		    		layer.msg('修改成功！',{icon:1});
		    		setTimeout(function(){
						location.reload();
					},1400);
				}else{
					layer.msg(data.message.error[0],{icon:2});
				}
		    }
		});
	}
</script>
</html>