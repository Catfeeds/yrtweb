package com.yt.framework.utils.oss;

import java.io.File;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.aliyun.oss.OSSClient;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.utils.SpringContextUtil;


public class OSSUploadFile implements Runnable {
	
	public static final Logger LOGGER = Logger.getLogger(OSSUploadFile.class);

	private String sourcePath;//上次路径
    private String key;//云端存储路径
    private String ivId;
    private String type;
    private ImageVideoService imageVideoService;
	
	public OSSUploadFile() {
	}

	public OSSUploadFile(String ivId,String type,String sourcePath,String key) {
		this.ivId = ivId;
		this.type = type;
		this.sourcePath=sourcePath;
		this.key=key;
		imageVideoService = (ImageVideoService) SpringContextUtil.getBean("imageVideoService");
	}
	
	@Override
	public void run() {
		File uploadFile = new File(sourcePath);
		if (!uploadFile.exists()){ 
			LOGGER.info("[OSS]无法找到文件：" + sourcePath);
			return;
		}
		OSSClient client  = OSSClientFactory.getInstance();  
		int result = Global.ERROR;
		key = key.contains("\\\\")?key.replaceAll("\\\\", "/"):key.contains("\\")?key.replaceAll("\\", "/"):key;
		// 准备Bucket
        result = OSSClientFactory.ensureBucket(client,Constant.BUCKET_NAME);
        if(result != Global.ERROR && (!OSSClientFactory.fileExist(client,Constant.BUCKET_NAME,key))){
        	result = OSSClientFactory.uploadFile(client, Constant.BUCKET_NAME, key, uploadFile);
        }
        if(result == Global.SUCCESS){
        	if(StringUtils.isNotBlank(ivId)&&StringUtils.isNotBlank(type)){
        		imageVideoService.updateImgOrVideo2OSS(ivId,type,uploadFile);
        	}
        	LOGGER.info("[OSS]上传文件到OSS成功！:"+sourcePath+"/"+key);
        }else{
        	LOGGER.info("[OSS]上传文件到OSS失败！:"+sourcePath);
        }
	}
	
}
