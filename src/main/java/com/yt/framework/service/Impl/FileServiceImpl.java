package com.yt.framework.service.Impl;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.service.FileService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.SpaceService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.file.UploadUtils;
import com.yt.framework.utils.file.VideoImageUtil;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;
@Service(value="fileService")
public class FileServiceImpl implements FileService {
	
	protected static Logger logger = LogManager.getLogger(FileServiceImpl.class);
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	@Autowired
	private SpaceService spaceService;
	@Autowired
	private ImageVideoService imageVideoService;
	@Autowired
	private MessageResourceService messageResourceService;

	@Override
	public AjaxMsg uploadFile(MultipartFile file,String fileType) throws IOException {
		//上传的文件名
		String fileName = file.getOriginalFilename();
		//上传文件的后缀名（小写）
		String suffix = Common.getSuffix(fileName).toLowerCase();
		// 视频格式
		String[] video_format = { "asx", "asf", "mpg", "wmv", "3gp", "mp4", "mov", "avi", "flv", "x-ms-wmv" };
		//图片格式
		String[] pic_format = {"jpg","bmp","png","jpeg","gif"};
		//文件保存的路径。需根据上传文件的后缀来判断上传至何处
		String path = fileType.replaceAll("_", "/");
		if(fileType.contains("video")){
			//校验视频格式
			if(!Common.contains(video_format, suffix)){
				return AjaxMsg.newError().addMessage("上传的视频格式错误");
			}
			if("x-ms-wmv".equals(suffix)){
				fileName = fileRepository.storeByExt(path, "wmv", file);
			}else{
				fileName = fileRepository.storeByExt(path, suffix, file);
			}
			String vpath = fileRepository.getRealPath(fileName);
			if("flv".equals(suffix)){
				VideoImageUtil.process(vpath);//视频截图
			}else{
				String opath = fileName;
				vpath = VideoImageUtil.processChange(vpath);
				if(StringUtils.isNotBlank(vpath)){
					fileName = fileName.substring(0,fileName.lastIndexOf("."))+".flv";
					//deleteFile(opath);
				}else{
					return AjaxMsg.newError().addMessage("上传异常");
				}
			}
			return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
		}else if(fileType.contains("picture")){
			//校验图片格式
			if(!Common.contains(pic_format, suffix)){
				return AjaxMsg.newError().addMessage("上传的图片格式错误");
			}
			fileName = fileRepository.storeByExt(path, suffix, file);
			return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
			
		}else if("attac".equals(fileType)){
			fileName = fileRepository.storeByExt(path, suffix, file);
			return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
		}
		//页面传到后台的类型 不是 picture 或者 video
		return AjaxMsg.newError().addMessage("上传异常");
	}
	
	@Override
	public AjaxMsg uploadFile2OSS(MultipartFile file,String fileType) throws Exception {
		//上传的文件名
		String fileName = file.getOriginalFilename();
		//上传文件的后缀名（小写）
		String suffix = Common.getSuffix(fileName).toLowerCase();
		// 视频格式
		String[] video_format = { "asx", "asf", "mpg", "wmv", "3gp", "mp4", "mov", "avi", "flv", "x-ms-wmv" };
		//图片格式
		String[] pic_format = {"jpg","bmp","png","jpeg","gif"};
		//文件保存的路径。需根据上传文件的后缀来判断上传至何处
		String path = fileType.replaceAll("_", "/");
		if(fileType.contains("video")){
			//校验视频格式
			if(!Common.contains(video_format, suffix)){
				return AjaxMsg.newError().addMessage("上传的视频格式错误");
			}
			if("x-ms-wmv".equals(suffix)){
				fileName = fileRepository.storeByExt(path, "wmv", file);
			}else{
				fileName = fileRepository.storeByExt(path, suffix, file);
			}
			String vpath = fileRepository.getRealPath(fileName);
			if("flv".equals(suffix)){
				VideoImageUtil.process(vpath);//视频截图
			}else{
				String opath = fileName;
				vpath = VideoImageUtil.processChange(vpath);
				if(StringUtils.isNotBlank(vpath)){
					fileName = fileName.substring(0,fileName.lastIndexOf("."))+".flv";
					//deleteFile(opath);
				}else{
					return AjaxMsg.newError().addMessage("上传异常");
				}
			}
			String cover = fileName.substring(0,fileName.lastIndexOf("."))+".jpg";
			imageVideoService.uploadFile2OSS(null,null,fileRepository.getRealPath(cover),cover);
			imageVideoService.uploadFile2OSS(null,null,fileRepository.getRealPath(fileName),fileName);
			return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
		}else if(fileType.contains("picture")){
			//校验图片格式
			if(!Common.contains(pic_format, suffix)){
				return AjaxMsg.newError().addMessage("上传的图片格式错误");
			}
//			fileName = fileRepository.storeByExt(path, suffix, file);
			fileName = UploadUtils.generateFilename(path, suffix);
			OSSClientFactory.uploadFile(fileName,file);
			return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
			
		}else if("attac".equals(fileType)){
//			fileName = fileRepository.storeByExt(path, suffix, file);
			fileName = UploadUtils.generateFilename(path, suffix);
			OSSClientFactory.uploadFile(fileName,file);
			return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
		}
		//页面传到后台的类型 不是 picture 或者 video
		return AjaxMsg.newError().addMessage("上传异常");
	}
	
