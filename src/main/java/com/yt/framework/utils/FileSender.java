package com.yt.framework.utils;

import java.io.File;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.file.OssTool;

public class FileSender implements Runnable {

	private FileRepository fileRepository;
	
	private String filePath;
	
	public FileSender() {
	}

	public FileSender(String filePath) {
//		this.fileRepository = (FileRepository) SpringContextUtil.getBean("fileRepository");
		this.filePath=filePath;
	}

	@Override
	public void run() {
		if(StringUtils.isNotBlank(filePath)){
//			System.out.println("=========================================================");
//			System.out.println(fileRepository);
//			System.out.println("=========================================================+++"+fileRepository.getRealPath(filePath));
			File dest = new File("E:/upload/player/picture/201511/24142750nqa1.jpg");
			System.out.println(dest.exists());
			System.out.println("+++++++++++++=");
			if(dest.exists()){
				OssTool.uploadObject2OSS(dest, "/test/"+filePath);
			}
		}
	}
}
