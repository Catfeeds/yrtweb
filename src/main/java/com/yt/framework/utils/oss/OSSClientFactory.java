package com.yt.framework.utils.oss;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.OSSErrorCode;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.CannedAccessControlList;
import com.aliyun.oss.model.ObjectMetadata;

public class OSSClientFactory {
	public static final Logger LOGGER = Logger.getLogger(OSSClientFactory.class);

	private static OSSClient ossClient = null;
    private OSSClientFactory() {
    }
    public static OSSClient getInstance() {
        if (ossClient == null) {
            // 可以使用ClientConfiguration对象设置代理服务器、最大重试次数等参数。
            // ClientConfiguration config = new ClientConfiguration();
            ossClient = new OSSClient(Constant.OSS_ENDPOINT,Constant.ACCESS_ID, Constant.ACCESS_KEY);
        }
        return ossClient;
    }
    
    public static int uploadFile(String key,File file){
    	OSSClient client = getInstance();
    	return uploadFile(client,Constant.BUCKET_NAME,key,file);
    } 
    
    public static int uploadFile(OSSClient client, String bucket_name, String key,
			File file) {
    	String oss_key = Constant.LOCAL_URL.substring(Constant.LOCAL_URL.indexOf("/")+1)+key;
    	int state = Global.ERROR;
    	InputStream is = null;
		try {
			is = new FileInputStream(file);
	        String fileName = file.getName();  
	        Long fileSize = file.length();
	        //创建上传Object的Metadata  
	        ObjectMetadata metadata = new ObjectMetadata();  
	        metadata.setContentLength(is.available());  
	        metadata.setCacheControl("no-cache");  
	        metadata.setHeader("Pragma", "no-cache");  
	        metadata.setContentEncoding("utf-8"); 
	        metadata.setContentType(getContentType(fileName));  
	        metadata.setContentDisposition("filename/filesize=" + fileName + "/" + fileSize + "Byte.");  
	        //上传文件   
	        client.putObject(bucket_name, oss_key, is, metadata);
	        state = Global.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.info("[OSS]上传：" + e);
			state = Global.ERROR;
		} finally {
			if(is!=null){
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			//client.shutdown();
        }
		return state;
	}
    
    public static int uploadFile(String key,MultipartFile file){
    	OSSClient client = getInstance();
    	return uploadFile(client,Constant.BUCKET_NAME,key,file);
    } 
    
    public static int uploadFile(OSSClient client, String bucket_name, String key,MultipartFile file) {
    	String oss_key = Constant.LOCAL_URL.substring(Constant.LOCAL_URL.indexOf("/")+1)+key;
    	int state = Global.ERROR;
    	InputStream is = null;
		try {
			is = file.getInputStream();
	        String fileName = file.getName();  
	        Long fileSize = file.getSize();
	        //创建上传Object的Metadata  
	        ObjectMetadata metadata = new ObjectMetadata();  
	        metadata.setContentLength(is.available());  
	        metadata.setCacheControl("no-cache");  
	        metadata.setHeader("Pragma", "no-cache");  
	        metadata.setContentEncoding("utf-8"); 
	        metadata.setContentType(getContentType(fileName));  
	        metadata.setContentDisposition("filename/filesize=" + fileName + "/" + fileSize + "Byte.");  
	        //上传文件   
	        client.putObject(bucket_name, oss_key, is, metadata);
	        state = Global.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.info("[OSS]上传：" + e);
			state = Global.ERROR;
		} finally {
			if(is!=null){
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			//client.shutdown();
        }
		return state;
	}
    
    // 创建Bucket
    public static int ensureBucket(OSSClient client, String bucketName){
            try {
                // 创建bucket
                client.createBucket(bucketName);
                //设置bucket的访问权限，public-read-write权限
                client.setBucketAcl(bucketName, CannedAccessControlList.PublicRead);
            } catch (OSSException e) {
                e.printStackTrace();
                LOGGER.info("==" + e.getMessage());
                return Global.ERROR;
            } catch (ClientException e) {
                if (!OSSErrorCode.BUCKET_ALREADY_EXISTS.equals(e.getErrorCode())) {
                    // 如果Bucket已经存在，则忽略
                LOGGER.info("==bucketName已经存在");
                }else{
                    e.printStackTrace();
                    LOGGER.info("=="+e.getMessage());
                    return Global.ERROR;
                }
            }
            return Global.SUCCESS;
    }
    
    public static boolean fileExist(OSSClient client, String bucketName,String key){
    	String oss_key = Constant.LOCAL_URL.substring(Constant.LOCAL_URL.indexOf("/")+1)+key;
    	// Object是否存在
    	boolean found = ossClient.doesObjectExist(bucketName, oss_key);
  	  	return found;
    }
    
    public static void deleteFile(String key){    
    	String oss_key = Constant.LOCAL_URL.substring(Constant.LOCAL_URL.indexOf("/")+1)+key;
    	OSSClient client = OSSClientFactory.getInstance();
    	if(fileExist(client,Constant.BUCKET_NAME,key)){
    		client.deleteObject(Constant.BUCKET_NAME, oss_key);   
    		LOGGER.info("删除" + Constant.BUCKET_NAME + "下的文件" + key + "成功");  
    	}
  	  	// 关闭client
  	  	//ossClient.shutdown();
    }
	
    /**  
     * 通过文件名判断并获取OSS服务文件上传时文件的contentType  
     * @param fileName 文件名 
     * @return 文件的contentType    
     */    
     public static String getContentType(String fileName){    
        String fileExtension = fileName.substring(fileName.lastIndexOf(".")+1);  
        if("bmp".equalsIgnoreCase(fileExtension)) return "image/bmp";  
        if("gif".equalsIgnoreCase(fileExtension)) return "image/gif";  
        if("jpeg".equalsIgnoreCase(fileExtension) || "jpg".equalsIgnoreCase(fileExtension)  || "png".equalsIgnoreCase(fileExtension) ) return "image/jpeg";  
        if("html".equalsIgnoreCase(fileExtension)) return "text/html";  
        if("txt".equalsIgnoreCase(fileExtension)) return "text/plain";  
        if("vsd".equalsIgnoreCase(fileExtension)) return "application/vnd.visio";  
        if("ppt".equalsIgnoreCase(fileExtension) || "pptx".equalsIgnoreCase(fileExtension)) return "application/vnd.ms-powerpoint";  
        if("doc".equalsIgnoreCase(fileExtension) || "docx".equalsIgnoreCase(fileExtension)) return "application/msword";  
        if("xml".equalsIgnoreCase(fileExtension)) return "text/xml";  
        if("flv".equalsIgnoreCase(fileExtension)) return "video/x-flv";
        if("mp4".equalsIgnoreCase(fileExtension)) return "video/mp4";
        return "text/html";    
     }
}
