package com.yt.framework.controller;

import java.math.BigDecimal;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamInvite;
import com.yt.framework.persistent.entity.TransferMsg;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.TransferMsg;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.BabyCheerService;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.ScheduleSmsService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.service.TeamLoanPlayerService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 *俱乐部比赛
 *@autor ylt
 *@date2015-8-13下午2:46:36
 */
@Controller
@RequestMapping(value="/teamInvite/")
public class TeamInviteController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(TeamInviteController.class);

	@Autowired
	private TeamInviteService teamInviteService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private BabyCheerService babyCheerService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private ScheduleSmsService scheduleSmsService;
	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private LeagueService leagueService;
	@Autowired 
	private LeagueMarketService leagueMarketService;
	@Autowired 
	private TeamLoanPlayerService teamLoanPlayerService;
	
	
	@RequestMapping(value="page")
	public String invitePage(Model model,HttpServletRequest request){
		String minDate = Common.formatDateY();
		Calendar c = Calendar.getInstance();
		c.setTime(Common.parseStringDate(minDate, "yyyy-MM-dd"));
		c.add(Calendar.DATE,6);  
        Date monday = c.getTime();
        String maxDate = Common.formatDate(monday, "yyyy-MM-dd");
        request.setAttribute("minDate", minDate);
        request.setAttribute("maxDate", maxDate);
		return "team/invite/invite_page";
	}
	
	@RequestMapping(value="list")
	public String teminvitelist(HttpServletRequest request){
		String teaminfo_id =  request.getParameter("teaminfo_id");
		request.setAttribute("teaminfo_id", teaminfo_id);
		return "team/invite/teaminvitelist";
	}
	
	/**
	 * 俱乐部邀请保存与更新
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-13下午5:26:52
	 */
	@RequestMapping(value="saveOrUpdate")
	public @ResponseBody String saveInvite(HttpServletRequest request,TeamInvite vi){
		String user_id = this.getUserId();
		if(null == user_id) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		if(null == vi.getTeaminfo_id()){
			TeamInfo t = teamInfoService.getTeamInfoByUserId(user_id);
			if(null != t){
				vi.setT_logo(t.getLogo());
				vi.setTeaminfo_id(t.getId());
				vi.setT_name(t.getName());
			}
		}
		AjaxMsg msg = AjaxMsg.newError();
		//added by gl 检测该俱乐部是否接受对战邀请
		TeamInfo resp_t = teamInfoService.getEntityById(vi.getRespond_teaminfo_id());
		if(resp_t.getIs_pk()!=1){
			return msg.addMessage("该俱乐部暂时不接受对战邀请！").toJson();
		}
		//added by gl
		//added by bo.xie 是否需要强制刷新页面	start
		String flush_page = request.getParameter("flush_page");
		if(vi.getInvite_time()==null || StringUtils.isBlank(vi.getPosition())){
			return msg.addMessage("比赛时间、比赛地点不能为空！").toJson();
		}
		//added by bo.xie 是否需要强制刷新页面	end
		if(vi.getTeaminfo_id().equals(vi.getRespond_teaminfo_id())){
			return msg.addMessage("不能自己挑战自己").toJson();
		}
		if(StringUtils.isBlank(vi.getId())){
			vi.setId(UUIDGenerator.getUUID());
			msg = teamInviteService.save(vi);
		}else{
			 msg = teamInviteService.update(vi);
		}
		
			if(msg.isSuccess()){//发送短信通知
				StringBuilder sb = new StringBuilder();
				String re_teaminfo_id = vi.getRespond_teaminfo_id();
				TeamInfo teamInfo = teamInfoService.getEntityById(re_teaminfo_id);
				User user = userService.getEntityById(teamInfo.getUser_id());
					if(StringUtils.isNotBlank(user.getPhone())&&user.getReceive_sms()==1){
					sb.append("@1@=").append(vi.getT_name()).append("邀请您于").append(Common.formatDate(vi.getInvite_time(), "yyyy-MM-dd"))
				 	  .append("进行一场").append(vi.getBall_format()).append("人制的比赛，");
					msg = SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880020.toString());
					if(msg.isError()) logger.error("挑战短信通知发送失败！user_id:"+user.getId()+"reson:"+msg.getErrorMessages());
				}
			}
		
		return msg.addData("flush_page", flush_page).toJson();
	}
	
	/**
	 * 俱乐部对战受邀信息列表
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-13下午5:26:52
	 */
	@RequestMapping(value="inviteListDatas")
	public @ResponseBody String inviteListDatas(HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		if(StringUtils.isBlank(teaminfo_id)) return AjaxMsg.newError().addMessage("球队不存在").toJson();
		AjaxMsg msg = teamInviteService.inviteList(teaminfo_id);
		System.out.println(msg.toJson());
		return msg.toJson();
	}
	
	/**
	 * 俱乐部对战受邀信息列表
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-7下午5:26:52
	 */
	@RequestMapping(value="listInvite/{toPage}")
	public String inviteListDatasPage(HttpServletRequest request,@PathVariable String toPage,PageModel pageModel){
		String teaminfo_id = request.getParameter("teaminfo_id");
		String pFlag = request.getParameter("pFlag");
		if(StringUtils.isBlank(teaminfo_id)) return AjaxMsg.newError().addMessage("球队不存在").toJson();
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isNotBlank(pFlag)){
			Map<String,Object> map = Maps.newHashMap();
			map.put("respond_teaminfo_id",teaminfo_id);
			msg = teamInviteService.queryForPage(map, pageModel);
			request.setAttribute("listInvite",msg.getData("page"));
		}else{
			msg = teamInviteService.inviteList(teaminfo_id);
			request.setAttribute("listInvite",msg.getData("listInvite"));
		}
		request.setAttribute("teaminfo_id",teaminfo_id);
		return "team/invite/"+toPage;
	}
	/**
	 * <p>Description:查询是否有俱乐部信息 </p>
	 * @Author zhangwei
	 * @Date 2015年12月9日 下午3:38:24
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="/queryNotReadTeamMsg")
	@ResponseBody
	public String queryNotReadTeamMsg(HttpServletRequest request,PageModel pageModel){
		String teaminfo_id = request.getParameter("teaminfo_id");
		if(StringUtils.isBlank(teaminfo_id)) return AjaxMsg.newError().addMessage("球队不存在").toJson();
		/*PK邀请**/
		Map<String,Object> map = Maps.newHashMap();
		map.put("respond_teaminfo_id",teaminfo_id);
		map.put("status", 2);//约战中
		AjaxMsg msg = teamInviteService.queryForPage(map, pageModel);
		PageModel  teamInviteDate = (PageModel) msg.getData("page");
		int teamInviteCount = teamInviteDate.getTotalCount();
		/*入队申请**/
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("teaminfo_id", teaminfo_id);
		maps.put("status", "0");//申请中
	    AjaxMsg msg1 = teamInfoService.loadAllTeamApplys(maps, pageModel); 
		PageModel  teamApplyDate = (PageModel) msg1.getData("page");
		int teamApplyCount = teamApplyDate.getTotalCount();
		/*工资消息**/
		Map<String,Object> tmaps = Maps.newHashMap();
		tmaps.put("teaminfo_id", teaminfo_id);
		tmaps.put("is_send", 1);
		int teamMsgCount = teamInfoService.loadAllTeamMsgCount(tmaps);
		/*转会消息**/
		Map<String,Object> tzhMap = Maps.newHashMap();
		tzhMap.put("teaminfo_id", teaminfo_id);
		tzhMap.put("type", "2");
		tzhMap.put("status", "0");
		int teamTmarketCount = teamInviteService.transferMarketCount(tzhMap);
		/*租借消息**/
		Map<String,Object> tloanMap = Maps.newHashMap();
		tloanMap.put("teaminfo_id", teaminfo_id);
		tloanMap.put("type", "1");
		tloanMap.put("status", "1");
		int teamLoanCount = teamLoanPlayerService.teamLoanMsgCount(tloanMap);
	    int msgCount = teamInviteCount + teamApplyCount + teamMsgCount + teamLoanCount+teamTmarketCount;
	    
	    Map<String,Object> mapMsg = Maps.newHashMap();
	    mapMsg.put("teamMsgCount", teamMsgCount);
	    mapMsg.put("teamInviteCount", teamInviteCount);
	    mapMsg.put("teamApplyCount", teamApplyCount);
	    mapMsg.put("teamLoanCount", teamLoanCount);
	    mapMsg.put("teamTmarketCount", teamTmarketCount);
	    mapMsg.put("count", msgCount);
		return AjaxMsg.toJson(mapMsg);
	}
	/**
	 * 俱乐部接收或拒绝约战
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-13下午5:26:52
	 */
	@RequestMapping(value="acceptOrRefuseInvite")
	public @ResponseBody String acceptOrRefuseInvite(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String id =  request.getParameter("id"); // 约战比赛id
		String status = request.getParameter("status"); // 约战比赛状态
		String teaminfo_id = request.getParameter("teaminfo_id"); // 主队id
		String respond_teaminfo_id = request.getParameter("respond_teaminfo_id"); // 受邀对手id
		if(StringUtils.isBlank(teaminfo_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.noteam")).toJson();
		//更新约战状态
		try{
			msg = teamInviteService.updateInvite(id,Integer.parseInt(status),
					teaminfo_id,respond_teaminfo_id);
		}catch(Exception e){
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
		}
		if(msg.isSuccess()){
			msg.addMessage(messageResourceService.getMessage("system.success"));
		}
		System.out.println(msg.toJson());
		return msg.toJson();
	}
	 
	/**
	 * 俱乐部历史对战信息列表
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-13下午5:26:52
	 */
	@RequestMapping(value="history/{toPage}")
	public String historyGameList(HttpServletRequest request,PageModel pageModel,@PathVariable String toPage){
		String teaminfo_id = request.getParameter("teaminfo_id");
		if(StringUtils.isBlank(teaminfo_id)) return AjaxMsg.newError().addMessage("球队不存在").toJson();
		AjaxMsg msg = teamInviteService.historyGameMap(teaminfo_id,new Integer(1),pageModel);
		//AjaxMsg msg = teamInviteService.historyGameList(teaminfo_id,pageModel);
		request.setAttribute("history", msg.getData("data"));
		request.setAttribute("teaminfo_id",teaminfo_id);
		return "team/history/"+toPage;
	}
	
	/**
	 * 俱乐部当前对战信息
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午5:26:52
	 */
	@RequestMapping(value="game/{toPage}")
	public String currentGame(HttpServletRequest request,@PathVariable String toPage){
		String teaminfo_id = request.getParameter("teaminfo_id");
		String user_id = request.getParameter("user_id");
		if(StringUtils.isBlank(teaminfo_id)) return AjaxMsg.newError().addMessage("球队不存在").toJson();
		AjaxMsg msg = teamInviteService.currentGame(teaminfo_id);
		TeamGame teamGame = (TeamGame)msg.getData("teamGame");
		if(null != teamGame && null != teamGame.getId()){
			AjaxMsg babymsg = babyCheerService.getByBabyByGame(teamGame.getId(), teaminfo_id);
			request.setAttribute("babys", babymsg.getData("babys"));
		}
		request.setAttribute("teamGame", msg.getData("teamGame"));
		request.setAttribute("teaminfo_id", teaminfo_id);
		request.setAttribute("user_id", user_id);
		return "team/game/"+toPage;
	}
	
	/**
	 * 上传比赛页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-7下午5:10:27
	 */
	@RequestMapping(value="resultPage")
	public String uploadResultPage(Model model,HttpServletRequest request){
		String team_id = request.getParameter("team_id");
		List<TeamGame> games = teamInviteService.loadTeamGameByTeamId(team_id);
		model.addAttribute("games", games);
		model.addAttribute("team_id", team_id);
		return "team/team_result";
		
	}
	
	/**
	 * 录入比分页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="newResultPage")
	public String updateNewResultPage(Model model,HttpServletRequest request){
		String id = request.getParameter("id");//比赛记录ID
		String teaminfo_id = request.getParameter("teaminfo_id");//比赛记录ID
		TeamGame games = teamInviteService.loadTeamGameById(id);
		model.addAttribute("games", games);
		model.addAttribute("teaminfo_id", teaminfo_id);
		return "team/new_team_result";
	}
	
	/**
	 * 判断是否有未上传比赛记录
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-23上午11:31:44
	 */
	@RequestMapping(value="haveResult")
	public @ResponseBody String haveResultRecord(HttpServletRequest request){
		String team_id = request.getParameter("team_id");
		List<TeamGame> games = teamInviteService.loadTeamGameByTeamId(team_id);
		return AjaxMsg.newSuccess().addData("size", games.size()).toJson();
	}
	
	/**
	 * 判断是否有未上传比赛记录
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-23上午11:31:44
	 */
	@RequestMapping(value="ifPk")
	public @ResponseBody String ifPk(HttpServletRequest request){
		String team_id = request.getParameter("teaminfo_id");
		AjaxMsg msg = teamInviteService.currentGame(team_id);
		TeamGame teamGame = (TeamGame)msg.getData("teamGame");
		if(null != teamGame && null != teamGame.getId()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.ingame")).toJson();
		return msg.toJson();
	}
	
	
	/**
	 * 上传比赛结果
	 *@param request
	 *@param tg()
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午5:26:52
	 */
	@RequestMapping(value="uploadResult")
	public @ResponseBody String uploadResult(HttpServletRequest request,TeamGame tg){
		//update by bo.xie
		String teaminfo_id = request.getParameter("teaminfo_id");
		AjaxMsg msg = AjaxMsg.newError(); 
		if(tg == null || StringUtils.isBlank(tg.getId())) return AjaxMsg.newError().addMessage("比赛记录不存在").toJson();
		try{
			msg = teamInviteService.uploadResult(tg,teaminfo_id);
			if(msg.isSuccess()){
				String teamGame_id = tg.getId();
				if(StringUtils.isNotBlank(teamGame_id)){
					scheduleSmsService.deleteScheduleSmsByTeamGameId(teamGame_id);
				}
			}
		}catch(Exception e){	
			e.printStackTrace();
			return AjaxMsg.newError().addMessage("更新结果异常").toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 比赛结果确认
	 *@param request
	 *@param 
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午5:26:52
	 */
	@RequestMapping(value="checkResult")
	public @ResponseBody String checkResult(HttpServletRequest request){
		String id = request.getParameter("id");
		String teaminfo_id = request.getParameter("teaminfo_id");
		String status = request.getParameter("status");
		AjaxMsg msg = AjaxMsg.newError(); 
		if(StringUtils.isBlank(id)) return AjaxMsg.newError().addMessage("比赛不存在").toJson();
		try{
			msg = teamInviteService.checkResult(id,teaminfo_id,Integer.parseInt(status));
		}catch(Exception e){	
			e.printStackTrace();
			return AjaxMsg.newError().addMessage("更新结果异常").toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * pk对战邀请
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午5:26:52
	 */
	@RequestMapping(value="pklist")
	public String pklist(HttpServletRequest request){
//		String teaminfo_id = request.getParameter("teaminfo_id");
//		TeamInfo teamInfo = teamInfoService.getEntityById(teaminfo_id);
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(getUserId());
		request.setAttribute("teamInfo", teamInfo);
		return "team/invite/pklist";
	}
	
	/**
	 * 获取比赛信息
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter 
	 *@date2015-8-14下午5:26:52
	 */
	@RequestMapping(value="gameInfo")
	@ResponseBody
	public String gameInfo(HttpServletRequest request){
		String id = request.getParameter("id");
		TeamGame teamGame = teamInviteService.loadTeamGameById(id);
		if(null == teamGame) return AjaxMsg.newError().toJson();
		return AjaxMsg.newSuccess().addData("teamGame", teamGame).toJson();
	}
	
	/**
	 * 俱乐部受邀列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value="msg")
	public String inviteMsgPage(Model model,HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		model.addAttribute("teaminfo_id", teaminfo_id);
		return "team/invite/msg";
	}
	
	@RequestMapping(value="teamApply")
	public String teamApply(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String teaminfo_id = request.getParameter("teaminfo_id");
		maps.put("teaminfo_id", teaminfo_id);
		AjaxMsg msg = teamInfoService.loadAllTeamApplys(maps, pageModel); 
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "team/invite/team_apply";
	}
	
	@RequestMapping(value="agreenApply")
	public @ResponseBody String agreeApply(HttpServletRequest request) throws Exception{
		String teaminfo_id = request.getParameter("teaminfo_id");
		String user_id = request.getParameter("user_id");
		String type = request.getParameter("type");
		return teamInfoService.agreeTeamApply(teaminfo_id, user_id, type).toJson();
	}
	
	/**
	 * 工资列表信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="salary_list")
	public String salaryList(Model model,HttpServletRequest request,PageModel pageModel){
		String teaminfo_id = request.getParameter("teaminfo_id");
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("teaminfo_id", teaminfo_id);
		maps.put("is_send", 1);
		AjaxMsg msg = teamInfoService.loadAllTeamMsg(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "league/salary_list";
	}
	
	
	/**
	 * 转会交易
	 * @param request
	 * @return
	 */
	@RequestMapping(value="transferMarket")
	public String transferMarket(HttpServletRequest request,PageModel pageModel){
		String teaminfo_id = request.getParameter("teaminfo_id");
		String type = request.getParameter("type");
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("type", type);
		maps.put("teaminfo_id", teaminfo_id);
		AjaxMsg msg = teamInviteService.queryTransferMarket(maps, pageModel); 
		if(msg.isSuccess()){
			request.setAttribute("page", msg.getData("page"));
		}
		request.setAttribute("params", maps);
		return "team/invite/transfer_market";
	}
	
	@RequestMapping(value="updateMsg")
	@ResponseBody
	public String updateMsg(HttpServletRequest request){
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		String userId = getUserId();
		TeamInfo team = teamInfoService.getTeamInfoByUserId(userId);
		if(team==null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nocaption")).toJson();
		}
		AjaxMsg msg = AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		try {
			msg = teamInviteService.updateTransferMsg(id,type,team);
		} catch (Exception e) {
			logger.error(e);
		}
		return msg.toJson();
	}
	
	/**
	 * 是否可以购买
	 * @param request
	 * @return
	 */
	@RequestMapping(value="ifBuy")
	@ResponseBody
	public String ifBuy(HttpServletRequest request){
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
		//是否符合转会条件
		String msgStr = teamInviteService.checkIfTransfer(teaminfo_id, team.getId());
		if(null != msgStr){
			return AjaxMsg.newError().addMessage(msgStr).toJson();
		}
		//判断是否被挂牌
		TeamPlayer teamPlayer = teamInfoService.getTeamPlayerByUserId(user_id);
		if(teamPlayer != null){
			if(teamPlayer.getIs_sale() == 1){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.playersale")).toJson();
			}
		}
		
		return msg.toJson();
	}
	
	/**
	 * 求购球员详情
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="lookPlayer")
	public String lookPlayer(HttpServletRequest request) {
		String user_id = BeanUtils.nullToString(request.getParameter("user_id"));
		AjaxMsg msg = playerInfoService.getPlayerInfoByUserId(user_id,false);
		request.setAttribute("dataMap", msg.getData("data"));
		return "team/player/player_info";
	}
	
	/**
	 * 发送邀请消息
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="sendTransferMsg")
	@ResponseBody
	public String sendTransferMsg(HttpServletRequest request) {
		String login_user_id = this.getUserId();
		String user_id =  BeanUtils.nullToString(request.getParameter("user_id"));
		String price =  BeanUtils.nullToString(request.getParameter("price"));
		if(StringUtils.isBlank(login_user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		}
		TeamInfo buyTeam = teamInfoService.getTeamInfoByUserId(login_user_id);
		TeamPlayer sellTeamPlayer = teamInfoService.getTeamPlayerByUserId(user_id);
		AjaxMsg msg = AjaxMsg.newSuccess();
		try{
			TransferMsg transferMsg = new TransferMsg();
			transferMsg.setId(UUIDGenerator.getUUID());
			transferMsg.setBuy_teaminfo_id(BeanUtils.nullToString(buyTeam.getId()));
			transferMsg.setSell_teaminfo_id(BeanUtils.nullToString(sellTeamPlayer.getTeaminfo_id()));
			transferMsg.setIf_ok(0);
			transferMsg.setPrice(new BigDecimal(price));
			transferMsg.setRemark("");
			transferMsg.setUser_id(user_id);
			transferMsg.setStatus(0);
			msg = teamInviteService.saveTransferMsg(transferMsg);
			
		}catch(Exception e){
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 撤销邀请消息
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="cancelBuy")
	@ResponseBody
	public String cancelBuy(HttpServletRequest request) {
		String login_user_id = this.getUserId();
		String id =  BeanUtils.nullToString(request.getParameter("id"));
		if(StringUtils.isBlank(login_user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
		}
		TeamInfo buyTeam = teamInfoService.getTeamInfoByUserId(login_user_id);
		AjaxMsg msg = AjaxMsg.newSuccess();
		try{
			TransferMsg transferMsg = teamInviteService.getTransferMsg(id);
			if(null != transferMsg){
				if(transferMsg.getStatus() == 0){
					msg = teamInviteService.deleteTransferMsg(id);
				}
			}else{
				msg.addMessage(messageResourceService.getMessage("system.success"));
			}
		}catch(Exception e){
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
}
