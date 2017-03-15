package com.yt.framework.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.ImageVideoTeam;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.ImageVideoTeamService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.file.FileRepository;

/**
 * 
 * 俱乐部图片和视频
 * @autor gl
 * @date2015-9-8下午5:40:05
 */
@Controller
@RequestMapping(value = "/imageVideoTeam")
public class ImageVideoTeamController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(ImageVideoTeamController.class);

	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	@Autowired
	private TeamInfoService teamInfoService;
	
	@Autowired
	private ImageVideoTeamService imageVideoTeamService;
	
	/**
	 * 俱乐部图片
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/images")
	@ResponseBody  
	public String playerImgs(HttpServletRequest request,PageModel pageModel){
		String team_id = request.getParameter("team_id");
		String type = request.getParameter("type");
		String uid = getUserId();
		int isme = 0;
		AjaxMsg msg = AjaxMsg.newError();
		try {
			if(StringUtils.isNotBlank(team_id)){
				TeamInfo team = teamInfoService.getEntityById(team_id);
				if(team!=null){
					if(StringUtils.isNotBlank(team.getUser_id())&&uid!=null&&(uid.equals(team.getUser_id()))){
						isme = 1;
					}
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("team_id", team_id);
					params.put("type", type);
					msg = imageVideoTeamService.searchImageVideos(params, pageModel);
				}
			}
			msg.addData("isme", isme);
			return msg.toJson();
		} catch (Exception e) {
			msg.addData("isme", isme);
			return msg.toJson();
		}
	}
	
	/**
	 * 进入俱乐部相册
	 * @param request
	 * @return photo.html
	 */
	@RequestMapping(value="/photo")
	public String photo(HttpServletRequest request){
		String team_id = request.getParameter("team_id");
		try {
			TeamInfo team = teamInfoService.getEntityById(team_id);
			if(team!=null){
				request.setAttribute("team_id", team_id);
				return "team/team_photo";
			}
			return "";
		} catch (Exception e) {
			return "";
		}
	}
	
	/**
	 * 进入球员视频
	 * @param request
	 * @return photo.html
	 */
	@RequestMapping(value="/video")
	public String videos(HttpServletRequest request){
		String team_id = request.getParameter("team_id");
		try {
			TeamInfo team = teamInfoService.getEntityById(team_id);
			if(team!=null){
				String user_img = "headImg/headimg.png";
				if(getUser()!=null){
					user_img = getUser().getHead_icon();
				}
				request.setAttribute("user_img", user_img);
				request.setAttribute("team_id", team_id);
				return "team/team_videos";
			}
			return "";
		} catch (Exception e) {
			return "";
		}
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
	public String saveImgOrVideos(HttpServletRequest request,ImageVideoTeam imageVideo,String images){
		imageVideo.setIf_show(2);
		imageVideo.setStatus(1);
		AjaxMsg msg = imageVideoTeamService.saveImgOrVideos(imageVideo,images);
		return msg.toJson();
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
		AjaxMsg msg = imageVideoTeamService.deleteFile(id,type);
		return msg.toJson();
	}
	
	
	/**
	 * 查询俱乐部拥有的栏位,剩余栏位
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/restCount")
	@ResponseBody  
	public String restCount(HttpServletRequest request){
		String team_id = request.getParameter("team_id");
		String type = request.getParameter("type");
		AjaxMsg msg = imageVideoTeamService.teamRestCount(team_id,type);
		return msg.toJson();
	}
	
	/**
	 * 在俱乐部中展示
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/showCenter")
	@ResponseBody  
	public String showCenter(HttpServletRequest request){
		String team_id = request.getParameter("team_id");
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		String state = request.getParameter("state");
		AjaxMsg msg = imageVideoTeamService.updateShowCenter(team_id,id,type,state);
		return msg.toJson();
	}
}
