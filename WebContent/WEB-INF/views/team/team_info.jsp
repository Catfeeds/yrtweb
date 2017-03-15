<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<link href="${ctx}/resources/css/editClub.css" rel="stylesheet" />

<title>俱乐部信息</title>
<c:set var="currentPage" value="TEAMDETAIL"/>
</head>
<body>
	<div class="masker"></div>
	<div class="warp">
		<!-- 头部 -->
		<%@include file="../common/header.jsp" %>
		  <!--导航 start-->
        <%@ include file="../common/naver.jsp" %>    
        <!--导航 end-->
		<div class="wrapper" style="margin-top: 116px;">
			 <!--页面主体-->
	           <div class="container ms">
            	<!--内容部分-->
               <div class="middle ms f14">
           			<form method="post" id="baseinfo">
           				<input type="hidden" name="id" value="${team.id}"/>
           				<input type="hidden" id="logo_type" name="logoType" value="0"/>
           				<table>
           					<tr>
           						<td>俱乐部LOGO：</td>
           						<td style="text-align: left;" id="upClub_logo">
            						<input type="" class="imgFile" value=""  name="logo"/>
            						<input type="hidden" name="logo" value="${team.logo}" id="logo_val" valid="require">
            						<c:choose>
            							<c:when test="${!empty team.logo}">
	            							<img src="${el:headPath()}${team.logo}" id="logo_img" style="margin-left: 60px;"/>
            							</c:when>
            							<c:otherwise>
		            						<img src="${ctx}/resources/images/upload.png" id="logo_img" style="margin-left: 60px;"/>
            							</c:otherwise>
            						</c:choose>
           							<%-- <div id="photo" valid="requireUpload">
                              			<c:if test="${!empty team.logo}">
                              				<div class="fileUploader-item">
				                       			<img src="${el:headPath()}${team.logo}">
				                       			<input type="hidden" name="logo" value="${team.logo}">
		                    				</div>
                              			</c:if>
						            </div> --%>
           						</td>
           					</tr>
           					<tr>
           						<td>俱乐部名称：</td>
           						<td>
           							<input type="text" name="name" class="clubName" value="${team.name}" maxlength="13" valid="require len(0,26)"/>
           						</td>
           					</tr>
           					
           					<tr>
           						<td>俱乐部赛制：</td>
           						<td>
           							<%-- <select name="ball_format">
           								<option value="5" <c:if test="${!empty team.ball_format && team.ball_format eq 5}"> selected</c:if>>5人制</option>
           								<option value="7" <c:if test="${!empty team.ball_format && team.ball_format eq 7}"> selected</c:if>>7人制</option>
           								<option value="11" <c:if test="${!empty team.ball_format && team.ball_format eq 11}"> selected</c:if>>11人制</option>
           							</select> --%>
           							<yt:dictSelect name="ball_format" nodeKey="ball_format" value="${team.ball_format}" required="require"></yt:dictSelect>
           							<%-- <yt:dict2Name nodeKey="ball_format" key="${team.ball_format}"></yt:dict2Name> --%>
           						</td>
           					</tr>
           					<tr>
           						<td>所属城市：</td>
           						<td>
           							 <select id="s_province" name="province" style="width: 78px;margin-right: 10px;"></select>&nbsp;
	                                 <select id="s_city" name="city" style="width: 98px;"></select>&nbsp;
           						</td>
           					</tr>
           					<tr>
           						<td>常踢球时间：</td>
           						<td>
           							<select name="play_time">
           								<option value="1" <c:if test="${!empty team.play_time && team.play_time eq 1}"> selected</c:if>>周末</option>
           								<option value="2" <c:if test="${!empty team.play_time && team.play_time eq 2}"> selected</c:if>>平时</option>
           								<option value="3" <c:if test="${!empty team.play_time && team.play_time eq 3}"> selected</c:if>>不限</option>
           							</select>
           						</td>
           					</tr>
           					<tr>
           						<td>邀请好友入队：</td>
           						<td>
           							<p id="showName"></p>
           							<input type="button" style="width: 60px;height: 30px;background: #494541;border: none;" onclick="addBtn()" value="添加" >
           						</td>
           					</tr>
           					<tr>
           						<td>
           							是否允许所有人加入：
           						</td>
           						<td style="text-align: left;">
           							<c:choose>
           								<c:when test="${tl == 0}">
           									<input name="allow" type="hidden" value="${team.allow}"/>
           									<yt:dict2Name nodeKey="status" key="${tl}"></yt:dict2Name>
           								</c:when>	
           								<c:otherwise>
		           							<input type="radio" style="width: 30px;" name="allow" value="1" <c:if test="${empty team.allow or team.allow eq 1}"> checked</c:if>/><span>是</span>&emsp;
		           							<input type="radio" style="width: 30px;" name="allow" value="0" <c:if test="${team.allow eq 0}"> checked</c:if>/><span>否</span>
           								</c:otherwise>	
           							</c:choose>
           							
           						</td>
           					</tr>
           					<tr>
           						<td>
           							是否开启对战邀请：
           						</td>
           						<td style="text-align: left;">
             						<input type="radio" style="width: 30px;" name="is_pk" value="1" <c:if test="${empty team.is_pk or team.is_pk eq 1}"> checked</c:if>/><span>是</span>&emsp;
           							<input type="radio" style="width: 30px;" name="is_pk" value="0" <c:if test="${team.is_pk eq 0}"> checked</c:if>/><span>否</span>
           						</td>
           					</tr>
           					<tr>
           						<td>
           							简介：
           						</td>
           						<td style="text-align: left;">
             						<textarea class="team_intorduce" maxlength="70" name="remark">${team.remark}</textarea>
           						</td>
           					</tr>
           				</table>
           				<div class="confirm">
           					<c:choose>
           						<c:when test="${empty team.id}">
		           					<input type="button" name="save" value="创建" onclick="updateTeam()"/>
           						</c:when>
           						<c:otherwise>
           							<input type="button" name="save" value="保存" onclick="updateTeam()"/>
      							</c:otherwise>
           					</c:choose>
           					<input type="button" name="cancel" value="取消" onclick="javascript:window.location='${ctx}/team/guide'"/>
          				</div>
           			</form>
               </div>
               <div class="invitation ms" style="display: none;">
               		<div class="closeBtn"></div>
               		<div class="list">
               			<div class="player_list">
               				<h5 style="text-align: center;font-size: 14px;color: white;">好友列表</h5>
               				<div class="playerBox" >
              					<select multiple="multiple" id="left">
              						<c:forEach items="${players}" var="player">
               							<option value="${player.id}">${player.nick}</option>
              						</c:forEach>
               					</select>
               				</div>
               			</div>
               			<div class="addPlayer">
               				<div>
               					<input type="button" value="添加" id="addBtn"/>
               					<input type="button" value="移除" id="delBtn"/>
               					<input type="hidden" value="" name="players" id="players"/>
               					<input type="hidden" value="" name="players_name" id="players_name"/>
               				</div>
               			</div>
               			<div class="player_list">
               				<h5 style="text-align: center;font-size: 14px;color: white;">已选列表</h5>
               				<div class="playerBox" >
               					<select multiple="multiple" id="right">
               					</select>
               				</div>
               			</div>
               		</div>
               		<div class="inviteBtn">
               			<input type="button" onclick="inviteBtn()" value="邀请">
               		</div>
               </div>
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
	if('${team.province}'!="" && '${team.city}'!=""){
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
    $("#upClub_logo").click(function(){
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
    	ctl();
    })
     $(".closeBtn_1").click(function(){
    	 $(".masker").hide();
     	$('.clubLogo').hide();
    })
    
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
</script>
</html>