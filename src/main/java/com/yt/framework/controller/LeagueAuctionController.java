package com.yt.framework.controller;

import java.util.Date;
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

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AuctionCondition;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;

/**
 * 联赛
 * 
 * @autor ylt
 * @date2015-10-14下午2:46:36
 */
@Controller
@RequestMapping(value = "/auction/")
public class LeagueAuctionController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(LeagueAuctionController.class);
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private LeagueAuctionService leagueAuctionService;
	@Autowired
	private UserAmountService userAmountService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private TeamInfoService teamInfoService;
	
	/**
	 * 查询竞拍球员
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="search")
	@ResponseBody
	public String search(HttpServletRequest request) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		return msg.toJson();
	}
	
	/**
	 * 竞拍球员列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="searchList")
	public String searchList(HttpServletRequest request,AuctionCondition auctionCondition,PageModel pageModel) {
		LeagueAuctionCfg leagueAuctionCfg = leagueAuctionService.getCurrentAuction(auctionCondition.getS_id());
		
		if(leagueAuctionCfg!=null && StringUtils.isNotBlank(leagueAuctionCfg.getId())){
			Date nowDate = new Date();
			Date openDate = leagueAuctionCfg.getStart_time();
			boolean result  = Common.compareDates(nowDate, openDate);
			//竞拍未开始
			if(result == true){
				//return "league/auction/auction_wait";
				request.setAttribute("ifOpen", false);
			}else if(leagueAuctionCfg.getStatus() == 0){
				request.setAttribute("ifOpen", false);
				//市场未开放
				//return "league/auction/auction_wait";
			}else{
				auctionCondition.setTurn_num(leagueAuctionCfg.getTurn_num()+"");
				request.setAttribute("ifOpen", true);
			}
			Date endDate = leagueAuctionCfg.getEnd_time();
			boolean e_result = Common.compareDates(nowDate, endDate);
			if(e_result == false){
				request.setAttribute("ifEnd", false);
			}else{
				request.setAttribute("ifEnd", true);
			}
		}
		String user_id = this.getUserId();
		if(StringUtils.isNotBlank(user_id)){
			TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
			if(null != teamInfo){
				request.setAttribute("teaminfo_id",teamInfo.getId());
			}
		}	
		request.setAttribute("leagueAuctionCfg",leagueAuctionCfg);
		request.setAttribute("auctionCondition",auctionCondition);
		return "league/auction/all_auction";
	}
	
	/**
	 * 竞拍球员列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="mySearchList")
	public String mySearchList(HttpServletRequest request,AuctionCondition auctionCondition,PageModel pageModel) {
		String user_id = this.getUserId();
		//未登录
		if(StringUtils.isBlank(user_id)){
			return "";
		}else{
			auctionCondition.setUser_id(user_id);
		}
		LeagueAuctionCfg leagueAuctionCfg = leagueAuctionService.getCurrentAuction(auctionCondition.getS_id());
		//判断市场是否存在
		if(leagueAuctionCfg!=null && StringUtils.isNotBlank(leagueAuctionCfg.getId())){
			request.setAttribute("leagueAuctionCfg",leagueAuctionCfg);
			Date nowDate = new Date();
			Date openDate = leagueAuctionCfg.getStart_time();
			boolean result  = Common.compareDates(nowDate, openDate);
			//竞拍未开始
			if(result == true){
				//return "league/auction/auction_wait";
				request.setAttribute("ifOpen", false);
			}else if(leagueAuctionCfg.getStatus() == 0){
				request.setAttribute("ifOpen", false);
				//市场未开放
				//return "league/auction/auction_wait";
			}else{
				request.setAttribute("ifOpen", true);
			}
			Date endDate = leagueAuctionCfg.getEnd_time();
			boolean e_result = Common.compareDates(nowDate, endDate);
			if(e_result == false){
				//市场已结束
				request.setAttribute("ifEnd", false);
			}else{
				request.setAttribute("ifEnd", true);
			}
		}/*else{
			return "league/auction/auction_wait";
		}*/
		//判断市场是否存在
		//List<LeagueAuctionCfg> listCfg = leagueAuctionService.getCfgByLeague(auctionCondition.getLeague_id());
		List<LeagueAuctionCfg> listCfg = leagueAuctionService.getCfgByLeagueCfg(auctionCondition.getS_id());
		if(listCfg.isEmpty()){
			//return "league/auction/auction_wait";
		}else{
			request.setAttribute("listCfg",listCfg);
		}
		if(StringUtils.isNotBlank(user_id)){
			TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
			if(null != teamInfo){
				request.setAttribute("teaminfo_id",teamInfo.getId());
			}
		}	
		AjaxMsg msg = AjaxMsg.newSuccess();
		request.setAttribute("auctionCondition",auctionCondition);
		return "league/auction/my_auction";
	}
	
	/**
	 * 竞拍球员详情
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="lookPlayer")
	public String lookPlayer(HttpServletRequest request) {
		String user_id = this.getUserId();
		String id = request.getParameter("id");
		AjaxMsg msgDetail = leagueAuctionService.getAuctionPlayerDetail(id);
		//AjaxMsg msgUser = userAmountService.getByUserId(user_id);
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		UserAmount userAmount = new UserAmount();
		if(null != teamInfo && null !=teamInfo.getId()){
			userAmount = userAmountService.getUserAmountByTeamInfoID(teamInfo.getId());
		}else{
			return "/error/info";
		}
		request.setAttribute("userAmount", userAmount);
		request.setAttribute("auctionMap", msgDetail.getData("auctionMap"));
		return "league/auction/auction_user";
	}
	
	/**
	 * 竞价
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="bidAuction")
	@ResponseBody
	public String bidAuction(HttpServletRequest request) {
		String user_id = this.getUserId();
		String id = request.getParameter("id");
		String turn_id =  request.getParameter("turn_id");
		String price = request.getParameter("bid_price");
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(null == user_id){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		}
		try{
			msg = leagueAuctionService.saveAuction(user_id,id,turn_id,price);
		}catch(Exception e){
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 竞拍球员详情
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="loadQueryPage")
	public String loadQueryPage(HttpServletRequest request,AuctionCondition auctionCondition,PageModel pageModel) {
		LeagueAuctionCfg leagueAuctionCfg = leagueAuctionService.getCurrentAuction(auctionCondition.getS_id());
		if(leagueAuctionCfg!=null && StringUtils.isNotBlank(leagueAuctionCfg.getId())){
			Date nowDate = new Date();
			Date openDate = leagueAuctionCfg.getStart_time();
			boolean result  = Common.compareDates(nowDate, openDate);
			//竞拍未开始
			if(result == true){
				//return "league/auction/auction_wait";
				request.setAttribute("ifOpen", false);
			}else if(leagueAuctionCfg.getStatus() == 0){
				request.setAttribute("ifOpen", false);
				//市场未开放
				//return "league/auction/auction_wait";
			}else{
				auctionCondition.setTurn_num(leagueAuctionCfg.getTurn_num()+"");
				request.setAttribute("ifOpen", true);
			}
			Date endDate = leagueAuctionCfg.getEnd_time();
			boolean e_result = Common.compareDates(nowDate, endDate);
			if(e_result == false){
				request.setAttribute("ifEnd", false);
			}else{
				request.setAttribute("ifEnd", true);
			}
		}else{
			request.setAttribute("leagueAuctionCfg",leagueAuctionCfg);
			return "league/auction/auction_wait";
		}
		//String user_id = this.getUserId();
		AjaxMsg msg = AjaxMsg.newSuccess();
		/*TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		if(teamInfo == null) return "";
		TeamLeague teamLeague =  leagueService.getTeamLeague(auctionCondition.getLeague_id(), teamInfo.getId());
		if(teamLeague == null || teamLeague.getStatus() == 0) return "";*/
		try {
			msg = leagueAuctionService.queryAuctionForMap(auctionCondition,pageModel);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("leagueAuctionCfg",leagueAuctionCfg);
		request.setAttribute("rf", msg.getData("page"));
		request.setAttribute("auctionCondition",auctionCondition);
		return "league/auction/all_auction_list";
	}
	
	/**
	 * 竞拍球员详情
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="loadMyQueryPage")
	public String loadMyQueryPage(HttpServletRequest request,AuctionCondition auctionCondition,PageModel pageModel) {
		String user_id = this.getUserId();
		//未登录
		if(StringUtils.isBlank(user_id)){
			return "";
		}else{
			auctionCondition.setUser_id(user_id);
		}
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		if(null != teamInfo){
			auctionCondition.setTeaminfo_id(teamInfo.getId());
		}
		LeagueAuctionCfg leagueAuctionCfg = leagueAuctionService.getCurrentAuction(auctionCondition.getS_id());
		//判断市场是否存在
		if(leagueAuctionCfg!=null && StringUtils.isNotBlank(leagueAuctionCfg.getId())){
			request.setAttribute("leagueAuctionCfg",leagueAuctionCfg);
			Date nowDate = new Date();
			Date openDate = leagueAuctionCfg.getStart_time();
			boolean result  = Common.compareDates(nowDate, openDate);
			//竞拍未开始
			if(result == true){
				//return "league/auction/auction_wait";
				request.setAttribute("ifOpen", false);
			}else if(leagueAuctionCfg.getStatus() == 0){
				request.setAttribute("ifOpen", false);
				//市场未开放
				//return "league/auction/auction_wait";
			}else{
				request.setAttribute("ifOpen", true);
			}
			Date endDate = leagueAuctionCfg.getEnd_time();
			boolean e_result = Common.compareDates(nowDate, endDate);
			if(e_result == false){
				request.setAttribute("ifEnd", false);
			}else{
				request.setAttribute("ifEnd", true);
			}
		}
		//判断市场是否存在
		List<LeagueAuctionCfg> listCfg = leagueAuctionService.getCfgByLeagueCfg(auctionCondition.getS_id());
		if(listCfg.isEmpty()){
			return "league/auction/auction_wait";
		}else{
			request.setAttribute("listCfg",listCfg);
		}
		
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = leagueAuctionService.queryMyAuctionForMap(auctionCondition,pageModel);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("rf", msg.getData("page"));
		request.setAttribute("auctionCondition",auctionCondition);
		return "league/auction/my_auction_list";
	}
	
	
	/**
	 * 获取对应消息
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="getMsg")
	@ResponseBody
	public String getMsg(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String info = request.getParameter("info");
		String key = request.getParameter("key");
		if(StringUtils.isNotBlank(key)){
			System.out.println(key.substring(1, key.length()));
			TeamInfo team = teamInfoService.getEntityById(key.substring(1, key.length()));
			msg.addMessage(messageResourceService.getMessage(new Object[]{team.getName()}, info));
		}
		return msg.toJson();
	}
	
	/**
	 * 是否具有竞拍权限
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="ifAuction")
	@ResponseBody
	public String ifAuction(HttpServletRequest request){
		String user_id = this.getUserId();
		String s_id = request.getParameter("s_id");
		String turn_num = request.getParameter("turn_num");
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		if(teamInfo == null) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nocaption")).toJson();
		//TeamLeague teamLeague =  leagueService.getTeamLeague(league_id, teamInfo.getId());
		TeamLeague teamLeague = leagueService.getTeamSignByLeague(teamInfo.getId(), s_id);
		if(teamLeague == null || teamLeague.getStatus() == 0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noteam")).toJson();
		LeagueAuctionCfg cfg = leagueAuctionService.getCurrentAuction(s_id);
		if(null == cfg){
			 return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.auction.timeover")).toJson();
		}else{
			 if(cfg.getTurn_num() != Integer.valueOf(turn_num)){
				 return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.auction.timeover")).toJson();
			 }
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/**
	 * 球员竞拍记录
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="bidRecord")
	public @ResponseBody String bidRecods(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String user_id = request.getParameter("user_id");//竞拍球员用户user_id
		String au_id = request.getParameter("au_id");//竞拍市场ID
		String s_id = request.getParameter("s_id");//联赛赛季ID
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(au_id)||StringUtils.isBlank(s_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		maps.put("user_id", user_id);
		maps.put("au_id", au_id);
		maps.put("s_id", s_id);
		AjaxMsg msg = leagueService.loadBidRecords(maps, pageModel);
		return AjaxMsg.newSuccess().addData("rf", msg.getData("page")).addData("pageCount", msg.getData("pageCount")).toJson();
	}
	
}