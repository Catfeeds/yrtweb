package com.yt.framework.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 审核管理
 * @author ylt
 * @date 2015年7月27日 上午10:25:03 
 */
@Controller
@RequestMapping(value="/admin/file")
public class FileController {
	
	private static Logger logger = LogManager.getLogger(FileController.class);
	
	@Autowired
	private ImageVideoService imageVideoService;
	
	/**
	 * 视频列表
	 * @param request
	 * @param pageModel
	 * @return msg
	 */
	@RequestMapping(value="videoList")
	public String videoList(HttpServletRequest request,ImageVideo imageVideo,PageModel pageModel){
		imageVideo.setType("video");
		AjaxMsg ajaxMsg = imageVideoService.searchImageVideos(imageVideo, pageModel);
		request.setAttribute("page", ajaxMsg.getData("page"));
		request.setAttribute("params", imageVideo);
		return "admin/file/videolist"; 
	}
	/**
	 * 图片列表
	 * @param request
	 * @param pageModel 
	 * @return msg
	 */
	@RequestMapping(value="imageList")
	public String imageList(HttpServletRequest request,ImageVideo imageVideo,PageModel pageModel){
		imageVideo.setType("image");
		AjaxMsg ajaxMsg = imageVideoService.searchImageVideos(imageVideo, pageModel);
		request.setAttribute("page", ajaxMsg.getData("page"));
		request.setAttribute("params", imageVideo);
		return "admin/file/imagelist"; 
	}
	
	/**
	 * 文件更新
	 * @param request
	 * @param pageModel
	 * @return msg
	 */
	@RequestMapping(value="updateFile")
	@ResponseBody
	public String updateFile(HttpServletRequest request,ImageVideo imageVideo){
		AjaxMsg msg = imageVideoService.update(imageVideo);
		return msg.toJson(); 
	}
	
	
	/**
	 * 图片编辑页面
	 * @param request
	 * @param pageModel
	 * @return msg
	 */
	@RequestMapping(value="toImage")
	public String toImage(HttpServletRequest request){
		String id = request.getParameter("id");
		ImageVideo imageVideo = imageVideoService.getImageById(id);
		request.setAttribute("imageForm", imageVideo);
		return "admin/file/imageForm";  
	}
	
	/**
	 * 文件编辑页面
	 * @param request
	 * @param pageModel
	 * @return msg
	 */
	@RequestMapping(value="toVideo")
	public String toVideo(HttpServletRequest request){
		String id = request.getParameter("id");
		ImageVideo imageVideo = imageVideoService.getVideoById(id);
		request.setAttribute("videoForm", imageVideo);
		return "admin/file/videoForm";  
	}
	
}
