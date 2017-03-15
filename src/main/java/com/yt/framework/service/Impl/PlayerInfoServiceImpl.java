package com.yt.framework.service.Impl;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AgentInfo;
import com.yt.framework.persistent.entity.AgentPlayer;
import com.yt.framework.persistent.entity.AgentPlayerSign;
import com.yt.framework.persistent.entity.AuctionCondition;
import com.yt.framework.persistent.entity.Fee;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.MarketRecords;
import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.Order;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.PlayerTag;
import com.yt.framework.persistent.entity.PlayerTerm;
import com.yt.framework.persistent.entity.PriceSlave;
import com.yt.framework.persistent.entity.SuspendPlayer;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.TeamSale;
import com.yt.framework.persistent.entity.TransferRecord;
import com.yt.framework.persistent.entity.Trial;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ParamMap;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 * @Title: PlayerInfoServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月3日 下午3:58:34 
 */
@Service(value="playerInfoService")
public class PlayerInfoServiceImpl extends BaseServiceImpl<PlayerInfo> implements PlayerInfoService{
	static Logger logger = LogManager.getLogger(PlayerInfoServiceImpl.class.getName());
	
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private LeagueMarketService leagueMarketService;
	
	
	@Override
	public AjaxMsg getAgentByUserId(String userId) {
		if(StringUtils.isNotBlank(userId)){
			Map<String, Object> user = playerInfoMapper.getAgentByUserId(userId);
			if(user!=null){
				return AjaxMsg.newSuccess().addData("data", user);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg getTeamByUserId(String userId) {
		if(StringUtils.isNotBlank(userId)){
			Map<String, Object> team = playerInfoMapper.getTeamByUserId(userId);
			if(team!=null){
				return AjaxMsg.newSuccess().addData("data", team);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg terminated(String userId) {
		if(StringUtils.isNotBlank(userId)){
			int num = playerInfoMapper.terminated(userId);
			if(num==1){
				return AjaxMsg.newSuccess();
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg quitTeam(String userId) {
		if(StringUtils.isNotBlank(userId)){
			Map<String, Object> user = playerInfoMapper.getAgentByUserId(userId);
			if(user!=null){
				return AjaxMsg.newError().addMessage("请叫经纪人帮助退队");
			}else{
				int num = playerInfoMapper.quitTeam(userId);
				if(num==1){
					return AjaxMsg.newSuccess();
				}
			}
		}
		return AjaxMsg.newError();
	}

	/*@Override
	public AjaxMsg signByPlayer(Long userId, String playerId) {
		if(userId == null) return AjaxMsg.newError().addMessage("请先登陆系统!");
		String msg = "操作失败";
		if(StringUtils.isNotBlank(userId)&&StringUtils.isNotBlank(playerId)){
			if(playerId.equals(userId.toString())){
				msg = "不能与自己签约";
			}else{
				AgentPlayer aplayer = agentInfoMapper.getAgentPlayerByIds(userId, Long.parseLong(playerId));
				if(aplayer!=null){
					if(aplayer.getStatus()==4){
						msg ="你已经对该球员发送了邀请,等待处理...." ;
					}else{
						msg ="你已经和该球员签约" ;
					}
				}else{
					PlayerInfo info = playerInfoMapper.getByUserId(Long.parseLong(playerId));
					if(info!=null){
						AgentPlayer ap = new AgentPlayer();
						ap.setUser_id(userId);
						ap.setP_user_id(Long.parseLong(playerId.toString()));
						ap.setStatus(4);//球员受邀请
						int num = playerInfoMapper.signByPlayer(ap);
						if(num==1){
							Message message =new Message();
							message.setUser_id(Long.parseLong(playerId));
							message.setS_user_id(userId);
							message.setContent("申请签约");
							message.setType(SystemEnum.SYSTYPE.ATPQ.toString());
							message.setRelate_id(ap.getId());
							messageMapper.save(message);
							return AjaxMsg.newSuccess();
						}
					}else{
						msg = "该球员不存在";
					}
				}
			}
		}
		return AjaxMsg.newError().addMessage(msg);
	}*/
	
	@Override
	public AjaxMsg saveTeamByPlayer(String userId, String playerId)throws Exception {
		if(StringUtils.isBlank(userId)) return AjaxMsg.newError().addMessage("请先登陆系统!");
		String msg = messageResourceService.getMessage("system.error");
		
		TeamInfo team = teamInfoMapper.getTeamInfoByUserId(userId);
		if(null == team) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nocaption"));
		//判断俱乐部是否联赛俱乐部
		TeamLeague teamLeague = leagueService.getTeamLeague(team.getId());
		if(null != teamLeague){
			if(teamLeague.getStatus() == 1) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noinviteplayer"));
		}
		//判断俱乐部加入是否开放
		if(team.getAllow() == 0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.team.noallow"));
		if(team!=null){
			TeamPlayer tp = teamInfoMapper.getTeamPlayerInfoByIds(playerId, team.getId());
			if(tp!=null){
				//msg="该球员已经加入你的球队";
				msg = messageResourceService.getMessage("system.warn.player.join");
			}else{
				List<Message> msgs = messageMapper.queryMsg(playerId,userId,SystemEnum.SYSTYPE.TTPA.toString());
				if(msgs!=null && msgs.size()>0){
					//msg ="你已经对该球员发送了邀请,等待处理...." ;
					msg = messageResourceService.getMessage("system.warn.player.request");
				}else{
					return messageResourceService.saveMessage(new Object[]{team.getName()}, SystemEnum.SYSTYPE.TTPA.toString(), 
							"user.team.request", playerId, team.getId(), team.getId(),3);
				}
			}
		}else{
			//msg="你没有操作权限";
			msg = messageResourceService.getMessage("system.warn.nopri");
		}
		return AjaxMsg.newError().addMessage(msg);
	}

	@Override
	public AjaxMsg signByAgent(String userId, String agentId) {
		String msg = "操作失败";
		if(StringUtils.isNotBlank(userId)&&StringUtils.isNotBlank(agentId)){
			if(agentId.equals(userId.toString())){
				msg = "不能与自己签约";
			}else{
				AgentInfo info = agentInfoMapper.getEntityById(agentId);
				if(info!=null){
					//判断是否已签约
					int count = agentInfoMapper.isSignPlayer(userId);
					if(count>0){
						msg = "你已签约了经纪人";
					}else{
						AgentPlayer ap = new AgentPlayer();
						ap.setUser_id(info.getUser_id());
						ap.setP_user_id(userId);
						ap.setStatus(0);//球员申请签约
						int num = playerInfoMapper.signByPlayer(ap);
						if(num==1){
							return AjaxMsg.newSuccess();
						}
					}
				}else{
					msg = "该经纪人不存在";
				}
			}
		}
		return AjaxMsg.newError().addMessage(msg);
	}

	@Override
	public AjaxMsg saveTrial(Trial trial)throws Exception {
		if(trial!=null&&StringUtils.isNotBlank(trial.getUser_id())){
			trial.setId(UUIDGenerator.getUUID());
			int num = playerInfoMapper.saveTrial(trial);
			if(num==1){
				//added by bo.xie 向用户发送试训短信	start
				StringBuilder sb = new StringBuilder();
				String user_id = trial.getUser_id();
				User user = userMapper.getEntityById(user_id);
				TeamInfo ti = teamInfoMapper.getTeamInfoByUserId(trial.getS_user_id());
				sb.append("@1@=").append(ti.getName()).append(",@2@=").append(Common.formatDate(trial.getTrail_date(), "yyyy-MM-dd"))
					.append(",@3@=").append(trial.getTrail_position());
				String phoneNum = user.getPhone();//电话号码
				if(StringUtils.isNotBlank(phoneNum)&&user.getReceive_sms()==1){
					AjaxMsg send_msg = SendMsg.getInstance().sendSMS(phoneNum, sb.toString(), SMSTEMP.JSM405880027.toString());
					if(send_msg.isError())logger.error("试训通知短信发送失败！user_id="+user_id);
				}
				//added by ylt 向用户发送试训系统消息	start
				messageResourceService.saveMessage(new Object[]{ti.getName(),Common.formatDate(trial.getTrail_date(), "yyyy-MM-dd")
						,trial.getTrail_position()}, SystemEnum.SYSTYPE.TRIAL.toString(),
						"user.team.trial", trial.getUser_id(), ti.getId(), trial.getId(),3);
				//added by bo.xie 向用户发送试训信息	end
				/*Message msg =new Message();
				msg.setUser_id(trial.getUser_id());
				msg.setS_user_id(trial.getS_user_id());
				msg.setContent("参加试训");
				msg.setType(SystemEnum.SYSTYPE.TRIAL.toString());
				msg.setRelate_id(trial.getId());
				messageMapper.save(msg);*/
				return AjaxMsg.newSuccess();
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg updateTrial(String trail_id,Integer status) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		try{
			playerInfoMapper.updateTrial(trail_id,status);
		}catch(Exception e){
			return AjaxMsg.newError();
		}
		return msg;
	}
	
	@Override
	public int trialCount(String userId) {
		return playerInfoMapper.trialCount(userId);
	}

	@Override
	public AjaxMsg savePlayerInfo(PlayerInfo info,HttpServletRequest request) throws Exception{
		info = setPlayerInfo(info);
		if(StringUtils.isNotBlank(info.getId())){
			return updatePlayerInfo(info);
		}
		info.setScore(getScore(info));
		if(StringUtils.isBlank(info.getId())){
			info.setId(UUIDGenerator.getUUID());
		}
		AjaxMsg msg = save(info);
		if(msg.isSuccess()){
			User u = userMapper.getEntityById(info.getUser_id());
			u.setImage_count(5);
			u.setVideo_count(2);
			userMapper.update(u);
			securityService.saveUserRole(u,"3",request);
			return msg.addData("data", getPlayerInfoByUserId(info.getUser_id(),true).get("data"));
		}
		return msg;
	}

	@Override
	public AjaxMsg updatePlayerInfo(PlayerInfo info) throws Exception{
		info = setPlayerInfo(info);
		info.setScore(getScore(info));
		AjaxMsg msg = update(info);
		return msg.addData("data", getPlayerInfoByUserId(info.getUser_id(),true).get("data"));
	}
	
	private PlayerInfo setPlayerInfo(PlayerInfo info) throws Exception{
		PlayerInfo playerInfo = playerInfoMapper.getByUserId(info.getUser_id());
		//info.setExplosive(String.valueOf(getResults(info)));//爆发力
		if(playerInfo!=null){
			info.setId(playerInfo.getId());
			info.setIs_sign(playerInfo.getIs_sign());//是否签约
		}else{
			info.setTack_ability(info.getTack_ability()!=null?info.getTack_ability():"50");
			info.setPass_ability(info.getPass_ability()!=null?info.getPass_ability():"50");
			info.setRespond_ability(info.getRespond_ability()!=null?info.getRespond_ability():"50");
			info.setBall_ability(info.getBall_ability()!=null?info.getBall_ability():"50");
			info.setExplosive(info.getExplosive()!=null?info.getExplosive():"50");
			info.setShot(info.getShot()!=null?info.getShot():"50");
			info.setBalance(info.getBalance()!=null?info.getBalance():"50");
			info.setPhysical(info.getPhysical()!=null?info.getPhysical():"50");
			//info.setAttack(info.getAttack()!=null?info.getAttack():"50");
			info.setInsight(info.getInsight()!=null?info.getInsight():"50");
			info.setHeader(info.getHeader()!=null?info.getHeader():"50");
			info.setFree_kick(info.getFree_kick()!=null?info.getFree_kick():"50");
			info.setFill(info.getFill()!=null?info.getFill():"50");
			info.setSpeed(info.getSpeed()!=null?info.getSpeed():"50");
			info.setPower(info.getPower()!=null?info.getPower():"50");
			info.setGoal(info.getGoal()!=null?info.getGoal():"50");
		}
		return info;
	}

	@Override
	public AjaxMsg searchPlayerInfo(PlayerTerm playerTerm, PageModel pageModel) throws Exception {
		Map<String, Object> params = Maps.newHashMap();
		int count = 0;
		if(pageModel!=null){
			params.put("start",pageModel.getFirstNum());
			params.put("rows",pageModel.getPageSize());
		}
		BeanUtils.object2Map(params, playerTerm);
		if(null != playerTerm.getSex() && playerTerm.getSex() == 0){
			params.put("sex", 2);
		}
		count = count(params);
		pageModel.setTotalCount(count);
		List<Map<String, Object>> datas = playerInfoMapper.searchPlayerInfo(params);
		pageModel.setItems(datas);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg queryHasPlayer(String userId) {
		PlayerInfo player = playerInfoMapper.getByUserId(userId);
		if(player!=null){
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg getPlayerInfoByUserId(String userId,boolean flag) {
		if(StringUtils.isNotBlank(userId)){
			Map<String, Object> playerInfo = playerInfoMapper.getPlayerInfoByUserId(userId);
			if(playerInfo!=null){
				if(flag){
					String position = playerInfo.get("position")!=null?playerInfo.get("position").toString():"";
					String[] pos = position.split(",");
					String posStr = "";
					for (String string : pos) {
						posStr+=ParamMap.getParam("p_position", string)+" , ";
					}
					posStr = posStr.substring(0,posStr.lastIndexOf(","));
					playerInfo.put("position", posStr);//场上位置
					String type = playerInfo.get("type")!=null?playerInfo.get("type").toString():"";
					playerInfo.put("type", ParamMap.getParam("p_type", type));//类型
//					String injured_area = playerInfo.get("injured_area")!=null?playerInfo.get("injured_area").toString():"";
//					playerInfo.put("injured_area", ParamMap.getParam("p_injured", injured_area));//受伤部位
					String tags = playerInfo.get("tags")!=null?playerInfo.get("tags").toString():"";
					playerInfo.put("tags", ParamMap.getParam("p_tags", tags));//特点标签
				}
				List<String> praises = playerInfoMapper.praiseCount(userId);
				Map<String, Object> praiseCount = new HashMap<String,Object>();
				praiseCount.put("praise", praises.get(0));
				praiseCount.put("cai", praises.get(1));
				return AjaxMsg.newSuccess().addData("data", playerInfo).addData("praiseCount", praiseCount);
			}else{
				return AjaxMsg.newSuccess().addData("data", playerInfo);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryTrialByUserId(String othUserId, String uid) {
		try {
			List<Trial> trials = playerInfoMapper.queryTrialByUserId(othUserId,uid);
			if(trials!=null&&trials.size()>0){
				Trial t = trials.get(0);
				Date create_time = t.getCreate_time();
				Date d = new Date();
				long time = (d.getTime()-create_time.getTime());
				if(!((time/(24*60*60*1000))>=1)){
					return AjaxMsg.newSuccess().addData("errorMsg", "一天只能发送一次试训邀请");
				}
			}
			User user = userMapper.getEntityById(othUserId);
			String userNick = user.getUsernick();
			if(!StringUtils.isNotBlank(userNick)){
				if(StringUtils.isNotBlank(user.getPhone())){
					userNick = Common.hiddenPhoneOrEmail(user.getPhone());
				}else{
					userNick = Common.hiddenPhoneOrEmail(user.getEmail());
				}
			}
			return AjaxMsg.newSuccess().addData("userNick", userNick);
		} catch (Exception e) {
			return AjaxMsg.newError();
		}
		
	}

	@Override
	public PlayerInfo getPlayerInfoByUserId(String user_id) {
		return playerInfoMapper.getByUserId(user_id);
	}

	@Override
	public AjaxMsg breakAgent(String agent_id, String player_id, Integer status) throws Exception {
		if(StringUtils.isBlank(agent_id) || StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage("经纪人或球员不存在");
		//更新球员消息记录表
		AgentPlayerSign agentPlayerSign = agentInfoMapper.getAgentPlayerSign(agent_id,player_id,new Long(2));
		agentPlayerSign.setBreak_sure_time(new Date());
		agentPlayerSign.setStatus(status);
		//同意解约
		User user = userMapper.getEntityById(player_id);
		AgentPlayer agentPlayer = agentInfoMapper.getAgentPlayerByIds(agent_id,player_id);
		if(status.intValue() == 1){
			agentPlayer.setStatus(new Integer(0));
			agentPlayer.setBreak_time(new Date());
			agentPlayer.setApplying(new Integer(0));
			agentInfoMapper.updateAgentPlayer(agentPlayer);
			agentInfoMapper.updateAgentPlayerSign(agentPlayerSign);
			//获取球员信息
			PlayerInfo pi = playerInfoMapper.getByUserId(player_id);
			//更新球员签约状态
			pi.setIs_sign(0);
			playerInfoMapper.update(pi);
			//球员同意解约
			messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick()}, "user.player.agreesurrender",agent_id , player_id,1);
		}else{
		//拒绝
			agentPlayer.setApplying(new Integer(0));
			agentInfoMapper.updateAgentPlayer(agentPlayer);
			agentInfoMapper.updateAgentPlayerSign(agentPlayerSign);
			messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick()}, "user.player.resurrender", agent_id, player_id,1);
		}
		return AjaxMsg.newSuccess();
	
	}
	
	@Override
	public AjaxMsg signAgent(String agent_id, String player_id, Integer status)throws Exception{
		if(StringUtils.isBlank(agent_id) || StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage("经纪人或球员不存在");
			//更新球员消息记录表
			AgentPlayerSign agentPlayerSign = agentInfoMapper.getAgentPlayerSign(agent_id,player_id,new Long(1));
			agentPlayerSign.setApply_sure_time(new Date());
			agentPlayerSign.setStatus(status);
			User user = userMapper.getEntityById(player_id);
			//同意签约
			if(status.intValue() == 1){
				//存储过程中insert a_agent_player关系表id必须手动写入uuid，经纪人功能开发后需修改此功能接口	
				agentInfoMapper.saveAgentPlayerByProcedure(agentPlayerSign);
				//获取球员信息
				PlayerInfo pi = playerInfoMapper.getByUserId(player_id);
				//更新球员签约状态
				pi.setIs_sign(1);
				playerInfoMapper.update(pi);
				messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick()}, "user.player.agreesign", agent_id, player_id,1);
			}else{
			//拒绝
				agentInfoMapper.updateAgentPlayerSign(agentPlayerSign);
				messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick()}, "user.player.refusesign", agent_id, player_id,1);
			}
			return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg updatePraise(Map<String, Object> params) throws Exception {
		String state = params.get("p_state")!=null?params.get("p_state").toString():"";
		String p_user_id = params.get("p_user_id")!=null?params.get("p_user_id").toString():"";
		if(StringUtils.isNotBlank(state)){
			List<Map<String, Object>> praise = playerInfoMapper.queryPraise(params);
			List<String> praises = playerInfoMapper.praiseCount(p_user_id);
			int num = 0;
			int count = "1".equals(state)?Integer.parseInt(praises.get(0)):Integer.parseInt(praises.get(1));
			int flag = 1;
			if(praise!=null&&praise.size()>0){
				num = playerInfoMapper.deletePraise(params);
				count = count>0?count-1:0;
				flag = 0;
			}else{
				params.put("id", UUIDGenerator.getUUID());
				num = playerInfoMapper.savePraise(params);
				count = count+1;
			}
			if(num>0){
				return AjaxMsg.newSuccess().addData("praiseCount", count).addData("flag", flag);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<Map<String, Object>> queryPraise(Map<String, Object> params) {
		return playerInfoMapper.queryPraise(params);
	}

	@Override
	public AjaxMsg buyPalyer(Map<String, Object> maps)throws Exception {
		String buyer = BeanUtils.nullToString(maps.get("buyer"));//购买用户ID
		String id = BeanUtils.nullToString(maps.get("id"));//球员跳蚤市场记录ID
		String price = BeanUtils.nullToString(maps.get("price"));//购买价格
		String tm_user_id = BeanUtils.nullToString(maps.get("tm_user_id"));//出售球员俱乐部管理者用户ID
		String p_user_id = BeanUtils.nullToString(maps.get("p_user_id"));//出售球员用户ID
		String s_id = BeanUtils.nullToString(maps.get("s_id"));//赛季ID
		
		//判断购买用户是否是俱乐部队长
		TeamInfo ti = teamInfoMapper.getTeamInfoByUserId(buyer);
		if(ti==null)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.noteam"));
		//出售球员俱乐部
		TeamInfo tm = teamInfoMapper.getTeamInfoByUserId(tm_user_id);
		//update by bo.xie 购买球员账户由个人资金账户转到俱乐部资金账户 start
		/*
		 * //获取购买者资金账户,并判断可用资金是否足够
			UserAmount userAmount = userAmountMapper.getByUserId(buyer);
		*/
		
		//获取购买俱乐部资金账户，并判断可用资金是否足够
		UserAmount userAmount = userAmountMapper.getUserAmountByTeaminfoID(ti.getId());
		//update by bo.xie 购买球员账户由个人资金账户转到俱乐部资金账户 end
		if(userAmount.getStatus()==2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.freeze"));
		if(userAmount.getReal_amount().compareTo(new BigDecimal(price))<0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.not_enough"));
		}
		
		//更新俱乐部资金表
		userAmount.setAmount(userAmount.getAmount().subtract(new BigDecimal(price)));
		userAmount.setReal_amount(userAmount.getReal_amount().subtract(new BigDecimal(price)));
		userAmountMapper.update(userAmount);
		
		//更新球员市场表
		LeagueMarket leagueMarket = playerInfoMapper.getLeagueMarketById(id);
		leagueMarket.setBuy_time(new Date());
		leagueMarket.setBuyer(buyer);
		leagueMarket.setStatus(1);
		playerInfoMapper.updateLeagueMarker(leagueMarket);
		
		//保存球员购买记录
		MarketRecords mr = new MarketRecords();
		mr.setId(UUIDGenerator.getUUID());
		mr.setBuy_price(new BigDecimal(price));
		mr.setM_id(leagueMarket.getId());
		mr.setManager_id(buyer);
		playerInfoMapper.saveMarketRecord(mr);
		
		//保存用户订单信息
		Order order = new Order();
		order.setId(UUIDGenerator.getUUID());
		order.setMount(1);
		order.setNum_str(Common.createOrderOSN());
		order.setP_code("buyplay");
		order.setPrice(new BigDecimal(price));
		order.setSum_amount(new BigDecimal(price));
		//order.setUser_id(buyer);
		order.setTeaminfo_id(ti.getId());
		orderMapper.save(order);
		//插入俱乐部消费记录
		PayCost pc = new PayCost();
		pc.setId(UUIDGenerator.getUUID());
		pc.setAmount(new BigDecimal(price));
		pc.setDescrible("购买球员");
		pc.setNum_str(Common.createOrderOSN());
		pc.setStatus(1);
		pc.setOrder_id(order.getId());
		//pc.setUser_id(buyer);
		pc.setTeaminfo_id(ti.getId());
		pc.setP_code("buyplay");
		payCostMapper.save(pc);
		
		//upadte by bo.xie 个人账户转为俱乐部资金账户start
		/*//获取俱乐部管理者用户资金
		UserAmount tm_userAmount = userAmountMapper.getByUserId(tm_user_id);*/
		
		//获取出售球员俱乐部账户资金
		UserAmount tm_userAmount = userAmountMapper.getUserAmountByTeaminfoID(tm.getId());
		//upadte by bo.xie 个人账户转为俱乐部资金账户end 
		if(tm_userAmount!=null){
			//获取市场分成比例参数
			MarketCfg marketCfg = leagueMarketService.getCurrentMarket(s_id);
			BigDecimal player_money = new BigDecimal(price).multiply(new BigDecimal(marketCfg.getUser_percent())).setScale(0,BigDecimal.ROUND_DOWN);
			BigDecimal team_money = new BigDecimal(price).multiply(new BigDecimal(marketCfg.getTeam_percent())).setScale(0,BigDecimal.ROUND_DOWN);
			//球员出售成功，更新俱乐部管理者资金账户
			/*Properties p = PropertiesUtils.loadSetting("/messages/common.properties");
			//获取手续费用
			String fee_str =String.valueOf(p.get("buy.player.fee")); 
			BigDecimal fee_money = new BigDecimal(price).multiply(new BigDecimal(fee_str)).setScale(0);
			*/
			//保存手续费记录
			Fee fee = new Fee();
			fee.setId(UUIDGenerator.getUUID());
			fee.setFee_money(new BigDecimal(price).subtract(player_money).subtract(team_money));
			fee.setOrder_id(order.getId());
			userAmountMapper.saveFee(fee);
			//实得金额
			//BigDecimal real_receive = new BigDecimal(price).subtract(fee_money);
			tm_userAmount.setAmount(tm_userAmount.getAmount().add(team_money));
			tm_userAmount.setReal_amount(tm_userAmount.getReal_amount().add(team_money));
			//更新俱乐部管理者资金账户
			userAmountMapper.update(tm_userAmount);
			//更新球员资金账户
			UserAmount playerAmount = userAmountMapper.getByUserId(p_user_id);
			playerAmount.setAmount(playerAmount.getAmount().add(player_money));
			playerAmount.setReal_amount(playerAmount.getReal_amount().add(player_money));
			userAmountMapper.update(playerAmount);
		}
		
		//更新当前球员身价
		playerInfoMapper.updatePrice(p_user_id, new BigDecimal(price));
		
		//俱乐部成员转会操作,先删除旧俱乐部再添入到新俱乐部中
		if(tm!=null){
			teamInfoMapper.deleteTeamPlayer(tm.getId(), p_user_id);
		}
		TeamPlayer teamPlayer = new TeamPlayer();
		teamPlayer.setId(UUIDGenerator.getUUID());
		teamPlayer.setTeaminfo_id(ti.getId());
		teamPlayer.setType(3);
		teamPlayer.setUser_id(p_user_id);
		teamInfoMapper.saveTeamPlayer(teamPlayer);
		//插入用户转会记录
		TransferRecord tr = new TransferRecord();
		tr.setId(UUIDGenerator.getUUID());
		tr.setTeaminfo_id(tm==null?null:tm.getId());
		tr.setNew_teaminfo_id(ti.getId());
		tr.setUser_id(p_user_id);
		playerInfoMapper.saveTransferRecord(tr);
		//插入球员身价记录
		PriceSlave ps = new PriceSlave();	
		ps.setId(UUIDGenerator.getUUID());
		ps.setPrice(new BigDecimal(price));
		ps.setRole_type(2);
		ps.setUser_id(p_user_id);
		ps.setBuy_type("zh");
		ps.setS_id(s_id);
		priceSlaveMapper.save(ps);
		if(tm!=null){
			//更新出售球员记录表
			TeamSale teamSale = playerInfoMapper.getTeamSaleByUserID(p_user_id, "2");
			teamSale.setStatus(1);
			playerInfoMapper.updateTeamSale(teamSale);
		}
		
		//判断被购买球员是否报名参加联赛，若报名参加联赛：购买成功，发送短信通知俱乐部管理者
		LeagueSign ls = leagueMapper.getLeagueSign(p_user_id, s_id);
		//获取俱乐部管理者用户信息
		User user = userMapper.getEntityById(ti.getUser_id());
		//获取球员用户信息
		User p_user = userMapper.getEntityById(p_user_id);
		if(ls!=null && user!=null && StringUtils.isNotBlank(ls.getMobile())&&StringUtils.isNotBlank(user.getPhone())){
			//发送给俱乐部管理者
			StringBuilder sb = new StringBuilder();
			String league_id = ls.getLeagues_id();
			League league = leagueMapper.getEntityById(league_id);
			String league_name = "";
			if(null!=league)league_name = league.getName();
			sb.append("@1@=").append(user.getUsernick()).append(",@2@=").append(p_user.getUsernick())
			.append(",@3@=").append(league_name).append(",@4@=").append(ls.getMobile());
			AjaxMsg msg = SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880033.toString());
			logger.info(user.getUsernick()+"("+user.getPhone()+")"+"购买球员短信通知发送失败！reson:"+msg.toJson());
			//发送给球员
			StringBuilder sb2 = new StringBuilder();
			sb2.append("@1@=").append(p_user.getUsernick()).append(",@2@=").append(league_name).append(",@3@=").append(ti.getName())
			.append(",@4@=").append(league_name).append(",@5@=").append(user.getPhone());
			AjaxMsg re_msg = SendMsg.getInstance().sendSMS(ls.getMobile(), sb2.toString(), SMSTEMP.JSM405880034.toString());
			logger.info(p_user.getUsernick()+"("+ls.getMobile()+")"+"短信通知发送失败！reson:"+re_msg.toJson());
		}
		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg loadMarketRecord(Map params, PageModel pageModel) {
		int totalCount =  playerInfoMapper.loadMarketRecordCount(params);
		params.put("start",pageModel.getFirstNum());
		params.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> remap = playerInfoMapper.loadMarketRecord(params);
		pageModel.setItems(remap);
		pageModel.setTotalCount(totalCount);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg loadPlayers(AuctionCondition condition,PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		int totalCount =  playerInfoMapper.loadPlayersCount(condition);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> remap = playerInfoMapper.loadPlayers(condition, maps);
		pageModel.setItems(remap);
		pageModel.setTotalCount(totalCount);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public Map<String, Object> getPlayerInfoForMarketByUserId(String user_id,String status) {
		return playerInfoMapper.getPlayerInfoForMarketByUserId(user_id,status);
	}

	@Override
	public AjaxMsg updatePrice(String user_id, BigDecimal current_price)throws Exception {
		 playerInfoMapper.updatePrice(user_id,current_price);
		 return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg loadSaleRecord(AuctionCondition condition,PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		int totalCount =  playerInfoMapper.loadSaleRecordCount(condition);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> remap = playerInfoMapper.loadSaleRecord(condition, maps);
		pageModel.setItems(remap);
		pageModel.setTotalCount(totalCount);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg queryPlayerTag(String user_id) {
		List<PlayerTag> list = Lists.newArrayList();
		list = playerInfoMapper.queryPlayerTag(user_id);
		return AjaxMsg.newSuccess().addData("page", list);
	}

	@Override
	public AjaxMsg savePlayerTag(PlayerTag playerTag)throws Exception {
		playerInfoMapper.savePlayerTag(playerTag);
		String name = userMapper.id2Name(playerTag.getS_user_id());
		messageResourceService.saveMessageNoReply(new Object[]{name,playerTag.getTag()}, 
				"user.player.tag", playerTag.getUser_id(), playerTag.getS_user_id(),1);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg deletePlayerTag(String id)throws Exception {
		playerInfoMapper.deletePlayerTag(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg searchPlayerInfoByAdmin(Map maps, PageModel pageModel) {
		int count = 0;
		if(pageModel!=null){
			maps.put("start",pageModel.getFirstNum());
			maps.put("rows",pageModel.getPageSize());
		}
		count = countAdmin(maps);
		pageModel.setTotalCount(count);
		List<Map<String, Object>> datas = playerInfoMapper.searchPlayerInfoByAdmin(maps);
		pageModel.setItems(datas);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}
	
	@Override
	public int countAdmin(Map maps) {
		return playerInfoMapper.countAdmin(maps);
	}

	@Override
	public AjaxMsg savePlayerRecommendation(String userIds)throws Exception {
		String uids[] = userIds.split(",");
		if(uids!=null&&uids.length>0){
			for (String uid : uids) {
				Map<String, Object> rec = new HashMap<String,Object>();
				rec.put("id", UUIDGenerator.getUUID());
				rec.put("user_id", uid);
				rec.put("if_up", "0");
				playerInfoMapper.savePlayerRecommendation(rec);
			}
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg updatePlayerRecommendation(Map<String, Object> maps)throws Exception {
		playerInfoMapper.updatePlayerRecommendation(maps);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg deletePlayerRecommendation(String id)throws Exception {
		playerInfoMapper.deletePlayerRecommendation(id);
		return AjaxMsg.newSuccess();
	}

	@Override
	public LeagueMarket getPlayerInLeagueMarket(String userId) {
		LeagueMarket market = playerInfoMapper.getPlayerInLeagueMarket(userId);
		return market;
	}

	@Override
	public SuspendPlayer getSuspendPlayerByUserId(String user_id) {
		return playerInfoMapper.getSuspendPlayerByUserId(user_id);
	}

}
