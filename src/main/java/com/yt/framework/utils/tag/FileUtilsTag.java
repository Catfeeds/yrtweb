package com.yt.framework.utils.tag;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.yt.framework.utils.oss.Constant;

public class FileUtilsTag {
	

	public static String filePath(String path, String status){
		if(StringUtils.isNotBlank(status)&&"1".equals(status)){
			path = Constant.OSS_URL + Constant.LOCAL_URL.substring(Constant.LOCAL_URL.indexOf("/")+1) + path;
		}else{
			path = Constant.LOCAL_URL + path;
		}
		return path;
	}
	
	public static String headPath(){
		String path = Constant.LOCAL_URL;
		if(Constant.OSS_OPEN){
			path = Constant.OSS_URL + Constant.LOCAL_URL.substring(Constant.LOCAL_URL.indexOf("/")+1);
		}
		return path;
	}
	
	public static String long2Date(Long num){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss,SSS");
		Date date= new Date(num);
		return sdf.format(date);
	}
	
	public static String long2DateTime(Long num){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss,SSS");
		Date date= new Date(num);
		return sdf.format(date);
	}
}
