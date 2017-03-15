package com.yt.framework.controller;

import java.util.Date;
import java.util.HashMap;
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
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;

/**
 * 球员交易
 * @author bo.xie
 * @date 2015年11月20日14:18:15
 */
@RequestMapping(value="/playerTrade/")
@Controller
public class PlayerTradeController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(PlayerTradeController.class);

	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private LeagueMarketService leagueMarketService;
	@Autowired
	private UserAmountService userAmountService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private LeagueService leagueService;
	
	
	/**
	 * 判断转会市场是否开启
	 */
	@RequestMapping(value="isOpenMarket")
	public @ResponseBody String asd(HttpServletRequest request){
		String league_id = request.getParameter("league_id");
		return leagueMarketService.marketStatus(league_id).toJson();
	}
	
	/**
	 * 跳蚤市场球员列表
	 * @param model
	 * @param auctionCondition
	 * @param request
	 * @return
	 */
	@RequestMapping(value="list")
	public String playerList(Model model,AuctionCondition auctionCondition,HttpServletRequest request,PageModel pageModel){
		String s_id = BeanUtils.nullToString(request.getParameter("s_id"));
		String userId = request.getParameter("pid");
		AjaxMsg msg = AjaxMsg.newSuccess();
		//当前的市场配置
		MarketCfg cfg = leagueMarketService.getCurrentMarket(s_id);
		String username = "";
		if(StringUtils.isNotBlank(userId)){
			User user = userService.getEntityById(userId);
			username = user.getUsername();
		}
		String login_user_id = this.getUserId();
		if(StringUtils.isNotBlank(login_user_id)){
			TeamInfo teaminfo = teamInfoService.getTeamInfoByUserId(login_user_id);
			if(null != teaminfo){
				request.setAttribute("teaminfo_id", BeanUtils.nullToString(teaminfo.getId()));
			}
		}
		//成交记录
		PageModel pm = new PageModel();
		pm.setCurrentPage(1);
		pm.setPageSize(4);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("s_id",s_id);
		AjaxMsg lmmsg = leagueMarketService.queryLeagueMarket(params,pm);
		pm = (PageModel) lmmsg.getData("page");
		model.addAttribute("leagueMarkets", pm.getItems());
		model.addAttribute("s_id", s_id);
		model.addAttribute("cfg", cfg);
		model.addAttribute("username", username);
		return "league/player/list";
	}
	
	@RequestMapping(value="listdatas")
	public String playerListData(Model model,AuctionCondition auctionCondition,HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isNotBlank(league_id)){
			msg = leagueMarketService.ifOpenMarket(league_id);
			if(msg.isError()){
				request.setAttribute("msg", msg);
				return "";
			}
		}
		msg = playerInfoService.loadPlayers(auctionCondition, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		MarketCfg cfg = leagueMarketService.getCurrentMarket(auctionCondition.getS_id());
		if(cfg!=null && StringUtils.isNotBlank(cfg.getId())){
			Date nowDate = new Date();
			Date openDate = cfg.getStart_time();
			boolean result  = Common.compareDates(nowDate, openDate);
			//竞拍未开始
			if(result == true){
				request.setAttribute("ifOpen", false);
			}else if(cfg.getIf_open() == 0){
				request.setAttribute("ifOpen", false);
			}else{
				auctionCondition.setTurn_num(cfg.getTurn_num()+"");
				request.setAttribute("ifOpen", true);
			}
			Date endDate = cfg.getEnd_time();
			boolean e_result = Common.compareDates(nowDate, endDate);
			if(e_result == false){
				request.setAttribute("ifEnd", false);
			}else{
				request.setAttribute("ifEnd", true);
			}
		}else{
			request.setAttribute("ifOpen", false);
		}
		request.setAttribute("cfg",cfg);
		return "league/player/listdata";
	}
	
	
	/**
	 * 购买球员
	 * @param request
	 * @return
	 */
	@RequestMapping(value="buy")
	public @ResponseBody String buyPlayer(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		try{
			String buyer = super.getUserId();//购买者用户ID
			String id = request.getParameter("id");//球员跳蚤市场记录ID
			String price = request.getParameter("price");//购买球员价格
			String tm_user_id = request.getParameter("tm_user_id");//出售球员俱乐部管理者用户ID
			String p_user_id = request.getParameter("p_user_id");//出售球员用户ID
			String s_id = request.getParameter("s_id");//当前联赛ID
			String cfg_id = request.getParameter("cfg_id");
			if(StringUtils.isBlank(buyer)||StringUtils.isBlank(id)||
			   StringUtils.isBlank(price)||StringUtils.isBlank(p_user_id)){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
			Map<String,Object> params = Maps.newHashMap();
			params.put("buyer", buyer);
			params.put("id", id);
			params.put("price", price);
			params.put("tm_user_id",tm_user_id);
			params.put("p_user_id",p_user_id);
			params.put("s_id", s_id);
			params.put("cfg_id", cfg_id);
			LeagueMarket leagueMarket = leagueMarketService.getEntityById(id);
			if(leagueMarket.getStatus() == 1){
				return  AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.userselled")).toJson();
			}else if(leagueMarket.getIf_up() == 0){
				return  AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.usernoup")).toJson();
			}
			//一口价购买
			if(leagueMarket.getIf_one() == 1){
				msg = leagueMarketService.saveMarketDataOnePrice(params);
			}else{ //竞拍购买
				msg = leagueMarketService.saveMarketData(params);
			}
			
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
	@RequestMapping(value="lookPlayer")
	public String lookPlayer(HttpServletRequest request) {
		String user_id = this.getUserId();
		String m_id = request.getParameter("m_id");//球员转会数据ID
		//Map<String,Object> playerInfo =  playerInfoService.getPlayerInfoForMarketByUserId("m_id","0");
		Map<String,Object> playerInfo = leagueMarketService.getPlayerInfoForMarketById(m_id);
		AjaxMsg teamInfo = playerInfoService.getTeamByUserId(BeanUtils.nullToString(playerInfo.get("user_id")));//查询球员所属俱乐部
		//判断当前用户是否是俱乐部管理者，若是管理者查询该俱乐部资金账户
		TeamInfo ti = teamInfoService.getTeamInfoByUserId(user_id);
		if(null!=ti){
			String teaminfo_id = ti.getId();
			UserAmount userAmount = userAmountService.getUserAmountByTeamInfoID(teaminfo_id);
			request.setAttribute("userAmount", userAmount);
		}
		//update by bo.xie 更新个人账户为俱乐部账户	end
		request.setAttribute("teamInfo", teamInfo.getData("data"));
		request.setAttribute("auctionMap", playerInfo);
		request.setAttribute("p_user_id", BeanUtils.nullToString(playerInfo.get("user_id")));
		return "league/player/player_info";
	}
	
	/**
	 * 我买到的球员
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="myPlayers")
	public String tradePlayersFormy(Model model,AuctionCondition auctionCondition,HttpServletRequest request,PageModel pageModel){
		/*String user_id = super.getUserId();
		auctionCondition.setUser_id(user_id);
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		if(null != teamInfo){
			auctionCondition.setTeaminfo_id(teamInfo.getId());
		}
		AjaxMsg msg = playerInfoService.loadMarketRecord(auctionCondition, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		model.addAttribute("auctionCondition", auctionCondition);*/
		MarketCfg cfg = leagueMarketService.getCurrentMarket(auctionCondition.getS_id());
		String user_id = super.getUserId();
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		model.addAttribute("teamInfo", teamInfo);
		if(null != teamInfo){
			model.addAttribute("teaminfo_id", teamInfo.getId());
		}
		model.addAttribute("cfg", cfg);
		return "league/player/my_trade_players";
	}
	
	/**
	 * 我买到的球员数据
	 * @param model
	 * @param auctionCondition
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="buyPlays")
	public String buyPlayersData(Model model,AuctionCondition auctionCondition,HttpServletRequest request,PageModel pageModel){
		String user_id = super.getUserId();
		auctionCondition.setUser_id(user_id);
		Map params = Maps.newHashMap();
		try {
			params = BeanUtils.object2Map(auctionCondition);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		if(null != teamInfo){
			params.put("teaminfo_id",teamInfo.getId());
		}
		AjaxMsg msg = playerInfoService.loadMarketRecord(params, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		model.addAttribute("auctionCondition", auctionCondition);
		return "league/player/buy_palyers_data";
	}
	
	/**
	 * 我出售的球员
	 * @param model
	 * @param auctionCondition
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="mySalePlayers")
	public String salePlayersFormy(Model model,AuctionCondition auctionCondition,HttpServletRequest request,PageModel pageModel){
		/*String user_id = super.getUserId();
		auctionCondition.setUser_id(user_id);
		TeamInfo teaminfo =  teamInfoService.getTeamInfoByPUserID(user_id);
		auctionCondition.setTeaminfo_id(teaminfo.getId());
		AjaxMsg msg = playerInfoService.loadSaleRecord(auctionCondition, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}*/
		model.addAttribute("auctionCondition", auctionCondition);
		return "league/player/my_sale_players";
	}
	
	/**
	 * 我出售球员列表
	 * @param model
	 * @param auctionCondition
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="saleDatas")
	public String salePlayerDatas(Model model,AuctionCondition auctionCondition,HttpServletRequest request,PageModel pageModel){
		String user_id = super.getUserId();
		auctionCondition.setUser_id(user_id);
		TeamInfo teaminfo =  teamInfoService.getTeamInfoByPUserID(user_id);
		auctionCondition.setTeaminfo_id(teaminfo.getId());
		AjaxMsg msg = playerInfoService.loadSaleRecord(auctionCondition, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		model.addAttribute("auctionCondition", auctionCondition);
		return "league/player/sale_player_data";
	}
	
	/**
	 *  转会公告
	 * @param request
	 * @return
	 */
	@RequestMapping(value="leagueMarket")
	public String leagueMarket(HttpServletRequest request){
		String s_id = request.getParameter("s_id");
		request.setAttribute("s_id", s_id);
		return "league/player/league_market";
	}
	
	@RequestMapping(value="queryLeagueMarket")
	public String queryLeagueMarket(HttpServletRequest request,PageModel pageModel){
		String s_id = request.getParameter("s_id");
		if(StringUtils.isNotBlank(s_id)){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("s_id",s_id);
			AjaxMsg msg = leagueMarketService.queryLeagueMarket(params,pageModel);
			request.setAttribute("page", msg.getData("page"));
			request.setAttribute("params", params);
			return "league/player/league_market_page";
		}
		return "";
	}
	
	/**
	 * 是否具有竞拍权限
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="ifMarket")
	@ResponseBody
	public String ifMarket(HttpServletRequest request){
		String user_id = this.getUserId();
		String id = BeanUtils.nullToString(request.getParameter("id"));
		String s_id = BeanUtils.nullToString(request.getParameter("s_id"));
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		if(teamInfo == null) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nocaption")).toJson();
		TeamLeague teamLeague = leagueService.getTeamSignByLeague(teamInfo.getId(), s_id);
		if(teamLeague == null || teamLeague.getStatus() == 0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noteam")).toJson();
		MarketCfg cfg = leagueMarketService.getCfgById(id);
		if(cfg.getIf_open() == 0){
			 return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.auction.timeover")).toJson();
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/**
	 * 转会竞拍历史记录
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="marketHistorys")
	@ResponseBody
	public String marketHistorys(HttpServletRequest request,PageModel pageModel){
		String s_id = request.getParameter("s_id");
		String m_id = request.getParameter("m_id");
		String user_id = request.getParameter("user_id");
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(m_id)||StringUtils.isBlank(s_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		maps.put("m_id", m_id);
		maps.put("s_id", s_id);
		AjaxMsg msg = leagueMarketService.queryMarketHistorys(maps, pageModel);
		return AjaxMsg.newSuccess().addData("rf", msg.getData("page")).addData("pageCount", msg.getData("pageCount")).toJson();
	}
}
