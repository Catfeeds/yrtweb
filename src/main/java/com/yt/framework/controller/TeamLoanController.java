package com.yt.framework.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamLoanMsg;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamLoanPlayerService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 俱乐部租借
 *@autor ylt
 *@date2015-8-13下午2:46:36
 */
@Controller
@RequestMapping(value="/teamLoan/")
public class TeamLoanController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(TeamLoanController.class);

	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private LeagueService leagueService;
	@Autowired 
	private LeagueMarketService leagueMarketService;
	@Autowired 
	private UserAmountService userAmountService;
	
	@Autowired 
	private TeamLoanPlayerService teamLoanPlayerService;
	/**
	 * 租借球员详情
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="lookLoanPlayer")
	public String lookPlayer(HttpServletRequest request) {
		String user_id = BeanUtils.nullToString(request.getParameter("user_id"));
		AjaxMsg msg = playerInfoService.getPlayerInfoByUserId(user_id,false);
		request.setAttribute("dataMap", msg.getData("data"));
		return "team/player/player_loan";
	}
	
	/**
	 * 是否可以租借
	 * @param request
	 * @return
	 */
	@RequestMapping(value="ifLoan")
	@ResponseBody
	public String ifLoan(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String login_user_id = super.getUserId();
		String teaminfo_id = BeanUtils.nullToString(request.getParameter("teaminfo_id"));
		String user_id = BeanUtils.nullToString(request.getParameter("user_id"));
		if(StringUtils.isBlank(login_user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		}
		//判断是否俱乐部老板
		TeamInfo team = teamInfoService.getTeamInfoByUserId(login_user_id);
		if(team == null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nocaption")).toJson();
		}
		//判断当前登录用户俱乐部是否联赛俱乐部
		TeamLeague buyTeamLeague = leagueService.getTeamLeague(team.getId());
		if(buyTeamLeague == null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.unleagueteam")).toJson();
		}
		//判断球员所在俱乐部是否联赛俱乐部
		TeamLeague sellTeamLeague = leagueService.getTeamLeague(teaminfo_id);
		if(sellTeamLeague == null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.unleagueteam")).toJson();
		}
		//判断是否被挂牌
		TeamPlayer teamPlayer = teamInfoService.getTeamPlayerByUserId(user_id);
		if(teamPlayer != null){
			if(teamPlayer.getIs_sale() == 1){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.playersale")).toJson();
			}
		}
		//转会期是否开始
		String s_id  = BeanUtils.nullToString(sellTeamLeague.getS_id());
		MarketCfg marketCfg = leagueMarketService.getCurrentMarket(s_id);
		if(marketCfg != null){
			if(marketCfg.getIf_open() == 0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen")).toJson();
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen")).toJson();
		}
		//判断是否激活码中配置了租借
		String msgStr = teamLoanPlayerService.checkIfLoan(teaminfo_id, team.getId());
		if(null != msgStr){
			return AjaxMsg.newError().addMessage(msgStr).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 租借申请信息
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="loanApplication")
	public String loanApplication(HttpServletRequest request, PageModel pageModel){
		String type = request.getParameter("type");
		if(StringUtils.isBlank(type) || (!"1".equals(type) && !"2".equals(type))){
			request.setAttribute("info", messageResourceService.getMessage("system.error"));
			return "error/info";
		}
		String tid = request.getParameter("teaminfo_id");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("teaminfo_id", tid);
		AjaxMsg msg = teamLoanPlayerService.queryTeamLoanMsg(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		if("1".equals(type)){
			return "team/loan/my_lease";
		}else{
			return "team/loan/my_loan";
		}
	}
	
	/**
	 * 修改租借信息状态
	 * @param request
	 * @return
	 */
	@RequestMapping(value="loanManage")
	@ResponseBody
	public String loanManage(HttpServletRequest request){
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		AjaxMsg msg = AjaxMsg.newError();
		String errorMsg = messageResourceService.getMessage("system.error");
		if(StringUtils.isBlank(id) || StringUtils.isBlank(type) || (!"1".equals(type) && !"2".equals(type)&& !"3".equals(type))){
			return AjaxMsg.newError().addMessage(errorMsg).toJson();
		}
		try {
			TeamLoanMsg loanMsg = teamLoanPlayerService.getTeamLoanMsgById(id);
			if(loanMsg!=null){
				//检测信息是否失效或者已经处理
				long overTime = loanMsg.getOver_time().getTime();
				long nowTime = new Date().getTime();
				if(overTime>=nowTime&&loanMsg.getStatus()!=2){
					boolean flag = true;
					if("1".equals(type)){
						//判断出租球员是否挂牌到转会市场
						TeamPlayer teamPlayer = teamInfoService.getTeamPlayerByUserId(loanMsg.getUser_id());
						if(teamPlayer != null){
							if(teamPlayer.getIs_sale() == 1){
								msg = AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.playersale"));
								flag = false;
							}
						}
						//判断承租方余额
						UserAmount buyTeam = userAmountService.getUserAmountByTeamInfoID(loanMsg.getBuy_teaminfo_id());
						if(buyTeam.getReal_amount().compareTo(loanMsg.getPrice())<0){
							msg = AjaxMsg.newError().addMessage(messageResourceService.getMessage("team.amount.not_enough"));
							flag = false;
						}
					}
					if(flag){
						msg = teamLoanPlayerService.updateLoanManage(loanMsg,type);
					}
				}else{
					msg = AjaxMsg.newError().addMessage("信息已失效或者已处理！");
				}
			}
			return msg.toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(errorMsg).toJson();
		}
	}
	
	
	/**
	 * 发送租借消息
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="sendLoanMsg")
	@ResponseBody
	public String sendLoanMsg(HttpServletRequest request) {
		String login_user_id = this.getUserId();
		String user_id =  BeanUtils.nullToString(request.getParameter("user_id"));
		String price =  BeanUtils.nullToString(request.getParameter("price"));
		String end_time =  BeanUtils.nullToString(request.getParameter("end_time"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isBlank(login_user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		}
		try{
			TeamInfo buyTeam = teamInfoService.getTeamInfoByUserId(login_user_id);
			TeamPlayer sellTeamPlayer = teamInfoService.getTeamPlayerByUserId(user_id);
			TeamLeague sellTeamLeague = leagueService.getTeamLeague(sellTeamPlayer.getTeaminfo_id());
			MarketCfg marketCfg = leagueMarketService.getCurrentMarket(sellTeamLeague.getS_id());
			if(marketCfg != null){
				if(marketCfg.getIf_open() == 0){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen")).toJson();
				}
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen")).toJson();
			}
			if(Common.compareDates(Common.parseStringDate(end_time, "yyyy-MM-dd hh:mm:ss"),marketCfg.getEnd_time())){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("team.loan.endtime")).toJson();
			}
			if(new BigDecimal(price).compareTo(new BigDecimal(1000)) == -1){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("team.loan.unprice")).toJson();
			}
			
			TeamLoanMsg teamLoanMsg = new TeamLoanMsg();
			teamLoanMsg.setId(UUIDGenerator.getUUID());
			teamLoanMsg.setBuy_teaminfo_id(buyTeam.getId());
			teamLoanMsg.setLoan_teaminfo_id(sellTeamPlayer.getTeaminfo_id());
			teamLoanMsg.setEnd_time(Common.parseStringDate(end_time, "yyyy-MM-dd hh:mm:ss"));
			teamLoanMsg.setOver_time(marketCfg.getEnd_time());
			teamLoanMsg.setPrice(new BigDecimal(price));
			teamLoanMsg.setUser_id(user_id);
			teamLoanMsg.setCfg_id(marketCfg.getId());
			teamLoanMsg.setRemark("");
			msg = teamLoanPlayerService.saveLoanMsg(teamLoanMsg);
		}catch(Exception e){
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 撤销租借消息
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="cancelLoan")
	@ResponseBody
	public String cancelLoan(HttpServletRequest request) {
		String login_user_id = this.getUserId();
		String id =  BeanUtils.nullToString(request.getParameter("id"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isBlank(login_user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		}
		try{
			TeamLoanMsg teamLoanMsg = teamLoanPlayerService.getTeamLoanMsgById(id);
			if(null != teamLoanMsg){
				//消息已处理不可撤销
				if(teamLoanMsg.getStatus() == 2){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("team.loan.msgdeal")).toJson();
				}
			msg = teamLoanPlayerService.deleteTeamLoanMsg(id);
			}else{
				//消息不存在	
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("team.loan.nomsg")).toJson();
			}
		}catch(Exception e){
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 租借球员列表
	 * @autor ylt
	 * @parameter *
	 * @date2016-06-14下午3:48:45
	 */
	@RequestMapping(value="loanPlayerList")
	public String loanPlayerList(HttpServletRequest request,PageModel pageModel) {
		String teaminfo_id = BeanUtils.nullToString(request.getParameter("teaminfo_id"));
		Map<String,	Object> map = Maps.newHashMap();
		map.put("teaminfo_id", teaminfo_id);
		AjaxMsg msg = teamLoanPlayerService.queryForPageForMap(map, pageModel);
		request.setAttribute("team_players", msg.getData("page"));
		return "team/player/teamloanplayer";
	}
	
	
}
