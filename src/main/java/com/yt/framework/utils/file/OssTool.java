package com.yt.framework.utils.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import com.aliyun.oss.ClientConfiguration;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.Bucket;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;
import com.yt.framework.utils.PropertiesUtils;

public class OssTool {
	protected static Logger logger = LogManager.getLogger(OssTool.class.getName());

	// 如果是杭州节点的OSS服务，请求地址可以使用oss-cn-hangzhou.aliyuncs.com跟oss.aliyuncs.com 
	private static String ENDPOINT = "http://oss-cn-hangzhou.aliyuncs.com";
	// accessKey请登录https://ak-console.aliyun.com/#/查看
	private static String ACCESS_KEY = "rggvH3jDPSgGzrRL";
	private static String ACCESS_SECRET = "kSCWB115QB2j2NYTGqRRupa3AAuQ23";
	private static String BUCKET_NAME = "yrt2016";
	public static String OSS_URL = "http://img.11uniplay.com/";
	
	//init static datas  
    static{  
    	Properties prop = PropertiesUtils.loadSetting("/messages/common.properties");
        ENDPOINT = prop.containsKey("endpoint") == false ? "" : prop.getProperty("endpoint");  
        ACCESS_KEY = prop.containsKey("accessKeyId") == false? "" : prop.getProperty("accessKeyId");  
        ACCESS_SECRET = prop.containsKey("accessKeySecret") == false ? "" : prop.getProperty("accessKeySecret");  
        BUCKET_NAME = prop.containsKey("bucketName") == false ? "" : prop.getProperty("bucketName");
        OSS_URL = prop.containsKey("ossUrl") == false ? "" : prop.getProperty("ossUrl");
    }  
    
    public static void test(){
    	System.out.println("testestestsetsets");
    }
    
    public static ClientConfiguration conf(){
    	// 创建ClientConfiguration实例
    	ClientConfiguration conf = new ClientConfiguration();
    	// 设置OSSClient使用的最大连接数，默认1024
    	conf.setMaxConnections(200);
    	// 设置请求超时时间，默认50秒
    	conf.setSocketTimeout(10000);
    	// 设置失败请求重试次数，默认3次
    	conf.setMaxErrorRetry(3);
    	return conf;
    }
	
    /** 
     * 获取阿里云OSS客户端对象 
     * */  
    public static OSSClient getOSSClient(){  
        return new OSSClient(ENDPOINT,ACCESS_KEY, ACCESS_SECRET);  
    }  
	
	/** 
     * 新建Bucket  --Bucket权限:私有 
     * @param bucketName bucket名称 
     * @return true 新建Bucket成功 
     * */  
	public static boolean createBucket(OSSClient client, String bucketName){  
        Bucket bucket = client.createBucket(bucketName);   
        return bucketName.equals(bucket.getName());  
    }  
	
	/** 
     * 删除Bucket  
     * @param bucketName bucket名称 
     * */  
    public static void deleteBucket(OSSClient client, String bucketName){  
        client.deleteBucket(bucketName);   
        logger.info("删除" + bucketName + "Bucket成功");  
    } 
    
    
    /** 
     * 向阿里云的OSS存储中存储文件  --file也可以用InputStream替代 
     * @param client OSS客户端 
     * @param file 上传文件 
     * @param bucketName bucket名称 
     * @param diskName 上传文件的目录  --bucket下文件的路径 
     * @return String 唯一MD5数字签名 
     * */  
    public static String uploadObject2OSS(MultipartFile file, String diskName) {  
    	OSSClient ossClient = getOSSClient();
        String resultStr = null;  
        try {  
            InputStream is = file.getInputStream();
            String fileName = file.getOriginalFilename();
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
            PutObjectResult putResult = ossClient.putObject(BUCKET_NAME, diskName, is, metadata);  
            //解析结果  
            resultStr = putResult.getETag(); 
        } catch (Exception e) {  
        	logger.error("上传阿里云OSS服务器异常." + e.getMessage(), e);  
        } finally {
            ossClient.shutdown();
        }
        return resultStr;  
    }  
    
    public static String uploadObject2OSS(File file, String diskName) {  
    	OSSClient ossClient = getOSSClient();
    	System.out.println("=========================2");
        String resultStr = null;  
        try {  
            InputStream is = new FileInputStream(file);
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
            PutObjectResult putResult = ossClient.putObject(BUCKET_NAME, diskName, is, metadata);  
            //解析结果  
            resultStr = putResult.getETag(); 
        } catch (Exception e) {  
        	logger.error("上传阿里云OSS服务器异常." + e.getMessage(), e);  
        } finally {
            ossClient.shutdown();
        }
        return resultStr;  
    } 
    /**  
     * 根据key获取OSS服务器上的文件输入流 
     * @param client OSS客户端 
     * @param bucketName bucket名称 
     * @param diskName 文件路径 
     * @param key Bucket下的文件的路径名+文件名 
     */    
     public static InputStream getOSS2InputStream(OSSClient client, String bucketName, String diskName, String key){   
        OSSObject ossObj = client.getObject(bucketName, diskName + key);  
        return ossObj.getObjectContent();     
     }    
      
   /**  
    * 根据key删除OSS服务器上的文件  
    * @param client OSS客户端 
    * @param bucketName bucket名称 
    * @param diskName 文件路径 
    * @param key Bucket下的文件的路径名+文件名 
    */    
      public static void deleteFile(String diskName){    
    	  OSSClient ossClient = getOSSClient();	
    	  ossClient.deleteObject(BUCKET_NAME, diskName);   
    	  logger.info("删除" + BUCKET_NAME + "下的文件" + diskName + "成功");  
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
     
     public static void main(String[] args) {
    	/*Path path = Paths.get("C:/Users/lenovo/Desktop/yasuo/uu.mp4");
    	try {
			String ct = Files.probeContentType(path);
			System.out.println(ct);
		} catch (Exception e) {
		}*/
    	 //上传测试
    	File file = new File("E:/upload/player/picture/201511/24142750nqa1.jpg");
 		String url = OssTool.uploadObject2OSS(file, "player/picture/201511/24142750nqa1.jpg");
 		System.out.println(url);
    	//删除测试
    	// OssTool.deleteFile("images/test2.jpg");
    	 
         //OSSClient client = new OSSClient(ENDPOINT, ACCESS_KEY, ACCESS_SECRET);
         
         /*try {
             System.out.println("Uploading a new object to OSS from an input stream\n");
             File file = new File("C:/Users/lenovo/Desktop/yasuo/oss/24113603b6tt.jpg");
             client.putObject(BUCKET_NAME, "images/test2.jpg", file);
             
              
            // System.out.println("Uploading a new object to OSS from a file\n");
            // client.putObject(new PutObjectRequest(bucketName, key, createSampleFile()));
             
              
             //System.out.println("Downloading an object");
            // OSSObject object = client.getObject(new GetObjectRequest(bucketName, key));
            // System.out.println("Content-Type: "  + object.getObjectMetadata().getContentType());
            // displayTextInputStream(object.getObjectContent());
             
         } catch (OSSException oe) {
             System.out.println("Caught an OSSException, which means your request made it to OSS, "
                     + "but was rejected with an error response for some reason.");
             System.out.println("Error Message: " + oe.getErrorCode());
             System.out.println("Error Code:       " + oe.getErrorCode());
             System.out.println("Request ID:      " + oe.getRequestId());
             System.out.println("Host ID:           " + oe.getHostId());
         } catch (Exception ce) {
        	 ce.printStackTrace();
         } finally {
             client.shutdown();
         }*/
     }
}
