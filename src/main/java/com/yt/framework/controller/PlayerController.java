package com.yt.framework.controller;

import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.PlayerCareer;
import com.yt.framework.persistent.entity.PlayerHobby;
import com.yt.framework.persistent.entity.PlayerHonor;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.PlayerOther;
import com.yt.framework.persistent.entity.PlayerTag;
import com.yt.framework.persistent.entity.PlayerTerm;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.Trial;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserRole;
import com.yt.framework.persistent.enums.SmsEnum;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.persistent.enums.SystemEnum.SYSTYPE;
import com.yt.framework.service.AgentInfoService;
import com.yt.framework.service.BaseService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerCareerService;
import com.yt.framework.service.PlayerHobbyService;
import com.yt.framework.service.PlayerHonorService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.PlayerOtherService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ParamMap;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 * @Title: PlayerController.java 
 * @Package com.yt.framework.controller
 * @author GL
 * @date 2015年8月5日 上午11:16:57 
 */
@Controller
@RequestMapping(value="/player")
public class PlayerController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(PlayerController.class);
	
	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private PlayerHobbyService playerHobbyService;
	@Autowired
	private PlayerCareerService playerCareerService;
	@Autowired
	private PlayerHonorService playerHonorService;
	@Autowired
	private PlayerOtherService playerOtherService;
	@Autowired
	private ImageVideoService imageVideoService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private AgentInfoService agentInfoService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private UserService userService;
	
	
	/**
	 * 进入球员信息页
	 * @return player
	 */
	@RequestMapping(value="")
	public String player(){
		return "center/player";
	}
	
	/**
	 * 检测用户是否球员
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/hasPlayer")
	@ResponseBody
	public String hasPlayer(HttpServletRequest request){
		String ouid = request.getParameter("othUserId");
		String userId = getUserId();
		int isme = 0;
		if(StringUtils.isNotBlank(userId)&&userId.equals(ouid)){
			isme = 1;
		}
		if(StringUtils.isNotBlank(ouid)){
			userId = ouid;
		}
		AjaxMsg msg = playerInfoService.queryHasPlayer(userId);
		msg.addData("isme", isme);
		return msg.toJson();
	}
	
	@RequestMapping(value="/secPlayer")
	@ResponseBody
	public String secPlayer(){
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 根据type 查询球员信息
	 * @param request
	 * @param type 
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/info")
	@ResponseBody
	public String info(HttpServletRequest request,String oth_user_id,String type){
		String uid = getUserId();
		int isme = 0;
		if(StringUtils.isNotBlank(uid)&&uid.equals(oth_user_id)){
			isme = 1;
		}
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		AjaxMsg msg = AjaxMsg.newError();
		if("info".equals(type)||"ability".equals(type)){
			msg = playerInfoService.getPlayerInfoByUserId(uid,true);
			if(StringUtils.isNotBlank(uid)){
				Map<String, Object> params = new HashMap<String,Object>();
				params.put("user_id", getUserId());
				params.put("p_user_id", oth_user_id);
				List<Map<String, Object>> ispraise = playerInfoService.queryPraise(params);
				if(ispraise!=null&&ispraise.size()>0){
					for (Map<String, Object> p : ispraise) {
						if("1".equals(p.get("p_state").toString())){
							msg.addData("ispra", "1");
						}else if("2".equals(p.get("p_state").toString())){
							msg.addData("iscai", "1");
						}
					}
				}
			}
//			msg = playerInfoService.getByUserId(getUserId());
		}else if("hobby".equals(type)){
			msg = playerHobbyService.getByUserId(uid);
		}else if("career".equals(type)){
			msg = playerCareerService.queryByUserId(uid);
		}else if("honor".equals(type)){
			msg = playerHonorService.queryByUserId(uid);
		}else if("other".equals(type)){
			msg = playerOtherService.getByUserId(uid);
		}
		msg.addData("isme", isme);
		return msg.toJson();
	}
	
	/**
	 * 编辑球员信息
	 * @param request
	 * @return player-info
	 */
	@RequestMapping(value="/editPlayer")
	public String editPlayer(HttpServletRequest request,String type){
		String userId = getUserId();
		if("info".equals(type)){
			AjaxMsg msg = playerInfoService.getPlayerInfoByUserId(getUserId(),false);
			request.setAttribute("info", msg.getData("data")); 
			request.setAttribute("paramMap", ParamMap.getMap());
		}else if("hobby".equals(type)){
			PlayerHobby hobby = (PlayerHobby) (getPlayer(userId,playerHobbyService)!=null?getPlayer(userId,playerHobbyService):null);
			if(hobby==null) hobby = new PlayerHobby();
			hobby.setUser_id(userId);
			request.setAttribute("hobby", hobby);
		}else if("career".equals(type)){
			PlayerCareer career = (PlayerCareer) (getPlayer(userId,playerCareerService)!=null?getPlayer(userId,playerCareerService):null);
			if(career==null) career = new PlayerCareer();
			career.setUser_id(userId);
			request.setAttribute("career", career);
		}else if("honor".equals(type)){
			PlayerHonor honor = (PlayerHonor) (getPlayer(userId,playerHonorService)!=null?getPlayer(userId,playerHonorService):null);
			if(honor==null) honor = new PlayerHonor();
			honor.setUser_id(userId);
			request.setAttribute("honor", honor);
		}else if("other".equals(type)){
			PlayerOther other = (PlayerOther) (getPlayer(userId,playerOtherService)!=null?getPlayer(userId,playerOtherService):null);
			if(other==null) other = new PlayerOther();
			other.setUser_id(userId);
			request.setAttribute("other", other);
		}
		return "center/player-"+type.toLowerCase();
	}
	@RequestMapping(value="/updatePlayer")
	public String edit_player(HttpServletRequest request,String type){
		if("info".equals(type)){
			AjaxMsg msg = playerInfoService.getPlayerInfoByUserId(getUserId(),false);
			request.setAttribute("info", msg.getData("data")); 
			request.setAttribute("paramMap", ParamMap.getMap());
		}
		String oth_user_id = request.getParameter("oth_user_id");
		User c_user = userService.getEntityById(oth_user_id);
		request.setAttribute("c_user",c_user);
		request.setAttribute("nowYear", new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()));
		return "centerv1/center_player_"+type.toLowerCase();
	}
	
	@SuppressWarnings("rawtypes")
	private Object getPlayer(String userId,BaseService service){
		AjaxMsg msg = service.getByUserId(userId);
		Object obj = null;
		if(msg.isSuccess()){
			obj = msg.getData("data");
		}
		return obj;
	}
	
	@RequestMapping(value="/getPlayer")
	@ResponseBody
	public String getPlayer(HttpServletRequest request){
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		AjaxMsg msg = AjaxMsg.newError();
		if("career".equals(type)){
			PlayerCareer career = playerCareerService.getEntityById(id);
			if(career!=null){
				msg = AjaxMsg.newSuccess().addData("data", career);
			}
		}else if("hobby".equals(type)){
			PlayerHobby hobby = playerHobbyService.getEntityById(id);
			if(hobby!=null){
				msg = AjaxMsg.newSuccess().addData("data", hobby);
			}
		}else if("honor".equals(type)){
			PlayerHonor honor = playerHonorService.getEntityById(id);
			if(honor!=null){
				msg = AjaxMsg.newSuccess().addData("data", honor);
			}
		}else if("other".equals(type)){
			PlayerOther other = playerOtherService.getEntityById(id);
			if(other!=null){
				msg = AjaxMsg.newSuccess().addData("data", other);
			}
		}
		return msg.toJson();
	}
	
	/**
	 * 添加或修改球员主要信息
	 * @param request
	 * @param playerInfo
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/saveOrUpdateInfo")
	@ResponseBody
	public String saveOrUpdateInfo(HttpServletRequest request,PlayerInfo playerInfo,@RequestParam("p_position[]")String[] p_position){
		try {
			AjaxMsg msg = AjaxMsg.newError();
			playerInfo.setUser_id(getUserId());
			playerInfo.setPosition(parsePosition(p_position));
			if(playerInfo!=null&&StringUtils.isNotBlank(playerInfo.getId())){
				msg = playerInfoService.updatePlayerInfo(playerInfo);
			}else{
				msg = playerInfoService.savePlayerInfo(playerInfo,request);
			}
			return msg.toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().toJson();
		}
	}
	private String parsePosition(String[] p_position) {
		String positions = "";
		if(p_position!=null&&p_position.length>0){
			for (String position : p_position) {
				positions+=position+",";
			}
			positions = positions.substring(0,positions.lastIndexOf(","));
		}
		return positions;
	}

	/**
	 * 修改球员能力
	 * @param request
	 * @param playerInfo
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/updateAbility")
	@ResponseBody
	public String updateAbility(HttpServletRequest request,PlayerInfo playerInfo){
		try {
			playerInfo.setUser_id(getUserId());
			AjaxMsg msg = playerInfoService.updatePlayerInfo(playerInfo);
			return msg.toJson();
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().toJson();
		}
	}
	
	/**
	 * 添加或修改球员爱好
	 * @param request
	 * @param playerInfo
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/saveOrUpdateHobby")
	@ResponseBody
	public String saveOrUpdateHobby(HttpServletRequest request,PlayerHobby hobby){
		AjaxMsg msg = AjaxMsg.newError();
		hobby.setUser_id(getUserId());
		if(hobby!=null&&StringUtils.isNotBlank(hobby.getId())){
			msg = playerHobbyService.update(hobby);
		}else{
			hobby.setId(UUIDGenerator.getUUID());
			msg = playerHobbyService.save(hobby);
		}
		return msg.toJson();
	}
	
	/**
	 * 添加或修改球员职业生涯
	 * @param request
	 * @param playerInfo
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/saveOrUpdateCareer")
	@ResponseBody
	public String saveOrUpdateCareer(HttpServletRequest request,PlayerCareer career){
		AjaxMsg msg = AjaxMsg.newError();
		career.setUser_id(getUserId());
		if(career!=null&&StringUtils.isNotBlank(career.getId())){
			msg = playerCareerService.update(career);
		}else{
			career.setId(UUIDGenerator.getUUID());
			msg = playerCareerService.save(career);
		}
		if(msg.isSuccess()){
			msg = playerCareerService.queryByUserId(getUserId());
		}
		return msg.toJson();
	}
	
	/**
	 * 删除职业生涯
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/deleteCareer")
	@ResponseBody
	public String deleteCareer(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = playerCareerService.delete(id);
		if(msg.isSuccess()){
			msg = playerCareerService.queryByUserId(getUserId());
		}
		return msg.toJson();
	}
	
	/**
	 * 删除荣誉
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/deleteHonor")
	@ResponseBody
	public String deleteHonor(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = playerHonorService.delete(id);
		return msg.toJson();
	}
	
	/**
	 * 添加或修改球员荣誉
	 * @param request
	 * @param playerInfo
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/saveOrUpdateHonor")
	@ResponseBody
	public String saveOrUpdateHonor(HttpServletRequest request,PlayerHonor honor){
		AjaxMsg msg = AjaxMsg.newError();
		honor.setUser_id(getUserId());
		if(honor!=null&&StringUtils.isNotBlank(honor.getId())){
			msg = playerHonorService.update(honor);
		}else{
			honor.setId(UUIDGenerator.getUUID());
			msg = playerHonorService.save(honor);
		}
		return msg.toJson();
	}
	
	/**
	 * 添加或修改球员其他属性
	 * @param request
	 * @param playerInfo
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/saveOrUpdateOther")
	@ResponseBody
	public String saveOrUpdateOther(HttpServletRequest request,PlayerOther other){
		AjaxMsg msg = AjaxMsg.newError();
		other.setUser_id(getUserId());
		if(other!=null&&StringUtils.isNotBlank(other.getId())){
			msg = playerOtherService.update(other);
		}else{
			other.setId(UUIDGenerator.getUUID());
			msg = playerOtherService.save(other);
		}
		return msg.toJson();
	}
	
	/**
	 * 查询球员经纪人
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/agent")
	@ResponseBody
	public String agent(HttpServletRequest request,String oth_user_id){
		String uid = getUserId();
		int isme = 0;
		if(StringUtils.isNotBlank(uid)&&uid.equals(oth_user_id)){
			isme = 1;
		}
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		AjaxMsg msg = playerInfoService.getAgentByUserId(uid);
		msg.addData("isme", isme);
		return msg.toJson();
	}
	
	/**
	 * 球员申请解约
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/terminated")
	@ResponseBody
	public String terminated(HttpServletRequest request){
		String agent_id = request.getParameter("agent_id");
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isBlank(agent_id)){
			return AjaxMsg.newError().addMessage("球员或者经纪人不存在").toJson();
		}
		try {
			msg = agentInfoService.applyBreakPlayer(agent_id, this.getUserId(), SYSTYPE.PTAJ.toString());
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage("操作失败").toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 查询球员所在球队
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/team")
	@ResponseBody
	public String team(HttpServletRequest request,String oth_user_id){
		String uid = getUserId();
		int isme = 0;
		if(StringUtils.isNotBlank(uid)&&uid.equals(oth_user_id)){
			isme = 1;
		}
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		AjaxMsg msg = playerInfoService.getTeamByUserId(uid);
		msg.addData("isme", isme);
		return msg.toJson();
	}
	
	/**
	 * 退出球队
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/quitTeam")
	@ResponseBody
	public String quitTeam(HttpServletRequest request){
		//update by bo.xie 退出球队
		String str_teaminfo_id = request.getParameter("teaminfo_id");
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(str_teaminfo_id))return msg.addMessage("删除失败！").toJson();
		try {
			msg = teamInfoService.outTeam(str_teaminfo_id, super.getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return msg.toJson();
	}
	
	/**
	 * 经纪人向球员申请签约  该按钮在球员信息页
	 * @param request
	 * @return AjaxMsg
	 */
	
	/* del by ylt 20150921  申请签约方法在agentController查找
 	@RequestMapping(value="/signByPlayer")
	@ResponseBody
	public String signByPlayer(HttpServletRequest request){
		String playerId = request.getParameter("playerId"); 
		AjaxMsg msg = playerInfoService.signByPlayer(getUserId(),playerId);
		return msg.toJson();
	}*/
	
	/**
	 * 队长邀请球员加入球队
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/teamByPlayer")
	@ResponseBody
	public String teamByPlayer(HttpServletRequest request){
		String playerId = request.getParameter("playerId"); 
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = playerInfoService.saveTeamByPlayer(getUserId(),playerId);
			if(msg.isSuccess()){
				msg.addMessage(messageResourceService.getMessage("system.success"));
			}
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 球员向经纪人申请签约  该按钮在经纪人信息页
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/signByAgent")
	@ResponseBody
	public String signByAgent(HttpServletRequest request){
		String agentId = request.getParameter("agentId"); 
		//AjaxMsg msg = playerInfoService.signByAgent(getUserId(),agentId);
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = agentInfoService.applySignPlayer(agentId, getUserId(), SYSTYPE.PTAQ.toString());
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	
	/**
	 * 邀请试训 返回用户昵称 验证一天只能邀请一次
	 * @param request
	 * @return String
	 */
	@RequestMapping(value="/inviteTrial")
	@ResponseBody
	public String inviteTrial(HttpServletRequest request){
		String othUserId = request.getParameter("othUserId");
		String uid = getUserId();
		AjaxMsg msg = playerInfoService.queryTrialByUserId(othUserId,uid);
		return msg.toJson();
	}
	
	/**
	 * 记录试训
	 * @return
	 */
	@RequestMapping(value="/saveTrial")
	@ResponseBody
	public String saveTrial(HttpServletRequest request,Trial trial,String tdate){
		try {
			if(StringUtils.isNotBlank(tdate)){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				trial.setTrail_date(sdf.parse(tdate));
			}
			trial.setS_user_id(getUserId());
			AjaxMsg msg = playerInfoService.saveTrial(trial);
			return msg.toJson();
		} catch (Exception e) {
			return AjaxMsg.newSuccess().addData("errorMsg", "试训日期错误").toJson();
		}
		
	}
	
	/**
	 * 球员试训次数
	 * @param request 
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/trialCount")
	@ResponseBody
	public Map<String, Object> trialCount(HttpServletRequest request){
		String userId = request.getParameter("userId");
		int num = playerInfoService.trialCount(userId);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("trialCount",num);
		return map;
	}
	

	/**
	 * 球员搜索页面
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/searchPlayer")
	public String searchPlayer(HttpServletRequest request){
		String usernick = request.getParameter("usernick");
		if(null != usernick && !usernick.equals("")){
			request.setAttribute("usernick", usernick);
		}
		return "player/playerlist";
	}
	
	/**
	 * 球员搜索结果
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/searchList")
	public String searchPlayerList(HttpServletRequest request,PlayerTerm playerTerm,PageModel pageModel){
		String login_user_id = this.getUserId();
		if(null != login_user_id){
			playerTerm.setUser_id(login_user_id);
		}
		UserRole userRole = this.getUser();
		if(userRole != null){
			Set<Role> setRole = userRole.getRoles();
			request.setAttribute("role", setRole);
		}
		AjaxMsg msg = AjaxMsg.newError();		
		try {
			msg = playerInfoService.searchPlayerInfo(playerTerm,pageModel);
			request.setAttribute("rf", msg.getData("page"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "player/result_player";
	}
	
	/**
	 * 推荐球员搜索结果
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/searchGoodList")
	public String searchPlayerGoodList(HttpServletRequest request,PageModel pageModel){
		String login_user_id = this.getUserId();
		UserRole userRole = this.getUser();
		if(userRole != null){
			Set<Role> setRole = userRole.getRoles();
			request.setAttribute("role", setRole);
		}
		AjaxMsg msg = AjaxMsg.newSuccess();		
		try {
			Map<String,Object> maps = Maps.newHashMap();
			msg = playerInfoService.searchPlayerInfoByAdmin(maps,pageModel);
			request.setAttribute("sf", msg.getData("page"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "player/special_result_player";
	}
	
	/**
	 * 进入球员相册
	 * @param request
	 * @return photo.html
	 */
	@RequestMapping(value="/photo")
	public String photo(HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		if(!StringUtils.isNotBlank(oth_user_id)){
			oth_user_id = getUserId().toString();
		}
		try {
			AjaxMsg msg = playerInfoService.getByUserId(oth_user_id);
			if(msg.isSuccess()){
				String role_type = SystemEnum.IMAGE.PLAYER.toString();
				request.setAttribute("oth_user_id", oth_user_id);
				request.setAttribute("role_type", role_type);
				request.setAttribute("fpath", role_type.toLowerCase());
				return "player/photo";
			}
		} catch (Exception e) {
			return "";
		}
		return "";
	}
	
	/**
	 * 进入球员视频
	 * @param request
	 * @return photo.html
	 */
	@RequestMapping(value="/video")
	public String videos(HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		if(!StringUtils.isNotBlank(oth_user_id)){
			oth_user_id = getUserId().toString();
		}
		try {
			AjaxMsg msg = playerInfoService.getByUserId(oth_user_id);
			if(msg.isSuccess()){
				String role_type = SystemEnum.IMAGE.PLAYER.toString();
				request.setAttribute("oth_user_id", oth_user_id);
				request.setAttribute("role_type", role_type);
				request.setAttribute("fpath", role_type.toLowerCase());
				String user_img = "headImg/headimg.png";
				if(getUser()!=null){
					user_img = getUser().getHead_icon();
				}
				request.setAttribute("user_img", user_img);
				return "player/videos";
			}
		} catch (Exception e) {
			return "";
		}
		return "";
	}
	
	/**
	 * 查询用户拥有的栏位,剩余栏位
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/restCount")
	@ResponseBody  
	public String restCount(HttpServletRequest request){
		String type = request.getParameter("type");
		AjaxMsg msg = imageVideoService.restCount(getUserId(),type);
		return msg.toJson();
	}
	
	/**
	 * 球员图片
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/images")
	@ResponseBody  
	public String playerImgs(HttpServletRequest request,PageModel pageModel){
		String oth_user_id = request.getParameter("oth_user_id");
		String uid = getUserId();
		int isme = 0;
		if(StringUtils.isNotBlank(uid)&&uid.equals(oth_user_id)){
			isme = 1;
		}
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		ImageVideo iv = new ImageVideo();
		iv.setUser_id(uid);
		//iv.setRole_type(SystemEnum.IMAGE.PLAYER.toString());
		iv.setNot_role_type(SystemEnum.IMAGE.TEAM.toString());
		iv.setF_status(1);
		iv.setType("image");
		AjaxMsg msg = imageVideoService.searchImageVideos(iv, pageModel);
		msg.addData("isme", isme);
		return msg.toJson();
	}
	
	/**
	 * 球员视频
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/videos")
	@ResponseBody  
	public String playerVideos(HttpServletRequest request,PageModel pageModel){
		String oth_user_id = request.getParameter("oth_user_id");
		String uid = getUserId();
		int isme = 0;
		if(StringUtils.isNotBlank(uid)&&uid.equals(oth_user_id)){
			isme = 1;
		}
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		ImageVideo iv = new ImageVideo();
		iv.setUser_id(uid);
//		iv.setRole_type(SystemEnum.IMAGE.PLAYER.toString());
		iv.setNot_role_type(SystemEnum.IMAGE.TEAM.toString());
		iv.setF_status(1);
		iv.setType("video");
		AjaxMsg msg = imageVideoService.searchImageVideos(iv, pageModel);
		msg.addData("isme", isme);
		return msg.toJson();
	}
	
	@RequestMapping(value="/showCenter")
	@ResponseBody  
	public String showCenter(HttpServletRequest request){
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		String state = request.getParameter("state");
		AjaxMsg msg = imageVideoService.updateShowCenter(getUserId(),id,type,state);
		return msg.toJson();
	}
	
	@RequestMapping(value="/praise")
	@ResponseBody 
	public String praise(HttpServletRequest request){
		String p_user_id = request.getParameter("p_user_id");
		String p_state = request.getParameter("p_state");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("user_id", getUserId());
		params.put("p_user_id", p_user_id);
		params.put("p_state", p_state);
		params.put("ip_str", request.getRemoteAddr());
		try {
			AjaxMsg msg = playerInfoService.updatePraise(params);
			return msg.toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().toJson();
		}
	}
	/**
	 * 查询球员评价标签
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/showTags")
	@ResponseBody  
	public String showTags(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String user_id = request.getParameter("user_id");
		msg = playerInfoService.queryPlayerTag(user_id);
		return msg.toJson();
	}
	
	/**
	 * 球员评价标签保存
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/savePlayerTag")
	@ResponseBody
	public String savePlayerTag(HttpServletRequest request,PlayerTag playerTag){
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			playerTag.setId(UUIDGenerator.getUUID());
			playerTag.setS_user_id(this.getUserId());
			msg = playerInfoService.savePlayerTag(playerTag);
		} catch (Exception e) {
			e.printStackTrace();
			return  AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 删除用户标签
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/deletePlayerTag")
	@ResponseBody
	public String deletePlayerTag(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String id = request.getParameter("id");
		try {
			msg = playerInfoService.deletePlayerTag(id);
		} catch (Exception e) {
			e.printStackTrace();
			return  AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
}



