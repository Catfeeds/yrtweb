package com.yt.framework.utils.shop;

import java.util.Properties;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import com.yt.framework.utils.PropertiesUtils;

/**
 * 一元夺宝购买
 *@autor ylt
 *@date 2016-11-15 
 */
public class HttpSendShop{
	static Logger logger = LogManager.getLogger(HttpSendShop.class.getName());
	public static HttpSendShop httpSendShop = null;
	
	public HttpSendShop() {
	}

	public static HttpSendShop getInstance() {
		if (httpSendShop == null)
			httpSendShop = new HttpSendShop();
		return httpSendShop;
	}
	
	/**
	 * 接口key校验
	 *@param key
	 *@return boolean
	 *@autor ylt
	 *@date 2016-11-15 
	 */
	public boolean checkKey(String token) {
		boolean result = false;
		Properties p = PropertiesUtils.loadSetting("/messages/common.properties");
		String c_key = String.valueOf(p.get("shop.buy.token"));
		if(StringUtils.isNotBlank(token) && token.equals(c_key)){
			result = true;
		}
		return result;
	}
	

	
}
