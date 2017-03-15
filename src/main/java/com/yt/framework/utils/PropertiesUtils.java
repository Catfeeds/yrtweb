package com.yt.framework.utils;

import java.io.InputStream;
import java.util.Properties;
/**
 * 解析properties
 * @author xiebo
 * 2014年11月18日15:09:09
 */
public class PropertiesUtils {
	
	/**
	 * 加载系统级的配置文件
	 * 
	 * @param uri
	 * @return
	 */
	public static Properties loadSetting(String uri) {
		
	  InputStream in = PropertiesUtils.class.getResourceAsStream(uri);
		 // 生成properties对象  
      Properties p = new Properties(); 
      try {  
          p.load(in);  
      } catch (Exception e) {  
          e.printStackTrace();  
      }  
		return p;
	}
}
