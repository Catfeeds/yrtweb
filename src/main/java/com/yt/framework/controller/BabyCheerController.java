package com.yt.framework.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BabyCheer;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.BabyCheerService;
import com.yt.framework.service.BabyInService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 宝贝助威
 *@autor ylt
 *@date2015-9-25下午6:17:38
 */
@Controller
@RequestMapping(value="/babyCheer/")
public class BabyCheerController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(BabyCheerController.class);
	
	@Autowired
	private BabyCheerService babyCheerService;
	@Autowired
	private UserService userService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private TeamInviteService teamInviteService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private BabyInService babyInService;
	@Autowired
	private PlayerInfoService playerInfoService;
	

	/**
	 * 跳转弹出邀请助威信息填写页面
	 *@param babyCheer
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="babyCheer")
	public String babyCheer(Model model,HttpServletRequest request){
		String user_id =  request.getParameter("user_id");
		String caption = this.getUserId();
		//判断是否队长
		TeamInfo t = teamInfoService.getTeamInfoByUserId(caption);
		if(null == t) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.noteam")).toJson();
		//获取宝贝信息
		User baby = userService.getEntityById(user_id);
		//获取球队是否有比赛
		List<TeamGame> games = teamInviteService.loadTeamGameByTeamId(t.getId());
		if(games.isEmpty()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nogame")).toJson();
		request.setAttribute("babyInfo", baby);
		model.addAttribute("games", games);
		model.addAttribute("team_id", t.getId());
		return AjaxMsg.newSuccess().addMessage("").toJson();
	}
	
	/**
	 * 宝贝助威页面跳转
	 *@param babyCheer
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="openGameBaby")
	public String openGameBaby(Model model,HttpServletRequest request,PageModel pageModel){
		String teamgame_id = request.getParameter("teamgame_id");
		String teaminfo_id = request.getParameter("teaminfo_id");
		String status = request.getParameter("status");
		if(StringUtils.isBlank(teaminfo_id)) return "error/404";
		Map<String,Object> map = Maps.newHashMap();
		map.put("teaminfo_id", teaminfo_id);
		map.put("status",status);
		AjaxMsg msg = babyInService.queryBabyTeamForMap(map, pageModel);
		model.addAttribute("rf", msg.getData("page"));
		model.addAttribute("teamgame_id", teamgame_id);
		model.addAttribute("teaminfo_id", teaminfo_id);
		return "team/baby/cheerbaby";
	}
	
	/**
	 * 批量保存助威邀请页面
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="saveCheerBatch")
	@ResponseBody
	public String saveCheerBatch(HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		String teamgame_id = request.getParameter("teamgame_id");
		String contact_person = request.getParameter("contact_person");
		String contact_phone = request.getParameter("contact_phone");
		String remark = request.getParameter("remark");
		String baby_ids = request.getParameter("baby_ids");
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(teamgame_id)	||StringUtils.isBlank(baby_ids)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.errcode")).toJson();
		}
		String[] user_ids = baby_ids.split(",");
		AjaxMsg msg = AjaxMsg.newSuccess();
		//added by bo.xie 一个俱乐部只能邀请3个宝贝助威start
		int babyCount = babyCheerService.babyCheerCount(teaminfo_id,teamgame_id);
		if(babyCount>2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.cheerGameCount")).toJson();
		if((babyCount+user_ids.length)>3) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.cheerGameCount")).toJson();
		//added by bo.xie 一个俱乐部只能邀请3个宝贝助威end
		TeamInfo teamInfo = teamInfoService.getEntityById(teaminfo_id);
		TeamGame teamGame = teamInviteService.loadTeamGameById(teamgame_id);
		List<BabyCheer> listCheer = Lists.newArrayList();
		for(int i=0;i<user_ids.length;i++){
			BabyCheer babyCheer = new BabyCheer();
			babyCheer.setId(UUIDGenerator.getUUID());
			babyCheer.setTeamgame_id(teamgame_id);
			babyCheer.setCheer_time(teamGame.getGame_time());
			babyCheer.setCheer_address(teamGame.getPosition());
			babyCheer.setTeaminfo_id(teaminfo_id);
			babyCheer.setContact_person(contact_person);
			babyCheer.setContact_phone(contact_phone);
			babyCheer.setRemark(remark);
			babyCheer.setTeam_name(teamInfo.getName());
			babyCheer.setLogo(teamInfo.getLogo());
			babyCheer.setUser_id(user_ids[i]);
			listCheer.add(babyCheer);
		}
		try {
			msg = babyCheerService.saveCheerBatch(listCheer);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.cheered")).toJson();
		}
		if(msg.isSuccess()){
			msg.addMessage(messageResourceService.getMessage("system.success"));
		}else{
			msg.addMessage(messageResourceService.getMessage("system.error"));
		}
		return msg.toJson();
	}
	
	/**
	 * 保存助威邀请页面
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="saveCheer")
	@ResponseBody
	public String saveCheer(HttpServletRequest request,BabyCheer babyCheer){
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isBlank(babyCheer.getId())){
			//added by bo.xie 一个俱乐部只能邀请3个宝贝助威start
			int babyCount = babyCheerService.babyCheerCount(babyCheer.getTeaminfo_id(), babyCheer.getTeamgame_id());
			if(babyCount>2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.cheerGameCount")).toJson();
			Map<String,Object> map = Maps.newHashMap();
			map.put("temagame_id", babyCheer.getTeamgame_id());
			map.put("teaminfo_id", babyCheer.getTeaminfo_id());
			map.put("user_id", babyCheer.getUser_id());
			map.put("status", "0");
			int i = babyCheerService.count(map);
			if(i>0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.cheered")).toJson();
			//added by bo.xie 一个俱乐部只能邀请3个宝贝助威end
			babyCheer.setId(UUIDGenerator.getUUID());
			msg = babyCheerService.save(babyCheer);	
		}else{
			BabyCheer babyCheerData = babyCheerService.getEntityById(babyCheer.getId());
			babyCheerData.setStatus(babyCheer.getStatus());
			msg = babyCheerService.update(babyCheerData);	
		}
		if(msg.isSuccess()){
			msg.addMessage(messageResourceService.getMessage("system.success"));
		}else{
			msg.addMessage(messageResourceService.getMessage("system.error"));
		}
		return msg.toJson();
	}
	
	
	
	/**
	 * 更新状态信息
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="updateStatus")
	@ResponseBody
	public String updateStatus(HttpServletRequest request,BabyCheer babyCheer){
		BabyCheer babyCheerData = babyCheerService.getEntityById(babyCheer.getId());
		
		AjaxMsg msg = AjaxMsg.newSuccess();
		//判断俱乐部是否存在
		if(babyCheer.getStatus() != 2){
			TeamInfo teamInfo =  teamInfoService.getEntityById(babyCheerData.getTeaminfo_id());
			if(null == teamInfo || null == teamInfo.getId()){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.noteam")).toJson();
			}else if(teamInfo.getIs_exist() == 0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.noteam")).toJson();
			}
			//判断本场比赛宝贝是否大于2人
			int babyCount = babyCheerService.babyCheerCount(babyCheerData.getTeaminfo_id(), babyCheerData.getTeamgame_id());
			if(babyCount>2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.cheerGameCount")).toJson();
			//判断比赛是否已经结束
			TeamGame teamGame = teamInviteService.loadTeamGameById(babyCheerData.getTeamgame_id());
			if(null == teamGame || null == teamGame.getId()){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.noteam")).toJson();
			}else if(teamGame.getStatus() != 0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.gameover")).toJson();
			}
		}
		babyCheerData.setStatus(babyCheer.getStatus());
		msg = babyCheerService.update(babyCheerData);	
		if(msg.isSuccess()){
			msg.addMessage(messageResourceService.getMessage("system.success"));
		}else{
			msg.addMessage(messageResourceService.getMessage("system.error"));
		}
		return msg.toJson();
	}
	
	/**
	 * 助威邀请搜索列表
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="searchCheer")
	@ResponseBody
	public String searchCheer(HttpServletRequest request,PageModel pageModel){
		String team_name = request.getParameter("team_name");
		String status = request.getParameter("status");
		Map<String,Object> map = Maps.newHashMap();
		map.put("team_name", team_name);
		map.put("status",status);
		AjaxMsg msg = babyCheerService.queryForPage(map, pageModel);
		request.setAttribute("babyCheers", msg.getData("page"));
		return msg.toJson();
	}
	
	/**
	 * 同意或者拒绝助威邀请
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="checkCheer")
	@ResponseBody
	public String checkCheer(HttpServletRequest request){
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		BabyCheer babyCheer = babyCheerService.getEntityById(id);
		int babyCount = babyCheerService.babyCheerCount(babyCheer.getTeaminfo_id(), babyCheer.getTeamgame_id());
		if(babyCount>2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.cheerGameCount")).toJson();
		if(babyCheer == null) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.baby.nocheer")).toJson();
		babyCheer.setStatus(new Integer(status));
		AjaxMsg msg = babyCheerService.update(babyCheer);
		if(msg.isSuccess()){
			msg.addMessage(messageResourceService.getMessage("system.success"));
		}else{
			msg.addMessage(messageResourceService.getMessage("system.error"));
		}
		request.setAttribute("babyCheers", msg.getData("page"));
		return msg.toJson();
	}
	
	/**
	 * 通过比赛获取宝贝信息
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="getBabyByGame")
	@ResponseBody
	public String getBabyByGame(HttpServletRequest request){
		String game_id = request.getParameter("game_id");
		if(StringUtils.isBlank(game_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nogame")).toJson();
		AjaxMsg msg = babyCheerService.getByBabyByGame(game_id,"");
		request.setAttribute("babys", msg.getData("babys"));
		return msg.toJson();
	}
	
	/**
	 * 助威邀请列表
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-25下午6:17:38
	 */
	@RequestMapping(value="listDatas")
	public String cheerList(HttpServletRequest request,PageModel pageModel){
		String login_user_id = super.getUserId();
		Map<String,Object> map = Maps.newHashMap();
		map.put("user_id", login_user_id);
		AjaxMsg msg = babyCheerService.queryForPage(map, pageModel);
		if(msg.isSuccess()){
			request.setAttribute("rf", msg.getData("page"));
		}
		return "baby/result_cheer";
	}
	
	
	/**
	 * 助威校验
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
		//用户邀请宝贝助威时分三个层级判定用户：1、是否是球员；2、是否是俱乐部管理员；3、是否是有比赛。
		if(StringUtils.isBlank(session_login_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		PlayerInfo playerInfo = playerInfoService.getPlayerInfoByUserId(session_login_id);
		if(null == playerInfo || null == playerInfo.getId() ) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.noplayer")).toJson();
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(session_login_id);
		if(null == teamInfo || null == teamInfo.getId() ){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.noteam")).toJson();
		}else{
			List<TeamGame> listGame = teamInviteService.loadTeamGameByTeamId(teamInfo.getId());
			if(null == listGame || listGame.isEmpty()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.nogame")).toJson();
		}
		return msg.addMessage("system.success").toJson();
	}
}
