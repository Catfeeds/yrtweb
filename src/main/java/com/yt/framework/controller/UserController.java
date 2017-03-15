package com.yt.framework.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.velocity.runtime.Runtime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.SecurityService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.file.UploadUtils;
import com.yt.framework.utils.gson.JSONUtils;
import com.yt.framework.utils.oss.Constant;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;

/**
 *用户操作
 *@autor bo.xie
 *@date2015-8-12下午5:16:49
 */
@RequestMapping(value="/user/")
@Controller
public class UserController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(UserController.class);

	@Autowired
	private UserService userService;
	@Autowired
	private SecurityService securityService;
	@Autowired
	private UserAmountService userAmountService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	/**
	 * 关注用户
	 *@param f_user_id 关注用户ID
	 *@param f_type 0:非俱乐部，1 俱乐部
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午5:43:15
	 */
	@RequestMapping(value="focus")
	public @ResponseBody String focusUser(HttpServletRequest request,Focus focus){
		String user_id = super.getUserId();
		if(StringUtils.isBlank(user_id)) return AjaxMsg.newError().addMessage("请先登陆系统!").toJson();
		focus.setUser_id(user_id);
		focus.setStatus(0);
		if(StringUtils.isBlank(focus.getId())){
			focus.setId(UUIDGenerator.getUUID());
		}
		AjaxMsg msg = userService.saveFocus(focus);
		return msg.toJson();
	}
	
	/**
	 * 取消关注
	 *@param user_id 用户ID
	 *@param f_user_id 被关注用户ID
	 *@param type 0:非俱乐部 1：俱乐部 默认为0
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午6:01:04
	 */
	@RequestMapping(value="cancel")
	public @ResponseBody String cancelFocusUser(HttpServletRequest request){
		String user_id = super.getUserId();
		String f_user_id = request.getParameter("f_user_id");
		int type = StringUtils.isNotBlank(request.getParameter("type"))?Integer.valueOf(request.getParameter("type")):0;
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(user_id) && StringUtils.isNotBlank(f_user_id)){
			msg = userService.deleteFocus(user_id, f_user_id,type);
		}
		return msg.toJson();
	}
	
	/**
	 * 获取当前用户关注的所有用户或俱乐部
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午5:48:56
	 */
	@RequestMapping(value="focusData")
	public @ResponseBody String focusUserDatas(HttpServletRequest request,PageModel pageModel){
		String user_id =  request.getParameter("user_id");
		String other_user_id = this.getUserId();
		AjaxMsg msg = userService.getFocusUsersByUserId(user_id, other_user_id,pageModel);
		return msg.toJson();
	}
	
	/**
	 * 获取当前用户关注的所有用户或俱乐部(页面)
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-31下午5:48:56
	 */
	@RequestMapping(value="focusDataPage")
	public String focusUserDatasPage(Model model,HttpServletRequest request,PageModel pageModel){
		String user_id =  request.getParameter("user_id");
		String other_user_id = this.getUserId();
		pageModel.setPageSize(9);
		AjaxMsg msg = userService.getFocusUsersByUserId(user_id,other_user_id,pageModel);
		model.addAttribute("follows", msg.getData("data"));
		return "center/follow/followlist";
	}
	
	@RequestMapping(value = "saveHeadImg")
	@ResponseBody
	public String saveHeadImg(HttpServletRequest request){
		
		String head_img = request.getParameter("head_img");
		String x = request.getParameter("x");
		String y = request.getParameter("y");
		String widthx = request.getParameter("width");
		String heighty = request.getParameter("height");
		try {
			if(StringUtils.isNotBlank(head_img)){
				File file = new File(fileRepository.getRealPath(head_img));
				if (file.exists()) {
					String type = ImageKit.getImageFormat(file);
					String srcPath = UploadUtils.generateYearName("headImg", type);
					srcPath = fileRepository.getRealPath(srcPath);
			        BufferedImage bufferedImage = ImageIO.read(file);
			        int width = bufferedImage.getWidth();
			        int height = bufferedImage.getHeight();

			        int rotate = 0;

			        if (rotate == -90 || rotate == -270) {
			            width = bufferedImage.getHeight();
			            height = bufferedImage.getWidth();
			        }
			        bufferedImage = ImageKit.rotateImage(rotate, bufferedImage);
			        ImageKit.abscut(bufferedImage, srcPath, type, (int) Double.parseDouble(x), (int) Double.parseDouble(y), (int) Double.parseDouble(widthx), (int) Double.parseDouble(heighty), width, height);
			        String filename = UploadUtils.generateYearName("headImg", type);
			        String newSrc = fileRepository.getRealPath(filename);
			        newSrc = ImageKit.zipImage(srcPath, type,newSrc);
			        ImageKit.delFile(fileRepository.getRealPath(head_img));
			        ImageKit.delFile(srcPath);
			        User user = userService.getEntityById(getUserId());
			        String oldImg = user.getHead_icon();
			        int result = OSSClientFactory.uploadFile(filename, new File(fileRepository.getRealPath(filename)));
			        if(result == Global.SUCCESS){
			        	ImageKit.delFile(fileRepository.getRealPath(filename));
			        }else{
			        	return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			        }
			        user.setHead_icon(filename);
			        AjaxMsg msg = userService.update(user);
			        if(msg.isSuccess()){
			        	securityService.reloadUserRole(user, request);
			        	if(!"headImg/headimg.png".equals(oldImg)&&!"headImg/headimg.jpg".equals(oldImg)){
			        		//ImageKit.delFile(fileRepository.getRealPath(oldImg));
			        		OSSClientFactory.deleteFile(oldImg);
			        	}
			        }
			        msg.addData("filename", filename);
			        return msg.toJson();
		        }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return AjaxMsg.newError().addMessage("上传的头像不存在").toJson();
	}
	
	/**
	 * 获取球员、经纪人、教练、俱乐部个数
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-14下午3:04:39
	 */
	@RequestMapping(value="getCounts")
	public @ResponseBody String getCounts(HttpServletRequest request){
		String usernick = request.getParameter("usernick");
		Map<String, Object> map = userService.userCounts(usernick);
		return AjaxMsg.newSuccess().addData("maps", map).toJson();
	}
	
	/**
	 * 我所关注用户列表页
	 * @param request
	 * @author bo.xie
	 * @return
	 */
	@RequestMapping(value="focusList/{u_id}")
	public String focusListPage(HttpServletRequest request,@PathVariable String u_id){
		request.setAttribute("u_id", u_id);
		return "center/focusList";
	}
	
	/**
	 * 我所关注用户列表数据
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="focusDatas")
	public String focusListData(Model model,HttpServletRequest request,PageModel pageModel){
		String other_user_id = this.getUserId();
		String user_id = request.getParameter("u_id");
		pageModel.setPageSize(20);
		AjaxMsg msg = userService.getFocusUsersByUserId(user_id,other_user_id,pageModel);
		model.addAttribute("rf", msg.getData("data"));
		return "center/focusDatas";
	}
	
	@RequestMapping(value="fansList/{u_id}")
	public String fansListPage(HttpServletRequest request,@PathVariable String u_id){
		request.setAttribute("u_id", u_id);
		return "center/fansList";
	}
	
	/**
	 * 我所关注用户列表数据
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="fansDatas")
	public String fansListData(Model model,HttpServletRequest request,PageModel pageModel){
		String other_user_id = this.getUserId();
		String user_id = request.getParameter("u_id");
		pageModel.setPageSize(20);
		AjaxMsg msg = userService.getUsersFansByUserId(user_id,other_user_id,pageModel);
		model.addAttribute("rf", msg.getData("data"));
		return "center/fansDatas";
	}
	
	@RequestMapping(value="/getUserAmount")
	@ResponseBody
	public String getGiftList(HttpServletRequest request, HttpSession session){
		String user_id = this.getUserId();
		if(user_id==null)return "{}";
		UserAmount uas = userAmountService.getUserAmountByUserId(user_id);
		return JSONUtils.bean2json(uas);
	}
	
	/**
	 * 用户名片信息
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="card_info")
	public String userCardInfo(Model model,HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		AjaxMsg msg = userService.getUserCardInfo(user_id,this.getUserId());
		Boolean isMe = Boolean.FALSE;//是否是当前本人
		if(msg.isSuccess()){
			if(user_id.equals(this.getUserId())){
				isMe = Boolean.TRUE;
			}
			model.addAttribute("isMe", isMe);
			model.addAttribute("reMap", msg.getData("data"));
		}
		return "card_info";
	}
	
	@RequestMapping(value="/updateShow")
	@ResponseBody
	public String updateShow(HttpServletRequest request, HttpSession session){
		String user_id = this.getUserId();
		String show = BeanUtils.nullToString(request.getParameter("show"));
		try{
			if(StringUtils.isNotBlank(user_id)){
				userAmountService.updateShow(user_id, new Integer(show));
			}
		}catch(Exception e){
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
}
