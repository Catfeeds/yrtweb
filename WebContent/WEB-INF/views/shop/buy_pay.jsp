<%@ page language="java" contentType="text/html; charset=UTF-8"
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
    	<div class="my_duo">
            <div class="d_title">
            	账户选择<span class="pull-right close_the">X</span>
            <div class="clearfix"></div>
            </div>
            <div class="d_title2">
                <input type="radio" name="payType" value="user" id="userType" checked="checked"/><span class="f14">&ensp;个人账户支付</span><br/>
                <input type="radio" name="payType"  value="club" id="clubType"/><span class="f14">&ensp;俱乐部账户支付</span>
            </div>
            <div class="d_title2">
                <input type="button" name="name" value="确定" class="pay_btn" style="margin-left: 0;" onclick="pay();"/>
            </div>
        </div>
        <div class="masker"></div>
        <!--头部-->
		<%@include file="../common/header.jsp" %>
		<!--导航 start-->
	    <%@ include file="../common/naver.jsp" %> 
	      
        <div class="wrapper" style="margin-top: 30px;">
            <div class="duo_home">
                <table class="zfqd">
                    <tr>
                        <th>商品名字</th>
                        <th>商品期号</th>
                        <th>价值（宇币）</th>
                        <th>夺宝单价(宇币/人次)</th>
                        <th>参与人次</th>
                        <th>小计（宇币）</th>
                    </tr>
                    <tr>
                        <td><span class="sp_ms">${data.product_title}</span></td>
                        <td><span>${data.data_sn}</span></td>
                        <td><span><fmt:formatNumber value="${data.data_total_price}" pattern="#0"></fmt:formatNumber></span></td>
                        <td><span><fmt:formatNumber value="${data.data_single_price}" pattern="#0"></fmt:formatNumber></span></td>
                        <td><span>${order_count}</span></td>
                        <td><span class="ybi"><fmt:formatNumber value="${data.data_single_price*order_count}" pattern="#0"></fmt:formatNumber>宇币</span></td>
                    </tr>
                </table>
                <div class="cmp">
                    <a href="javascript:void(0);" class="sp_ms" onclick="window.location='${ctx}/shop/toBuy/${data.data_id}'">返回清单修改</a>&emsp;
                    <span class="text-white">商品合计：<span class="ybi f18">
                    	<fmt:formatNumber value="${data.data_single_price*order_count}" pattern="#0"></fmt:formatNumber>宇币</span>
                    </span>
                </div>
                <div class="cmp">
                    <span class="text-white f18">总需支付：<span class="ybi f18"><fmt:formatNumber value="${data.data_single_price*order_count}" pattern="#0"/>宇币</span></span>
                </div>
                <div class="cmp">
                    <input type="button" name="name" id="pay_alipay" value="去支付" class="paybtn ms" onclick="checkType();"/>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp" %>
    <script type="text/javascript">
	    $(".sp_ms").each(function () {
	        var maxwidth = 12;
	        if ($(this).text().length > maxwidth) {
	            $(this).text($(this).text().substring(0, maxwidth));
	            $(this).html($(this).html() + '...');
	        }
	    });
	    
	    $(".close_the").click(function () {
            $(".masker").fadeOut();
            $(".my_duo").fadeOut();
        });
	    
	    function checkType(){
	    	if('${amount_type}' == 'club'){
	    		 var h = $(document).height();
	             $(".masker").css("height", h).show();
	             $(".my_duo").center().fadeIn();
	    	}else{
	    		$("#userType").attr("checked","checked");
	    		pay();
	    	}
	    	
	    }
	    
	    function pay(){
	    	if($('input[name="payType"]:checked') == null){
	    		alert("请选择支付方式");
	    		return false;
	    	}
	    	$.ajax({
    		        type: 'POST',
    		        url: base+'/shop/pay',
    		        cache:false,
    		        dataType: 'json',
    		        data: {
    		        		'data_id' : '${data.data_id}',
    		        		'order_count' : '${order_count}',
    		        		'type':$("input[name='payType']:checked").val()
    		        	},
    		        async: false,
    		        beforeSend: function(){   //触发ajax请求开始时执行
    		            $('#pay_alipay').val('提交中...');
    		            $('#pay_alipay').attr('onclick','javascript:void(0);');//改变提交按钮上的文字并将按钮设置为不可点击
    		            $('#pay_alipay').addClass("end");
    		        },                
    		        success: function(data){
    		            if(data.state=='success'){
    		            	layer.msg("订单提交成功，请点击我的夺宝查看订单是否生效！",{icon:1,time:4000},function(){
    							window.location.href = base + "/shop/products"; //返回产品详情页
    						});
    		            }else{
    		            	layer.msg(data.message.error[0],{icon:2});	
    		                $('#pay_alipay').val('去支付');
    		                $('#pay_alipay').attr('onclick','pay();');//改变提交按钮上的文字并将按钮设置为可点击     
    		                $('#pay_alipay').removeClass("end");
    		            }
    		        },
    		        error: function (textStatus){
    		            $('#pay_alipay').val('去支付');
    		            $('#pay_alipay').attr('onclick','pay();');//改变提交按钮上的文字并将按钮设置为可点击   
    		            $('#pay_alipay').removeClass("end");
    		        }            
    		    });  
	    }
    </script>

</body>
</html>
