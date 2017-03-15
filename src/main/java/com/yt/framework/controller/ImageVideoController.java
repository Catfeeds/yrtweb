package com.yt.framework.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.Dynamic;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.FileService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.file.ImageUtils;
import com.yt.framework.utils.file.VideoImageUtil;
import com.yt.framework.utils.tag.FileUtilsTag;

/**
 * 图片资料上传
 * 
 * @autor bo.xie
 * @date2015-7-23下午6:40:05
 */
@Controller
@RequestMapping(value = "/imageVideo")
public class ImageVideoController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(ImageVideoController.class);

	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private ImageVideoService imageVideoService;
	@Autowired
	private DynamicService dynamicService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private TeamInfoService teamInfoService;
	
	
	@RequestMapping(value = "/uploadImgTemp")
	public void uploadTemp(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8");
		try {
			String type = request.getParameter("filetype");
			String size = StringUtils.isNotBlank(request.getParameter("size"))?request.getParameter("size"):"2";
			String path = request.getContextPath() + "/upload";
			String filename = "";
			if(file.getSize() > 0 && file.getSize() < 1024 * 1024 * Integer.parseInt(size)) {
				String exts[] = file.getContentType().split("/");
				if (ImageUtils.isValidImageExt(exts[1]) || "attac".equals(type)) {
					//filename = fileRepository.storeByExtCtx(request.getContextPath() + "/filetemp/",exts[1],file);
					filename = fileRepository.storeByExt("filetemp", file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1), file);
					response.getWriter().print(AjaxMsg.newSuccess().addData("filename", filename).addData("url", path+"/"+filename).toJson());
				}else{
					response.getWriter().print(AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.upload.style")).toJson());
				}
			}else{
				response.getWriter().print(AjaxMsg.newError().addMessage(messageResourceService.getMessage(new Object[]{"2M"}, "system.error.upload.size")).toJson());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	/**
	 * ajax单张图片上传
	 * 
	 * @param myFiles
	 * @param response
	 */
	@RequestMapping(value = "/imageUpload")
	public @ResponseBody String ajaxImageUpload(@RequestParam("file")MultipartFile file, HttpServletResponse response,
			HttpServletRequest request) {
		try {
			String path = request.getContextPath() + "/upload";
			String fileName = "";
//			for (int i = 0; i < files.length; i++) {
				//MultipartFile file = files[i];
				if (file.getSize() > 0 && file.getSize() < 1024 * 1024 * 2) {
					String exts[] = file.getContentType().split("/");
					if (ImageUtils.isValidImageExt(exts[1])) {
						fileName = fileRepository.storeByExt("/picture", exts[1], file);
						return AjaxMsg.newSuccess().addData("url", path + fileName).addData("src", fileName).toJson();
					} else {
						return AjaxMsg.newError().addMessage("上传的图片格式错误").toJson();
					}
				} else {
					return AjaxMsg.newError().addMessage("上传的图片大于2M，当前图片大小为：" + file.getSize() + "字节").toJson();
				}
//			}
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return AjaxMsg.newError().addMessage("图片上传失败").toJson();
	}
	
	@RequestMapping(value = "/videoUpload")
	@ResponseBody
	public String videoUpload(@RequestParam MultipartFile[] myFiles, HttpServletResponse response,
			HttpServletRequest request){
		try {
			String path = request.getContextPath() + "/upload";
			String fileName = "";
			for (int i = 0; i < myFiles.length; i++) {
				MultipartFile file = myFiles[i];
				if (file.getSize() > 0 && file.getSize() < 1024 * 1024 * 30) {
					String exts[] = file.getContentType().split("/");
					if (ImageUtils.isValidVideoExt(exts[1])) {
						if("x-ms-wmv".equals(exts[1])){
							fileName = fileRepository.storeByExt("/video", "wmv", file);
						}else{
							fileName = fileRepository.storeByExt("/video", exts[1], file);
						}
						String vpath = fileRepository.getRealPath(fileName);
						VideoImageUtil.process(vpath);//视频截图
						String imagePath = fileName.substring(0,fileName.lastIndexOf("."))+".jpg";
						return AjaxMsg.newSuccess().addData("url", path + imagePath).addData("src", fileName).toJson();
					} else {
						return AjaxMsg.newError().addMessage("上传的视频格式错误").toJson();
					}
				} else {
					return AjaxMsg.newError().addMessage("上传的视频大于30M，当前图片大小为：" + file.getSize() + "字节").toJson();
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return AjaxMsg.newError().addMessage("视频上传失败").toJson();
	}
	

//	/**
//	 * 删除图片
//	 * 
//	 * @param request
//	 * @return
//	 * @autor bo.xie
//	 * @parameter *
//	 * @date2015-7-24上午10:55:49
//	 */
//	@RequestMapping("imageDelete")
//	public @ResponseBody String deleteImage(HttpServletRequest request) {
//		try {
//			String imgUrl = request.getParameter("src");
//			File dest = new File(fileRepository.getRealPath(imgUrl));
//			if (dest.exists()) {
//				dest.delete();
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.error("图片删除失败");
//			return AjaxMsg.newError().toJson();
//		}
//		return AjaxMsg.newSuccess().toJson();
//
//	}

	@RequestMapping("")
	public String goVideoUpload(HttpServletRequest request) {
		return "fileupload";
	}

	/**
	 * @Title: uploadVideo 
	 * @Description: 上传文件 （视频、图片）
	 * @param @param file
	 * @param @param request
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月29日上午10:16:48
	 */
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	@ResponseBody
	public String uploadFile(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,HttpServletResponse response){
		String file_type = request.getParameter("filetype"); 
		try {
			AjaxMsg msg = fileService.uploadFile(file,file_type);
			if(msg.isSuccess()){
				String path = request.getContextPath() + "/upload/";
				String fileName = String.valueOf(msg.getData("src"));
				if(file_type.contains("video")){
					String imagePath = fileName.substring(0,fileName.lastIndexOf("."))+".jpg";
					msg.addData("url", path + imagePath);
				}else{
					msg.addData("url", path + fileName);
				}
			}
			return msg.toJson();
		} catch (IOException e) {
			logger.error("上传失败");
			return AjaxMsg.newError().addMessage("上传失败").toJson();
		}
	}
	
	@RequestMapping(value = "/uploadFile2OSS", method = RequestMethod.POST)
	@ResponseBody
	public String uploadFile2OSS(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,HttpServletResponse response){
		String file_type = request.getParameter("filetype"); 
		try {
			AjaxMsg msg = fileService.uploadFile2OSS(file,file_type);
			if(msg.isSuccess()){
				String path = FileUtilsTag.headPath();
				String fileName = String.valueOf(msg.getData("src"));
				if(file_type.contains("video")){
					String imagePath = fileName.substring(0,fileName.lastIndexOf("."))+".jpg";
					msg.addData("url", path + imagePath);
				}else{
					msg.addData("url", path + fileName);
				}
			}
			return msg.toJson();
		} catch (Exception e) {
			logger.error("上传失败");
			return AjaxMsg.newError().addMessage("上传失败").toJson();
		}
	}
	
	/**
	 * @Title: uploadBatchImage 
	 * @Description: 批量上传图片
	 * @param @param file
	 * @param @param request
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author ylt
	 * @date:2015年7月29日上午10:16:48
	 */
	@RequestMapping(value = "/uploadBatchImage", method = RequestMethod.POST)
	@ResponseBody
	public String uploadBatchFile(HttpServletRequest request){
		String file_type = request.getParameter("filetype"); 
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();  
		try {
			AjaxMsg msg = fileService.uploadBatchImage(fileMap,file_type);
			return msg.toJson();
		} catch (Exception e) {
			logger.error("上传失败");
			return AjaxMsg.newError().addMessage("上传失败").toJson();
		}
	}
	
	
	
	
	/**
	 * @Title: saveOrUpdateVideo 
	 * @Description: 保存或者更新文件 （视频、图片）
	 * @param @param imageVideo
	 * @param @param request
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author ylt
	 * @date:2015年7月29日上午10:16:48
	 */
	@RequestMapping(value = "/saveOrUpdateVideo", method = RequestMethod.POST)
	@ResponseBody
	public String saveOrUpdateVideo(HttpServletRequest request,ImageVideo imageVideo){
		String id = imageVideo.getId();
		imageVideo.setUser_id(super.getUserId());
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(id)){
			imageVideo.setId(UUIDGenerator.getUUID());
			msg = imageVideoService.save(imageVideo);
		}else{
			 msg = imageVideoService.update(imageVideo);
		}
		System.out.println(msg.toJson());
		return msg.toJson();
	}
	
	/**
	 * 保存相册中上传的图片
	 * @param request
	 * @param imageVideo
	 * @param images
	 * @author gl
	 * @return AjaxMsg
	 */
	@RequestMapping(value = "/saveImgOrVideos", method = RequestMethod.POST)
	@ResponseBody
	public String saveImgOrVideos(HttpServletRequest request,ImageVideo imageVideo,String images){
		try {
			imageVideo.setUser_id(getUserId());
			imageVideo.setIf_show(0);
			imageVideo.setF_status(1);
			AjaxMsg msg = imageVideoService.saveImgOrVideos(imageVideo,images);
			User user = super.getUser();
			if(msg.isSuccess()){//上传视频或者图片成功，我的动态中插入一条记录
				Dynamic dynamic = new Dynamic();
				dynamic.setId(UUIDGenerator.getUUID());
				dynamic.setUser_id(user.getId());
				String src = parseImages(images);
				dynamic.setType(0);//设置type为个人动态
				if(imageVideo.getType().equals("image")){//类型 1：图片 2：视频
					dynamic.setImage(src);
					dynamic.setText(user.getUsernick()+"上传了照片");
				   AjaxMsg reMsg = dynamicService.save(dynamic);
				   if(reMsg.isError()) logger.error("上传图片生成个人动态失败！");
				}else if(imageVideo.getType().equals("video")){
					dynamic.setVideo(src);
					dynamic.setText(user.getUsernick()+"上传了视频");
					AjaxMsg reMsg =dynamicService.save(dynamic);
					 if(reMsg.isError()) logger.error("上传视频生成个人动态失败！");
				}
			}
			return msg.toJson();
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().toJson();
		}
		
	}
	
	private static String parseImages(String images) {
		String str = "";
		if(StringUtils.isNotBlank(images)){
			String[] imgs = images.split(",");
			if(imgs!=null&&imgs.length>0){
				for (String i : imgs) {
					if(StringUtils.isNotBlank(i)){
						str += i + ",";
					}
				}
			}
		}
		if(str.lastIndexOf(",")>=0){
			str = str.substring(0,str.lastIndexOf(","));
		}
		return str;
	}
	
	@RequestMapping(value = "/saveTeamImgOrVideos", method = RequestMethod.POST)
	@ResponseBody
	public String saveTeamImgOrVideos(HttpServletRequest request,ImageVideo imageVideo,String images){
		try {
			TeamInfo team = teamInfoService.getTeamInfoByUserId(getUserId());
			imageVideo.setUser_id(team.getId());
			imageVideo.setIf_show(0);
			imageVideo.setF_status(1);
			AjaxMsg msg = imageVideoService.saveImgOrVideos(imageVideo,images);
			return msg.toJson();
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().toJson();
		}
	}
	
	/**
	 * @Title: deleteFile 
	 * @Description: 删除文件 
	 * @param @param request
	 * @param @return    设定文件 
	 * @return String    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月29日上午10:17:10
	 */
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public String deleteFile(HttpServletRequest request){
		String fileUrl = request.getParameter("src");
		AjaxMsg msg = null;
		try {
			String ext = fileUrl.substring(fileUrl.lastIndexOf(".")+1);
			if(ImageUtils.isValidVideoExt(ext)){
				String imagePath = fileUrl.substring(0,fileUrl.lastIndexOf("."))+".jpg";
				fileService.deleteFile(imagePath);
			}
			msg = fileService.deleteFile(fileUrl);
			return msg.toJson();
		} catch (Exception e) {
			logger.error("删除失败");
			return AjaxMsg.newError().addMessage("删除失败").toJson();
		}
		
	}
	
	/**
	 * 删除图片或视频  m_image_video表操作
	 * @param request
	 * @autor gl
	 * @return String
	 */
	@RequestMapping(value = "/removeFile", method = RequestMethod.POST)
	@ResponseBody
	public String removeFile(HttpServletRequest request){
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		AjaxMsg msg = imageVideoService.deleteFile(id,type);
		return msg.toJson();
	}
	
	/**
	 * 热门视频列表
	 *@param type 1：图片 2：视频
	 *@param role_type 角色类型 USER球迷；PLAYER:球员；TEAM:球队；BABY：宝贝
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午3:42:09
	 */
	@RequestMapping(value="/hotImageVideos")
	public String hotImageVideos(HttpServletRequest request){
		String type = request.getParameter("type"); // 文件类型 图片 视频 
		if(StringUtils.isBlank(type)) return AjaxMsg.newError().addMessage("类型错误").toJson();
		List listVideos = imageVideoService.hotImageVideosList(Integer.valueOf(type));
		System.out.println(listVideos);
		System.out.println(listVideos.size());
		request.setAttribute("videos", listVideos);
		return "index/video";
	}
	
	/**
	 * 视频图片查询列表
	 *@param group_id 分组id
	 *@param role_type 角色类型 USER球迷；PLAYER:球员；TEAM:球队；BABY：宝贝
	 *@param type 1：图片 2：视频
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午3:42:09
	 */
	@RequestMapping(value="/listDatas")
	public @ResponseBody String listDatas(HttpServletRequest request,PageModel pageModel){
		String group_id = request.getParameter("group_id"); //分组id
		String type = request.getParameter("type"); // 文件类型 图片 视频
		String role_type = request.getParameter("role_type"); //角色类别
		AjaxMsg msg = imageVideoService.getImageVideos(group_id, Integer.valueOf(type), Integer.valueOf(role_type), pageModel);
		return msg.toJson();
	}
	
	/**
	 * 视频列表页面跳转
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-19下午5:22:39
	 */
	@RequestMapping(value="/listVideo")
	public String listVideo(HttpServletRequest request){
		return "imageVideo/listVideo";
	}
	
	/**
	 * 图片列表页面跳转
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-19下午5:22:39
	 */
	@RequestMapping(value="/listImage")
	public String listImage(HttpServletRequest request){
		return "imageVideo/listImage";
	}
	
	/**
	 * 查询图片或者视频
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-19下午5:22:39
	 */
	@RequestMapping(value="/searchFile")
	public String searchImageVideos(HttpServletRequest request,ImageVideo imageVideo,PageModel pageModel){
		AjaxMsg ajaxMsg = imageVideoService.searchImageVideos(imageVideo, pageModel);
		return ajaxMsg.toJson();
	}
	
	/**
	 * 视频列表页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/loadVideos")
	public String videoListPage(Model model,HttpServletRequest request){
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		request.setAttribute("user_img", user_img);
		//TODO 视频列表页面
		return "videolist";
	}
	
	/**
	 * 视频列表数据
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="/videoDatas")
	public String videoDatas(Model model,HttpServletRequest request,PageModel pageModel){
		//TODO 视频列表数据
		Map<String,Object> maps = Maps.newHashMap();
		AjaxMsg msg = imageVideoService.loadAllVideos(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "videoDatas";
	}
	
	/**
	 * 保存用户对视频的评价
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveComments")
	public @ResponseBody String saveVideoComments(HttpServletRequest request){
		//TODO 保存用户对视频的评价
		Map<String,Object> maps = Maps.newHashMap();
		String user_id = super.getUserId();
		String iv_id = request.getParameter("iv_id");//视频ID
		String content = request.getParameter("content");//评价内容
		String roleType = request.getParameter("roleType");//类型：用户 ，俱乐部，足球宝贝
		maps.put("user_id", user_id);
		maps.put("iv_id", iv_id);
		maps.put("content", content);
		maps.put("roleType", roleType);
		AjaxMsg msg = imageVideoService.saveImageVideoComments(maps);
		return msg.toJson();
	}
	
	/**
	 * 查询图片或视频评论
	 * @autor gl
	 * @return
	 */
	@RequestMapping(value="/queryVideoComments")
	@ResponseBody
	public String queryVideoComments(HttpServletRequest request,PageModel pageModel){
		String id = request.getParameter("id");//图片或视频id
		String type = request.getParameter("type");//球员player、俱乐部club、宝贝baby
		if(StringUtils.isNotBlank(id)){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", id);
			params.put("type", type);
			AjaxMsg msg = imageVideoService.queryComments(params, pageModel);
			return msg.toJson();
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
		}
		
	}
	
	/**
	 * 更新视频点击量
	 * @param id
	 * @param request
	 */
	@RequestMapping(value="/updateClickCount",method=RequestMethod.POST)
	@ResponseBody
	public String updateClickCountVideo(HttpServletRequest request){
		Map<String,Object> maps = new HashMap<String,Object>();
		String iv_id = request.getParameter("iv_id");//视频ID
		String roleType = request.getParameter("roleType");//类型：用户 ，俱乐部，足球宝贝
		String type = request.getParameter("type");// imgage video
		maps.put("iv_id", iv_id);
		maps.put("roleType", roleType);
		maps.put("type", type);
		AjaxMsg msg = imageVideoService.updateImageVideoClickCount(maps);
		maps.put("p_type", roleType);
		maps.put("user_id", getUserId());
		List<Map<String, Object>> ispraise = imageVideoService.queryPraise(maps);
		if(ispraise!=null&&ispraise.size()>0){
			for (Map<String, Object> p : ispraise) {
				if("1".equals(p.get("p_state").toString())){
					msg.addData("ispra", "1");
				}else if("2".equals(p.get("p_state").toString())){
					msg.addData("iscai", "1");
				}
			}
		}
		List<String> praises = imageVideoService.praiseCount(maps);
		Map<String, Object> praiseCount = new HashMap<String,Object>();
		praiseCount.put("praise", praises.get(0));
		praiseCount.put("cai", praises.get(1));
		msg.addData("praiseCount", praiseCount);
		return msg.toJson();
	}
	
	@RequestMapping(value="/praise")
	@ResponseBody 
	public String praise(HttpServletRequest request){
		String iv_id = request.getParameter("iv_id");
		String p_type = request.getParameter("p_type");
		String p_state = request.getParameter("p_state");
		String type = request.getParameter("type");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("user_id", getUserId());
		params.put("iv_id", iv_id);
		params.put("p_type", p_type);
		params.put("roleType", p_type);
		params.put("p_state", p_state);
		params.put("type", type);
		params.put("ip_str", request.getRemoteAddr());
		try {
			AjaxMsg msg = imageVideoService.updatePraise(params);
			return msg.toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().toJson();
		}
	}
	
	/**
	 * 载入所有评论
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="loadAllComments")
	@ResponseBody
	public String queryVideoLeagueComments(HttpServletRequest request,PageModel pageModel){
		String id = request.getParameter("id");//图片或视频id
		if(StringUtils.isNotBlank(id)){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", id);
			AjaxMsg msg = imageVideoService.queryIVsLeagueComments(params, pageModel);
			return msg.toJson();
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
		}
	}
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="test")
	@ResponseBody
	public String test(){
		try {
			/*for (int i = 0; i < 100; i++) {
				System.out.println(userService.task(i));
			}*/
			//System.out.println(userService.task2("player/picture/201511/24142750nqa1.jpg"));
			userService.task("1111");
			System.out.println("===============================");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "test";
	}
}
