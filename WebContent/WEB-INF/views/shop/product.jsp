<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="../common/common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>商品详情</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/seize.css" rel="stylesheet" />
</head>
<body>
    <div class="warp">
        <!--头部-->
		<%@include file="../common/header.jsp" %>
		<!--导航 start-->
	    <%@ include file="../common/naver.jsp" %> 
	      
        <div class="wrapper" style="margin-top: 30px;">
            <div class="duobao">
                <div class="duo_title">
                    <span>
                       <a href="${ctx}/shop/index" style="color: #fff;"> 首页</a>
                        >
                        <a href="${ctx}/shop/products" style="color: #fff;"> 全部产品</a>
                        >
                        ${product.product_title}
                    </span>
                </div>
               
                <div class="duo_body">
                    <div class="duo_pic">
                    	<c:if test="${!empty product.product_banner}">
                       	<c:forEach items="${fn:split(product.product_banner, ',')}" var="rimg" begin="0" end="0">
                        <div class="pic_large">
                        	<c:if test="${product.product_hot eq '1'}">
                        	<span class="top_hot2"></span>
                            </c:if>
                            <img src="${el:headPath()}${rimg}" />
                        </div>
                       	</c:forEach>
                       	</c:if>
                        <div class="pic_small">
                        	<c:if test="${!empty product.product_banner}">
                            <c:forEach items="${fn:split(product.product_banner, ',')}" var="rimg" varStatus="status">
                            <c:choose>
                            	<c:when test="${status.index == 0}">
	               			<div class="pica active">
                            	</c:when>
                            	<c:otherwise>
                            <div class="pica">
                            	</c:otherwise>
                            </c:choose>
                                <img src="${el:headPath()}${rimg}" />
                            </div>
	               			</c:forEach>
	             			</c:if>
                            <div class="clearfix"></div>
                        </div>

                        <div class="ren_icon">
                            <span class="gzgk">公正公开</span>
                            <span class="zpbz">正品保证</span>
                            <span class="qybz">权益保障</span>
                            <span class="mfps">免费配送</span>
                        </div>
                        <span class="jiathis_style_24x24">
                            <span class="pull-left text-white ms f12">分享到：</span>
                            <a class="jiathis_button_tsina"></a>
                            <a class="jiathis_button_tqq"></a>
                            <a class="jiathis_button_weixin"></a>
                            <a class="jiathis_button_renren"></a>
                        </span>
                        <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
                    </div>
                    <div class="duo_txt">
                        <div class="d_xian">
                            <p class="wp_title">${product.product_title}</p>
                            <p class="wp_title_f">${product.product_second_title}</p>
                        </div>
                        <c:choose>
                        	<c:when test="${product.data_status eq '4'}">
                        <p class="f14 mt20">商品价值：<span style="color: #c10a0a; font-size: 20px; ">¥<fmt:formatNumber value="${product.data_total_price}" pattern="##0.0#"/> /  宇币<fmt:formatNumber value="${product.data_total_price*100}" pattern="##0"/></span></p>
                        <div class="duo_txt2">
                            <div class="new_duo_num">
                                <div class="duo_num_info">
                                    <span class="qihao">期号 ${product.data_sn} | 幸运号码</span>
                                </div>
                                <span class="ms ml15 f30 sspa">${product.data_win_num}</span>
                            </div>
                            <div class="duobao_txt">
                                <img class="duo_img" src="${el:headPath()}${product.head_icon}" alt="" onclick="location.href='${ctx}/center/${product.data_win_user}'" style="cursor: pointer;">
                                <dl class="duo_dl">
                                    <dt><span class="f14">用户昵称：<span class="text-info" onclick="location.href='${ctx}/center/${product.data_win_user}'" style="cursor: pointer;">${product.usernick}</span></span></dt>
                                    <dd><span class="f14">揭晓时间：<fmt:formatDate value="${product.data_finish_time}" pattern="yyyy-MM-dd HH:mm:ss" /></span></dd>
                                    <dd><span class="f14">夺宝时间：${el:long2Date(product.order_pay_num)}</span></dd>
                                    <dd><span class="f14">本期参与：<span style="color: #c10a0a; ">${product.data_total_count}人次</span></span></dd>
                                    <!-- <dd><a href="#" class="ms text-gray-s_999 f14">查看他的号码 >></a></dd> -->
                                </dl>
                                <div class="clearfix"></div>
                            </div>


                            <div class="jxgs">
                                <div class="jx_l">
                                    <table>
                                        <tr>
                                            <td colspan="3" align="left"><span>如何计算？</span></td>
                                        </tr>
                                        <tr>
                                            <td><span>${product.data_win_num}</span></td>
                                            <td class="ww">=</td>
                                            <td><span>80000001</span></td>
                                            <td class="ww">+</td>
                                            <td align="left"><span>${product.data_remainder}</span></td>
                                        </tr>
                                        <tr>
                                            <td><span>本期幸运号码</span></td>
                                            <td></td>
                                            <td><span>固定数值</span></td>
                                            <td></td>
                                            <td><span class="text-info">变化数值</span></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="jx_m"></div>
                                <div class="jx_l ml5">
                                    <table>
                                        <tr>
                                            <td colspan="5" align="left"><span>变化数值是取下面公式的余数</span></td>
                                        </tr>
                                        <tr>
                                            <td><span>（${product.data_total_num}</span></td>
                                            <td class="ww">+</td>
                                            <td><span>${product.data_ticket}）</span></td>
                                            <td class="ww">÷</td>
                                            <td><span>${product.data_total_count}</span></td>
                                        </tr>
                                        <tr>
                                            <td><span>${product.data_calculate_count}个时间求和</span></td>
                                            <td></td>
                                            <td><span>“重庆时时彩”幸运号码</span></td>
                                            <td></td>
                                            <td><span class="text-info">总需人次</span></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="clearfix"></div>

							<c:if test="${!empty recent}">
                            <div class="canyu_num mt10">
                                <span class="f14">【最新一期】正在火热进行中…</span>
                                <div class="sch_bg">
                                    <div class="sch_b" style="width: ${(recent.data_count/recent.data_total_count)*100}%;"></div>
                                </div>
                                <style>
                                </style>
                                <a href="${ctx}/shop/product/${recent.data_id}" class="qwcy">前往参与</a>
                                <span class="jindu">已完成<fmt:formatNumber value="${(recent.data_count/recent.data_total_count)*100}" pattern="##0.0#"/>%，剩余${recent.data_total_count-recent.data_count}</span>
                            </div>
							</c:if>

                        </div>
                        	</c:when>
                        	<c:otherwise>
                        <div class="duo_txt2">
                            <div class="duobao_txt">
                                <span class="yiyuan">宇币夺宝</span>
                                <span class="qixian">期号：${product.data_sn}</span>
                                <span class="xuyao">每满总需人次，即抽取1人获得该商品</span>
                            </div>
                            <p class="f14 mt20">商品价值：<span style="color: #c10a0a; font-size: 20px;">¥<fmt:formatNumber value="${product.data_total_price}" pattern="##0.0#"/> /  宇币<fmt:formatNumber value="${product.data_total_price*100}" pattern="##0"/></span></p>

                            <div class="qg">
                                <div class="schedule_bg">
                                    <div class="schedule_b" style="width: ${(product.data_count/product.data_total_count)*100}%;"></div>
                                </div>
                                <span class="zonggou">总需人次${product.data_total_count}</span>
                                <span class="sy">剩余人次${product.data_total_count-product.data_count}</span>
                                <span class="wcd">已完成<fmt:formatNumber value="${(product.data_count/product.data_total_count)*100}" pattern="##0.0#"/>%</span>
                            </div>
                            <div class="clearfix"></div>

                            <div class="canyu_num">
                            	<c:choose>
                            		<c:when test="${product.data_status eq '2'}">
                                <span class="f18">参与</span>
                                <div class="fix_pos">
                                    <span class="fuhao_sub">-</span><input type="text" id="num" name="num" value="1" class="nnn" style="background: #000 none repeat scroll 0 0;border-radius: 0;color: #fff;font-family: "Microsoft YaHei";height: 18px;text-align: center;width: 30px;" /><span class="fuhao_add">+</span><span class="ml30 f14" style="color: #c10a0a; ">多参与1人次，获奖机会翻倍！</span>
                                </div>
                                <a href="javascript:void(0);" class="ljgm" onclick="toBuy('${product.data_id}');">立即夺宝</a>
                            		</c:when>
                            		<c:otherwise>
                            	<a href="javascript:void(0);" class="ljgm" style="background: #999 none repeat scroll 0 0;"><yt:dict2Name nodeKey="data_status" key="${product.data_status}"></yt:dict2Name></a>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
                        </div>
                        	</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="clearfix"></div>

                    <div class="duobaoxiangqing">
                        <div class="xx"></div>
                        <div class="duobao_menu active">
                            <span>商品详情</span>
                        </div>
                        <div class="duobao_menu">
                            <span>夺宝参与记录</span>
                        </div>
                        <div class="duobao_menu">
                            <span>往期夺宝</span>
                        </div>
                        <div class="duobao_menu">
                            <span>中奖规则</span>
                        </div>
                        <div class="clearfix"></div>
                        <div class="duobao_info" style="display: block;">
                            <c:if test="${!empty product.product_desc}">
                            <c:forEach items="${fn:split(product.product_desc, ',')}" var="rimg" varStatus="status">
                            <img src="${el:headPath()}${rimg}" alt="" class="sp_pic" />
	               			</c:forEach>
	             			</c:if>
                            <div class="clearfix"></div>
                            <p class="text-white f16 mt10">&emsp;1、本商品由第三方提供；</p>
                            <p class="text-white f16 mt10">&emsp;2、以上详情页面展示信息仅供参考，商品以实物为准；</p>
                            <p class="text-white f16 mt10">&emsp;3、如快递无法配送至获得者提供的送货地址，将默认配送到距离最近的送货地，由获得者本人自提。</p>
                            <p class="text-white f16 mt10">&emsp;4、所有商品尺寸，颜色请参考第三方合作平台信息。</p>
                        </div>
                        <div id="indiana_records" class="duobao_info">
                        </div>
                        <div id="indiana_past" class="duobao_info">
                        </div>
                        <div class="duobao_info">
                            <div class="duo_shuom">
                                <p>1、商品的最后一个号码分配完毕后，将公示截止该时间点本站全部商品的最后50个参与时间，不足50个时取所有；</p>
                                <p>2、将这50个时间的数值进行求和（得出数值A）（每个时间按时、分、秒、毫秒的顺序组合，如20:15:25.362则为201525362）；</p>
                                <p>3、为保证公平公正公开，系统还会等待一小段时间，取最近下一期重庆彩票“时时彩”的揭晓结果（一个五位数值B）；</p>
                                <p>4、（数值A+数值B）除以该商品总需人次得到的余数 + 原始数 80000001，得到最终幸运号码，拥有该幸运号码者，直接获得该商品。</p>
                                <p>注：如遇福彩中心通讯故障，无法获取上述期数的重庆彩票“时时彩”揭晓结果，且24小时内该期“时时彩”揭晓结果仍未公布，则默认“老时时彩”揭晓结果为00000。</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="clearfix"></div>
    </div>
    <script src="${ctx}/resources/js/own/shop.js"></script> 
    <%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
