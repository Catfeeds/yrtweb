<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="footer  <c:choose><c:when test="${(currentPage  eq 'LOGIN') or (currentPage eq 'REGISTER')}">footerfix</c:when><c:otherwise>mt20</c:otherwise></c:choose>">
        <div class="footer_content clearfix">
            <ul>
                <li>
                    <dl>
                        <dt>
                            <img src="${ctx}/resources/images/logo3.png" />
                        </dt>
                        <dd class="mt10">
                            <span class="text-gray">
                                Copyright © 2014-2015 成都宇任拓<br />
                               	蜀ICP备14020910号-2
                            </span>
                        </dd>
                    </dl>
                </li>
                <li class="y_info">
                    <dl>
                        <dt><span onclick="window.open('${ctx}/about/questions')" class="ms f20">夺宝指南</span></dt>
                        <div style="width: 125px; border-bottom: 1px solid #666;margin-top: 10px;"></div>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/process')" class="f14 ms fw">夺宝流程</span></dd>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/agreement')" class="f14 ms fw">夺宝协议</span></dd>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/doubt')" class="f14 ms fw">常见问题</span></dd>
                    </dl>
                </li>
                <li class="y_info">
                    <dl>
                        <dt><span onclick="window.open('${ctx}/about/questions')" class="ms f20">常见问题</span></dt>
                        <div style="width: 125px; border-bottom: 1px solid #666;margin-top: 10px;"></div>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/questions')" class="f14 ms fw">常见问题</span></dd>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/payhelp')" class="f14 ms fw">支付帮助</span></dd>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/contact_us')" class="f14 ms fw">联系我们</span></dd>
                    </dl>
                </li>
                <li class="y_info">
                    <dl>
                        <dt><span onclick="window.open('${ctx}/about/about_us')" class="ms f20">关于宇任拓</span></dt>
                        <div style="width: 125px; border-bottom: 1px solid #666;margin-top: 10px;"></div>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/about_us')" class="f14 ms fw">关于我们</span></dd>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/cooperation')" class="f14 ms fw">商务合作</span></dd>
                        <dd style="cursor: pointer"><span onclick="window.open('${ctx}/about/join_us')" class="f14 ms fw">加入我们</span></dd>
                    </dl>
                </li>
               
                <li class="y_info">
                    <dl>
                        <dt><span class="ms f20">宇任拓微博</span><span class="ms f20  ml35">宇任拓微信</span></dt>
                        <div style="width: 270px; border-bottom: 1px solid #666;margin-top: 10px;"></div>
                        <dd>
                            <span class="f14 ms fw">
                                <img src="${ctx}/resources/images/wxwb.png" />
                            </span>
                        </dd>
                         <dd>
                            <span class="f14 ms fw">
                                                                                                 联系邮箱：yutuoscore@sina.cn
                            </span>
                        </dd>
                       <!--  <dd><span class="f14 ms">联系邮箱：yutuoscore@sina.cn</span></dd> -->
                    </dl>
                </li>
                <!--<li class="y_info">
                    <dl>
                        <dt><span class="ms f16 fw">宇任拓客户服务</span></dt>
                        <dd><!-- <span class="f14 ms">400-000-0000</span></dd>
                        <dd>
                            <span class="f14 ms fw">
                                <img src="${ctx}/resources/images/kffw.png" />
                            </span>
                        </dd>
                    </dl>
                </li>-->
            </ul>
        </div>
    </div>
     <ul style="position: fixed;bottom: 20px;right: 20px;">
        <li><span class="top_btn"></span></li>
        <li><span class="feedback_btn"></span></li>
        <li><span class="help_btn" onclick="window.location='${ctx}/about/questions'"></span></li>
    </ul>
  <script src="${ctx}/resources/js/jquery-1.10.2.min.js"></script> 
  <script src="${ctx}/resources/layer/layer.js"></script>
  <script src="${ctx}/resources/js/base.js"></script>
  <script src="${ctx}/resources/js/validation.js"></script>
  <script type="text/javascript" src="${ctx}/resources/js/yt.ext.js"></script>
  <script src="${ctx}/resources/js/jQuery.md5.js"></script>
  <script type="text/javascript" src="${ctx }/resources/fileupload/webuploader/webuploader.js"></script>
  <script type="text/javascript" src="${ctx }/resources/fileupload/fileUploader.js"></script>
  <script src="${ctx}/resources/js/own/playeropt.js"></script>
  <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1256698899'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1256698899%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
<script>
$(function(){
	/*上传控件初始化*/
	var uploadeOpts = {
		uploaderType: 'imgUploader',
		itemWidth: 185,
		itemHeight: 100,
		fileNumLimit: 1,
		fileSingleSizeLimit: 1*1024*1024, /*1M*/
		fileVal: 'file',
		server: base+'/imageVideo/uploadFile?filetype=picture',
		toolbar:{
			del: true
		}
	};
	$('#feedBackphoto').fileUploader($.extend({},uploadeOpts,{inputName:'image_url'}));
})
$('.gtop').click(function(){
	$("html,body").animate({ scrollTop: 0 },1000);
});

