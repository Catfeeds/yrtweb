package com.yt.framework.controller;

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

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AgentInfo;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.SystemEnum.SYSTYPE;
import com.yt.framework.service.AgentInfoService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *经纪人
 *@autor bo.xie
 *@date2015-8-5下午6:17:38
 */
@Controller
@RequestMapping(value="/agent/")
public class AgentController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(AgentController.class);
	
	@Autowired
	private AgentInfoService agentInfoService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private ImageVideoService imageVideoService;

	/**
	 * 经纪人信息编辑页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-6上午11:17:01
	 */
	@RequestMapping(value="info")
	public String agentInfo(Model model,HttpServletRequest request){
		String type = request.getParameter("type");
		String str_oth_user_id = request.getParameter("oth_user_id");
		String user_id =super.getUserId();
		String oth_user_id = StringUtils.isNotBlank(str_oth_user_id)?str_oth_user_id:"";
		AgentInfo ai = new AgentInfo();
		if(user_id.equals(oth_user_id)){
			AjaxMsg msg = agentInfoService.getAgentInfoByUserId(oth_user_id);
			if(msg.isSuccess())ai=(AgentInfo) msg.getData("data");
		}else{
			AjaxMsg msg = agentInfoService.getAgentInfoByUserId(user_id);
			if(msg.isSuccess())ai=(AgentInfo) msg.getData("data");
		}
		model.addAttribute("agent", ai);
		model.addAttribute("oth_user_id", oth_user_id);
		if(StringUtils.isNotBlank(type) && type.equals("edit") && oth_user_id.equals(user_id)){
			return "center/agent/agent_editInfo";
		}
		
		return "center/agent/agent_info";
	}
	
	/**
	 * 保存或更新经纪人信息
	 *@param request
	 *@param cer_no 证书号
	 *@param title 头衔
	 *@param agent_plays 代理过球员
	 *@param know_clubs 熟悉俱乐部
	 *@param find_area 寻找球员区域
	 *@param is_player 是否有球员经历
	 *@param company 所属公司
	 *@param education 学历
	 *@param cases 典型案例
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-6上午11:17:16
	 */
	@RequestMapping(value="saveOrUpdate")
	public @ResponseBody String saveOrUpdateAgentInfo(HttpServletRequest request,AgentInfo ai){
		String id = ai.getId();
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(id)){
			String user_id = super.getUserId();
			ai.setUser_id(user_id);
			//update by gl 保存经济人信息后增加经纪人权限
			try {
				msg = agentInfoService.saveAgent(ai,request);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//update by gl 
		}else{
			 msg = agentInfoService.update(ai);
		}
		return msg.toJson();
	}
	
	/**
	 * 所有经济人列表
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-6下午2:29:11
	 */
	@RequestMapping(value="list")
	public String agentListPage(Model model,HttpServletRequest request){
		model.addAttribute("usernick", request.getParameter("usernick"));
		return "agent_listPage";
	}
	
	/**
	 * 所有经纪人列表数据
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-6下午2:48:52
	 */
	@RequestMapping(value="listData")
	public String agentListDatas(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> map = Maps.newHashMap();
		map.put("area", request.getParameter("area"));
		map.put("province", request.getParameter("province"));
		map.put("city", request.getParameter("city"));
		map.put("company", request.getParameter("company"));
		map.put("usernick", request.getParameter("usernick"));
		AjaxMsg msg = agentInfoService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "agent_listData";
	}
	
	/**
	 * 签约球员(生成签约数据)
	 *@param agent_id 经纪人用户ID
	 *@param player_id 球员用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10上午11:12:36
	 */
	@RequestMapping(value="toSign")
	public @ResponseBody String signPlayer(HttpServletRequest request){
		String agent_id = this.getUserId();//经纪人用户ID
		String player_id = request.getParameter("player_id");//球员用户ID
		String status = request.getParameter("status");
		if(null == agent_id || StringUtils.isBlank(player_id))return AjaxMsg.newError().addMessage("经纪人或球员不存在").toJson();
		AjaxMsg msg;
		try {
			msg = agentInfoService.signPlayer(agent_id, player_id,  Integer.valueOf(status));
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage("操作失败").toJson();
		}
		return msg.toJson();
	}

	/**
	 * 经纪人申请解约球员
	 *@param agent_id 经纪人用户ID
	 *@param player_id 球员用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10上午11:34:22
	 */
	@RequestMapping(value="applyBreakPlayer")
	public @ResponseBody String applyBreakPlayer(HttpServletRequest request){
		User user = super.getUser();
		String p_user_id = request.getParameter("p_user_id");//球员用户ID
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = agentInfoService.applyBreakPlayer(user.getId(),p_user_id, SYSTYPE.ATPJ.toString());
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage("操作失败").toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 球员签约申请记录列表数据
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10上午11:59:28
	 */
	@RequestMapping(value="applyDatas")
	public @ResponseBody String playerApplyAgent(HttpServletRequest request,PageModel pageModel){
		String user_id = super.getUserId();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		maps.put("status", 0);
		AjaxMsg msg = agentInfoService.queryAgentPlayerForPage(maps, pageModel);
		return msg.toJson();
	}

	
	/**
	 * 经纪人已签约球员数据
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-28下午2:34:28
	 */
	@RequestMapping(value="agentPlayers")
	public String agentPlayersData(Model model,HttpServletRequest request,PageModel pageModel){
		String oth_user_id = request.getParameter("oth_user_id");
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", oth_user_id);
		maps.put("status", "1");
		AjaxMsg msg = agentInfoService.queryAgentPlayerForPage(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "center/agent/agent_players";
	}
	
	@RequestMapping(value="outTeam")
	public @ResponseBody String outTeam(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String teaminfo_id = request.getParameter("teaminfo_id");//俱乐部ID
		String p_user_id = request.getParameter("p_user_id");//球员用户ID
		if(StringUtils.isBlank(p_user_id)) return msg.addMessage("球员不存在！").toJson();
		try {
			msg = teamInfoService.outTeam(teaminfo_id, p_user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msg.toJson();
	}
	
	/**
	 * 获取经纪人图片
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-29下午3:08:11
	 */
	/*@RequestMapping(value="images")
	public String agentImages(Model model,HttpServletRequest request,PageModel pageModel){
		String user_id = super.getUserId();
		AjaxMsg msg = imageVideoService.getImageVideosByUserId(user_id, 1, 4, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("data"));
		}
		return "center/agent/agent_image";
	}*/
	
	/**
	 * 经纪人图片和视频加载
	 * @autor gl
	 * @return agent-imgvideo
	 */
	@RequestMapping(value="imgAndVdo")
	public String agentImgAndVdo(){
		return "center/agent/agent-imgvideo";
	}
	
	/**
	 * 经纪人图片
	 * @param request
	 * @autor gl
	 * @return AjaxMsg
	 */
	@RequestMapping(value="images")
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
		/*iv.setRole_type(4);
		iv.setType(1);
		iv.setStatus(1);*/
		AjaxMsg msg = imageVideoService.searchImageVideos(iv, pageModel);
		msg.addData("page", msg.getData("data"));
		msg.addData("isme", isme);
		return msg.toJson();
	}
	/**
	 * 经纪人视频
	 * @autor gl
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="videos")
	@ResponseBody  
	public String playerVideos(HttpServletRequest request,PageModel pageModel){
		String oth_user_id = request.getParameter("oth_user_id");
		String uid = getUserId();
		int isme = 0;
		if(StringUtils.isNotBlank(uid)&&(uid.toString()).equals(oth_user_id)){
			isme = 1;
		}
		if(StringUtils.isNotBlank(oth_user_id)){
			uid = oth_user_id;
		}
		ImageVideo iv = new ImageVideo();
		iv.setUser_id(uid);
		/*iv.setRole_type(4);
		iv.setType(2);
		iv.setStatus(1);*/
		AjaxMsg msg = imageVideoService.searchImageVideos(iv, pageModel);
		msg.addData("page", msg.getData("data"));
		msg.addData("isme", isme);
		return msg.toJson();
	}
	
	/**
	 * 获取经纪人视频
	 *@param model
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-29下午3:54:56
	 */
	/*@RequestMapping(value="videos")
	public String agentVideo(Model model,HttpServletRequest request,PageModel pageModel){
		String user_id = super.getUserId();
		AjaxMsg msg = imageVideoService.getImageVideosByUserId(user_id, 2, 4, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("data"));
		}
		return "center/agent/agent_video";
	}*/
	
	
	/**
	 * 进入经纪人相册
	 * @param request
	 * @autor gl
	 * @return photo.html
	 */
	@RequestMapping(value="photo")
	public String photo(HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		if(!StringUtils.isNotBlank(oth_user_id)){
			oth_user_id = getUserId().toString();
		}
		try {
			AjaxMsg msg = agentInfoService.getByUserId(oth_user_id);
			if(msg.isSuccess()){
				request.setAttribute("oth_user_id", oth_user_id);
				return "center/agent/photo";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return "";
	}
	
	/**
	 * 进入经纪人视频
	 * @param request
	 * @autor gl
	 * @return photo.html
	 */
	@RequestMapping(value="video")
	public String videos(HttpServletRequest request){
		String oth_user_id = request.getParameter("oth_user_id");
		if(!StringUtils.isNotBlank(oth_user_id)){
			oth_user_id = getUserId().toString();
		}
		try {
			AjaxMsg msg = agentInfoService.getByUserId(oth_user_id);
			if(msg.isSuccess()){
				request.setAttribute("oth_user_id", oth_user_id);
				return "center/agent/videos";
			}
		} catch (Exception e) {
			return "";
		}
		return "";
	}
	
	/**
	 * 经纪人向球员申请签约 
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/signByAgent")
	@ResponseBody
	public String signByAgent(HttpServletRequest request){
		String playerId = request.getParameter("playerId"); 
		if(StringUtils.isBlank(super.getUserId())) return AjaxMsg.newError().addMessage("请登陆系统再操作!").toJson();
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = agentInfoService.applySignPlayer(super.getUserId(), playerId, SYSTYPE.ATPQ.toString());
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage("操作失败!").toJson();
		}
		return msg.toJson();
	}
}
