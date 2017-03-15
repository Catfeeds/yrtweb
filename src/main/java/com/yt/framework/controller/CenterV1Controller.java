package com.yt.framework.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.GiftVO;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.PageCount;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.SuspendPlayer;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserComment;
import com.yt.framework.persistent.entity.UserRole;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.Visitor;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.persistent.enums.VisitorEnum.VISTORTYPE;
import com.yt.framework.service.BabyService;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.CommonService;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.MessageService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.VisitorService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 个人中心
 * @author GL
 * @date 2015年8月3日 下午2:13:35 
 */
@Controller
@RequestMapping(value="/center")
public class CenterV1Controller extends BaseController{
	
	private static Logger logger = LogManager.getLogger(CenterV1Controller.class);
	
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private ImageVideoService imageVideoService;
	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private DynamicService dynamicService;
	@Autowired
	private BabyService babyService;
	@Autowired
	private CommonService commonService;
	@Autowired
	private VisitorService visitorService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private LeagueMarketService leagueMarketService;
	@Autowired
	private CertificaService certificaService;
	
	@RequestMapping("")
	public String center(HttpServletRequest request){
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		User user = new User();
		user = userService.getEntityById(getUserId());
		request.setAttribute("player", user);
		request.setAttribute("oth_user_id", getUserId());
		request.setAttribute("user_img", user_img);
		request.setAttribute("focus", false); //显示关注
		request.setAttribute("isme", 1);
		return "centerv1/center";
	}
	@RequestMapping("/{user_id}")
	public String center(HttpServletRequest request,@PathVariable String user_id){
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		String session_user_id = this.getUserId();
		if(null != session_user_id && null != user_id ){
			if(!session_user_id.equals(user_id)){
				Visitor visitor = visitorService.getVisitor(session_user_id, user_id,"0");
				if(visitor == null){
					visitor = new Visitor();
					visitor.setId(UUIDGenerator.getUUID());
					visitor.setP_visitor_id(user_id);
					visitor.setVisitor_id(session_user_id);
					visitor.setVisit_url(VISTORTYPE.CENTER.toString());
					visitor.setVisit_type("0");
					visitor.setT_visit_count(1);
					visitor.setVisit_count(1);
					visitorService.save(visitor);
				}else{
					visitor.setT_visit_count(visitor.getT_visit_count()+1);
					visitor.setVisit_count(visitor.getVisit_count()+1);
					visitorService.update(visitor);
				}
			}
		}
		if(null == session_user_id){
			request.setAttribute("focus", false); //显示关注
		}else{
			int count = userService.isOnFocusById(session_user_id, user_id);
			if(count>0){
				request.setAttribute("focus", true); //显示取消关注
			}else{
				request.setAttribute("focus", false); //显示关注
			}
		}
		
		
		User user = userService.getEntityById(user_id);
		request.setAttribute("player", user);
		request.setAttribute("oth_user_id", user_id);
		request.setAttribute("user_img", user_img);
		request.setAttribute("isme", isme(user_id));
		return "centerv1/center";
	}
	
