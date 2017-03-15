package com.yt.framework.service.Impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.Fee;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.MarketRecords;
import com.yt.framework.persistent.entity.Order;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.PriceSlave;
import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.persistent.entity.TeamGameBaby;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamInvite;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamLoanMsg;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.TeamSale;
import com.yt.framework.persistent.entity.TransferMsg;
import com.yt.framework.persistent.entity.TransferRecord;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.persistent.enums.SystemEnum.MSGTYPE;
import com.yt.framework.persistent.enums.SystemEnum.SYSTYPE;
import com.yt.framework.service.AutoInfoMationService;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 *俱乐部对战
 *@autor ylt
 *@date2015-8-3下午3:31:47
 */
@Transactional
@Service("teamInviteService")
public class TeamInviteServiceImpl extends BaseServiceImpl<TeamInvite> implements TeamInviteService {
	
	private static Logger logger = LogManager.getLogger(TeamInviteServiceImpl.class.getName());
	
	@Autowired 
	TeamInfoService teamInfoService;
	@Autowired 
	DynamicService dynamicService;
	@Autowired 
	MessageResourceService messageResourceService;
	@Autowired
	AutoInfoMationService autoInfoMationService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private LeagueMarketService leagueMarketService;
	
	@Override
	public AjaxMsg updateInvite(String id, Integer status,String teaminfo_id,String respond_teaminfo_id)throws Exception {
			AjaxMsg msg = AjaxMsg.newSuccess();
			TeamInvite teamInvite = teamInviteMapper.getEntityById(id);
			if(teamInvite == null) return AjaxMsg.newError().addMessage("约战记录不存在"); 
			TeamInfo t = teamInfoService.getEntityById(teaminfo_id);
			TeamInfo rt = teamInfoService.getEntityById(respond_teaminfo_id);
			//约战比赛成功时将其余比赛全部改为失败状态
			if(status.intValue() == 1){
				if(teamInvite.getStatus() == 0){
					return AjaxMsg.newError().addMessage("改约战记录状态已失败");  
				}
				//调用存储过程 更新双方记录并生成比赛预告数据
				Map maps = Maps.newHashMap();
				try {
					maps = BeanUtils.object2Map(teamInvite);
				} catch (Exception e) {
					e.printStackTrace();
					return AjaxMsg.newError().addMessage("改约战记录状态已失败");  
				}
				maps.put("game_id",UUIDGenerator.getUUID());
				teamInviteMapper.updateInviteByProcedure(maps); 
				//俱乐部比赛更新状态并保存动态消息
				msg = messageResourceService.saveTeamDynamicMessage(new Object[]{teamInvite.getT_name(),teamInvite.getR_name(),
						Common.formatDate(teamInvite.getInvite_time(),"yyyy-MM-dd hh:mm:ss"),teamInvite.getPosition(),t.getUser_id(),rt.getUser_id()} , "team.game.info", teaminfo_id);
				//发送队长接收消息
				msg = messageResourceService.saveMessageNoReply(new Object[]{teamInvite.getR_name()},
						"user.caption.agreepk", t.getUser_id(), t.getUser_id(),1);
				//广场推送消息
				msg = autoInfoMationService.sendInfo(t.getUser_id(), t.getUser_id(), MSGTYPE.INDEX.toString(), SYSTYPE.TAPK.toString(), 
						messageResourceService.getMessage(new Object[]{teamInvite.getT_name(),teamInvite.getR_name(),
								Common.formatDate(teamInvite.getInvite_time(),"yyyy-MM-dd hh:mm:ss"),teamInvite.getPosition(),
								teamInvite.getTeaminfo_id(),teamInvite.getRespond_teaminfo_id()} , "square.game.info"));
				//added by bo.xie 写入计划任务发送短信通知记录
				TeamInfo teamInfo = teamInfoService.getEntityById(teaminfo_id);
				User user = userMapper.getEntityById(teamInfo.getUser_id());
				String phone = user.getPhone();
				if(StringUtils.isNotBlank(phone)){
					Map<String,Object> params = Maps.newHashMap();
					params.put("phone", phone);
					params.put("teamgame_id", maps.get("game_id"));
					params.put("team_name", teamInvite.getR_name());
					params.put("play_time", teamInvite.getInvite_time());
					scheduleSmsMapper.saveScheduleSMS(params);
					
					//added by bo.xie 同意约战,发送短信通知对方
					if(user.getReceive_sms()==1){
						StringBuilder sb = new StringBuilder();
						sb.append("@1@=").append(teamInvite.getR_name()).append(",@2@=").append(Common.formatDate(teamInvite.getInvite_time(), "yyyy-MM-dd"))
						.append(",@3@=").append(teamInvite.getPosition());
						AjaxMsg re_msg =SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880021.toString());
						if(re_msg.isError()) logger.error("同意约战短信通知发送失败！user_id="+user.getId()+",reson:"+re_msg.getErrorMessages());
					}
				}
			}else{
				teamInviteMapper.updateInvite(id,status);
				msg = messageResourceService.saveMessageNoReply(new Object[]{teamInvite.getR_name()},
						"user.caption.refusepk", t.getUser_id(), t.getUser_id(),1);
			}
			
