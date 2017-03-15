<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.yt.framework.alipay.config.*"%>
<%@ page import="com.yt.framework.alipay.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%!	String formatString(Object text){ 
			if(text == null) {
				return ""; 
			}
			return text.toString();
		}
%>
<%
	String  realPath  =  "http://"  +  request.getServerName()  +  ":"  +  request.getServerPort()  +  request.getContextPath()+"/account/payCallback";
	request.setCharacterEncoding("utf-8");
	
	String p2_Order = formatString(request.getAttribute("osn")); // 商户订单号
	String p3_Amt = formatString(request.getAttribute("amount")); // 支付金额
	String p5_Pid = formatString(request.getAttribute("productName")); // 商品名称
	String p7_Pdesc = formatString(request.getAttribute("productDesc")); // 商品描述
	String pa_MP = formatString(request.getAttribute("uid")); // 商户扩展信息
	//此页面是即时到账交易
	//支付类型
	String payment_type = "1";
	//服务器异步通知页面路径
	String notify_url = realPath+"/alipayAsy";
	//需http://格式的完整路径，不能加?id=123这类自定义参数

	//页面跳转同步通知页面路径
	String return_url = realPath+"/alipaySyn";
	//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
			
	//卖家支付宝帐户
	String seller_id = AlipayConfig.seller_id;
	//商户订单号
	String out_trade_no = formatString(request.getAttribute("osn"));
	//订单名称
	String subject = formatString(request.getAttribute("productName"));
	//付款金额
	String total_fee = p3_Amt;
	//订单描述
	String body = p7_Pdesc;
	//商品展示地址
	String show_url = "";
	//防钓鱼时间戳
	String anti_phishing_key = "";
	//客户端的IP地址
	String exter_invoke_ip = "";
	
	//把请求参数打包成数组
	Map<String, String> sParaTemp = new HashMap<String, String>();
/* 	sParaTemp.put("service", "create_direct_pay_by_user");
    sParaTemp.put("partner", AlipayConfig.partner);
    sParaTemp.put("_input_charset", AlipayConfig.input_charset);
	sParaTemp.put("payment_type", payment_type);
	sParaTemp.put("notify_url", notify_url);
	sParaTemp.put("return_url", return_url);
	sParaTemp.put("seller_email", seller_id);
	sParaTemp.put("out_trade_no", out_trade_no);
	sParaTemp.put("subject", subject);
	sParaTemp.put("total_fee", total_fee);
	sParaTemp.put("body", body);
	sParaTemp.put("show_url", show_url);
	sParaTemp.put("anti_phishing_key", anti_phishing_key);
	sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
	 */
	sParaTemp.put("service", "create_direct_pay_by_user");
	sParaTemp.put("partner", AlipayConfig.partner);
	sParaTemp.put("seller_email", seller_id);
	sParaTemp.put("_input_charset", AlipayConfig.input_charset);
	sParaTemp.put("payment_type", payment_type);
	sParaTemp.put("notify_url", notify_url);
	sParaTemp.put("return_url", return_url);
	sParaTemp.put("anti_phishing_key", "");
	sParaTemp.put("exter_invoke_ip", "");
	sParaTemp.put("out_trade_no", out_trade_no);
	sParaTemp.put("subject", subject);
	sParaTemp.put("total_fee", total_fee);
	sParaTemp.put("body", body);
	
	
	//建立请求
	String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
	out.println(sHtmlText);
%>
<html>
	<head>
		<title>正在连接支付页面</title>
	</head>
	<body>
		<h1>正在跳转到支付页面...</h1>
	</body>
</html>
