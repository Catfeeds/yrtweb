<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/common.jsp"%>
<title>宇任拓-我的宇币</title>
    <meta name="renderer" content="webkit">
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/master.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/center.css" rel="stylesheet" />
</head>
<c:set var="currentPage" value="DYNAMIC" />
<body>
	<div class="warp">
	 <div class="masker" style="z-index: 0">
    </div>
		<!--头部-->
		<%@ include file="../common/header.jsp"%>
		<!--导航 start-->
		<%@ include file="../common/naver.jsp"%>
		<!--导航 end-->
 
        <div class="wrapper" style="margin-top: 220px;">
            <div class="myyt">
                <h1 class="ms">我的宇币</h1>
                <p class="pull-left ms f24" style="margin-left: 168px;margin-top: 20px;">
                    宇币总额：<span id="user_amount" style="color: #ff3c00; ">0</span>
                </p>
                <p class="pull-right ms f24 " style="margin-right: 168px; margin-top: 20px;">
                    可用余额：<span id="user_real_amount" class="text-gray-s_999">0</span>
                </p>
                <div class="clearit"></div>
                <div class="title mt40">
                    <span class="text-white f16 ms ml20">兑换列表</span>
                </div>
                <ul id="product_list" class="exchange">
                </ul>
                    <div class="clearit" ></div>
                <div style="width: 1000px;margin-top: 20px; text-align: center;">
                    <ul id="product_page" class="pagination"></ul>
                    <div class="clearit"></div>
                </div>
                <div class="title mt20">
                    <a id="a_pay" href="javascript:myPayData(1);void(0);" class="f16 ms ml20 active">充值记录</a>
                    <a href="javascript:void(0)" class="f16 ms ml10">|</a>
                    <a id="a_consume" href="javascript:myConsumeData(1);void(0);" class="f16 ms ml10">消费记录</a>
                </div>
                <table id="recharge_rec" class="recharge"></table>
                <div style="width: 1000px;margin-top: 20px; text-align: center;">
                    <ul  id="recharge_page" class="pagination"></ul>
                    <div class="clearit"></div>
                </div>

            </div>
        </div>
    </div>
    
    <script type="text/javascript">
    var PageInfo={
    		currentType:1,
    		currentPage:1
    }
    
    var update_user_amount=function(){ 
 		$.ajax({
    		type : "POST",
    		url : "${ctx}/user/getUserAmount",
    		data : {},
    		dataType : "json",
    		contentType : "application/json",
    		success : function(items) {
    			if(items.real_amount){
    				$("#user_amount").text(items.amount);
    				$("#user_real_amount").text(items.real_amount);
    			}
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
    }
    

    var update_page=function(pageMode){ 
    	if(PageInfo.currentType==3){
        	$("#product_page").empty();
    	}else{
        	$("#recharge_page").empty();
    	}
    	
    	var maxPage = parseInt(pageMode.totalCount/pageMode.pageSize);
    	var prevPage = pageMode.currentPage-1;
    	var nextPage = pageMode.currentPage+1;
    	
		var arr=[];
		arr.push('<li onclick="topage(1)" data-command="home"><a>首页</a><li>');	
		if(prevPage>=1){
			arr.push('<li onclick="topage('+prevPage+')" data-command="prev"><a><</a><li>');	
		}
		for(i=1;i<maxPage;i++){
			var cls='';
			if(i==pageMode.currentPage){
				cls=' class="active" ';
			}
			arr.push('<li onclick="topage('+i+')" '+cls+' data-command="'+i+'"><a>'+i+'</a><li>');
		}
		
		if(nextPage<=maxPage){
			arr.push('<li onclick="topage('+nextPage+')" data-command="next"><a>></a><li>');	
		}
		arr.push('<li onclick="topage('+maxPage+')" data-command="end"><a>尾页</a><li>');

    	if(PageInfo.currentType==3){
    		$("#product_page").append(arr.join(''));
    	}else{
    		$("#recharge_page").append(arr.join(''));
    	}
    }
    var myPayData=function(cp){ 
 		$.ajax({
    		type : "POST",
    		url : "${ctx}/account/myPayData",
    		data : '{"currentPage":'+cp+'}',
    		dataType : "json",
    		contentType : "application/json",
    		success : function(items) {
    			$("#recharge_rec").empty();
    			$("#a_consume").removeClass("active");
    			$("#a_pay").addClass("active");
    			PageInfo.currentType = 1;
    			PageInfo.currentPage = items.currentPage;
    			var arr=[];
    			arr.push('<tr><th><span>充值时间</span></th><th><span>订单号</span></th><th><span>充值金额</span></th><th><span>详情</span></th><th><span>状态</span></th></tr>');
    			var ls = items.items;
    			for(i in ls){
    				var o = ls[i];
    				if(!o.bank_no){
    					o.bank_no = "-";
    				}
        			arr.push('<tr>');
        			arr.push('<td><span>'+o.create_time+'</span></td>');
                    arr.push('<td><span>'+o.bank_no+'</span></td>');
                    arr.push('<td><span>￥'+o.amount+'</span></td>');
                    arr.push('<td><span>宇币 +'+(o.real_amount*100)+'</span></td>');
                    if(o.status==1){
                        arr.push('<td><span class="text-success">充值成功</span></td>');
                    }else{
                        arr.push('<td><span class="text-red">充值失败</span></td>');
                    }
                    arr.push('</tr>');
    				
    			}

        		$("#recharge_rec").append(arr.join(''));
        		update_page(items)
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
    }

    var myConsumeData=function(cp){ 
 		$.ajax({
    		type : "POST",
    		url : "${ctx}/account/myConsumeData",
    		data : '{"currentPage":'+cp+'}',
    		dataType : "json",
    		contentType : "application/json",
    		success : function(items) {
    			$("#recharge_rec").empty();
    			$("#a_consume").addClass("active");
    			$("#a_pay").removeClass("active");
    			PageInfo.currentType = 1;
    			PageInfo.currentPage = items.currentPage;
    			var arr=[];
    			arr.push('<tr><th><span>交易时间</span></th><th><span>流水号</span></th><th><span>消息金额</span></th><th><span>备注</span></th><th><span>状态</span></th></tr>');
    			var ls = items.items;
    			for(i in ls){
    				var o = ls[i];
    				if(!o.num_str){
    					o.num_str = "-";
    				}
        			arr.push('<tr>');
        			arr.push('<td><span>'+o.create_time+'</span></td>');
                    arr.push('<td><span>'+o.num_str+'</span></td>');
                    arr.push('<td><span>宇币 -'+o.amount+'</span></td>');
                    arr.push('<td><span>'+o.describle+'</span></td>');
                    if(o.status==1){
                        arr.push('<td><span class="text-success">交易成功</span></td>');
                    }else{
                        arr.push('<td><span class="text-red">交易失败</span></td>');
                    }
                    arr.push('</tr>');
    				
    			}

        		$("#recharge_rec").append(arr.join(''));
        		update_page(items)
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
    }

    var productList=function(cp){ 
 		$.ajax({
    		type : "POST",
    		url : "${ctx}/admin/product/productList",
    		data : '{"currentPage":'+cp+'}',
    		dataType : "json",
    		contentType : "application/json",
    		success : function(items) {
    			$("#product_list").empty();
    			PageInfo.currentType = 3;
    			PageInfo.currentPage = items.currentPage;
    			var arr=[];
    			var ls = items.items;
    			for(i in ls){
    				var o = ls[i];
    				arr.push('<li><div class="exchange_info"><dl>');
                    arr.push('<dt><span class="ms f14">'+o.p_name+'</span></dt>');
                    arr.push('<dd><span class="yubi ms">'+o.p_price+'宇币</span></dd>');
                    arr.push('</dl></div>');
                    arr.push('<img src="${ctx }/resources/images/liwu001.jpg" alt="Alternate Text" />');
                    arr.push('<input type="button" name="name" value="兑换" class="exch_btn mt20" /></li>');
    			}

        		$("#product_list").append(arr.join(''));
        		update_page(items)
    		},
    		error : function(msg) {
    			if (msg.statusText != "abort") {
    				
    			}
    		}
    	});
    }
    var topage=function(p){
    	if(PageInfo.currentType==1){
        	myPayData(p);
    	}else if(PageInfo.currentType==2){
    		myConsumeData(p);
    	}else if(PageInfo.currentType==2){
    		productList(p);
    	}
    }
    myPayData(1);
    update_user_amount();
    productList(1);
    </script>
</body>
</html>
 