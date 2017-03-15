package com.yt.framework.utils.oss;

import java.util.Properties;

import com.yt.framework.utils.PropertiesUtils;

public class Constant {

	public static String OSS_ENDPOINT = "http://oss-cn-hangzhou.aliyuncs.com";
    public static String ACCESS_ID = "rggvH3jDPSgGzrRL";
    public static String ACCESS_KEY = "kSCWB115QB2j2NYTGqRRupa3AAuQ23";
    public static String BUCKET_NAME = "yrt2016";
    public static String OSS_URL = "http://img.11uniplay.com/";
    public static String LOCAL_URL = "/upload";
    public static Integer DOWNLOAD_PART_SIZE ; // 每个上传Part的大小
    public static Integer UPLOAD_PART_SIZE = 1 * 1024 * 1024; // 每个上传Part的大小
    public static int CONCURRENT_FILE_NUMBER = 5; // 并发文件数。
    public static int SINGLE_FILE_CONCURRENT_THREADS = 3; // 单文件并发线程数。
    public static int RETRY =3;//失败重试次数
    public static int SERIALIZATION_TIME=60;//断点保存时间间隔(秒)
    public static boolean OSS_OPEN=false;
    
    static{  
    	Properties prop = PropertiesUtils.loadSetting("/messages/common.properties");
    	OSS_ENDPOINT = prop.containsKey("endpoint") == false ? "" : prop.getProperty("endpoint");  
    	ACCESS_ID = prop.containsKey("accessKeyId") == false? "" : prop.getProperty("accessKeyId");  
    	ACCESS_KEY = prop.containsKey("accessKeySecret") == false ? "" : prop.getProperty("accessKeySecret");  
        BUCKET_NAME = prop.containsKey("bucketName") == false ? "" : prop.getProperty("bucketName");
        OSS_URL = prop.containsKey("ossUrl") == false ? "" : prop.getProperty("ossUrl");
        LOCAL_URL = prop.containsKey("localUrl") == false ? "" : prop.getProperty("localUrl");
        OSS_OPEN = prop.containsKey("ossOpen") == false ? false : Boolean.parseBoolean(prop.getProperty("ossOpen"));
    } 
}
