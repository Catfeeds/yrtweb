package com.yt.framework.alipay.config;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *版本：3.3
 *日期：2012-08-10
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
	
 *提示：如何获取安全校验码和合作身份者ID
 *1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
 *2.点击“商家服务”(https://b.alipay.com/order/myOrder.htm)
 *3.点击“查询合作者身份(PID)”、“查询安全校验码(Key)”

 *安全校验码查看时，输入支付密码后，页面呈灰色的现象，怎么办？
 *解决方法：
 *1、检查浏览器配置，不让浏览器做弹框屏蔽设置
 *2、更换浏览器或电脑，重新登录查询。
 */

public class AlipayConfig {
	
	//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	// 合作身份者ID，以2088开头由16位纯数字组成的字符串
	public static String partner = "2088021586074283";
	// 商户的私钥
	public static String key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCu/39Qgnfts4wj0vsj3+N2ktO/6zsCNh0mupbBH60PelrwtJ7Vbubo3tK/x8UY6MrHzCqEW8rb7jRDZirPBj43LsKHKy5dBIrcbzQpk322yYk+IThCBj0Rr4p25bC2mFG9u2OGLX51tTJelkmzH3mc19WWDq/iUtcEIRCJKXW93roJ0mUZsqa6iyi3Rwq8w5ybtL1RO9v66/s52/1ePvoNSuCwWQkbrYx+KLLBqjY5JrGmj78uJFHNVjMVDXQtOQQuvC36172fBt4lqagBm8uU+hxdw5GMxqUq1NgatJDyDGuTYPnGNombRf5DxPbUuBL0uinkhDaDdGMAtiRqgn4hAgMBAAECggEAX5M5JG5tM4xZIIOtF9XCdFMShQHjE30chLdpeIZlTUvE+Such/Lu+AYiUg24DretcFuIaQt9CorZTmoxPSoqtpa6NXqW8sR1VpkBgyeDhF4jr6QTBrRDjDI0TGV8Eu2zzwzV+UVFiOHyZYhtLgAlukyC4VaaJuCZgC7SyiazoINpew79KLtkZK8puK67hZ4NsjSaxlP05LFsp1dcNiiWBhuP70rS/J5Hz4WCnNuxAikGQ75VfhMoNDfG2ENCnvSDkBCUYQ9wz/0+RnBr9XP/0reys1eJkRVf9qL/cPREOpJP50GWEKcAdiXwj3vwWv9MoTezk3BQQqNQARN0zoOywQKBgQDkN4TUv2dB5wKeoPXF9jL37AOuEMVd9w7n9CjewWlyPj4yGwuE6At1LNbN0ms8A85NktJYpiZ+o689nyYklGWByTUoLwQKQ/CZCKpDLzrLiPLW2UZGa149wKop6DkiMcr/Ncls3kkym0i2PwV//Fj0/Iggc3DNAVhC+dsa/PdFmQKBgQDETWO9zM4V9UJjKnKgDqB4DfLlY+dz/XtEFoQrGMMpiY+17CWgW1ync3Dgdja0BHPNarpsaiIn/iGGuOItK/YHjYO6vG3yV6zLRvZDxa8ZwuSfhV/mACZ9Ff4JH7lTpv9E1MQmQzQWxZTTMrKMZwooh5huBckyDqst9rWwTdlByQKBgGKjdHAXwmODm2hAnbnQbbsmcXi8mvHAJNswdrHA2vib2noBonrxaHJezQDs35hy9KomuW/DcIPv74As12mcEjuEYctadt6Q+t7KFf0v3rO2H2+pPWyWX4dFTMcMLhWPe/POpZ6+fNi4sTbECnaE9VX+CEAuZSTWXfWk1ITXrXCRAoGAPe48fXDTw9GwtCB8MUrsDXQ5IW23Y7yg2wZPhFk3mS8xC7AI3uJ0BNBC2E3zTC/raO83CWUiiYN/iEVj9eRcpl1bJdq0xTQr66Xjo9YGPBZkkn89lg6OFgCOOMqtaVrSRiDqETg6gsSrA0aHVgxcBBVjXbKtmwFNuB6Ri6HD3SECgYEAzKDAT3lOXzo4AP1Mgq+p0lVyGapOse1QQVx//VvFiKj+pHXNne7fNpxI1fSsSN3bcYsdBlsn7x66wTctWbjRSU+chRausM0aWeo3VFhb6uSIEtw6lkUlaBJTD4x/Pd3aiay6ti1rUflfW7emzAknyPZp0Ih3SFFbk44qZO7JGcA=";	// 商户的私钥
	public static String seller_id = "deanbarley@qq.com";

	//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	

	// 调试用，创建TXT日志文件夹路径
	public static String log_path = "C:\\";

	// 字符编码格式 目前支持 gbk 或 utf-8
	public static String input_charset = "utf-8";
	
	// 签名方式 不需修改
	public static String sign_type = "RSA";

}