//一键反馈提交
function submitFeedback(){
	$.ajax({
		context:$("#feedBackForm"),
		type:"POST",
		url:base+"/feedback/save?random="+Math.random(),
		data:$("#feedBackForm").serialize(),
		dataType:"JSON",
		success:function(data){
			if(data.state=="success"){
				layer.msg("提交成功！",{icon:1});
				 $(".login_masker").fadeOut();
				 $(".feedback").fadeOut();
			}else{
				layer.msg("提交失败！",{icon:1});
			}
		}
	});
}

function searDatasByNick(){
	var searchUserNick = $("#searchUserNick").val();
	$.ajaxSec({
		type:"POST",
		url:base+"/user/getCounts?random="+Math.random(),
		data:{"usernick":searchUserNick},
		dataType:"JSON",
		success:function(data){
			$(".search_res").empty();
			var html="<p><a class='qiuyuan' href="+base+"/player/searchPlayer?usernick="+searchUserNick+">"+searchUserNick+"相关球员"+data.data.maps.u_counts+"人</a></p>";
				//html+="<p><a class='jingjiren' href="+base+"/agent/list?usernick="+searchUserNick+">"+searchUserNick+"相关经纪人"+data.data.maps.a_counts+"人</a></p>";
				//html+="<p><a class='julebu' href="+base+"/coach/listPage?usernick="+searchUserNick+">"+searchUserNick+"相关教练"+data.data.maps.c_counts+"人</a></p>";
				html+="<p><a class='jiaolian' href="+base+"/team/list?name="+searchUserNick+">"+searchUserNick+"相关俱乐部"+data.data.maps.t_counts+"个</a></p>";
				html+="<p><a class='ftbaby' href="+base+"/baby/toSearch?usernick="+searchUserNick+">"+searchUserNick+"相关宝贝"+data.data.maps.f_counts+"人</a></p>";
				html+="<p><a class='p_product' href="+base+"/shop/products?type=user&product_title="+searchUserNick+">"+searchUserNick+"个人产品"+data.data.maps.g_counts+"人</a></p>";
				//html+="<p><a class='c_product' href="+base+"/shop/products?type=club&product_title="+searchUserNick+">"+searchUserNick+"俱乐部产品"+data.data.maps.j_counts+"人</a></p>";
			$(".search_res").html(html);
			
			$(".search_res").show();

			$(document).click(function(e) {
				var vinp = $(e.target).attr("id");
				if(!$(".search_res").is(':has('+e.target.localName+')')&&e.target.id!='tag'&&!(vinp=='searchUserNick')){
					$(".search_res").hide();
				}
			});
		}
	});
}
//搜索
/* $(".search").click(function() {
    $(".search_res").show();
}); */
/* $(".search_res p").click(function () {
    var res = $(this).text();
    $(".search").val(res);
    $(".search_res").hide();
}); */
$(".navGC").mouseover(function () {
    $(".navGC").attr({ src: "${ctx}/resources/images/nav_guangchang_1.png" });
}).mouseout(function () {
    if ($(".navGC").hasClass("on")) {
        return false;
    } else {
        $(".navGC").attr({ src: "${ctx}/resources/images/nav_guangchang.png" });
    }
});

$(".navDT").mouseover(function () {
    $(".navDT").attr({ src: "${ctx}/resources/images/nav_dongtai_1.png" });
}).mouseout(function () {
    if ($(".navDT").hasClass("on")) {
        return false;
    } else {
        $(".navDT").attr({ src: "${ctx}/resources/images/nav_dongtai.png" });
    }
});

$(".navJLB").mouseover(function () {
    $(".navJLB").attr({ src: "${ctx}/resources/images/nav_julebu_1.png" });
}).mouseout(function () {
    if ($(".navJLB").hasClass("on")) {
        return false;
    } else {
        $(".navJLB").attr({ src: "${ctx}/resources/images/nav_julebu.png" });
    }

});

$(".navGR").mouseover(function () {
    $(".navGR").attr({ src: "${ctx}/resources/images/nav_geren_1.png" });
}).mouseout(function () {
    if ($(".navGR").hasClass("on")) {
        return false;
    } else {
        $(".navGR").attr({ src: "${ctx}/resources/images/nav_geren.png" });
    }
});

$(".navBB").mouseover(function () {
    $(".navBB").attr({ src: "${ctx}/resources/images/nav_baby_1.png" });
}).mouseout(function () {
    if ($(".navBB").hasClass("on")) {
        return false;
    } else {
        $(".navBB").attr({ src: "${ctx}/resources/images/nav_baby.png" });
    }
});

$(".navLS").mouseover(function () {
    $(".navLS").attr({ src: "${ctx}/resources/images/nav_liansai_1.png" });
}).mouseout(function () {
    if ($(".navLS").hasClass("on")) {
        return false;
    } else {
        $(".navLS").attr({ src: "${ctx}/resources/images/nav_liansai.png" });
    }
});
$("#league_li").mouseover(function () {
	$(".navLS").attr({ src: "${ctx}/resources/images/nav_liansai_1.png" });
    $("#ls_menu_btn").show();
}).mouseout(function () {
	$("#ls_menu_btn").hide();
	if ($(".navLS").hasClass("on")) {
        return false;
    } else {
        $(".navLS").attr({ src: "${ctx}/resources/images/nav_liansai.png" });
    }
});

