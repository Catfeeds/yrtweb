package com.yt.framework.service;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.yt.framework.utils.AjaxMsg;

public interface FileService {
	/**
	 * @Title: uploadFile 
	 * @Description: 文件上传 
	 * @param @param file 需要上传的文件
	 * @param @param fileType 上传文件的类型（视频或者图片）
	 * @param @return
	 * @param @throws IOException    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月28日下午3:43:49
	 */
	public AjaxMsg uploadFile(MultipartFile file,String fileType) throws IOException;
	
	public AjaxMsg uploadFile2OSS(MultipartFile file,String fileType) throws Exception;
	
	public AjaxMsg uploadImg2OSS(String img) throws Exception;
	public AjaxMsg uploadImg2OSS(String[] imgs) throws Exception;
	
	public AjaxMsg uploadImg2OSS(String old_img,String new_img) throws Exception;
	public AjaxMsg uploadImg2OSS(String[] old_img,String[] new_img) throws Exception;
	
	/**
	 * 文件上传时判断存储空间是否足够
	 *@param id 用户或者俱乐部ID
	 *@param type 用户 或 俱乐部 ROLETYPE
	 *@param file
	 *@param fileType
	 *@return
	 *@throws IOException
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-2下午12:15:50
	 */
	public AjaxMsg uploadFile(String id,String roleType,MultipartFile file,String fileType) throws IOException;
	/**
	 * @Title: deleteFile 
	 * @Description: 文件url删除文件 
	 * @param @param url
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月28日上午10:09:16
	 */
	public AjaxMsg deleteFile(String url);
	/**
	 * @Title: selectFilesInfoById 
	 * @Description: 根据用户ID查询其上传的文件列表 
	 * @param @param uid
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月27日下午4:39:30
	 */
	public AjaxMsg queryFilesInfoByUid();
	/**
	 * @Title: queryFileInfoById 
	 * @Description: 根据文件上传记录ID查询文件信息 
	 * @param @param fid
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月27日下午4:43:08
	 */
	public AjaxMsg queryFileInfoById(String fid);
	/**
	 * @Title: uploadImg 
	 * @Description: 上传图片 
	 * @param @param file
	 * @param @return
	 * @param @throws IOException    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月28日上午10:31:03
	 */
	public AjaxMsg uploadImg(MultipartFile file) throws IOException;
	/**
	 * @Title: deleteImg 
	 * @Description: 根据uid，文件url 删除图片 
	 * @param @param url
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月28日上午10:35:32
	 */
	public AjaxMsg deleteImg(String url);
	/**
	 * @Title: updateFileInfo 
	 * @Description: 更新文件上传记录 
	 * @param @param o
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月28日上午10:42:57
	 */
	public AjaxMsg updateFileInfo(Object o);
	
	/**
	 * @Title: uploadBatchImage
	 * @Description: 批量上传图片
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author ylt
	 * @date:2015年7月28日上午10:42:57
	 */
	public AjaxMsg uploadBatchImage(Map<String, MultipartFile> fileMap, String file_type)throws IOException;
	
	/**
	 * @Title: uploadBatchFile
	 * @Description: 批量上传文件
	 * @param fileMap 文件集合 pic_format 文件类型{"jpg","bmp","png","jpeg","gif"} path 存放路径 size 单个文件上限大小字节
	 * @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author ylt
	 * @date:2015年7月28日上午10:42:57
	 */
	public AjaxMsg uploadBatchFile(Map<String, MultipartFile> fileMap,String[] pic_format,String path,long size)throws IOException;
	
	
	public AjaxMsg uploadExcelFile(MultipartFile file)throws IOException;
}
