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
            <div class="duo_home">
            	<div class="duo_title">
                    <span>
                        <a href="${ctx}/shop/index" style="color: #fff;"> 首页</a>
                        &gt; ${empty category_name?'全部商品':category_name}
                    </span>
                </div>
                <style>
                    .all_sp {
                        width: 100%;
                        margin-top: 20px;
                        height: 48px;
                        line-height: 48px;
                        color: #fff;
                    }
                </style>
                <div class="all_sp">
                    <span class="ml20 f16">所有商品</span><span id="total_count">（共 0 件相关商品）</span>
                </div>
                <div style="border-bottom: 1px solid #fff;border-top: 1px solid #fff;">
                    <div class="duo_nav zhuangb ${category_id=='SxumxKhLvRJyt0rNUsP'?'active':''}" onclick="location.href='${ctx}/shop/products?category=SxumxKhLvRJyt0rNUsP'"></div>
                    <div class="duo_nav qiuyi ${category_id=='zlQ25viEiXvQzFyFqgM'?'active':''}" onclick="location.href='${ctx}/shop/products?category=zlQ25viEiXvQzFyFqgM'"></div>
                    <div class="duo_nav qiuxie ${category_id=='0X60FaomJvwPUQyeKre'?'active':''}" onclick="location.href='${ctx}/shop/products?category=0X60FaomJvwPUQyeKre'"></div>
                    <div class="duo_nav zhoubian ${category_id=='KsiSByydtpUwuFLxv14'?'active':''}" onclick="location.href='${ctx}/shop/products?category=KsiSByydtpUwuFLxv14'"></div>
                    <div class="duo_nav qit ${category_id=='7SIpparxR8Yf0qL0k4G'?'active':''}" onclick="location.href='${ctx}/shop/products?category=7SIpparxR8Yf0qL0k4G'"></div>
                    <div class="clearfix"></div>
                </div>
                <div class="all_sp">
                    <div class="pull-left">
                        <span class="ml20 f16">商品搜索 -</span><span class="ml5 f16 text-santand">“${empty category_name?'全部商品':category_name}”</span>
                    </div>
                    <input type="button" onclick="location.href='${ctx}/shop/products?type=${product_type}'" value="全部商品" class="pull-right mr15 mt10 real_pay" />
                </div>
                <!--商品区域-->
                <div id="product_list" class="spfl" style="min-height: 200px;">
                </div>
            </div>
        </div>

        </div>
        <div class="clearfix"></div>
    </div>
	<script src="${ctx}/resources/js/own/shop.js"></script> 
    <%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
$(function(){
	load_products("#product_list",1,'${category_id}');
})

function load_html(dom){
	var load_html = '<img alt="数据加载中" id="load_html" loading src="${ctx}/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 480px;margin-top:100px;">';
	$(dom).append(load_html);
}

function load_products(dom,cur,cid){
	load_html(dom);
	var params = $.param({category_id:cid,product_title:'${product_title}',currentPage:cur,pageSize:12});
	$(dom).load( base+'/shop/productDatas', params,function(){
		$("#load_html").remove();
		//限制字符个数
	    
	    $(".id").each(function () {
	        var maxwidth = 7;
	        if ($(this).text().length > maxwidth) {
	            $(this).text($(this).text().substring(0, maxwidth));
	            $(this).html($(this).html() + '...');
	        }
	    });
	    $(".jj_3").each(function () {
	        var maxwidth = 13;
	        if ($(this).text().length > maxwidth) {
	            $(this).text($(this).text().substring(0, maxwidth));
	            $(this).html($(this).html() + '...');
	        }
	    });
	});
}
</script>

</body>
</html>