//图片切换
$(".pica img").each(function () {
    $(this).mouseover(function () {
        $(".pic_large img").attr({ src: $(this).attr("src") });
    });
});
$(".pica").each(function () {
    $(this).mouseover(function () {
        $(this).addClass("active").siblings().removeClass("active");
    })
});

//菜单切换
var title = $(".duobao_menu").get();
var duobao = $(".duobao_info").get();

for (var i = 0; i < title.length; i++) {
    title[i].index = i;
    title[i].onclick = function () {
        for (var i = 0; i < title.length; i++) {
            duobao[i].style.display = "none";
            $(".duobao_menu").removeClass("active");
        }
        duobao[this.index].style.display = "block";
        this.className = "duobao_menu active";
        load_datas(duobao[this.index].id,'${product.data_id}',1);
    }
}


//数量调整
var sub = $(".fuhao_sub").get();
var add = $(".fuhao_add").get();
var nnn = $(".canyu_num input").get();

function sub_num() {
    if ($(".nnn").val() <= 1) {
        return false;
    } else {
        nnn.value = parseInt($(".canyu_num input").val());
        nnn.value = nnn.value - 1;
        $(".canyu_num input").val(nnn.value);
    }
};
function add_num() {
    if ($(".nnn").val() < 1) {
        return false;
    } else {
        nnn.value = parseInt($(".canyu_num input").val());
        nnn.value = nnn.value + 1;
        $(".canyu_num input").val(nnn.value);
    }
};
$(".fuhao_sub").click(function() {
    sub_num();
});
$(".fuhao_add").click(function () {
    add_num();
});

function load_html(dom){
	var load_html = '<img alt="数据加载中" id="load_html" loading src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 440px;margin-top:100px;">';
	$(dom).append(load_html);
}

function load_datas(id,data_id,cur){
	if(!id)return;
	var url = base+'/shop/indianaRecords';
	if(id == 'indiana_past'){
		url = base+'/shop/indianaPast';
		data_id = '${product.product_id}';
	}
	var dom = '#'+id;
	load_html(dom);
	var params = $.param({id:data_id,current_id:'${product.data_id}',currentPage:cur,pageSize:20});
	$(dom).load( url, params,function(){
		$("#load_html").remove();
	});
}

$(".sp_pic").eq(0).css({"margin-top":"0"});
</script>

</body>
</html>