//宝贝下拉
$("#bb").mouseover(function () {
    $(".b_up_menu").show();
}).mouseout(function () {
    $(".b_up_menu").hide();
});

function check_msg_state(){
	$.ajax({
		type: 'post',
		url: base+'/message/queryNotReadMsg',
		dataType:'json',
		success: function(result){
			if(result.state=='success'){
				$("#msg_case_png").html(result.data.msg_num);
				$("#msg_case_png").show();
			}else{
				$("#msg_case_png").hide();
			}
		},
		error: $.ajaxError
	});
}

function check_sysmsg_state(){
	$.ajax({
		type:"POST",
		url:base+"/message/queryNotReadSysMsg?random="+Math.random(),
		data:{"user_id":"${session_user_id}","m_style":1},
		dataType:"json",
		success:function(result){
			//console.debug(result);
			if(result.state=='success'&& result.data.page.totalCount > 0){
				$("#sys_case_png").html(result.data.page.totalCount);
				$("#sys_case_png").show();
			}else{
				$("#sys_case_png").hide();
			}
		}
	});
}

function check_shopmsg_state(){
	$.ajax({
		type:"POST",
		url:base+"/shop/luckResultCount?random="+Math.random(),
		data:{},
		dataType:"json",
		success:function(result){
			//console.debug(result);
			if(result.state=='success'&& result.data.page.totalCount > 0){
				$("#shop_case_png").html(result.data.page.totalCount);
				$("#shop_case_png").show();
			}else{
				$("#shop_case_png").hide();
			}
		}
	});
}

$(function(){
	var sessionUser = '${session_user_id}';
	if(sessionUser != ""){
		check_msg_state();
		check_sysmsg_state();
		check_shopmsg_state();
	}
})

jQuery.fn.center = function () {
            this.css("position", "absolute");
            this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
            this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
            return this;
        }
$(".feedback_btn").click(function () {
	$(".feedback").find("input[type=text]").val("");
	$(".feedback").find("textarea").val("");
    $(".feedback").center().fadeIn();
    $(".login_masker").height($(document).height());
    $(".login_masker").fadeIn();
});

$(".closeBtn_1").click(function () {
	layer.closeAll();
    $(".login_masker").fadeOut();
    $(".feedback").fadeOut();
});

$(".login_masker").click(function() {
	$(".login_masker").fadeOut();
    $(".feedback").fadeOut();
});

$(".top_btn").click(function() {
    $('body,html').animate({ scrollTop: 0 }, 500);
});
$("#cnzz_stat_icon_1256698899").css({ "position": "fixed", "bottom": "0" }).hide();

/**
 * 判断转会市场是否已开放
 */
function isOpenMarket(s_id){
	$.ajax({
		type:'post',
		url:base+"/playerTrade/isOpenMarket",
		data:{"s_id":s_id},
		dataType:"json",
		success:function(data){
			if(data.state=='success'){
				window.location = base+"/playerTrade/list?s_id="+s_id;
			}else{
				layer.msg(data.message.error[0],{icon:0});
			}
		}
	});
}
$("#cnzz_stat_icon_1256698899").css({ "position": "fixed", "bottom": "0" }).hide();
queryAmount();
function queryAmount(){
	$.ajax({
			type:"POST",
			url:base+"/user/getUserAmount?random="+Math.random(),
			data:{},
			dataType:"json",
			success:function(data){
				if(data.state=="error"){
					layer.msg(data.message.error[0],{icon: 2});
				}else{
					if(data.show == 1){
						$("#status_1").hide();
					    $("#status_2").show();
					}else{
						$("#status_2").hide();
					    $("#status_1").show();
					}
					$("#amountUser").text(data.real_amount);
				}
			}
		});
}

//显示余额状态
function showAmount(){
	$("#status_1").hide();
    $("#status_2").show();
    changeShow(1);
}

//隐藏余额状态
function hideAmount(){
	$("#status_2").hide();	
    $("#status_1").show();
    changeShow(0);
}
function changeShow(show){
	$.ajaxSec({
		type:"POST",
		url:base+"/user/updateShow?random="+Math.random(),
		data:{"show":show},
		dataType:"json",
		success:function(data){
			/* if(data.state=="error"){
				//layer.msg(data.message.error[0],{icon: 2});
			}else{
				layer.msg(data.message.success[0],{icon: 2});
			} */
		}
	});
}
var names = $(".user_h").get();
if (new RegExp('^[1][3|5|7|8][0-9]{9}$').test(names)) {
	for (var i = 0; i < names.length; i++) {
	    names[i].innerText = names[i].innerText.replace(/^(.).*(.)$/, "$1****$2");
	}
}


function my(){
	if(check_user_role()){
		window.location = base + "shop/orderList";
	}
}
</script>

