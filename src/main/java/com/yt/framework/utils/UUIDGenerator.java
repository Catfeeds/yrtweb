package com.yt.framework.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.httpclient.util.DateUtil;

public class UUIDGenerator {
	  /**
	   * 以62进制（字母加数字）生成32位UUID 
	   * @return
	   */
	  public static String getUUID32() {
	        UUID uuid = UUID.randomUUID();
	        return uuid.toString().replaceAll("-", "");
	    }
	   
	    private static String digits(long val, int digits) {  
	        long hi = 1L << (digits * 4);  
	        return Num62.toString(hi | (val & (hi - 1)), Num62.MAX_RADIX)  
	                .substring(1);  
	    }  
	      
	    /** 
	     * 以62进制（字母加数字）生成19位UUID，最短的UUID 
	     *  
	     * @return 
	     */  
	    public static String getUUID() {  
	        UUID uuid = UUID.randomUUID();  
	        StringBuilder sb = new StringBuilder();  
	        sb.append(digits(uuid.getMostSignificantBits() >> 32, 8));  
	        sb.append(digits(uuid.getMostSignificantBits() >> 16, 4));  
	        sb.append(digits(uuid.getMostSignificantBits(), 4));  
	        sb.append(digits(uuid.getLeastSignificantBits() >> 48, 4));  
	        sb.append(digits(uuid.getLeastSignificantBits(), 12));  
	        return sb.toString();  
	    }  
	    
	    
		/**
		 * 获取订单ID生成编码
		 * @return
		 */
		public static String get12ORID(){
			Random r = new Random();
			Random t = new Random();
			SimpleDateFormat sdfTime = new SimpleDateFormat("HHmmss");
			return r.nextInt(10)+ sdfTime.format(new Date())+(t.nextInt(89999) + 10000);
		}
	    public static void main(String[] args){
	    	 System.out.println(getUUID());
	    	 System.out.println(getUUID());
	    	 System.out.println(getUUID());
	    	 System.out.println(getUUID());
	    	 System.out.println(getUUID());
	    	 System.out.println(getUUID());
	    	/*PlayerTerm playerTerm = new PlayerTerm();
	    	playerTerm.setBall_format(new Integer(11));
	    	playerTerm.setEnd_age(11212);
	    	Map<String, Object> params = Maps.newHashMap();
	    	params.put("start",1111);
			params.put("rows",222);
	    	try {
	    		Map<String, Object> params1 = object2Map(params,playerTerm);
				System.out.println(params1);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
	    }
}
