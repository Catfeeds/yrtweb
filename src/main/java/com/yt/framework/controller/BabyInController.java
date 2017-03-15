package com.yt.framework.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BabyIn;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.BabyInService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 *邀请宝贝入驻
 *@autor bo.xie
 *@date2015-9-25下午4:36:37
 */
@Controller
@RequestMapping(value="/babyIn/")
public class BabyInController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(BabyInController.class);
	
	@Autowired
	private UserService userService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private BabyInService babyInService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private PlayerInfoService playerInfoService;
	
	@RequestMapping(value="info/{baby_user_id}")
	public String infoPage(Model model,HttpServletRequest request,@PathVariable("baby_user_id")String baby_user_id){
		User login_user = super.getUser();
		//获取当前登录用户俱乐部信息
		TeamInfo info = teamInfoService.getTeamInfoByUserId(login_user.getId());
		//获取宝贝昵称，头像
		User user = userService.getEntityById(baby_user_id);
		model.addAttribute("team", info);
		model.addAttribute("user", user);
		model.addAttribute("baby_user_id", baby_user_id);
		return "baby/in_info";
	}
	
	/**
	 * 保存邀请宝贝入驻信息
	 *@param request
	 *@param babyIn
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-25下午4:56:31
	 */
	@RequestMapping(value="save")
	public @ResponseBody String saveInvite(HttpServletRequest request,BabyIn babyIn){
		BabyIn old_babyIn = babyInService.getBabyInInfo(babyIn.getUser_id(), babyIn.getTeaminfo_id(), "3");
		if(old_babyIn!=null) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.invited")).toJson();
		babyIn.setStatus(3);
		babyIn.setId(UUIDGenerator.getUUID());
		AjaxMsg msg = babyInService.save(babyIn);
		if(msg.isSuccess()){
			return msg.addMessage(messageResourceService.getMessage("system.success")).toJson();
		}else{
			return msg.addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
	}
	
	/**
	 * 宝贝是否同意入住更新状态信息
	 *@param request
	 *@param babyIn
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午4:56:31
	 */
	@RequestMapping(value="updateStatus")
	public @ResponseBody String updateStatus(HttpServletRequest request,BabyIn babyIn){
		BabyIn babyInData = babyInService.getEntityById(babyIn.getId());
		//状态：1：同意入驻,2：不同意入驻
		babyInData.setStatus(babyIn.getStatus());
		AjaxMsg msg = AjaxMsg.newError();
		try{
			msg = babyInService.updateInfo(babyInData);
		}catch(Exception e){
			return msg.addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 邀请宝贝入驻列表页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-25下午5:45:16
	 */
	@RequestMapping(value="listPage")
	public String loadrecordPage(Model model,HttpServletRequest request){
		
		return "baby/inListPage";
	}
	
	/**
	 * 邀请宝贝入驻列表数据
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-25下午5:50:08
	 */
	@RequestMapping(value="listDatas")
	public String loadDatas(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> map = Maps.newHashMap();
		String login_user_id = super.getUserId();
		map.put("user_id", login_user_id);
		AjaxMsg msg = babyInService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "baby/result_in";
	}
	
	/**
	 * 邀请宝贝已入驻列表数据
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-8下午5:50:08
	 */
	@RequestMapping(value="inListDatas")
	public String inListDatas(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> map = Maps.newHashMap();
		//String login_user_id = super.getUserId();
		String user_id = request.getParameter("user_id");
		map.put("user_id", user_id);
		map.put("status",new Integer(1));
		AjaxMsg msg = babyInService.queryBabyTeamForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "baby/result_inlist";
	}
	
	/**
	 * 邀请宝贝已入驻列表数据
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午5:50:08
	 */
	@RequestMapping(value="toInListDatas/{user_id}")
	public String toInListDatas(HttpServletRequest request,@PathVariable("user_id") String user_id){
		request.setAttribute("user_id", user_id);
		return "baby/babyInList";
	}
	
	/**
	 * 宝贝是否同意俱乐部入驻邀请
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-25下午6:52:18
	 *//*
	@RequestMapping(value="isAgree")
	public @ResponseBody String isAgree(HttpServletRequest request){
		//状态：1：同意入驻,2：不同意入驻
		String status = request.getParameter("status");
		String id =request.getParameter("id");
		if(StringUtils.isBlank(status) || StringUtils.isBlank(id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		BabyIn babyIn = babyInService.getEntityById(id);
		babyIn.setStatus(Integer.valueOf(status));
		babyInService.updateInfo(babyIn);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}*/
	
	/**
	 * 宝贝退出俱乐部入住
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-8下午6:52:18
	 */
	@RequestMapping(value="quitTeamIn")
	public @ResponseBody String quitTeamIn(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String login_user_id = super.getUserId();
		//状态：1：同意入驻,2：不同意入驻
		String id = request.getParameter("id");
		if(StringUtils.isBlank(id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		try{
			msg = babyInService.quitTeamIn(login_user_id,id);
		}catch(Exception e){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
		}
		return msg.toJson();
	}
	
	/**
	 * 俱乐部宝贝
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-06上午11:37:11
	 */
	@RequestMapping(value="teamBabys")
	public String teamBabys(Model model,HttpServletRequest request,PageModel pageModel){
		String teaminfo_id = request.getParameter("teaminfo_id");
		String status = request.getParameter("status");
		String user_id = request.getParameter("user_id");//俱乐部队长id
		if(StringUtils.isBlank(teaminfo_id)) return "error/404";
		Map<String,Object> map = Maps.newHashMap();
		map.put("teaminfo_id", teaminfo_id);
		map.put("status",status);
		AjaxMsg msg = babyInService.queryBabyTeamForMap(map, pageModel);
		model.addAttribute("rf", msg.getData("page"));
		model.addAttribute("user_id", user_id);
		return "team/baby/teambaby";
	}
	
	
	/**
	 * 踢出俱乐部入住宝贝
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-06上午11:37:11
	 */
	@RequestMapping(value="kickBabyIn")
	@ResponseBody
	public String kickBabyIn(Model model,HttpServletRequest request,PageModel pageModel){
		String login_user_id = super.getUserId();
		String id = request.getParameter("id");
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = babyInService.kickTeamIn(login_user_id, id);
		}catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 代言校验
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="validRule")
	@ResponseBody
	public String validRule(HttpServletRequest request,PageModel pageModel){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String session_login_id = this.getUserId();
		//用户邀请宝贝代言时分三个层级判定用户：1、是否是球员；2、是否是俱乐部管理员
		if(StringUtils.isBlank(session_login_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		PlayerInfo playerInfo = playerInfoService.getPlayerInfoByUserId(session_login_id);
		if(null == playerInfo || null == playerInfo.getId()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.noplayer")).toJson();
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(session_login_id);
		if(null == teamInfo || null == teamInfo.getId()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.noteam")).toJson();
		return msg.addMessage("system.success").toJson();
	}
}