		return msg;
	}
	
	/*public static void main(String[] args) {
		AjaxMsg msg = SendMsg.getInstance().sendSMS("18180212336", "测试", null);
		System.out.println(msg.toJson());
	}*/
	
	@Override
	public AjaxMsg updateInviteByMsg(String invite_id,Integer status)throws Exception {
			AjaxMsg msg = AjaxMsg.newSuccess();
			TeamInvite teamInvite = teamInviteMapper.getEntityById(invite_id);
			TeamInfo t = teamInfoMapper.getEntityById(teamInvite.getTeaminfo_id());
			if(teamInvite == null) return AjaxMsg.newError().addMessage("约战记录不存在"); 
			//约战比赛成功时将其余比赛全部改为失败状态
			if(status.intValue() == 1){
				if(teamInvite.getStatus() == 0){
					return AjaxMsg.newError().addMessage("改约战记录状态已失败");  
				}
				//调用存储过程 更新双方记录并生成比赛预告数据
				Map<String,Object> maps = Maps.newHashMap();
				maps = BeanUtils.object2Map(teamInvite);
				maps.put("game_id",UUIDGenerator.getUUID());
				teamInviteMapper.updateInviteByProcedure(maps); 
				//俱乐部比赛更新状态并保存动态消息
				msg = messageResourceService.saveTeamDynamicMessage(new Object[]{teamInvite.getT_name(),teamInvite.getR_name(),
						Common.formatDate(teamInvite.getInvite_time(),"yyyy-MM-dd hh:mm:ss"),teamInvite.getPosition()} ,
						"square.game.info", teamInvite.getTeaminfo_id());
				//发送队长接收消息
				msg = messageResourceService.saveMessageNoReply(new Object[]{teamInvite.getR_name()},
						"user.caption.agreepk", t.getUser_id(), t.getUser_id(),1);
				
				//added by bo.xie 写入计划任务发送短信通知记录
				User user = teamInfoMapper.getCaption(teamInvite.getTeaminfo_id());
				String phone = user.getPhone();
				if(StringUtils.isNotBlank(phone)){
					Map<String,Object> params = Maps.newHashMap();
					params.put("phone", phone);
					params.put("teamgame_id", maps.get("game_id"));
					params.put("team_name", teamInvite.getR_name());
					params.put("play_time", teamInvite.getInvite_time());
					scheduleSmsMapper.saveScheduleSMS(params);
					
					//added by bo.xie 同意约战,发送短信通知对方
					if(user.getReceive_sms()==1){
						StringBuilder sb = new StringBuilder();
						sb.append("@1@=").append(teamInvite.getR_name()).append(",@2@=").append(Common.formatDate(teamInvite.getInvite_time(), "yyyy-MM-dd"))
						.append(",@3@=").append(teamInvite.getPosition());
						AjaxMsg re_msg =SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880021.toString());
						if(re_msg.isError()) logger.error("同意约战短信通知发送失败！user_id="+user.getId()+",reson:"+re_msg.getErrorMessages());
					}
				}
			}else{
				teamInviteMapper.updateInvite(teamInvite.getId(),status);
				msg = messageResourceService.saveMessageNoReply(new Object[]{teamInvite.getR_name()},
						"user.caption.refusepk", t.getUser_id(), t.getUser_id(),1);
			}
			
		return AjaxMsg.newSuccess();
	}

	
	
	@Override
	public AjaxMsg inviteList(String teaminfo_id) {
		List<TeamInvite> listInvite = Lists.newArrayList();
		listInvite = teamInviteMapper.inviteList(teaminfo_id);
		return AjaxMsg.newSuccess().addData("listInvite", listInvite);
	}
	
	@Override
	public AjaxMsg historyGameList(String teaminfo_id,PageModel pageModel) {
		List<TeamGame> teamGameList = Lists.newArrayList();
		Map<String,Object> params = Maps.newHashMap();
		params.put("teaminfo_id", teaminfo_id);
		int count = 0 ;
		if(pageModel!=null){
			count = teamInviteMapper.countHistory(params);
			pageModel.setTotalCount(count);
			params.put("start",pageModel.getFirstNum());
			params.put("rows",pageModel.getPageSize());
		}
		teamGameList = teamInviteMapper.historyGameList(params);
		pageModel.setItems(teamGameList);
		return AjaxMsg.newSuccess().addData("data", pageModel);
	}
	
	@Override
	public AjaxMsg currentGame(String teaminfo_id) {
		TeamGame teamGame = new TeamGame();
		teamGame = teamInviteMapper.currentGame(teaminfo_id);
		return AjaxMsg.newSuccess().addData("teamGame", teamGame);
	}
	
	@Override
	public AjaxMsg allMatchGame(String teaminfo_id){
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		Map<String,Object> params = Maps.newHashMap();
		params.put("teaminfo_id", teaminfo_id);
		datas = teamInviteMapper.allMatchGame(params);
		return AjaxMsg.newSuccess().addData("matchGames", datas);
	}

	@Override
	public AjaxMsg uploadResult(TeamGame tg,String teaminfo_id)throws Exception{
		//上传比赛记录前查询该条记录是否在确认状态，若在确认状态提示用户不可以上传
		TeamGame teamGame = teamInviteMapper.getTeamGameById(tg.getId());
		if(teamGame == null) return AjaxMsg.newError().addMessage("比赛不存在");
		if(teamGame != null && teamGame.getStatus().intValue() == 3) return AjaxMsg.newError().addMessage("该比赛结果对方已上传，请等待确认！");
		TeamInfo r_t = teamInfoMapper.getEntityById(teamGame.getRespond_teaminfo_id());
		TeamInfo i_t = teamInfoMapper.getEntityById(teamGame.getInitiate_teaminfo_id());
		
		String user_id = "" ; //发送用户
		String s_user_id = ""; //接收用户
		String t_name = ""; //上传俱乐部名称
		Date date = teamGame.getGame_time();//比赛时间
		String now_tr = Common.formatDateY();
		Date now = Common.parseStringDate(now_tr, "yyyy-MM-dd");
		if(now.getTime()<date.getTime())return AjaxMsg.newError().addMessage("比赛未开始不能上传比赛结果");
//		Boolean flag = Common.compareDates(date, now);
//		if(!flag) return AjaxMsg.newError().addMessage("只能在比赛结束日之后上传比赛结果");
		teamGame.setStatus(3);
		teamGame.setInitiate_score(tg.getInitiate_score());
		teamGame.setRespond_score(tg.getRespond_score());
		if(teamGame.getInitiate_teaminfo_id().equals(teaminfo_id)){//邀请方
			teamGame.setInitiate_sure(1);
			teamGame.setRespond_sure(0);
			user_id = r_t.getUser_id();
			s_user_id = i_t.getUser_id();
			t_name = teamGame.getT_name();
		}else if(teamGame.getRespond_teaminfo_id().equals(teaminfo_id)){//被邀请方
			teamGame.setRespond_sure(1);
			teamGame.setInitiate_sure(0);
			user_id = i_t.getUser_id();
			s_user_id = r_t.getUser_id();
			t_name = teamGame.getR_name();
		}
		teamInviteMapper.updateTeamGame(teamGame);
		//发送给确认方上传比分消息。
		messageResourceService.saveMessage(new Object[]{t_name}, SystemEnum.SYSTYPE.TSCORE.toString(),
				"team.game.upload", user_id, teaminfo_id, teamGame.getId(),3);
		//发送短信通知
//		if(r_t.getUser_id().equals(Common.getCurrentSessionValue(Common.getServletRequest(), "session_user_id"))){
//			
//		}else if(i_t.getUser_id().equals(Common.getCurrentSessionValue(Common.getServletRequest(), "session_user_id"))){
//			
//		}
		
		StringBuilder sb = new StringBuilder();
		User user = userMapper.getEntityById(user_id);
		String phoneNum = user.getPhone();
		if(StringUtils.isNotBlank(phoneNum)&&user.getReceive_sms()==1){
			sb.append("@1@=").append(t_name);
			AjaxMsg msg = SendMsg.getInstance().sendSMS(phoneNum,sb.toString(), SMSTEMP.JSM405880022.toString());
			if(msg.isError()) logger.error("比赛上传结果短信通知发送失败 user_id="+user.getId()+",reson:"+msg.getErrorMessages());
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg checkResult(String id, String teaminfo_id, Integer status) throws Exception {
		AjaxMsg msg = AjaxMsg.newSuccess();
		TeamGame teamGame = teamInviteMapper.getTeamGameById(id);
		if(teamGame == null) return AjaxMsg.newError().addMessage("比赛不存在");
		String initiate_teaminfo_id =  teamGame.getInitiate_teaminfo_id();
		String respond_teaminfo_id = teamGame.getRespond_teaminfo_id();
		String t_name = "";// 发送通知消息的俱乐部名称
		String user_id = null ; //发送用户
		String s_user_id = null; //接收用户
		TeamInfo initiate_t = teamInfoMapper.getEntityById(initiate_teaminfo_id);
		TeamInfo respond_t = teamInfoMapper.getEntityById(respond_teaminfo_id);
		//同意比分
		if(status.intValue() == 1){
			//判断邀请方和受邀方并确认
			if(initiate_teaminfo_id.equals(teaminfo_id)){
				int i_sure = teamGame.getInitiate_sure();
				if(i_sure == 1)return AjaxMsg.newError().addMessage("不能确认自己上传的比赛结果");
				teamGame.setInitiate_sure(new Integer(1));
				t_name = initiate_t.getName();
				user_id = respond_t.getUser_id();
				s_user_id = initiate_t.getUser_id();
			}else if(respond_teaminfo_id.equals(teaminfo_id)){
				int r_sure = teamGame.getRespond_sure();
				if(r_sure == 1)return AjaxMsg.newError().addMessage("不能确认自己上传的比赛结果");
				teamGame.setRespond_sure(new Integer(1));
				t_name = respond_t.getName();
				user_id = initiate_t.getUser_id();
				s_user_id = respond_t.getUser_id();
			}
			//球队比分胜负关系
			if(teamGame.getInitiate_score() < teamGame.getRespond_score()){ //主队负
				initiate_t.setLoss_count(initiate_t.getLoss_count()+new Integer(1));
				respond_t.setWin_count(respond_t.getWin_count()+new Integer(1));
				teamGame.setInitiate_win(new Integer(0));
				//added gl 俱乐部活跃度
				initiate_t = teamInfoService.editTeamScore(initiate_t,"10");
				respond_t = teamInfoService.editTeamScore(respond_t,"50");
				//added gl
			}else if(teamGame.getInitiate_score() > teamGame.getRespond_score()){//主队胜
				initiate_t.setWin_count(initiate_t.getWin_count()+new Integer(1));
				respond_t.setLoss_count(respond_t.getLoss_count()+new Integer(1));
				teamGame.setInitiate_win(new Integer(1));
				//added gl 俱乐部活跃度
				initiate_t = teamInfoService.editTeamScore(initiate_t,"50");
				respond_t = teamInfoService.editTeamScore(respond_t,"10");
				//added gl
			}else{//平局
				initiate_t.setDraw_count(initiate_t.getDraw_count()+1);
				respond_t.setDraw_count(respond_t.getDraw_count()+1);
				teamGame.setInitiate_win(new Integer(2));
				//added gl 俱乐部活跃度
				initiate_t = teamInfoService.editTeamScore(initiate_t,"25");
				respond_t = teamInfoService.editTeamScore(respond_t,"25");
				//added gl
			}
			initiate_t.setSumballs(initiate_t.getSumballs()+teamGame.getInitiate_score());
			respond_t.setSumballs(respond_t.getSumballs()+teamGame.getRespond_score());
			//更新双方球队比赛数据
			teamInfoMapper.update(initiate_t); 
			teamInfoMapper.update(respond_t);
			
			//保存比赛结果动态
			messageResourceService.saveTeamDynamicMessage(new Object[]{teamGame.getT_name(),teamGame.getR_name(),
					teamGame.getInitiate_score(),teamGame.getRespond_score(),
					user_id,s_user_id,
					teamGame.getGame_time(),teamGame.getPosition()} , "square.game.result", initiate_t.getId());
			//发送比分确认消息给对方
			messageResourceService.saveMessageNoReply(new Object[]{t_name}, "team.game.agreeresult", user_id, s_user_id,1);
			//广场推送消息
			autoInfoMationService.sendInfo(user_id, s_user_id, MSGTYPE.INDEX.toString(), SYSTYPE.TAPK.toString(), 
					messageResourceService.getMessage(new Object[]{teamGame.getT_name(),teamGame.getR_name(),
							teamGame.getInitiate_score(),teamGame.getRespond_score(),
							user_id,s_user_id,
							teamGame.getGame_time(),teamGame.getPosition()} , "square.game.result"));
			//added by bo.xie 发送短信通知
			StringBuilder sb = new StringBuilder();
			sb.append("@1@=").append(teamGame.getT_name());
			//String user_id = initiate_t.getUser_id();
			User user = userMapper.getEntityById(user_id);
			if(StringUtils.isNotBlank(user.getPhone())&&user.getReceive_sms()==1){
				 msg = SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880024.toString());
				if(msg.isError()) logger.error("确认上传比分短信通知发送失败！user_id="+user.getId()+",reson:"+msg.getErrorMessages());
			}
		}else{ //不同意比分
			//判断邀请方和受邀方并确认
			if(initiate_teaminfo_id.equals(teaminfo_id)){
				int i_sure = teamGame.getInitiate_sure();
				if(i_sure == 1)return AjaxMsg.newError().addMessage("不能拒绝自己上传的比赛结果");
				t_name = initiate_t.getName();
				user_id = respond_t.getUser_id();
				s_user_id = initiate_t.getUser_id();
			}else if(respond_teaminfo_id.equals(teaminfo_id)){
				int r_sure = teamGame.getRespond_sure();
				if(r_sure == 1)return AjaxMsg.newError().addMessage("不能拒绝自己上传的比赛结果");
				t_name = respond_t.getName();
				user_id = initiate_t.getUser_id();
				s_user_id = respond_t.getUser_id();
			}
			status = new Integer(0);
			teamGame.setInitiate_sure(new Integer(0));
			teamGame.setRespond_sure(new Integer(0));
			messageResourceService.saveMessageNoReply(new Object[]{t_name}, "team.game.refuseresult", user_id, s_user_id,1);
		}
		teamGame.setStatus(status);
		teamInviteMapper.updateTeamGame(teamGame);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));		
	}

	@Override
	public List<Map<String, Object>> queryHotGameList(Map<String,Object> maps) {
		List<Map<String, Object>> datas = teamInviteMapper.queryHotGame(maps);
		return datas;
	}

	@Override
	public List<TeamGame> loadTeamGameByTeamId(String team_id) {
		return teamInviteMapper.loadTeamGameByTeamId(team_id);
		
	}

	@Override
	public TeamInvite getInviteByTeam(String teaminfo_id, String respond_teaminfo_id) {
		return teamInviteMapper.getInviteByTeam(teaminfo_id, respond_teaminfo_id);
		
	}

	@Override
	public int queryHotGameCount(Map<String, Object> maps) {
		return teamInviteMapper.queryHotGameCount(maps);
		
	}

	@Override
	public TeamGame loadTeamGameById(String id) {
		return teamInviteMapper.loadTeamGameById(id);
	}

	@Override
	public AjaxMsg historyGameMap(String teaminfo_id,Integer status ,PageModel pageModel) {
		List<TeamGameBaby> teamGameList = Lists.newArrayList();
		Map<String,Object> params = Maps.newHashMap();
		params.put("teaminfo_id", teaminfo_id);
		params.put("status", status);
		int count = 0 ;
		if(pageModel!=null){
			count = teamInviteMapper.countHistory(params);
			pageModel.setTotalCount(count);
			params.put("start",pageModel.getFirstNum());
			params.put("rows",pageModel.getPageSize());
		}
		teamGameList = teamInviteMapper.historyGameMap(params);
		pageModel.setItems(teamGameList);
		return AjaxMsg.newSuccess().addData("data", pageModel);
	}

	@Override
	public List<TeamGame> getAllTeamGameByDate(Date date) {
		return teamInviteMapper.getAllTeamGameByDate(date);
	}

	@Override
	public void updateTeamGame(TeamGame teamGame) {
		teamInviteMapper.updateTeamGame(teamGame);
	}

	@Override
	public void saveTeamGame(TeamGame teamGame) {
		teamInviteMapper.saveTeamGame(teamGame);
	}
	
	@Override
	public void delTeamGame(String id){
		teamInviteMapper.delTeamGame(id);
	}
	
	@Override
	public AjaxMsg saveTransferMsg(TransferMsg transferMsg)throws Exception{
		teamInviteMapper.saveTransferMsg(transferMsg);
		//[买方俱乐部]希望以[输入金额]购买[卖方俱乐部]的[球员名称]
		TeamInfo buyTeam = teamInfoService.getEntityById(transferMsg.getBuy_teaminfo_id());
		TeamInfo sellTeam = teamInfoService.getEntityById(transferMsg.getSell_teaminfo_id());
		User user = userMapper.getEntityById(transferMsg.getUser_id());
		messageResourceService.saveTeamDynamicMessage(new Object[]{buyTeam.getName(),
				transferMsg.getPrice(),sellTeam.getName(),user.getUsername(),buyTeam.getId()
				,sellTeam.getId(),user.getId()}, 
				"team.msg.buyplayer", transferMsg.getBuy_teaminfo_id());		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public AjaxMsg updateTransferMsg(TransferMsg transferMsg)throws Exception{
		teamInviteMapper.updateTransferMsg(transferMsg);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public AjaxMsg queryTransferMarket(Map<String, Object> maps,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(pageModel!=null){
			count = teamInviteMapper.transferMarketCount(maps);
			pageModel.setTotalCount(count);
			maps.put("start",pageModel.getFirstNum());
			maps.put("rows",pageModel.getPageSize());
		}else{
			pageModel = new PageModel();
		}
		datas = teamInviteMapper.queryTransferMarket(maps);
		pageModel.setItems(datas);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}
	
	@Override
	public int transferMarketCount(Map<String, Object> maps){
		return teamInviteMapper.transferMarketCount(maps);
	}

	@Override
	public AjaxMsg updateTransferMsg(String id, String type, TeamInfo team) throws Exception {
		TransferMsg tm = teamInviteMapper.getTransferMsg(id);
		if(tm==null||(!"1".equals(type)&&!"2".equals(type))){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
		if(tm.getStatus()!=0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
		String buy_team_id = tm.getBuy_teaminfo_id();//购买俱乐部ID
		TeamInfo buyTeam = teamInfoService.getEntityById(buy_team_id);
		//检测购买俱乐部是否存在
		if(buyTeam==null||StringUtils.isBlank(buyTeam.getId())){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
		TeamLeague teamLeague = leagueService.getTeamSignByLeague(buyTeam.getId(),null);
		String s_id = teamLeague.getS_id();
		if("1".equals(type)){
			//检测市场是否开启
			MarketCfg marketCfg = leagueMarketService.getCurrentMarket(s_id);
			if(marketCfg != null){
				if(marketCfg.getIf_open() == 0){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
				}
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
			}
			//检测球员是否在本俱乐部
			TeamPlayer tp = teamInfoMapper.getTeamPlayerInfoByIds(tm.getUser_id(), team.getId());
			if(tp==null||StringUtils.isBlank(tp.getId())){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noplayer"));
			}
			
			//转会费
			BigDecimal price = tm.getPrice();
			//获取购买俱乐部资金账户
			UserAmount buy_amount = userAmountMapper.getUserAmountByTeaminfoID(buy_team_id);
			//获取出售俱乐部资金账户
			UserAmount sell_amount = userAmountMapper.getUserAmountByTeaminfoID(team.getId());
			
			if(buy_amount.getReal_amount().compareTo(price)<0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("team.amount.not_enough"));
			}
			//买方俱乐部账户余额减少（扣除转会费）
			buy_amount.setAmount(buy_amount.getAmount().subtract(price));
			buy_amount.setReal_amount(buy_amount.getReal_amount().subtract(price));
			//buy_amount.setSend_amount(buy_amount.getSend_amount().subtract(price));
			userAmountMapper.update(buy_amount);
			
			String m_id = UUIDGenerator.getUUID();
			String r_id = UUIDGenerator.getUUID();
			
			MarketRecords mr = new MarketRecords();
			mr.setId(r_id);
			mr.setBuy_price(price);
			mr.setM_id(m_id);
			mr.setManager_id(buy_team_id);
			playerInfoMapper.saveMarketRecord(mr);
			
			//更新球员市场表
			LeagueMarket leagueMarket = new LeagueMarket();
			leagueMarket.setId(m_id);
			leagueMarket.setUser_id(tm.getUser_id());
			leagueMarket.setStatus(1);
			leagueMarket.setBuyer(buy_team_id);
			leagueMarket.setEnd_time(null);
			leagueMarket.setPrice(price);
			leagueMarket.setIf_up(0);
			leagueMarket.setIf_sold(0);
			leagueMarket.setBuy_time(new Date());
			leagueMarket.setTeam_id(team.getId());
			leagueMarket.setCreate_time(new Date());
			leagueMarket.setS_id(s_id);
			leagueMarket.setLeague_id(marketCfg.getLeague_id());
			leagueMarket.setVersion(0);
			leagueMarket.setTurn_num(marketCfg.getTurn_num());
			leagueMarket.setR_id(r_id);
			leagueMarket.setIf_one(1);
			leagueMarketMapper.save(leagueMarket);
			
			//保存用户订单信息
			Order order = new Order();
			order.setId(UUIDGenerator.getUUID());
			order.setMount(1);
			order.setNum_str(Common.createOrderOSN());
			order.setP_code("buyplay");
			order.setPrice(price);
			order.setSum_amount(price);
			//order.setUser_id(buyer);
			order.setTeaminfo_id(buy_team_id);
			orderMapper.save(order);
			
			//插入俱乐部消费记录
			PayCost pc = new PayCost();
			pc.setId(UUIDGenerator.getUUID());
			pc.setAmount(price);
			pc.setDescrible("购买球员");
			pc.setNum_str(Common.createOrderOSN());
			pc.setStatus(1);
			pc.setOrder_id(order.getId());
			//pc.setUser_id(buyer);
			pc.setTeaminfo_id(buy_team_id);
			pc.setP_code("buyplay");
			payCostMapper.save(pc);
			
			//球员所得
			BigDecimal player_money = price.multiply(new BigDecimal(marketCfg.getUser_percent())).setScale(0,BigDecimal.ROUND_DOWN);
			//俱乐部所得
			BigDecimal team_money = price.multiply(new BigDecimal(marketCfg.getTeam_percent())).setScale(0,BigDecimal.ROUND_DOWN);
			//保存手续费记录
			Fee fee = new Fee();
			fee.setId(UUIDGenerator.getUUID());
			fee.setFee_money(price.subtract(player_money).subtract(team_money));
			fee.setOrder_id(order.getId());
			userAmountMapper.saveFee(fee);
			
			//实得金额
			sell_amount.setAmount(sell_amount.getAmount().add(team_money));
			sell_amount.setReal_amount(sell_amount.getReal_amount().add(team_money));
			//更新俱乐部管理者资金账户
			userAmountMapper.update(sell_amount);
			//更新球员资金账户
			UserAmount playerAmount = userAmountMapper.getByUserId(tm.getUser_id());
			playerAmount.setAmount(playerAmount.getAmount().add(player_money));
			playerAmount.setReal_amount(playerAmount.getReal_amount().add(player_money));
			userAmountMapper.update(playerAmount);
			
			//更新当前球员身价
			playerInfoMapper.updatePrice(tm.getUser_id(),price);
			
			//俱乐部成员转会操作,先删除旧俱乐部再添入到新俱乐部中
			if(tm!=null){
				teamInfoMapper.deleteTeamPlayer(team.getId(), tm.getUser_id());
			}
			TeamPlayer teamPlayer = new TeamPlayer();
			teamPlayer.setId(UUIDGenerator.getUUID());
			teamPlayer.setTeaminfo_id(buy_team_id);
			teamPlayer.setType(3);
			teamPlayer.setUser_id(tm.getUser_id());
			teamInfoMapper.saveTeamPlayer(teamPlayer);
			//插入用户转会记录
			TransferRecord tr = new TransferRecord();
			tr.setId(UUIDGenerator.getUUID());
			tr.setTeaminfo_id(tm==null?null:tm.getId());
			tr.setNew_teaminfo_id(buy_team_id);
			tr.setUser_id(tm.getUser_id());
			playerInfoMapper.saveTransferRecord(tr);
			//插入球员身价记录
			PriceSlave ps = new PriceSlave();	
			ps.setId(UUIDGenerator.getUUID());
			ps.setPrice(price);
			ps.setRole_type(2);
			ps.setUser_id(tm.getUser_id());
			ps.setBuy_type("zh");
			ps.setS_id(s_id);
			ps.setLeague_id(marketCfg.getLeague_id());
			priceSlaveMapper.save(ps);
			if(tm!=null){
				//更新出售球员记录表
				TeamSale teamSale = new TeamSale();
				teamSale.setId(UUIDGenerator.getUUID());
				teamSale.setTeaminfo_id(team.getId());
				teamSale.setStatus(1);
				teamSale.setUser_id(tm.getUser_id());
				teamSale.setCreate_time(new Date());
				playerInfoMapper.updateTeamSale(teamSale);
			}
			
			//修改msg状态
			tm.setStatus(1);
			tm.setIf_ok(1);
			teamInviteMapper.updateTransferMsg(tm);
			
			//判断被购买球员是否报名参加联赛，若报名参加联赛：购买成功，发送短信通知俱乐部管理者
			LeagueSign ls = leagueMapper.getLeagueSign(tm.getUser_id(), s_id);
			//获取俱乐部管理者用户信息
			User user = userMapper.getEntityById(buyTeam.getUser_id());
			//获取球员用户信息
			User p_user = userMapper.getEntityById(tm.getUser_id());
			if(ls!=null && user!=null){
				boolean ifSendSMS = false;
				if(StringUtils.isNotBlank(ls.getMobile())&&StringUtils.isNotBlank(user.getPhone())){
					ifSendSMS = true;
					//发送给俱乐部管理者
					StringBuilder sb = new StringBuilder();
					//String league_id = ls.getLeagues_id();
					League league = leagueMapper.getEntityById(teamLeague.getLeague_id());
					String league_name = BeanUtils.nullToString(league.getName());
					sb.append("@1@=").append(user.getUsernick()).append(",@2@=").append(p_user.getUsernick())
					.append(",@3@=").append(league_name).append(",@4@=").append(ls.getMobile());
					AjaxMsg msg = SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880033.toString());
					logger.info(user.getUsernick()+"("+user.getPhone()+")"+"购买球员短信通知发送失败！reson:"+msg.toJson());
					//发送给球员
					StringBuilder sb2 = new StringBuilder();
					sb2.append("@1@=").append(p_user.getUsernick()).append(",@2@=").append(league_name).append(",@3@=").append(buyTeam.getName())
					.append(",@4@=").append(league_name).append(",@5@=").append(user.getPhone());
					AjaxMsg re_msg = SendMsg.getInstance().sendSMS(ls.getMobile(), sb2.toString(), SMSTEMP.JSM405880034.toString());
					logger.info(p_user.getUsernick()+"("+ls.getMobile()+")"+"短信通知发送失败！reson:"+re_msg.toJson());
				}
				
				//将其他求购该球员的信息全部拒绝
				//获取其他求购信息
				List<TransferMsg> tms = teamInviteMapper.queryOtherTransferMsg(tm.getId(),team.getId(),tm.getUser_id());
				if(tms!=null&&tms.size()>0){
					for (TransferMsg transferMsg : tms) {
						transferMsg.setStatus(2);
						teamInviteMapper.updateTransferMsg(transferMsg);
						if(ifSendSMS){
							//发送短信
							TeamInfo bteam = teamInfoService.getEntityById(transferMsg.getBuy_teaminfo_id());
							User buser = userMapper.getEntityById(bteam.getUser_id());
							StringBuilder sb3 = new StringBuilder();
							sb3.append("@1@=").append(team.getName()).append(",@2@=").append(p_user.getUsernick());
							AjaxMsg bmsg = SendMsg.getInstance().sendSMS(buser.getPhone(), sb3.toString(), SMSTEMP.JSM405880042.toString());
							logger.info(buser.getUsernick()+"("+buser.getPhone()+")"+"购买球员失败短信通知发送失败！reson:"+bmsg.toJson());
						}
					}
				}
				
				//查询该球员所有未失效和未处理租借信息
				List<TeamLoanMsg> tls = teamLoanPlayerMapper.queryUntreatedTeamLoanMsg(team.getId(),p_user.getId());
				String uname = StringUtils.isNotBlank(p_user.getUsername())?p_user.getUsername():p_user.getUsernick();
				if(tls!=null&&tls.size()>0){
					for (TeamLoanMsg teamLoanMsg : tls) {
						teamLoanMsg.setStatus(2);
						teamLoanPlayerMapper.updateTeamLoanMsg(teamLoanMsg);
						
						TeamInfo buy_team = teamInfoMapper.getEntityById(teamLoanMsg.getBuy_teaminfo_id());
						//发送站内信息
						messageResourceService.saveMessage(new Object[]{team.getName(),uname}, SYSTYPE.LOANFALSE.toString(), "team.loan.reject", buy_team.getUser_id(), team.getUser_id(), teamLoanMsg.getId(), 1);
					}
				}
				
				//向首页推送消息
				messageResourceService.saveTeamDynamicMessage(new Object[]{team.getId(),team.getName(),p_user.getId(),(StringUtils.isNotBlank(p_user.getUsername())?p_user.getUsername():p_user.getUsernick()),price,buyTeam.getId(),buyTeam.getName()},"team.msg.buysuccess",team.getId());
			}else{
				throw new RuntimeException(messageResourceService.getMessage("system.error"));
			}
		}else{
			tm.setStatus(2);
			tm.setIf_ok(0);
			teamInviteMapper.updateTransferMsg(tm);
			//发送短信
			User buser = userMapper.getEntityById(buyTeam.getUser_id());
			//获取球员用户信息
			User p_user = userMapper.getEntityById(tm.getUser_id());
			StringBuilder sb = new StringBuilder();
			sb.append("@1@=").append(team.getName()).append(",@2@=").append(p_user.getUsernick());
			AjaxMsg bmsg = SendMsg.getInstance().sendSMS(buser.getPhone(), sb.toString(), SMSTEMP.JSM405880042.toString());
			logger.info(buser.getUsernick()+"("+buser.getPhone()+")"+"购买球员失败短信通知发送失败！reson:"+bmsg.toJson());
			
			messageResourceService.saveTeamDynamicMessage(new Object[]{team.getId(),team.getName(),buyTeam.getId(),buyTeam.getName(),p_user.getId(),(StringUtils.isNotBlank(p_user.getUsername())?p_user.getUsername():p_user.getUsernick())},"team.msg.buyerror",team.getId());
		}
		
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public TransferMsg getTransferMsg(String id) {
		return teamInviteMapper.getTransferMsg(id);
	}

	@Override
	public AjaxMsg deleteTransferMsg(String id)throws Exception {
		teamInviteMapper.deleteTransferMsg(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		
	}

	@Override
	public String checkIfTransfer(String sellTeamId, String buyTeamId) {
		//检测出售方是否联赛俱乐部
		TeamLeague sellTeamLeague = leagueMapper.getTeamLeague(null,sellTeamId);
		if(sellTeamLeague == null){
			return messageResourceService.getMessage("system.error.league.unleagueteam");
		}
		//出售方是否可以租借
		ActiveCode activeCode = leagueMapper.getActiveCodeByLidAndTid(sellTeamLeague.getLeague_id(),sellTeamId);
		if(activeCode==null || activeCode.getIf_transfer()==0){
			return messageResourceService.getMessage("team.buyplayer.unsupported");
		}
		
		//检测购买方是否联赛俱乐部
		TeamLeague buyTeamLeague = leagueMapper.getTeamLeague(null,buyTeamId);
		if(buyTeamLeague == null){
			return messageResourceService.getMessage("system.error.league.unleagueteam");
		}
		
		//购买方是否可以租借
		ActiveCode buy_activeCode = leagueMapper.getActiveCodeByLidAndTid(buyTeamLeague.getLeague_id(),buyTeamId);
		if(buy_activeCode==null || buy_activeCode.getIf_transfer()==0){
			return messageResourceService.getMessage("team.buyplayer.buyunsupported");
		}
		
		//检测是否在同一赛季
		if(!(sellTeamLeague.getS_id()).equals(buyTeamLeague.getS_id())){
			return messageResourceService.getMessage("team.buyplayer.unsupported");
		}
		
		//转会期是否开始
		String s_id  = BeanUtils.nullToString(sellTeamLeague.getS_id());
		MarketCfg marketCfg = leagueMarketService.getCurrentMarket(s_id);
		if(marketCfg != null){
			if(marketCfg.getIf_open() == 0){
				return messageResourceService.getMessage("system.error.market.ifopen");
			}
		}else{
			return messageResourceService.getMessage("system.error.market.ifopen");
		}
		return null;
	}
	
	@Override
	public boolean checkIfTransferShow(String buyTeamId) {
		//检测转会购买方是否联赛俱乐部
		TeamLeague buyTeamLeague = leagueMapper.getTeamLeague(null,buyTeamId);
		if(buyTeamLeague == null){
			return false;
		}
		//转会购买方是否配置购买功能
		ActiveCode buy_activeCode = leagueMapper.getActiveCodeByLidAndTid(buyTeamLeague.getLeague_id(),buyTeamId);
		if(buy_activeCode==null || buy_activeCode.getIf_transfer()==0){
			return false;
		}
		return true;
	}
}
