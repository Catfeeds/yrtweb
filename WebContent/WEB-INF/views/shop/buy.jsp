﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="../common/common.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="${ctx}/resources/css/seize.css" rel="stylesheet" />
    <title>夺宝订单</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
</head>
<body>
    <div class="warp">
        <!--头部-->
		<%@include file="../common/header.jsp" %>
		<!--导航 start-->
	    <%@ include file="../common/naver.jsp" %> 
	      
        <div class="wrapper" style="margin-top: 30px;">
            <div class="duo_home">
                <div class="duo_step">
                    <div class="xianxian"></div>
                    <dl class="tt_1">
                        <dd><span class="step active">1</span></dd>
                        <dd><span class="f16 text-white">提交订单</span></dd>
                    </dl>
                    <dl class="tt_2">
                        <dd><span class="step">2</span></dd>
                        <dd><span class="f16 text-white">等待揭晓</span></dd>
                    </dl>
                    <dl class="tt_3">
                        <dd><span class="step">3</span></dd>
                        <dd><span class="f16 text-white">商品发派</span></dd>
                    </dl>
                    <div class="clearfix"></div>
                </div>
                <!--订单商品-->
				<form action="${ctx}/shop/toPay" method="post" id="orderForm">
				<input type="hidden" id="data_id" name="data_id" value="${data.data_id}"/>
                <div class="dd_sp">
                    <table class="db_dd_tab">
                        <tr>
                            <th style="width: 380px;">商品名字</th>
                            <th>价值(￥)</th>
                            <th style="width: 140px;">夺宝单价(宇币/人次)</th>
                            <th style="width: 170px;">参与人次</th>
                            <th>小计(宇币)</th>
                        </tr>
                        <tr>
                            <td valign="top">
                                <img src="${el:headPath()}${data.product_header}" alt="" class="iimg" />
                                <dl style="width: 265px;">
                                    <dt><span class="lsp"><fmt:formatNumber value="${data.data_single_price}" pattern="#0"/>宇币商品</span></dt>
                                    <dd><span class="sp_ms">${data.product_title}</span></dd>
                                    <dd>
                                    	<span>总需<span class="sp_ms">${data.data_total_count}</span>人次参与，还剩：
                                    	<span class="sp_ms">${data.data_total_count - data.data_count}</span>人次</span>
                                    </dd>
                                </dl>
                            </td>
                            <td>
                            	<span class="f12">
                            		￥<fmt:formatNumber value="${data.data_total_price}" pattern="#0"></fmt:formatNumber>/
                            		<fmt:formatNumber value="${data.data_total_price*100}" pattern="#0"></fmt:formatNumber>宇币	
                            	</span>
                            </td>
                            <td><span class="f12"><fmt:formatNumber value="${data.data_single_price}" pattern="#0"></fmt:formatNumber></span></td>
                            <td>
                                <input type="button" name="name" value="-" class="l_fuhao_sub"/>
                                <input type="text" name="order_count" id="order_count" value="${order_count}" class="l_input" valid="require number"/>
                                <input type="button" name="name" value="+" class="l_fuhao_add" />
                            </td>
                            <td><span class="f12" id="data_count_1"><fmt:formatNumber value="${data.data_single_price*order_count}" pattern="#0"></fmt:formatNumber></span></td>
                        </tr>
                    </table>
	
                    <div class="total_price">
                        <span class="lump">总计：<span class="edu" id="data_count_2"><fmt:formatNumber value="${data.data_single_price*order_count}" pattern="#0"></fmt:formatNumber></span>&ensp;宇币</span>
                        <div class="clearfix"></div>
                    </div>

                    <div class="tools_div">
                        <div class="pull-left">
                            <input type="button" name="name" value="返回首页" class="returnbtn ms" onclick="location.href='${ctx}/shop/index'"/>
                            <!-- <span class="text-white f14 ml10">现在可以一次参与多期商品哦</span>
                            <a href="#" class="sp_ms f14 ml10">详情</a> -->
                        </div>
                        <dl class="pull-right">
                            <dt><input type="button" name="name" value="结&emsp;算" class="jsbtn ms" onclick="checkData();"/></dt>
                            <dd><span class="text-white f14">夺宝有风险，参与需谨慎</span></dd>
                            <c:if test="${if_protocol eq 0}">
                            	<dd><input type="checkbox" name="name" id="agree_btn" value="1" />&ensp;<span class="text-white f14">我已阅读并同意《服务协议》</span></dd>
                        	</c:if>
                        </dl>
                        <div class="clearfix"></div>
                    </div>
                    <div class="fenge"></div>
                    <c:if test="${if_protocol eq 0}">
                    <div class="yiyuan_xieyi">
                        <h3>宇币夺宝众筹平台支持者协议</h3>
                        <div class="mt60 line_h">
                            <p class="one">
                                欢迎访问宇币夺宝众筹平台，为明确您（以下简称为“支持者”）的权利义务，保护支持者的合法权益，特制定本协议。申请使用宇任拓公司提供的宇币夺宝众筹平台（以下简称为“平台“）服务（包括宇币夺宝和一口价服务），请支持者仔细阅读以下全部内容（特别是粗体下划线标注的内容）。如支持者不同意本服务条款任意内容，请勿注册或使用平台服务。如支持者通过进入注册程序并勾选“我同意平台服务协议”，即表示支持者与宇任拓公司已达成协议，自愿接受本服务条款的所有内容。此后，支持者不得以未阅读本服务条款内容作任何形式的抗辩。
                            </p>
                            <p class="one">
                                鉴于：平台以“众筹”模式为各类商品的销售提供网络空间。在本平台，商品被平分成若干等分，支持者可以使用宇拓币支持一份或多份，当等份全部售完后，由系统根据平台规则计算出最终获得商品或服务的支持者。
                            </p>
                            <p class="one f14 font_b">
                                一、支持者使用平台服务的前提条件:
                            </p>
                            <p class="one ">
                                1、支持者拥有宇任拓公司认可的帐号，包括但不限于：
                            </p>
                            <p class="two ">
                                （1）宇任拓帐号，支持者通过宇任拓帐号使用平台服务的，本服务协议是《宇任拓注册协议》的补充条款，与《宇任拓注册协议》具有同等法律效力。
                            </p>
                            <p class="two ">
                                （2）第三方帐号，支持者可使用QQ帐号、微信帐号、微博帐号等其他宇任拓公司认可的帐号在同意本服务条款后使用平台服务。
                            </p>
                            <p class="one ">
                                2、支持者在使用平台服务时须具备相应的权利能力和行为能力，能够独立承担法律责任，如果支持者在18周岁以下，必须在父母或监护人的监护参与下才能使用本站。
                            </p>
                            <p class="one f14 font_b">
                                二、支持者管理
                            </p>
                            <p class="one ">
                                1、支持者ID
                            </p>
                            <p class="two ">
                                支持者首次登录平台时，平台会为每位支持者生成一个帐户ID，作为其使用平台服务的唯一身份标识，支持者需要对其帐户项下发生的所有行为负责。
                            </p>
                            <p class="one ">
                                2、支持者资料完善
                            </p>
                            <p class="two ">
                                支持者应当在使用平台服务时完善个人资料，支持者资料包括但不限于个人手机号码、收货地址、帐号昵称、头像、密码、注册或更新宇任拓帐号时输入的所有信息。
                            </p>
                            <p class="two ">
                                支持者在完善个人资料时承诺遵守法律法规、社会主义制度、国家利益、公民合法权益、公共秩序、社会道德风尚和信息真实性等七条底线，不得在资料中出现违法和不良信息，且支持者保证其在完善个人资料和使用帐号时，不得有以下情形：
                            </p>
                            <p class="two ">
                                （1）违反宪法或法律法规规定的；

                            </p>
                            <p class="two ">
                                （2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；
                            </p>
                            <p class="two ">
                                （3）损害国家荣誉和利益的，损害公共利益的；
                            </p>
                            <p class="two ">
                                （4）煽动民族仇恨、民族歧视，破坏民族团结的；
                            </p>
                            <p class="two ">
                                （5）破坏国家宗教政策，宣扬邪教和封建迷信的；
                            </p>
                            <p class="two ">
                                （6）散布谣言，扰乱社会秩序，破坏社会稳定的
                            </p>
                            <p class="two ">
                                （7）散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；
                            </p>
                            <p class="two ">
                                （8）侮辱或者诽谤他人，侵害他人合法权益的；
                            </p>
                            <p class="two ">
                                （9）含有法律、行政法规禁止的其他内容的。
                            </p>
                            <p class="two">
                                若支持者提供给宇任拓公司的资料不准确，不真实，含有违法或不良信息的，宇任拓公司有权不予完善，并保留终止支持者使用平台服务的权利。若支持者以虚假信息骗取帐号ID或帐号头像、个人简介等注册资料存在违法和不良信息的，宇任拓公司有权采取通知限期改正、暂停使用、注销登记等措施。对于冒用关联机构或社会名人注册帐号名称的，宇任拓公司有权注销该帐号，并向政府主管部门进行报告。
                            </p>
                            <p class="two">
                                根据相关法律、法规规定以及考虑到平台服务的重要性，支持者同意：
                            </p>
                            <p class="two">
                                （1）在完善资料时提交个人有效身份信息进行实名认证；
                            </p>
                            <p class="two">
                                （2）提供及时、详尽及准确的支持者资料；
                            </p>
                            <p class="two">
                                （3）不断更新支持者资料，符合及时、详尽准确的要求，对完善个人资料时填写的身份证件信息不能更新。
                            </p>
                            <p class="two">
                                （4）支持者有证明该帐号为本人所有的义务，需能提供宇任拓注册资料或第三方平台注册资料以证明该帐号为本人所有，否则宇任拓公司有权暂缓向支持者交付其所获得的商品。
                            </p>
                            <p class="one">
                                3、宇拓币
                            </p>
                            <p class="two">
                                （1）宇拓币必须通过宇任拓公司提供或认可的平台获得，从非宇任拓公司提供或认可的平台所获得的宇拓币将被认定为来源不符合本服务协议，宇任拓公司有权拒绝从非宇任拓公司提供或认可的平台所获得的宇拓币在平台中使用。
                            </p>
                            <p class="two">
                                （2）宇拓币不能在平台之外使用或者转移给其他支持者。
                            </p>
                            <p class="one">
                                4、支持者应当保证在使用平台服务的过程中遵守诚实信用原则，不扰乱平台的正常秩序，不得通过使用他人帐户、一人注册多个帐户、使用程序自动处理等非法方式损害他人或宇任拓公司的利益。
                            </p>
                            <p class="one">
                                5、若支持者存在任何违法或违反本服务协议约定的行为，宇任拓公司有权视支持者的违法或违规情况适用以下一项或多项处罚措施：
                            </p>
                            <p class="two">
                                （1）责令支持者改正违法或违规行为；
                            </p>
                            <p class="two">
                                （2）中止、终止部分或全部服务；
                            </p>
                            <p class="two">
                                （3）取消支持者夺宝订单并取消商品发放（若支持者已获得商品）， 且支持者已获得的宇拓币不予退回；
                            </p>
                            <p class="two">
                                （4）冻结或注销支持者帐号及其帐号中的宇拓币（如有）；
                            </p>
                            <p class="two">
                                （5）其他宇任拓公司认为合适在符合法律法规规定的情况下的处罚措施。
                                若支持者的行为造成宇任拓公司及其关联公司损失的，支持者还应承担赔偿责任。
                            </p>
                            <p class="one">
                                6、若支持者发表侵犯他人权利或违反法律规定的言论，宇任拓公司有权停止传输并删除其言论、禁止该支持者发言、注销支持者帐号及其帐号中的宇拓币（如有），同时，宇任拓公司保留根据国家法律法规、相关政策向有关机关报告的权利。
                            </p>
                            <p class="one f14 font_b">
                                三、宇币夺宝众筹平台服务的规则
                            </p>
                            <p class="one">
                                1、释义
                            </p>
                            <p class="two">
                                （1）宇拓币：指支持者在平台上购买商品或服务的资金的呈现方式。
                            </p>
                            <p class="two">
                                （2）夺宝号码：指支持者使用宇拓币参与宇币夺宝服务时所获取的随机分配号码。
                            </p>
                            <p class="two">
                                （3）幸运号码：指与某件商品的全部夺宝号码分配完毕后，宇币夺宝根据夺宝规则（详见宇任拓官方页面）计算出的一个号码。持有该幸运号码的支持者可直接获得该商品或服务。
                            </p>
                            <p class="two">
                                （4）全价购买：指支持者以固定价格直接获得平台商品或服务的形式。
                            </p>
                            <p class="two">
                                （5）宇币夺宝：指支持者通过平台获得宇拓币，然后凭宇拓币参与平台活动，并在使用宇拓币后根据夺宝规则获取相应商品或服务的形式。
                            </p>
                            <p class="two">
                                （6）宇任拓公司：指成都宇任拓网络科技有限公司。
                            </p>
                            <p class="one">
                                2、宇任拓公司承诺遵循公平、公正、公开的原则运营平台，确保所有支持者在平台中享受同等的权利与义务，夺宝结果向所有支持者公示。
                            </p>
                            <p class="one">
                                3、支持者知悉，除本协议另有约定外，无论是否获得商品，支持者已用于参与平台活动的宇拓币不能退回；其完全了解参与平台活动存在的风险，宇任拓公司不保证支持者参与宇币夺宝一定会获得商品或服务。
                            </p>
                            <p class="one">
                                4、支持者通过参与平台活动获得商品后，应在7天内登录平台提交或确认收货地址，否则视为放弃该商品，支持者因此行为造成的损失，宇任拓公司不承担任何责任。商品由宇任拓公司或经宇任拓公司确认的第三方商家提供及发货。
                            </p>
                            <p class="one">
                                5、支持者通过参与平台活动获得的商品，享受该商品生产厂家提供的三包服务，具体三包规定以该商品生产厂家公布的为准。
                            </p>
                            <p class="one">
                                6、如果下列情形发生，宇任拓公司有权取消支持者夺宝订单：
                            </p>
                            <p class="two">
                                （1）因不可抗力、平台系统发生故障或遭受第三方攻击，或发生其他宇任拓公司无法控制的情形；
                            </p>
                            <p class="two">
                                （2）根据宇任拓公司已经发布的或将来可能发布或更新的各类规则、公告的规定，宇任拓公司有权取消支持者订单的情形。
                            </p>
                            <p class="two">
                                （3）宇任拓公司有权取消支持者的订单时，支持者可申请退还宇拓币，所退宇拓币将在3个工作日内退还至支持者帐户中。
                            </p>
                            <p class="one">
                                7、若某件商品的夺宝号码从开始分配之日起90天未分配完毕，则宇任拓公司有权取消该件商品或服务的夺宝活动，并向支持者退还宇拓币，所退还宇拓币将在3个工作日内退还至支持者帐户中。
                            </p>
                            <p class="one f14 font_b">
                                四、本服务协议的修改
                            </p>
                            <p class="one">
                                支持者知晓宇任拓公司不时公布或修改的与本服务协议有关的其他规则、条款及公告等是本服务协议的组成部分。宇任拓公司有权在必要时通过在平台内发出公告等合理方式修改本服务协议，支持者在享受各项服务时，应当及时查阅了解修改的内容，并自觉遵守本服务协议。支持者如继续使用本服务协议涉及的服务，则视为对修改内容的同意，当发生有关争议时，以最新的服务协议为准；支持者在不同意修改内容的情况下，有权停止使用本服务协议涉及的服务。
                            </p>
                            <p class="one">
                                如支持者对本规则内容有任何疑问，可拨打客服电话（028-86616756）。
                            </p>
                        </div>
                    </div>
                    </c:if>
                </div>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script type="text/javascript">

        $(".sp_ms").each(function () {
            var maxwidth = 45;
            if ($(this).text().length > maxwidth) {
                $(this).text($(this).text().substring(0, maxwidth));
                $(this).html($(this).html() + '...');
            }
        });
        //数量调整
        var sub = $(".l_fuhao_sub").get();
        var add = $(".l_fuhao_add").get();
        var nnn = $(".l_input").get();

        for (var i = 0; i < sub.length; i++) {
            sub[i].index = i;

            sub[i].onclick = function () {
                if (nnn[this.index].value <= 0) {
                    return false;
                } else {
                    nnn[this.index].value = parseInt(nnn[this.index].value) - 1;
                    calculate();
                }
            };
        }
        for (var i = 0; i < add.length; i++) {
            add[i].index = i;
            add[i].onclick = function () {
                nnn[this.index].value = parseInt(nnn[this.index].value) + 1;
                calculate();
            };
        }
        
        $("#order_count").bind('input propertychange',function(){
        	calculate();   
        });

        $(".check_the").each(function () {
            $(this).click(function () {
                if ($(this).hasClass("active")) {
                    $(this).removeClass('active');
                } else {
                    $(this).addClass('active');
                }

            });
        });
        
        function checkData(){
        	if('${if_protocol}' == 0){
	        	if(!$('#agree_btn').is(':checked')){
	        		layer.msg("请选择是否同意夺宝协议？",{icon:0});
	        		return false;
	        	}
        	}
        	$.ajaxSec({
        		type: 'POST',
        		url: base+"/shop/checkData",
        		data: {
        				"data_id" : $("#data_id").val(),
        				"order_count" : $("#order_count").val()
        			},
        		dataType:"json",
        		success: function(data){
        			if(data.state=='error'){
        				layer.msg(data.message.error[0],{icon:2});
        			}else{
        				$("#orderForm").submit();
        			}
        		},
        		error: $.ajaxError
        	});	
        }
        
        function calculate(){
        	var single_price = parseFloat('${data.data_single_price}');
        	var order_count = $("#order_count").val();
        	var total = single_price * order_count;
        	$("#data_count_1").html(total);
        	$("#data_count_2").html(total);
        }
    </script>

</body>
</html>
