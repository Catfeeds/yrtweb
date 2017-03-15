<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/about.css" rel="stylesheet" />
<title>常见问题</title>
<c:set var="currentPage" value="DOUBT"/>
</head>
<body>
<div class="warp">
        <!--头部-->
    	<%@ include file="../common/header.jsp" %>
    	<!--导航 start-->
        <%@ include file="../common/naver.jsp" %>    
        <!--导航 end-->
        <div class="wrapper" style="margin-top: 116px;">
           <%@ include file="sleft.jsp" %>    
            <div class="about_r">
                <div class="about_r_title">
                    <span class="f20 ms text-white"><a href="/" class="text-white">首页</a>>>常见问题</span>
                </div>
                <div class="about_content">
                  <p class="blod">一．怎么参加宇币夺宝？什么是宇币？</p>
                    <p>用户登录宇任拓官方网站-点击宇币夺宝，只需要四步，就能参与宇币夺宝：</p>
                    <p>1、用户登录</p>
                    <p>2、挑选喜欢的商品</p>
                    <p>3、选择参与人次</p>
                    <p>4、抽出奖品后，如果您中奖，官方短信会通知您，【我的夺宝】个人账户也会提示。</p>
                    <p>宇币是宇任拓系统中的官方货币，用户可以通过充值购买宇币。100宇币=1人民币，宇币用于参与宇币夺宝或俱乐部其他操作场景，宇币无法兑换成现金。</p>

                    <p class="blod">二．如何获取和积累宇币？</p>
                    <p>1、单飞球员被球队竞拍招募，可以可以获得宇币。</p>
                    <p>2、球员转会至新球队，可以获得转会费分成。</p>
                    <p>3、参加宇任拓联赛，可以从俱乐部获得宇币工资。</p>

                    <p class="blod">三．宇币夺宝是怎样计算幸运号码的？</p>
                    <p>1、商品的最后一个号码分配完毕后，将公示截止该时间点本站全部商品的最后50个参与时间，不足50个时取所有；</p>
                    <p>2、将这50个时间的数值进行求和（得出数值A）（每个时间按时、分、秒、毫秒的顺序组合，如20:15:25.362则为201525362）；</p>
                    <p>3、为保证公平公正公开，系统还会等待一小段时间，取最近下一期重庆彩票“时时彩”的揭晓结果（一个五位数值B）；</p>
                    <p>4、（数值A+数值B）除以该商品总需人次得到的余数 + 原始数 80000001，得到最终幸运号码，拥有该幸运号码者，直接获得该商品。</p>
                    <p>注：如遇福彩中心通讯故障，无法获取上述期数的重庆彩票“时时彩”揭晓结果，且24小时内该期“时时彩”揭晓结果仍未公布，则默认“老时时彩”揭晓结果为00000。</p>

                    <p class="blod">三.怎么样查看是否成为中奖用户？如何获得商品？</p>
                    <p>方法一：宇任拓官方会向您发送中奖短信通知您。</p>
                    <p>方法二：访问宇任拓官方网站，登录个人账号，首页会提醒您中奖和系统消息提示。【幸运记录】查看和确认中奖信息。</p>
                    <p>收到中奖信息后，请到【我的夺宝】-【幸运记录】查看和确认中奖信息，填写真实的收货地址和联系方式。完善或确认个人信息，尺码颜色要求，以便我们的合作方为您派发获得的商品。</p>

                    <p class="blod">四.商品是否为正品？</p>
                    <p>宇币夺宝中奖商品全部由正规渠道第三方合作方保证商品为正品，不同奖品对应不同的联保政策。</p>

                    <p class="blod">五.收到中奖商品可以退换货吗？</p>
                    <p>收到奖品后，请您当场验货，如遇到运输途中造成奖品损坏或遗失，请您务必不要签收并退回。</p>
                    <p>非质量问题及不属于三包政策范围内的问题，将不予以退换货。</p>
                    
                    <p class="blod">六.中奖商品如何配送？</p>
                    <p>当您成为幸运中奖用户后，请尽快在【我的夺宝】-【幸运记录】确认中奖信息。</p>
                    <p>当您确认收货地址和联系方式后，宇币夺宝第三方合作方将为您发货。可登录个人账号【幸运记录】查看发货状态。（所产生的邮费，由宇币夺宝全部承担）</p>
                    <p class="blod">宇币夺宝最终解释权归宇任拓所有</p>
                </div>
            </div>
            <div class="clearit"></div>
        </div>
    </div>
     <!--页脚-->
    <%@ include file="../common/footer.jsp" %>
</body>
</html>