	/**
	 * 个人中心 用户基本信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/userInfo")
	public String userInfo(Model model,HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		String uid = super.getUserId();
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		if(StringUtils.isNotBlank(uid)){
			msg = userService.getUserById(uid,getUserId());
		}
		if(msg.isSuccess()){
			Map<String,Object> params = Maps.newHashMap();
			Map<String,Object> userMap = (Map<String,Object>)msg.getData("user");
			model.addAttribute("userinfo", msg.getData("user"));
			params.put("id", userMap.get("id"));
			AjaxMsg re_msg = dynamicService.queryNewDynamic(params, new PageModel());
			model.addAttribute("dynCount", re_msg.getData("dynCount"));
			List<GiftVO> ls = babyService.getReceiveGiftList(String.valueOf(userMap.get("id")));
			model.addAttribute("gifts", ls);
			AjaxMsg markMsg = leagueMarketService.ifOpenMarket(null);
			if(markMsg.isSuccess()){
				//查看该人员是否在转会市场
				LeagueMarket market = playerInfoService.getPlayerInLeagueMarket(uid);
				request.setAttribute("market",market);
			}
		}
		SuspendPlayer sp = playerInfoService.getSuspendPlayerByUserId(uid);
		PlayerInfo player = playerInfoService.getPlayerInfoByUserId(uid);
		if(null != player){
			request.setAttribute("level", player.getLevel());
		}
		request.setAttribute("sp", sp);
		request.setAttribute("isme", isme(oth_user_id));
		return "centerv1/center_user";
	}
	
	/**
	 * 编辑用户信息
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="editUser")
	public String editUserInfo(Model model,HttpServletRequest request){
		String uid = super.getUserId();
		User user = userService.getEntityById(uid);
		model.addAttribute("user", user);
		return "centerv1/center_edit_user";
	}
	
	/**
	 * 个人中心 用户印象
	 * @param request
	 * @return
	 */
	@RequestMapping("/userEffect")
	public String userEffect(HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		AjaxMsg msg = playerInfoService.queryPlayerTag(user_id);
		request.setAttribute("tags", msg.getData("page"));
		request.setAttribute("user_id", user_id);
		return "centerv1/center_effect";
	}
	
	/**
	 * 个人中心 用户印象
	 * @param request
	 * @return
	 */
	@RequestMapping("/queryEffectDetail")
	public String queryEffectDetail(HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		AjaxMsg msg = playerInfoService.queryPlayerTag(user_id);
		request.setAttribute("tags", msg.getData("page"));
		request.setAttribute("user_id", user_id);
		return "centerv1/center_effect_detail";
	}
	
	/**
	 * 个人中心 用户图片和视频
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping("/imagesOrVideos")
	public String imagesOrVideos(HttpServletRequest request,PageModel pageModel){
		String oth_user_id = request.getParameter("oth_user_id");
		String type = request.getParameter("type");
		String uid = getUserId();
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("user_id", uid);
		AjaxMsg msg = imageVideoService.queryViews(params, pageModel);
		request.setAttribute("views", msg.getData("page"));
		request.setAttribute("isme", isme(oth_user_id));
		request.setAttribute("type", type);
		//added by bo.xie 2015年12月18日14:33:31 start
		User c_user = userService.getEntityById(oth_user_id);
		request.setAttribute("c_user", c_user);
		//added by bo.xie 2015年12月18日14:33:31 end
		
		return "centerv1/center_image_video";
	}
	
	@RequestMapping("/playerInfo")
	public String playerInfo(HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		request.setAttribute("isme", isme(oth_user_id));
		return "centerv1/center_player";
	}
	
	/**
	 * 个人中心 评论
	 * @param request
	 * @return
	 */
	@RequestMapping("/comments")
	public String comments(HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		request.setAttribute("oth_user_id", oth_user_id);
		request.setAttribute("isme", isme(oth_user_id));
		return "centerv1/center_comment";
	}
	
