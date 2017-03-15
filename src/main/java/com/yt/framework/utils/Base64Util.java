package com.yt.framework.utils;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base64Util {
	 // 加密  
    public static String encodeBase64(String str) {  
        byte[] b = null;  
        String s = null;  
        try {  
            b = str.getBytes("utf-8");  
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        }  
        if (b != null) {  
            s = new BASE64Encoder().encode(b);  
        }  
        return s;  
    }  
  
    // 解密  
    public static String decodeBase64(String s) {  
        byte[] b = null;  
        String result = null;  
        if (s != null) {  
            BASE64Decoder decoder = new BASE64Decoder();  
            try {  
                b = decoder.decodeBuffer(s);  
                result = new String(b, "utf-8");  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
        return result;  
    }  
    
    public static void main(String[] args) {
    	System.out.println(Base64Util.encodeBase64("ffff"));
    	System.out.println(Base64Util.decodeBase64(Base64Util.encodeBase64("ffff")));
	}
    
}