	@Override
	public AjaxMsg uploadImg2OSS(String img) throws Exception{
		if(StringUtils.isNotBlank(img)){
			int result = OSSClientFactory.uploadFile(img, new File(fileRepository.getRealPath(img)));
			if(result == Global.SUCCESS){
				ImageKit.delFile(fileRepository.getRealPath(img));
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
			}
		}
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg uploadImg2OSS(String[] imgs) throws Exception{
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(imgs!=null&&imgs.length>0){
			for (String img : imgs) {
				if(StringUtils.isNotBlank(img.trim())){
					msg = uploadImg2OSS(img.trim());
				}
			}
		}
		return msg;
	}
	
	@Override
	public AjaxMsg uploadImg2OSS(String old_img,String new_img) throws Exception{
		if(StringUtils.isNotBlank(old_img)){
			if(!old_img.equals(new_img)){
				int result = OSSClientFactory.uploadFile(new_img, new File(fileRepository.getRealPath(new_img)));
				if(result == Global.SUCCESS){
					ImageKit.delFile(fileRepository.getRealPath(new_img));
					
				}else{
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
				}
				OSSClientFactory.deleteFile(old_img);
			}
		}else{
			if(StringUtils.isNotBlank(new_img)){
				int result = OSSClientFactory.uploadFile(new_img, new File(fileRepository.getRealPath(new_img)));
				if(result == Global.SUCCESS){
					ImageKit.delFile(fileRepository.getRealPath(new_img));
				}else{
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
				}
			}
		}
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg uploadImg2OSS(String[] old_imgs,String[] new_imgs) throws Exception{
		String[] olds = Common.parseStrings(old_imgs);
		String[] news = Common.parseStrings(new_imgs);
		if(olds!=null&&olds.length>0){
			List<String> oldImgs = Lists.newArrayList(olds);
			List<String> ss1 = new ArrayList<String>();
			ss1.addAll(oldImgs);
			if(news!=null&&news.length>0){
				List<String> newImgs = Lists.newArrayList(news);
				oldImgs.removeAll(newImgs);//缺少的
				newImgs.removeAll(ss1);//多出来的
				if(oldImgs!=null&&oldImgs.size()>0){
					for (String oi : oldImgs) {
						OSSClientFactory.deleteFile(oi);
					}
				}
				if(newImgs!=null&&newImgs.size()>0){
					for (String ni : newImgs) {
						int flag = OSSClientFactory.uploadFile(ni, new File(fileRepository.getRealPath(ni)));
						if(flag == Global.SUCCESS){
							ImageKit.delFile(fileRepository.getRealPath(ni));
						}
					}
				}
			}else{
				for (String oi : oldImgs) {
					OSSClientFactory.deleteFile(oi);
				}
			}
		}else{
			if(news!=null&&news.length>0){
				for (String str : news) {
					if(StringUtils.isNotBlank(str)){
						int flag = OSSClientFactory.uploadFile(str, new File(fileRepository.getRealPath(str)));
						if(flag == Global.SUCCESS){
							ImageKit.delFile(fileRepository.getRealPath(str));
						}else{
							return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
						}
					}
				}
			}
		}
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg uploadBatchFile(Map<String, MultipartFile> fileMap,String[] pic_format,String path,long size) throws IOException {
		Map<String,String>rMap =  Maps.newHashMap();
		for(Map.Entry<String, MultipartFile> entity : fileMap.entrySet()){
			MultipartFile file = entity.getValue();
			//上传的文件名
			String fileName = file.getOriginalFilename();
			//上传文件的后缀名（小写）
			String suffix = Common.getSuffix(fileName).toLowerCase();
			//图片格式是否正确
			if(!Common.contains(pic_format, suffix)){
				return AjaxMsg.newError().addMessage("上传的文件格式错误");
			}
			//校验文件大小,大于0,小于5M
			if(file.getSize()<=0 || file.getSize() >size){
				return AjaxMsg.newError().addMessage("上传的文件大于"+size+"字节，当前文件大小为：" + file.getSize() + "字节");
			}
			fileName = fileRepository.storeByExt(path, suffix, file);
			rMap.put(entity.getKey(), fileName);
		}
		return AjaxMsg.newSuccess().addData("fileMap", rMap).addMessage("上传成功");
	}
	
	@Override
	public AjaxMsg uploadBatchImage(Map<String, MultipartFile> fileMap,
			String file_type) throws IOException {
		//图片格式
		String[] pic_format = {"jpg","bmp","png","jpeg","gif"};
		String path = "picture";
		Map<String,String>rMap =  Maps.newHashMap();
		if(file_type.equals("picture")){
			if(fileMap.size() == 0 || fileMap.size()> 9) return AjaxMsg.newError().addMessage("上传的图片数量错误");
			for(Map.Entry<String, MultipartFile> entity : fileMap.entrySet()){
				MultipartFile file = entity.getValue();
				//上传的文件名
				String fileName = file.getOriginalFilename();
				//上传文件的后缀名（小写）
				String suffix = Common.getSuffix(fileName).toLowerCase();
				//图片格式是否正确
				if(!Common.contains(pic_format, suffix)){
					return AjaxMsg.newError().addMessage("上传的图片格式错误");
				}
				//校验文件大小,大于0,小于5M
				if(file.getSize()<=0 || file.getSize() >1024*1024*5){
					return AjaxMsg.newError().addMessage("上传的图片大于5M，当前图片大小为：" + file.getSize() + "字节");
				}
				fileName = fileRepository.storeByExt(path, suffix, file);
				rMap.put(entity.getKey(), fileName);
			}
		}else{
			return AjaxMsg.newError().addMessage("文件类型错误");
		}
		return AjaxMsg.newSuccess().addData("fileMap", rMap).addMessage("上传成功");
	}
	
	
	@Override
	public AjaxMsg deleteFile(String url) {
		File dest = new File(fileRepository.getRealPath(url));
		if (dest.exists()) {
			if(dest.delete()){
				return AjaxMsg.newSuccess().addMessage(url+"删除成功");
			}else{
				return AjaxMsg.newError().addMessage(url+"删除失败");
			}
		}
		return AjaxMsg.newError().addMessage(url+"文件不存在");
	}

	@Override
	public AjaxMsg queryFilesInfoByUid() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AjaxMsg queryFileInfoById(String fid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AjaxMsg uploadImg(MultipartFile file) throws IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AjaxMsg deleteImg(String url) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AjaxMsg updateFileInfo(Object o) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AjaxMsg uploadFile(String id, String roleType, MultipartFile file,
			String fileType) throws IOException {
				AjaxMsg msg = AjaxMsg.newError();
				//上传的文件名
				String fileName = file.getOriginalFilename();
				//上传文件的后缀名（小写）
				String suffix = Common.getSuffix(fileName).toLowerCase();
				// 视频格式
				String[] video_format = { "flv", "mp4", "wmv", "swf", "avi", "rm", "asf", "mov" };
				//图片格式
				String[] pic_format = {"jpg","bmp","png","jpeg","gif"};
				//文件保存的路径。需根据上传文件的后缀来判断上传至何处
				String path = "";
				if(fileType.equals("video")){
					path = "video";
					//校验视频格式
					if(!Common.contains(video_format, suffix)){
						return msg.addMessage("上传的视频格式错误");
					}
					//校验文件大小,大于0,小于20M
					if(file.getSize()<=0 || file.getSize() >1024*1024*20){
						return msg.addMessage("上传的视频大于20M，当前视频大小为：" + file.getSize() + "字节");
					}
					//判断用户空间大小是否足够存储文件
					BigDecimal fileSize = new BigDecimal(file.getSize()).divide(new BigDecimal(1024*1024), 2, RoundingMode.HALF_UP);
					msg = spaceService.calculateSpace(id, roleType, fileSize);
					if(msg.isError()) return msg;
					
					if("x-ms-wmv".equals(suffix)){
						fileName = fileRepository.storeByExt(path, "wmv", file);
					}else{
						fileName = fileRepository.storeByExt(path, suffix, file);
					}
					String vpath = fileRepository.getRealPath(fileName);
					VideoImageUtil.process(vpath);//视频截图
					return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
				}else if(fileType.equals("picture")){
					path = "picture";
					//校验图片格式
					if(!Common.contains(pic_format, suffix)){
						return msg.addMessage("上传的图片格式错误");
					}
					//校验文件大小,大于0,小于2M
					if(file.getSize()<=0 || file.getSize() >1024*1024*2){
						return msg.addMessage("上传的图片大于2M，当前图片大小为：" + file.getSize() + "字节");
					}
					
					//判断用户空间大小是否足够存储文件
					BigDecimal fileSize = new BigDecimal(file.getSize()).divide(new BigDecimal(1024*1024), 2, RoundingMode.HALF_UP);
					msg = spaceService.calculateSpace(id, roleType, fileSize);
					if(msg.isError()) return msg;
					
					fileName = fileRepository.storeByExt(path, suffix, file);
					return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
					
				}
				//页面传到后台的类型 不是 picture 或者 video
				return msg.addMessage("上传异常");
		
	}

	@Override
	public AjaxMsg uploadExcelFile(MultipartFile file) throws IOException {
			//上传的文件名
			String fileName = file.getOriginalFilename();
			//上传文件的后缀名（小写）
			String suffix = Common.getSuffix(fileName).toLowerCase();
			String[] excel_format = { "xlsx", "xls" };
			//文件保存的路径。需根据上传文件的后缀来判断上传至何处
			String path = "excel";
			if(!Common.contains(excel_format, suffix)){
				return AjaxMsg.newError().addMessage("上传异常");
			}
			fileName = fileRepository.storeByExt(path, suffix, file);
			return AjaxMsg.newSuccess().addData("src", fileName).addData("f_size",file.getSize()).addMessage("上传成功");
	}

	
}
