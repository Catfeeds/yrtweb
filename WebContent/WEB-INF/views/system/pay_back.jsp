<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/resources/css/template.css" rel="stylesheet" />
<title>充值回调</title>
    <style>
        .cz_cs {
            width: 100%;
            padding-top:90px;
            padding-bottom: 60px;
        }

         .cz_cs dl {
             float: left;
             margin-left: 45px;
             margin-top: 25px;
             line-height: 32px;
         }
        /*支付成功*/
        .cz_succ {
            float: left;
            display: inline-block;
            width: 90px;
            height: 90px;
            margin-left: 300px;
            background: url(${ctx}/resources/images/cz_cs.png) -0px -34px no-repeat;
        }
        /*支付失败*/
        .cz_fail {
            float: left;
            display: inline-block;
            width: 90px;
            height: 90px;
            margin-left: 350px;
            background: url(${ctx}/resources/images/cz_cs.png) -0px -176px no-repeat;
        }

        .fg {
            width: 590px;
            margin: 0 auto;
            border-bottom: 1px solid #535353;
        }

        .shuoming {
            width: 540px;
            margin: 20px auto 0;
            text-align: center;
        }

        .returnbtn {
            width: 125px;
            height: 30px;
            background: #1073c0;
            color: #fff;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
	<div class="warp">
        <!--头部-->
        <%@ include file="../common/header.jsp" %> 
        <!--导航-->
    	<%@ include file="../common/naver.jsp" %>   
        <div class="wrapper" style="margin-top: 116px;">
            <div class="mt20">
                <div class="p_title" style="text-align: center;">
                    <span class="f14 ml20 ms text-white">充值状态</span>
                </div>
                <div class="player_pic">

                    <div class="cz_cs" style="">
                    	<c:choose>
                    		<c:when test="${flag eq true }">
		                        <span class="cz_succ"></span>
                    		</c:when>
                    		<c:otherwise>
                    			<span class="cz_fail"></span>
                    		</c:otherwise>
                    	</c:choose>
                        <dl>
                        	<c:choose>
                        		<c:when test="${flag eq true }">
                        		 <dt><span class="text-white f20 ms">充值成功</span></dt>
                        	     <dd><span class="text-white f14 ms">充值金额：${payMoney}元</span></dd>
                        		</c:when>
                        		<c:otherwise>
                        		 <dt><span class="text-white f20 ms">充值失败</span></dt>
                           		 <dd><span class="text-white f14 ms"></span></dd>
                        		</c:otherwise>
                        	</c:choose>
                        </dl>
                        <div class="clearit"></div>
                    </div>
                    <div class="fg"></div>
                    <div class="shuoming">
                   		 <c:choose>
                        	<c:when test="${flag eq true }">
                       		 <p class="text-gray-s_81 ms">您可以使用宇币让您的个人中心更加美丽或者购买精美礼品赠送给其他用户。</p>
                       		</c:when>
                       		<c:otherwise>
                       		 <p class="text-gray-s_81 ms">请使用支付宝或网银来进行支付。</p>
                       		</c:otherwise>
                      	</c:choose> 
                    </div>
                    <div style="width: 400px; margin: 30px auto;text-align: center;">
                        <input type="button" name="name" value="返回首页" class="btn_l" onclick="toHome()"/>
                        <input type="button" onclick="javascript:window.location='${ctx}/account/recharge'" class="btn_l ml20" value="继续充值" name="name">
                    </div>

                </div>

            </div>
        </div>
		<!-- footer start -->
		<%@include file="../common/footer.jsp" %>
		<!-- footer end -->
    </div>
</body>
<script type="text/javascript">
	function toHome(){
		window.location = base+"/";
	}
</script>
</html>