	@RequestMapping("/queryComments")
	@ResponseBody
	public String queryComments(HttpServletRequest request,PageModel pageModel){
		String oth_user_id = request.getParameter("oth_user_id");
		String createTime = request.getParameter("createTime");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("s_user_id", oth_user_id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(StringUtils.isNotBlank(createTime)){
			try {
				sdf.parse(createTime);
				params.put("createTime", createTime);
			} catch (ParseException e) {
				return AjaxMsg.newError().toJson();
			}
		}else{
			createTime = sdf.format(new Date());
		}
		params.put("me_id", getUserId());
		AjaxMsg msg = commonService.queryUserComments(params, pageModel);
		params.put("createTime", createTime);
		return msg.addData("createTime", createTime).toJson();
	}
	@RequestMapping("/queryCommentChilds")
	@ResponseBody
	public String queryCommentChilds(HttpServletRequest request,PageModel pageModel){
		String parent_id = request.getParameter("parent_id");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("parent_id", parent_id);
		params.put("me_id", getUserId());
		AjaxMsg msg = commonService.queryUserCommentChilds(params, pageModel);
		return msg.toJson();
	}
	@RequestMapping("/saveUserComment")
	@ResponseBody
	public String saveUserComment(HttpServletRequest request,UserComment comment){
		String type = request.getParameter("type");
		comment.setUser_id(getUserId());
		try {
			AjaxMsg msg = commonService.saveUserComment(comment,type);
			return msg.toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage("回复失败").toJson();
		}
	}
	@RequestMapping("/deleteUserComment")
	@ResponseBody
	public String deleteUserComment(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = commonService.deleteUserComment(id);
		return msg.toJson();
	}
	
	/**
	 * 用户处理系统消息(同意或拒绝邀请)
	 * @param request
	 * @param msg
	 * @param submit
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/systemMsg")
	@ResponseBody
	public String systemMsg(HttpServletRequest request,Message msg,String submit){
		//add by ylt 2015-09-02  
		Message msg_t = messageService.getEntityById(msg.getId());
		if(null == msg_t.getId()) return AjaxMsg.newError().addMessage("消息不存在！").toJson(); 
		AjaxMsg ajaxMsg = AjaxMsg.newError();
		try {
			ajaxMsg = messageService.modifySystemMsg(msg_t,submit);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ajaxMsg.toJson();
	}
	
	@RequestMapping(value="/checkUserRole")
	@ResponseBody
	public String checkUserRole(){
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 更改头像
	 * @return String
	 */
	@RequestMapping(value="/changeHeadImg")
	public String changeHeadImg(){
		return "center/head_img";
	}
	
	/**
	 * 激活球员时检测是否是宝贝
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/hasBaby")
	@ResponseBody
	public String hasBaby(HttpServletRequest request){
		String userId = getUserId();
		BabyInfo baby = babyService.getBabyInfoByUserId(userId);
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(baby!=null){
			msg = AjaxMsg.newError();
		}
		return msg.toJson();
	}
	
	/**
	 * 保存页面访问量
	 * @param request
	 */
	@RequestMapping(value="updateCount")
	public @ResponseBody String savePageCount(HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		String code_str = request.getParameter("code_str");
		PageCount pageCount = new PageCount();
		pageCount.setUser_id(user_id);
		pageCount.setCode_str(code_str);
		AjaxMsg msg = commonService.savePageCount(pageCount);
		return msg.toJson();
	}
	
	/**
	 * 邀请用户上传短信通知
	 * @param request
	 * @return
	 */
	@RequestMapping(value="inviteUpload")
	public @ResponseBody String inviteUpload(HttpServletRequest request){
		String type = request.getParameter("type");
		String user_id = request.getParameter("user_id");
		User user = super.getUser();
		String f_usernick = user.getUsernick();//发起邀请用户昵称
		String f_user_id = user.getId();//发起邀请用户ID
		Map<String,Object> params = Maps.newHashMap();
		params.put("type", type);
		params.put("user_id", user_id);
		params.put("f_usernick", f_usernick);
		params.put("f_user_id", f_user_id);
		AjaxMsg msg = userService.inviteUploadSMS(params);
		return msg.toJson();
	}
	
	/**
	 * 宇任拓-我的宇币
	 * @return
	 */
	@RequestMapping(value="/currency")
	public String currency(){
		return "center/currency";
	}
	
	/**
	 * 检测用户是否实名认证
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/checkCertTrue")
	@ResponseBody
	public String checkCertTrue(HttpServletRequest request){
		
		//检查是否激活球员
		PlayerInfo playerInfo = playerInfoService.getPlayerInfoByUserId(getUserId());
		if(playerInfo==null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noplayer")).toJson();
		}
		Certification certification =  certificaService.getCertificationByUserId(getUserId(), "idcard");
		if(certification == null || certification.getStatus()!= 1){
			return AjaxMsg.newError().toJson();
		}
		return AjaxMsg.newSuccess().toJson();
	}
}
