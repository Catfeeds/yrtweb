package com.yt.framework.service.Impl;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AmountDetail;
import com.yt.framework.persistent.entity.Fee;
import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.Order;
import com.yt.framework.persistent.entity.PPosition;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.PayRecord;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.SalaryMsg;
import com.yt.framework.persistent.entity.SalaryRecord;
import com.yt.framework.persistent.entity.TeamActiveCode;
import com.yt.framework.persistent.entity.TeamApply;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamLoanMsg;
import com.yt.framework.persistent.entity.TeamNotice;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.TeamPlayerWage;
import com.yt.framework.persistent.entity.TeamSale;
import com.yt.framework.persistent.entity.TransferMsg;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.AmountEnum.PayType;
import com.yt.framework.persistent.enums.AmountEnum.WayType;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.persistent.enums.SystemEnum.MSGTYPE;
import com.yt.framework.persistent.enums.SystemEnum.SYSTYPE;
import com.yt.framework.service.AutoInfoMationService;
import com.yt.framework.service.BabyInService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.EhCache;
import com.yt.framework.utils.EhCacheObj;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ParamMap;
import com.yt.framework.utils.ReturnJosnMsg;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.gson.JSONUtils;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 *俱乐部
 *@autor bo.xie
 *@date2015-8-3下午3:31:47
 */
@Transactional
@Service("teamInfoService")
public class TeamInfoServiceImpl extends BaseServiceImpl<TeamInfo> implements TeamInfoService {
	
	protected static Logger logger = LogManager.getLogger(TeamInfoServiceImpl.class);
	
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private AutoInfoMationService autoInfoMationService;
	@Autowired
	private BabyInService babyInService;
	@Autowired
	private UserService userService;
	@Autowired
	private LeagueService leagueService;
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	
	@Override
	public AjaxMsg saveTeam(TeamInfo ti, HttpServletRequest request) throws Exception{
		LeagueSign leagueSign = leagueMapper.getLeagueSignInvalid(ti.getUser_id());
		if(leagueSign!=null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.repeatpsign"));
		}
		if(StringUtils.isBlank(ti.getId())){
			ti.setId(UUIDGenerator.getUUID());
		}
		//将LONG上传到OSS
		String logo = ti.getLogo();
		if(!logo.contains("images")){//非系统LOGO
			int result = OSSClientFactory.uploadFile(logo, new File(fileRepository.getRealPath(logo)));
			if(result == Global.SUCCESS){
				ImageKit.delFile(fileRepository.getRealPath(logo));
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
			}
		}
		String remark_imgs = ti.getRemark_images();
		if(StringUtils.isNotBlank(remark_imgs)){
			String[] imgs = remark_imgs.split(",");
			for (String str : imgs) {
				if(StringUtils.isNotBlank(str)){
					int flag = OSSClientFactory.uploadFile(str, new File(fileRepository.getRealPath(str)));
					if(flag == Global.SUCCESS){
						ImageKit.delFile(fileRepository.getRealPath(str));
					}else{
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
					}
				}
			}
		}
		AjaxMsg msg = save(ti);
		if(msg.isSuccess()){
			//added by bo.xie 创建俱乐部资金帐户  2016年2月24日17:22:17 start
				String teaminfo_id = ti.getId();
				//判断该俱乐部是否已存在资金账户，若不存在就创建
				UserAmount team_userAmount = userAmountMapper.getUserAmountByTeaminfoID(teaminfo_id);
				if(team_userAmount==null){
					//创建俱乐部资金账户
					team_userAmount = new UserAmount();
					team_userAmount.setAmount(new BigDecimal(0));
					team_userAmount.setId(UUIDGenerator.getUUID());
					team_userAmount.setReal_amount(new BigDecimal(0));
					team_userAmount.setSend_amount(new BigDecimal(0));
					team_userAmount.setTeaminfo_id(teaminfo_id);
					team_userAmount.setStatus(1);
					team_userAmount.setType(2);//俱乐部账户
					userAmountMapper.save(team_userAmount);
				}
			//added by bo.xie 创建俱乐部资金帐户  2016年2月24日17:22:17 end
			User user = userMapper.getEntityById(ti.getUser_id());
			msg = securityService.saveUserRole(user,"6",request);
			if(msg.isError()){
				throw new RuntimeException();
			}
		}
		return msg;
	}
	
	@Override
	public AjaxMsg saveTeamNoAmount(TeamInfo ti, HttpServletRequest request) throws Exception{
		LeagueSign leagueSign = leagueMapper.getLeagueSignInvalid(ti.getUser_id());
		if(leagueSign!=null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.repeatpsign"));
		}
		if(StringUtils.isBlank(ti.getId())){
			ti.setId(UUIDGenerator.getUUID());
		}
		AjaxMsg msg = save(ti);
		if(msg.isSuccess()){
			User user = userMapper.getEntityById(ti.getUser_id());
			msg = securityService.saveUserRole(user,"6",request);
			if(msg.isError()){
				throw new RuntimeException();
			}
		}
		return msg;
	}

	@Override
	public AjaxMsg save(TeamInfo t) {
		try {
			if(null == t.getUser_id()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt"));
			int count = teamInfoMapper.isJoinTeamForPlayer(t.getUser_id());
			if(count>0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.join"));
			if(StringUtils.isBlank(t.getId())){
				t.setId(UUIDGenerator.getUUID());
			}
			teamInfoMapper.save(t);
			
			//俱乐部创建成功，创建人为队长，信息写入俱乐部成员表中
			AjaxMsg msg = this.saveTeamPlayer(t.getId(), t.getUser_id(), 1);
			if(msg.isSuccess()){
				//added by bo.xie 俱乐部创建成功，系统消息形成动态推送至首页和动态页 start
				messageResourceService.saveTeamDynamicMessage(new Object[]{t.getId(),t.getName()},"team.info.create",t.getId());
				//added by bo.xie 俱乐部创建成功，系统消息形成动态推送至首页和动态页 end	
				return msg.addData("data", t);
			}
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError();
		}
	}

	@Override
	public TeamInfo getTeamInfoByUserId(String user_id) {
		return teamInfoMapper.getTeamInfoByUserId(user_id);

	}

	@Override
	public AjaxMsg saveTeamPlayer(String teaminfo_id, String player_id, int type) {
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt"));
		try {
			//判断该球员是否已加入俱乐部
			int count = teamInfoMapper.isJoinTeamForPlayer(player_id);
			if(count>0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.join"));
			//加入俱乐部
			TeamPlayer tp = new TeamPlayer();
				tp.setId(UUIDGenerator.getUUID());
				tp.setTeaminfo_id(teaminfo_id);
				tp.setType(type);
				tp.setUser_id(player_id); 
			teamInfoMapper.saveTeamPlayer(tp);
			return AjaxMsg.newSuccess();
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError();
		}
	}

	@Override
	public AjaxMsg outTeam(String teaminfo_id, String player_id)throws Exception {
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt"));
			
			LeagueSign leagueSign = leagueMapper.getLeagueSignInvalid(player_id);
			if(leagueSign!=null){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.outteam"));
			}
		
			//获取球员在俱乐部中的职位 1:队长 2:副队长 3：普通球员
			Integer type = teamInfoMapper.getTeamPlayerPosition(teaminfo_id, player_id);
			if(type==null){
				return AjaxMsg.newError().addMessage("结果不存在");
			}else if(type==1){
				return AjaxMsg.newError().addMessage("该球员为队长，不能直接退出队伍");
			}
			//退出俱乐部
			teamInfoMapper.deleteTeamPlayer(teaminfo_id, player_id);
			updateTeamScore(teaminfo_id,"out"); //add gl 退出球队 球队-3活跃度

			User caption = teamInfoMapper.getCaption(teaminfo_id);
			User player = userMapper.getEntityById(player_id);
			TeamInfo team = teamInfoMapper.getEntityById(teaminfo_id);
			//发送给球员退出俱乐部消息
			messageResourceService.saveMessageNoReply(new Object[]{player.getUsernick(),player.getId(),
				team.getName(),team.getId()}, "user.team.outteam", player_id, caption.getId(),1);
			//发送给球员退出俱乐部消息
			messageResourceService.saveMessageNoReply(new Object[]{player.getUsernick(),player.getId(),
					team.getName(),team.getId()}, "user.team.outteam", caption.getId(), caption.getId(),1);	
			//俱乐部动态
			messageResourceService.saveTeamDynamicMessage(new Object[]{player.getUsernick(),player.getId(),
					team.getName(),team.getId()}, "user.team.outteam", teaminfo_id);
			
			return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg joinTeam(String teaminfo_id, String player_id)throws Exception {
			AjaxMsg msg = applyTeamParamJudge(teaminfo_id, player_id,null);
		    if(msg.isError()){
		    	return msg;
		    }
			//updated by bo.xie 修改入队申请 start
			TeamApply teamApply = new TeamApply();
			teamApply.setId(UUIDGenerator.getUUID());
			teamApply.setTeaminfo_id(teaminfo_id);
			teamApply.setUser_id(player_id);
			teamInfoMapper.saveTeamApply(teamApply);
			//updated by bo.xie 修改入队申请 end
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public AjaxMsg joinLeagueTeam(String teaminfo_id, String player_id)throws Exception {
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt"));
		//判断是否为球员
		PlayerInfo playerInfo = playerInfoMapper.getByUserId(player_id);
		if(null == playerInfo || null == playerInfo.getId()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.noplayer"));
		//判断是否加入其他球队
		int count = teamInfoMapper.isJoinTeamForPlayer(player_id);
		if(count>0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.joined"));
		TeamInfo teamInfo = teamInfoMapper.getEntityById(teaminfo_id);
		TeamPlayer tp = new TeamPlayer();
		tp.setId(UUIDGenerator.getUUID());
		tp.setTeaminfo_id(teaminfo_id);
		tp.setType(3);//球员类型 1:队长 2:副队长 3：普通球员
		tp.setUser_id(player_id);
		teamInfoMapper.saveTeamPlayer(tp);
		updateTeamScore(teaminfo_id,"join");//add gl 球员加入球队加3活跃度
		User user =  userMapper.getEntityById(player_id);
		//发送俱乐部动态消息
		msg = messageResourceService.saveTeamDynamicMessage(new Object[]{user.getUsernick(),teamInfo.getName(),user.getId(),teamInfo.getUser_id()},"square.user.join",teaminfo_id);
		//发送队长消息	
		msg = messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick(),teamInfo.getName()},
				"square.user.join", teamInfo.getUser_id() , teamInfo.getUser_id(),1);
		//广场推送消息
		msg = autoInfoMationService.sendInfo(teamInfo.getUser_id(), teamInfo.getUser_id(), MSGTYPE.INDEX.toString(), SYSTYPE.TAPK.toString(), 
				messageResourceService.getMessage(new Object[]{user.getUsernick(),teamInfo.getName(),user.getId(),teamInfo.getUser_id()},
				"square.user.join"));
		
		return AjaxMsg.newSuccess();
	}
	
	
	@Override
	public AjaxMsg getTeamPlayerList(Map<String, Object> maps,PageModel pageModel) {
		List<Map<String,Object>> datas = Lists.newArrayList();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = teamPlayerCount(BeanUtils.nullToString(maps.get("teaminfo_id")));
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = teamInfoMapper.getTeamPlayerList(maps);
			if(pageModel == null){
				PageModel page = new PageModel();
				page.setTotalCount(datas.size());
				page.setItems(datas);
				return AjaxMsg.newSuccess().addData("page", page);
			}else{
				pageModel.setTotalCount(count);
				pageModel.setItems(datas);
			}
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}
	
	@Override
	public AjaxMsg defriendPlayer(String teaminfo_id, String player_id) throws Exception{
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt"));
		Integer type = teamInfoMapper.getTeamPlayerPosition(teaminfo_id, player_id);
		//判断该球员是否为本队球员
		if(type != null){
			teamInfoMapper.deleteTeamPlayer(teaminfo_id, player_id);
			updateTeamScore(teaminfo_id,"out");
		}
		Map<String,Object> params =  Maps.newHashMap();
		params.put("teaminfo_id", teaminfo_id);
		params.put("player_id", player_id);
		if(StringUtils.isBlank(BeanUtils.nullToString(params.get("id")))){
			params.put("id",UUIDGenerator.getUUID());
		}
		teamInfoMapper.saveBlackPlayer(params);
		return AjaxMsg.newSuccess().addMessage("system.success");
	}
	
	@Override
	public AjaxMsg kickfriendPlayer(String teaminfo_id, String player_id) {
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt"));
		try {
			Map<String,Object> params = Maps.newHashMap();
			params.put("teaminfo_id", teaminfo_id);
			params.put("player_id", player_id);
			List<Map<String, Object>> listBlackPlayer = Lists.newArrayList();
			listBlackPlayer = teamInfoMapper.getBlackPlayer(params);
			if(!listBlackPlayer.isEmpty() && listBlackPlayer.size()>0){
				teamInfoMapper.kickfriendPlayer(params);
			}else{
				return AjaxMsg.newWarn().addMessage(messageResourceService.getMessage("system.warn.player.noblack"));
			}
		}catch (Exception e){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg kickTeam(String teaminfo_id, String player_id)throws Exception {
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt"));
			//获取球员在俱乐部中的职位 1:队长 2:副队长 3：普通球员
			Integer type = teamInfoMapper.getTeamPlayerPosition(teaminfo_id, player_id);
			if(type==null){
				return AjaxMsg.newWarn().addMessage(messageResourceService.getMessage("system.error.user.noplayer"));
			}else{
				TeamPlayer teamPlayer = teamInfoMapper.getTeamPlayerByUserId(player_id);
				if(null != teamPlayer){
					if(teamPlayer.getIs_sale() == 1){
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.userup"));
					}
				}
				//退出俱乐部
				teamInfoMapper.deleteTeamPlayer(teaminfo_id, player_id);
				updateTeamScore(teaminfo_id,"out");//add gl 踢出球员-3活跃度

				User caption = teamInfoMapper.getCaption(teaminfo_id);
				User player = userMapper.getEntityById(player_id);
				TeamInfo t = teamInfoMapper.getEntityById(teaminfo_id);
				//判断是否联赛球员
				PlayerInfo playerInfo = playerInfoMapper.getByUserId(player_id);
				if(null != playerInfo && null != playerInfo.getIf_league()){
					if(playerInfo.getIf_league() == 1){
						playerInfoMapper.updateLeagueStatus(player_id, new Integer(0));
					}
				}
				//更新联赛报名表状态
				LeagueSign leagueSign = leagueService.getLeagueSignInvalid(player_id);
				if(null != leagueSign){
					leagueSign.setInvalid(0);
					leagueService.updateQLeagueSign(leagueSign);
				}
				
				messageResourceService.saveMessageNoReply(new Object[]{player.getUsernick(),
						caption.getUsernick(),t.getName()}, "user.team.remove", player_id, caption.getId(),1);
			}
			return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg blackList(String teaminfo_id,PageModel pageModel) {
		List<Map<String, Object>> blackPlayerList = Lists.newArrayList();
		Map<String,Object> params = Maps.newHashMap();
		params.put("teaminfo_id", teaminfo_id);
		try {
			if(params!=null){
				int count = 0;
				if(pageModel!=null){
					count = teamInfoMapper.getBlackPlayerCount(params);
					params.put("start",pageModel.getFirstNum());
					params.put("rows",pageModel.getPageSize());
				}
				blackPlayerList = teamInfoMapper.getBlackPlayer(params);
				pageModel.setItems(blackPlayerList);
				pageModel.setTotalCount(count);
			}
			return AjaxMsg.newSuccess().addData("data", pageModel);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError();
		}
	}

	@Override
	public AjaxMsg checkCaptain(String teaminfo_id, String player_id, int type,HttpServletRequest request) throws Exception{
		List<TeamPlayer> teamPlayerList = Lists.newArrayList();
		Map<String,Object> params = Maps.newHashMap();
		params.put("teaminfo_id", teaminfo_id);
		params.put("type", type);
		params.put("player_id", player_id);
		User caption = teamInfoMapper.getCaption(teaminfo_id);
		TeamInfo t = teamInfoMapper.getEntityById(teaminfo_id);
			//指认队长
			if(type == 1){
				//查询队长信息并修改为普通球员
				Map<String,Object> paramsCaption = new HashMap<String,Object>();
				paramsCaption.put("teaminfo_id", teaminfo_id);
				paramsCaption.put("type", 3);
				paramsCaption.put("player_id", caption.getId());
				teamInfoMapper.updateType(paramsCaption);
				securityService.deleteUserRole(caption.getId(), "6");//added gl 删除前队长俱乐部管理权限
				//更新俱乐部管理者id
				t.setUser_id(player_id);
				teamInfoMapper.update(t);
				User player_user = userMapper.getEntityById(player_id);
				securityService.saveUserRole(player_user, "6");//added gl 给被指定用户添加俱乐部管理权限
				securityService.reloadUserRole(caption, request);//added gl 重新载入当前
				
				messageResourceService.saveMessageNoReply(new Object[]{caption.getUsernick(),t.getName()}, 
						"user.team.caption", player_id, caption.getId(),1);
				
			}else if(type == 2){ //指认副队长
				//判断副队长是否达到2个的上限
				teamPlayerList = teamInfoMapper.getTeamPlayer(params);
				if(!teamPlayerList.isEmpty() && teamPlayerList.size() == 2){
					return AjaxMsg.newError().addMessage("副队长名额已达到上限");
				}
				messageResourceService.saveMessageNoReply(new Object[]{caption.getUsernick(),t.getName()}, 
						"user.team.cocaption", player_id, caption.getId(),1);
			}
			teamInfoMapper.updateType(params);		
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg searchInviteTeam(Map<String, Object> params, PageModel pageModel) {
		List<TeamInfo> datas = Lists.newArrayList();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = teamInfoMapper.searchInviteTeamCount(params);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = teamInfoMapper.searchInviteTeam(params);
			pageModel.setTotalCount(count);
			pageModel.setItems(datas);
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg getCaption(String teaminfo_id) {
		User user = teamInfoMapper.getCaption(teaminfo_id);
		return AjaxMsg.newSuccess().addData("user", user);
	}
	
	@Override
	public AjaxMsg saveFocus(Focus focus) {
		if(focus==null) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		try {
			if(StringUtils.isBlank(focus.getId())){
				focus.setId(UUIDGenerator.getUUID());
			}
			teamInfoMapper.saveFocus(focus);
			updateTeamScore(focus.getF_teaminfo_id(),"focus");
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
	}
	
	@Override
	public AjaxMsg deleteFocus(String user_id, String f_teaminfo_id) {
		if(StringUtils.isNotBlank(user_id) && StringUtils.isNotBlank(f_teaminfo_id)){
			teamInfoMapper.deleteFocus(user_id, f_teaminfo_id);
			try {
				updateTeamScore(f_teaminfo_id,"unfocus");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
			
		}
	}

	@Override
	public Map<String,Object> getTeamAbilityScore(String teaminfo_id) {
		return teamInfoMapper.getTeamAbilityScore(teaminfo_id);
		
	}

	@Override
	public TeamPlayer getTeamPlayerInfoByIds(String user_id, String teaminfo_id) {
		return teamInfoMapper.getTeamPlayerInfoByIds(user_id, teaminfo_id);
		
	}

	@Override
	public TeamPlayer getTeamPlayerByUserId(String user_id) {
		return teamInfoMapper.getTeamPlayerByUserId(user_id);
		
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg loadHistoryTeamGame(String teaminfo_id,
			PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		if(StringUtils.isBlank(teaminfo_id))return AjaxMsg.newError().addMessage("参数错误！");
		int totalCount = teamInfoMapper.loadHistoryTeamGameCount(teaminfo_id, maps);
		pageModel.setPageSize(4);
			maps.put("start",pageModel.getFirstNum());
			maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> lists = teamInfoMapper.loadHistoryTeamGame(teaminfo_id, maps);
		pageModel.setTotalCount(totalCount);
		pageModel.setItems(lists);
		return AjaxMsg.newSuccess().addData("page", pageModel);
		
	}

	@Override
	public AjaxMsg dissolvePlayers(String teaminfo_id)throws Exception{
			teamInfoMapper.deleteTeamPlayer(teaminfo_id, null);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg dissolveTeam(String user_id,String teaminfo_id,HttpServletRequest request) throws Exception {
		AjaxMsg msg = AjaxMsg.newError();
		if (StringUtils.isBlank(teaminfo_id))
			return msg.addMessage(messageResourceService.getMessage("system.error.team.noteam"));
		//added by bo.xie 报名联赛俱乐部，联赛期间不能解散 start
		TeamLeague tl = leagueMapper.getTeamLeague(teaminfo_id);
		if(null!=tl)return msg.addMessage(messageResourceService.getMessage("team.league.nodissolve"));
		//added by bo.xie 报名联赛俱乐部，联赛期间不能解散 end
		
		TeamPlayer tp = this.getTeamPlayerInfoByIds(user_id,teaminfo_id);
		if (tp == null)
			return msg.addMessage(messageResourceService.getMessage("system.error.team.noteam"));
		if (tp.getType() != 1) {// 球员类型 1:队长 2:副队长 3：普通球员
			return msg.addMessage(messageResourceService.getMessage("system.error.team.disteam"));
		}
		TeamInfo teamInfo = teamInfoMapper.getEntityById(teaminfo_id);
		teamInfo.setIs_exist(0);
		teamInfoMapper.update(teamInfo);
		securityService.deleteUserRole(teamInfo.getUser_id(), "6");//added gl 删除前队长俱乐部管理权限
		User user = userMapper.getEntityById(teamInfo.getUser_id());
		securityService.reloadUserRole(user, request);//added gl 重新载入当前用户权限
		//解散球员表信息
		this.dissolvePlayers(teamInfo.getId());
		//解散入住宝贝
		babyInService.dissolveAllBabyTeam(teaminfo_id);
		//messageResourceService.saveTeamDynamicMessage(new Object[]{teamInfo.getName()}, "square.team.dissolve", teaminfo_id);
		//广场推送消息
		/*msg = autoInfoMationService.sendInfo(teamInfo.getUser_id(), teamInfo.getUser_id(), MSGTYPE.INDEX.toString(), SYSTYPE.TAPK.toString(), 
				messageResourceService.getMessage(new Object[]{teamInfo.getName()}, "square.team.dissolve"));*/
		
		
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg updateTeamScore(String teamId, String type) throws Exception {
		//type 加入球队(join) 踢出、拉黑、退出(out) 关注(focus) 取消关注(unfocus)
		TeamInfo teamInfo = teamInfoMapper.getEntityById(teamId);
		return updateTeamScore(teamInfo,type);
	}
	@Override
	public AjaxMsg updateTeamScore(TeamInfo teamInfo, String type) throws Exception {
		//type 加入球队(join) 踢出、拉黑、退出(out) 关注(focus) 取消关注(unfocus)
		teamInfo = editTeamScore(teamInfo,type);
		return update(teamInfo);
	}
	
	@Override
	public TeamInfo editTeamScore(TeamInfo teamInfo, String type) throws Exception {
		//type 加入球队(join) 踢出、拉黑、退出(out) 关注(focus) 取消关注(unfocus)
		int score = teamInfo.getScore();
		if("join".equals(type)){
			score+=3;
		}else if("out".equals(type)){
			score-=3;
		}else if("focus".equals(type)){
			score+=5;
		}else if("unfocus".equals(type)){
			score-=5;
		}else{
			Integer num = Integer.parseInt(type);
			score+=num;
		}
		teamInfo.setScore(score);
		return teamInfo;
	}
	
	public int ifBlackPlayer(String teaminfo_id,String player_id){
		Map<String,Object> params = Maps.newHashMap();
		params.put("teaminfo_id", teaminfo_id);
		params.put("player_id", player_id);
		List<Map<String, Object>> listBlackPlayer = Lists.newArrayList();
		listBlackPlayer = teamInfoMapper.getBlackPlayer(params);
		if(!listBlackPlayer.isEmpty() && listBlackPlayer.size()>0){
			return 1;
		}
		return 0;
	}

	@Override
	public int getFocusTeams(String user_id, String f_teaminfo_id) {
		return teamInfoMapper.getFocusTeams(user_id, f_teaminfo_id);
	}

	@Override
	public AjaxMsg updateNotice(String teaminfo_id, String notice)throws Exception {
		teamInfoMapper.updateNotice(teaminfo_id, notice);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public int teamPlayerCount(String teaminfo_id) {
		return teamInfoMapper.teamPlayerCount(teaminfo_id);
	}

	@Override
	public void saveTeamActiveCode(TeamActiveCode teamActiveCode) {
		teamInfoMapper.saveTeamActiveCode(teamActiveCode);
	}

	@Override
	public void updateTeamActiveCode(TeamActiveCode teamActiveCode) {
		teamInfoMapper.updateTeamActiveCode(teamActiveCode);
	}

	@Override
	public List<TeamActiveCode> getTeamActiveCodeByTid(String teaminfo_id) {
		return teamInfoMapper.getTeamActiveCodeByTid(teaminfo_id);
	}

	@Override
	public AjaxMsg buyActiveCode(String price,String user_id, String teaminfo_id,Integer total,String league_id) {
		//生成激活码字符串
		
		//update by bo.xie 个人账户转俱乐部账户	start
			//UserAmount ua = userAmountMapper.getByUserId(user_id);
		UserAmount ua = userAmountMapper.getUserAmountByTeaminfoID(teaminfo_id);
		//update by bo.xie 个人账户转俱乐部账户	end
		
		//判断俱乐部资金是否可用
		if(ua.getStatus()==2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.freeze"));
		BigDecimal real_amount = ua.getReal_amount();//可用金额
		BigDecimal amount = new BigDecimal(price);//消费金额
		if(real_amount.compareTo(amount)<0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.not_enough"));
		
		//保存俱乐部购买激活码信息
		for(int i=0;i<total.intValue();i++){
			TeamActiveCode tac = new TeamActiveCode();
			String code_str = Common.creteActiveCode();
			tac.setId(UUIDGenerator.getUUID());
			tac.setCode_str(code_str);
			tac.setTeaminfo_id(teaminfo_id);
			League league = leagueService.getEntityById(league_id);
			//String player_code_time = ParamMap.getParam("buy_active_code","player_code_time");
			tac.setEnd_time(league.getEnd_time());
			tac.setIf_use(1);
			tac.setLeague_id(league_id);
			teamInfoMapper.saveTeamActiveCode(tac);
		}
		//更新俱乐部可用资金
		ua.setAmount(ua.getAmount().subtract(amount));
		ua.setReal_amount(real_amount.subtract(amount));
		userAmountMapper.update(ua);
		
		//保存俱乐部消费记录
		PayCost pc = new PayCost();
		pc.setId(UUIDGenerator.getUUID());
		pc.setAmount(amount);
		pc.setTeaminfo_id(teaminfo_id);
		pc.setStatus(1);
		pc.setNum_str(Common.createOrderOSN());
		pc.setDescrible("俱乐部购买激活码！");
		payCostMapper.save(pc);
		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public TeamActiveCode getTeamActiveCode(String code_str) {
		return teamInfoMapper.getTeamActiveCode(code_str);
	}

	@Override
	public AjaxMsg deleteAllPlayers(String teaminfo_id) {
		int num = teamInfoMapper.deleteAllPlayers(teaminfo_id);
		TeamInfo info = getEntityById(teaminfo_id);
		int score = info.getScore();
		score = score - num * 3;
		return update(info);
	}

	@Override
	public int isJoinTeamForPlayer(String user_id) {
		return teamInfoMapper.isJoinTeamForPlayer(user_id);
	}

	@Override
	public int teamBabyCount(String teaminfo_id) {
		return babyInService.teamBabyCount(teaminfo_id);
	}

	@Override
	public int teamPlayerPrice(String teaminfo_id) {
		return teamInfoMapper.teamPlayerPrice(teaminfo_id);
	}
	
	@Override
	public AjaxMsg salePlayer(Map<String, Object> param) throws Exception {
		String user_id = BeanUtils.nullToString(param.get("user_id"));//挂牌球员用户ID
		String price = BeanUtils.nullToString(param.get("price"));//球员挂牌价
		String if_one = BeanUtils.nullToString(param.get("if_one"));//球员挂牌价
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(price))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
	
		TeamPlayer tp = teamInfoMapper.getTeamPlayerByUserId(user_id);
		
		//判断该俱乐部是否是联赛俱乐部，只有联赛俱乐部才能出售球员
		TeamLeague tl = leagueMapper.getTeamSignByLeague(tp.getTeaminfo_id(),null);
		if(tl==null)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.team_sale"));
		
		//判断该球员是否已在球员出售市场中并且未出售
		LeagueMarket old_leagueMarket = leagueMarketMapper.getLeagueMarketByUserIDAndStatus(user_id, "0");
		if(old_leagueMarket!=null) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.player.isSale"));
		
		MarketCfg cfg = leagueMarketMapper.getCurrentMarket(tl.getS_id());
		if(null == cfg || cfg.getIf_open() == 0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
		}
		
		// 更新球员状态为挂牌出售当中,往球员跳蚤市场表中插入球员信息
		tp.setIs_sale(1);
		teamInfoMapper.updateTeamPlayer(tp);
		LeagueMarket lm = new LeagueMarket();
		lm.setId(UUIDGenerator.getUUID());
		lm.setIf_up(1);
		lm.setPrice(new BigDecimal(price));
		lm.setStatus(0);
		lm.setTeam_id(tp.getTeaminfo_id());
		lm.setUser_id(user_id);
		lm.setS_id(tl.getS_id());
		lm.setTurn_num(cfg.getTurn_num());
		lm.setIf_one(Integer.valueOf(if_one));
		leagueMarketMapper.save(lm);
		//添加到球员出售记录表中
		TeamSale ts = new TeamSale();
		ts.setId(UUIDGenerator.getUUID());
		ts.setTeaminfo_id(tp.getTeaminfo_id());
		ts.setUser_id(user_id);
		ts.setStatus(2);
		playerInfoMapper.saveTeamSale(ts);
		
		//球员挂牌出售后短信通知出售球员
		StringBuilder sb = new StringBuilder();
		User user = userMapper.getEntityById(user_id);
		TeamInfo ti = teamInfoMapper.getEntityById(tp.getTeaminfo_id());
		sb.append("@1@=").append(user.getUsernick()).append(",@2@=").append(ti.getName());
		AjaxMsg msg = SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880039.toString());
		if(msg.isError()){
			logger.error("挂牌出售球员短信发送失败！");
		}
		
		//将其他求购该球员的信息全部拒绝
		//获取其他求购信息
		List<TransferMsg> tms = teamInviteMapper.queryUntreatedTransferMsg(tp.getTeaminfo_id(),user_id);//查询关于该球员未处理转会请求
		if(tms!=null&&tms.size()>0){
			for (TransferMsg transferMsg : tms) {
				transferMsg.setStatus(2);
				teamInviteMapper.updateTransferMsg(transferMsg);
				//发送站内信息
				TeamInfo bteam = teamInfoMapper.getEntityById(transferMsg.getBuy_teaminfo_id());
				User bplayer = userMapper.getEntityById(transferMsg.getUser_id());
				if(bteam!=null&&bplayer!=null){
					String busername = StringUtils.isNotBlank(bplayer.getUsername())?bplayer.getUsername():bplayer.getUsernick();
					messageResourceService.saveMessage(new Object[]{ti.getName(),busername}, SYSTYPE.BUYFALSE.toString(), "team.buyplayer.reject", bteam.getUser_id(), ti.getUser_id(), transferMsg.getId(), 1);
				}
			}
		}
		
		//查询该球员所有未失效和未处理租借信息
		List<TeamLoanMsg> tls = teamLoanPlayerMapper.queryUntreatedTeamLoanMsg(tp.getTeaminfo_id(),user_id);
		String uname = StringUtils.isNotBlank(user.getUsername())?user.getUsername():user.getUsernick();
		if(tls!=null&&tls.size()>0){
			for (TeamLoanMsg teamLoanMsg : tls) {
				teamLoanMsg.setStatus(2);
				teamLoanPlayerMapper.updateTeamLoanMsg(teamLoanMsg);
				
				TeamInfo buy_team = teamInfoMapper.getEntityById(teamLoanMsg.getBuy_teaminfo_id());
				//发送站内信息
				messageResourceService.saveMessage(new Object[]{ti.getName(),uname}, SYSTYPE.LOANFALSE.toString(), "team.loan.reject", buy_team.getUser_id(), ti.getUser_id(), teamLoanMsg.getId(), 1);
			}
		}
		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg queryNoticeForPage(Map<String, Object> maps, PageModel pageModel) {
		List<TeamNotice> datas = Lists.newArrayList();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = countNotice(maps);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = teamInfoMapper.queryNoticeForPage(maps);
			pageModel.setTotalCount(count);
			pageModel.setItems(datas);
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
		
	}

	@Override
	public int countNotice(Map<String, Object> maps) {
		return teamInfoMapper.countNotice(maps);
	}

	@Override
	public TeamNotice getNoticeById(String id) {
		return teamInfoMapper.getNoticeById(id);
	}

	@Override
	public AjaxMsg saveTeamNotice(TeamNotice teamNotice) throws Exception {
		TeamNotice c_teamNotice = teamInfoMapper.getCurrentNotice(teamNotice.getTeaminfo_id());
		if(null != c_teamNotice && c_teamNotice.getSort() == 0){
			c_teamNotice.setSort(1);
			teamInfoMapper.updateTeamNotice(teamNotice);
		}
		teamNotice.setId(UUIDGenerator.getUUID());
		teamInfoMapper.saveTeamNotice(teamNotice);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg updateTeamNotice(TeamNotice teamNotice) throws Exception {
		teamInfoMapper.updateTeamNotice(teamNotice);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public List<Map<String, Object>> getTeamPlayerByTeamInfoID(String teaminfo_id) {
		return teamInfoMapper.getTeamPlayerByTeamInfoID(teaminfo_id);
	}

	@Override
	public List<TeamPlayerWage> getTeamPlayer(String teaminfo_id) {
		List<TeamPlayerWage> tpwList = new ArrayList<TeamPlayerWage>();
		List<Map<String, Object>> sl = teamInfoMapper.getMyTeamPlayer(teaminfo_id);
		for(Map<String, Object> map:sl){
			TeamPlayerWage tpw = new TeamPlayerWage();
			tpw.setDynamic_id(teaminfo_id);
			tpw.setUser_id(map.get("user_id").toString());
			tpw.setPlayer_num(Common.getString(map.get("player_num")));
			tpw.setPosition(Common.getString(map.get("position")));

			String userid = tpw.getUser_id();
			User user = null;
			if (EhCache.getInstance().isCache(userid)) {
				EhCacheObj o = EhCache.getInstance().get(userid);
				user = (User) o.getObj();
			} else {
				user=EhCache.getInstance().addUserToCache(userService, userid);
			}
			if (user != null) {
				tpw.setUser_name(user.getUsernick());
			}
			tpwList.add(tpw);
		}
		return tpwList;
	}
	@Override
	public ReturnJosnMsg wagePayrollSave(Map<String, String> maps) {
		String userids = maps.get("ids");
		String srmsg_id = maps.get("salary_msg_id");
		String[] ids = userids.split("\\|");
		List<String> srList = new ArrayList<String>();
		for(String uid:ids){
			String user_id=uid.replaceAll("wage_", "");
			srList.add(user_id);
		}

		SalaryMsg  salaryMsg= leagueService.getSalaryMsgByID(srmsg_id);
		if(salaryMsg.getStatus()!=0){
			return new ReturnJosnMsg(-1,"Status Error.");
		}
		List<SalaryRecord> srmsgList = leagueService.getSalaryRecord(srmsg_id);
		for(SalaryRecord sr:srmsgList){
			if(srList.contains(sr.getId())){
				int v = JSONUtils.toInt(maps.get("wage_"+sr.getId()));
				sr.setBonus(new BigDecimal(v));
				sr.setReal_salary(sr.getSalary().add(sr.getBonus()));
			}else{
				sr.setBonus(new BigDecimal(0));
				sr.setReal_salary(sr.getSalary());
			}
			leagueService.updateSalaryRecord(sr);
		}

		ReturnJosnMsg retmsg = ReturnJosnMsg.newSuccess();
		return retmsg;
	}
	@Override
	public ReturnJosnMsg wageSave(Map<String, String> maps) {
		String userids = maps.get("userids");
		String teaminfo_id = maps.get("teaminfo_id");
		String login_user_id = maps.get("login_user_id");
		String[] ids = userids.split("\\|");
		int priceSum = 0;//本次发放总金额
		List<TeamPlayer> pcList = new ArrayList<TeamPlayer>();
		for(String uid:ids){
			int v = JSONUtils.toInt(maps.get(uid));
			String user_id=uid.replaceAll("wage_", "");
			priceSum+=v;
			TeamPlayer pc = new TeamPlayer();
			pc.setSalary(new BigDecimal(v));
			pc.setUser_id(user_id);
			pc.setTeaminfo_id(teaminfo_id);
			pcList.add(pc);
		}

		int stuts = updateTeamAmount(login_user_id, priceSum,pcList);
		String errMsg = null;
		ReturnJosnMsg retmsg = ReturnJosnMsg.newError();
		if(stuts==0){
			retmsg =ReturnJosnMsg.newSuccess();
			
		}if(stuts==1){
			errMsg = messageResourceService.getMessage("user.amount.freeze");
			retmsg = new ReturnJosnMsg(-1,errMsg);
		}else if(stuts==2){
			errMsg =messageResourceService.getMessage("user.amount.not_enough");
			retmsg = new ReturnJosnMsg(-1,errMsg);
		}
		
		return retmsg;
	}

	private int updateTeamAmount(String login_user_id, int priceSum,List<TeamPlayer> pcList){
		//udpate by bo.xie 个人账户转俱乐部账户	start
			//UserAmount teamUserAmount = userAmountMapper.getByUserId(login_user_id);
		TeamInfo tt = teamInfoMapper.getTeamInfoByUserId(login_user_id);
		UserAmount teamUserAmount = userAmountMapper.getUserAmountByTeaminfoID(tt.getId());
		//udpate by bo.xie 个人账户转俱乐部账户	end
		//获取购买者资金账户,并判断可用资金是否足够
		if(teamUserAmount==null||teamUserAmount.getStatus()==2)return 1;
		if(teamUserAmount.getReal_amount().compareTo(new BigDecimal(priceSum))<0){
			return 2;
		}
		
		//更新用户资金表
		teamUserAmount.setAmount(teamUserAmount.getAmount().subtract(new BigDecimal(priceSum)));
		teamUserAmount.setReal_amount(teamUserAmount.getReal_amount().subtract(new BigDecimal(priceSum)));
		userAmountMapper.update(teamUserAmount);
		
		int mount = pcList.size();
		//保存用户订单信息
		Order order = new Order();
		order.setId(UUIDGenerator.getUUID());
		order.setMount(mount);
		order.setNum_str(Common.createOrderOSN());
		order.setP_code("salary");
		order.setPrice(new BigDecimal(priceSum));
		order.setSum_amount(new BigDecimal(priceSum));
		//order.setUser_id(login_user_id);
		order.setTeaminfo_id(tt.getId());
		orderMapper.save(order);
		String order_id = order.getId();
		String order_num = order.getNum_str();


		//获取手续费用
		String fee_str = "0.05";
		BigDecimal fee_money = new BigDecimal(0);
		for(TeamPlayer pc:pcList){
			BigDecimal am_fee =pc.getSalary().multiply(new BigDecimal(fee_str)).setScale(2);
			fee_money=fee_money.add(am_fee);
			BigDecimal am = pc.getSalary().subtract(am_fee);
			UserAmount userAmount = userAmountMapper.getByUserId(pc.getUser_id());
			userAmount.setAmount(userAmount.getAmount().add(am));
			userAmount.setReal_amount(userAmount.getReal_amount().add(am));
			userAmountMapper.update(userAmount);

			PayCost pcIncome = new PayCost();
			pcIncome.setId(UUIDGenerator.getUUID());
			pcIncome.setAmount(am);
			pcIncome.setDescrible("工资收入");
			pcIncome.setNum_str(order_num);
			pcIncome.setStatus(1);
			pcIncome.setOrder_id(order_id);
			pcIncome.setUser_id(pc.getUser_id());
			pcIncome.setP_code("salary");
			payCostMapper.save(pcIncome);

			PayCost pcPay = new PayCost();
			pcPay.setId(UUIDGenerator.getUUID());
			pcPay.setAmount(pc.getSalary());
			pcPay.setDescrible("工资发放");
			pcPay.setNum_str(order_num);
			pcPay.setStatus(1);
			pcPay.setOrder_id(order_id);
			//pcPay.setUser_id(login_user_id);
			pcPay.setTeaminfo_id(tt.getId());
			pcPay.setP_code("salary");
			payCostMapper.save(pcPay);
			
			//更新球员当前工资
			TeamPlayer tp = teamInfoMapper.getTeamPlayerByUserID(pc.getTeaminfo_id(), pc.getUser_id());
			if(null != tp){
				tp.setSalary(pc.getSalary());
				teamInfoMapper.updTeamPlayer(tp);
			}
		}
		
		//保存手续费记录
		Fee fee = new Fee();
		fee.setId(UUIDGenerator.getUUID());
		fee.setFee_money(fee_money);
		fee.setOrder_id(order_id);
		userAmountMapper.saveFee(fee);	
		return 0;
	}

	@Override
	public List<Map<String, Object>> getAllTPsTeamInfoID(String teaminfo_id) {
		return teamInfoMapper.getAllTPsTeamInfoID(teaminfo_id);
	}

	@Override
	public void updatePlayerPosition(List<PPosition> pp) {
		if(pp.size()>0){
			for (PPosition p : pp) {
				//if(p.getIsCheck()!=0){
					Map<String,Object> maps = Maps.newHashMap();
					maps.put("id", p.getId());
					maps.put("position", p.getPosition());
					maps.put("position_num", p.getPosition_num());
					teamInfoMapper.updatePlayerPosition(maps);
				//}
			}
		}
	}

	@Override
	public AjaxMsg updateNum(String id, int num) throws Exception {
		teamInfoMapper.updateNum(id,num);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public Map<String, Object> getTeamPlayerMap(String id) {
		return teamInfoMapper.getTeamPlayerMap(id);
	}

	@Override
	public AjaxMsg cancelSalePlayer(Map<String, Object> param) {
		String id = String.valueOf(param.get("id"));//俱乐部成员表ID
		if(StringUtils.isBlank(id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		// 更新球员状态为挂牌出售当中,往球员跳蚤市场表中插入球员信息
		TeamPlayer tp = teamInfoMapper.getTeamPlayerByID(id);
		tp.setIs_sale(0);
		teamInfoMapper.updateTeamPlayer(tp);
		LeagueMarket lm = leagueMarketMapper.getLeagueMarketByUserIDAndStatus(tp.getUser_id(),"0");
		if(StringUtils.isBlank(lm.getBuyer())){
			leagueMarketMapper.delete(lm.getId());
			//删除出售记录
			TeamSale ts = playerInfoMapper.getTeamSaleByUserID(tp.getUser_id(), "2");
			if(ts!=null)playerInfoMapper.deleteTeamSale(ts.getId());
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.cancelerr"));
		}
	}

	@Override
	public AjaxMsg loadAllTeamApplys(Map<String, Object> maps, PageModel pageModel) {
		int totalCount = teamInfoMapper.loadAllTeamApplysCount(maps);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> datas = teamInfoMapper.loadAllTeamApplys(maps);
		pageModel.setItems(datas);
		pageModel.setTotalCount(totalCount);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg agreeTeamApply(String teaminfo_id, String user_id, String type) throws Exception {
		 TeamInfo teamInfo = teamInfoMapper.getEntityById(teaminfo_id);
		if(type.equals("1")){//同意入队申请
				AjaxMsg msg = applyTeamParamJudge(teaminfo_id, user_id,type);
				if(msg.isError())return msg;
				TeamPlayer tp = new TeamPlayer();
				tp.setId(UUIDGenerator.getUUID());
				tp.setTeaminfo_id(teaminfo_id);
				tp.setType(3);//球员类型 1:队长 2:副队长 3：普通球员
				tp.setUser_id(user_id);
				teamInfoMapper.saveTeamPlayer(tp);
				updateTeamScore(teaminfo_id,"join");//add gl 球员加入球队加3活跃度
				User user =  userMapper.getEntityById(user_id);
				//更新入队申请记录状态
				TeamApply old_teamApply = teamInfoMapper.getTeamApplyByUIDAndTID(teaminfo_id, user_id);
				if(old_teamApply==null)AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
				old_teamApply.setStatus(1);
				teamInfoMapper.updateTeamApply(old_teamApply);
				//发送俱乐部动态消息
				msg = messageResourceService.saveTeamDynamicMessage(new Object[]{user.getUsernick(),teamInfo.getName(),user.getId(),teamInfo.getUser_id()},"square.user.join",teaminfo_id);
				//发送队长消息	
//				msg = messageResourceService.saveMessageNoReply(new Object[]{user.getUsernick(),teamInfo.getName()},
//						"square.user.join", teamInfo.getUser_id() , teamInfo.getUser_id());
				//广场推送消息
				msg = autoInfoMationService.sendInfo(teamInfo.getUser_id(), teamInfo.getUser_id(), MSGTYPE.INDEX.toString(), SYSTYPE.TAPK.toString(), 
						messageResourceService.getMessage(new Object[]{user.getUsernick(),teamInfo.getName(),user.getId(),teamInfo.getUser_id()},
						"square.user.join"));
		}else{//不同意入队申请
			//更新入队申请记录状态
			TeamApply old_teamApply = teamInfoMapper.getTeamApplyByUIDAndTID(teaminfo_id, user_id);
			if(old_teamApply==null)AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
			old_teamApply.setStatus(2);
			teamInfoMapper.updateTeamApply(old_teamApply);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	/**
	 * 球员入队申请条件判断
	 * @param teaminfo_id 申请入队俱乐部ID
	 * @param user_id 申请用户ID
	 * @return
	 */
	private AjaxMsg applyTeamParamJudge(String teaminfo_id, String user_id,String type) {
		LeagueSign leagueSign = leagueMapper.getLeagueSignInvalid(user_id);
		if(leagueSign!=null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.repeatpsign"));
		}
		if(StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(user_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt"));
		//判断是否为球员
		PlayerInfo playerInfo = playerInfoMapper.getByUserId(user_id);
		if(null == playerInfo || null == playerInfo.getId()) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.noplayer"));
		//判断是否加入其他球队
		int count = teamInfoMapper.isJoinTeamForPlayer(user_id);
		if(count>0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.joined"));
		//判断俱乐部是否允许加入
		TeamInfo teamInfo = teamInfoMapper.getEntityById(teaminfo_id);
		if(teamInfo.getAllow() == 0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.team.noallow"));
		//update by bo.xie 判断是否已申请入队俱乐部 2015年12月1日17:03:09 start
		if(!"1".equals(type)){
			TeamApply old_teamApply = teamInfoMapper.getTeamApplyByUIDAndTID(teaminfo_id, playerInfo.getUser_id());
			if(old_teamApply!=null && old_teamApply.getStatus() == 0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.applied"));
		}
		//update by bo.xie 判断是否已申请入队俱乐部 2015年12月1日17:03:09 end
		return AjaxMsg.newSuccess();
	}

	@Override
	public TeamInfo getTeamInfoByPUserID(String p_user_id) {
		return teamInfoMapper.getTeamInfoByPUserID(p_user_id);
	}
	
	@Override
	@CacheEvict(value = "objCache",key = "'tId'+#teamInfo.id")
	public AjaxMsg update(TeamInfo teamInfo) {
		try {
			teamInfoMapper.update(teamInfo);
			return  AjaxMsg.newSuccess().addData("data", teamInfo);
		} catch (Exception e) {
			return AjaxMsg.newError();
		}
	}
	
	@Override
	@Cacheable(value = "objCache",key = "'tId'+#id")
	public String id2Name(String id){
		return teamInfoMapper.id2Name(id);
	}

	@Override
	public int teamExistByTeamName(String name) {
		return teamInfoMapper.teamExistByTeamName(name);
	}

	@Override
	public AjaxMsg deleteNotice(String id) {
		if(StringUtils.isNotBlank(id)){
			teamInfoMapper.deleteTeamNotice(id);
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg queryRecommends(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = teamInfoMapper.recommendsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = teamInfoMapper.queryRecommends(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<Map<String, Object>> queryTeamInfoByName(String name) {
		return teamInfoMapper.queryTeamInfoByName(name);
	}

	@Override
	public List<TeamPlayer> getTeamPlayersByTeamInfoId(String teamInfoId) {
		Map<String, Object> params = Maps.newHashMap();
		params.put("teaminfo_id", teamInfoId);
		List<TeamPlayer> teamPlayerList = teamInfoMapper.getTeamPlayer(params);
		return teamPlayerList;
	}

	@Override
	public AjaxMsg payForTeam(Map<String, Object> maps)throws Exception {
		String teaminfo_id = String.valueOf(maps.get("teaminfo_id"));//充值俱乐部ID
		String user_id = String.valueOf(maps.get("user_id"));//为俱乐部充值的用户ID
		BigDecimal amount = new BigDecimal(String.valueOf(maps.get("amount")));//充值宇拓币
		//获取个人账户
		UserAmount user_amount = userAmountMapper.getByUserId(user_id);
		//获取俱乐部账户
		UserAmount team_amount = userAmountMapper.getUserAmountByTeaminfoID(teaminfo_id);
		
		//判断个人资金用户是否可用
		if(user_amount.getStatus()==2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.freeze"));
		//判断个人资金用户，资金是否足够
		if(user_amount.getReal_amount().compareTo(amount)<0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.not_enough"));
		
		//更新俱乐部账户余额
		team_amount.setAmount(team_amount.getAmount().add(amount));
		team_amount.setReal_amount(team_amount.getReal_amount().add(amount));
		userAmountMapper.update(team_amount);
		//保存俱乐部账户充值记录
		BigDecimal cash = amount.divide(new BigDecimal(100),2, RoundingMode.HALF_UP);//人民币
		String order_no = Common.createOrderOSN();
		PayRecord pr = new PayRecord();
		pr.setId(UUIDGenerator.getUUID());
		pr.setAmount(cash);
		pr.setFree(new BigDecimal(0));
		pr.setOrder_no(order_no);
		pr.setTeaminfo_id(teaminfo_id);
		pr.setOperate_id(user_id);
		pr.setReal_amount(cash.subtract(new BigDecimal(0)));
		pr.setStatus(1);
		pr.setSubmit_time(new Date());
		pr.setEnd_time(new Date());
		pr.setWay(WayType.ONSITE.toString());
		pr.setDescrible("平台账户转账");
		pr.setType(1);
		payRecordMapper.save(pr);
		
		//扣除个人账户金额
		user_amount.setAmount(user_amount.getAmount().subtract(amount));
		user_amount.setReal_amount(user_amount.getReal_amount().subtract(amount));
		userAmountMapper.update(user_amount);
		
		//插入个人消费记录
		PayCost pc = new PayCost();
		pc.setId(UUIDGenerator.getUUID());
		pc.setAmount(cash);
		pc.setUser_id(user_id);
		pc.setNum_str(order_no);
		pc.setStatus(1);
		pc.setDescrible("个人为俱乐部充值");
		payCostMapper.save(pc);
		
		//往俱乐部贡献榜表中插入数据
		AmountDetail ad = new AmountDetail();
		ad.setId(UUIDGenerator.getUUID32());
		ad.setAmount(amount);
		ad.setTeaminfo_id(teaminfo_id);
		ad.setUser_id(user_id);
		userAmountMapper.saveTeamAmountDetail(ad);
		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@SuppressWarnings("rawtypes")
	@Override
	public AjaxMsg loadAllTeamMsg(Map<String, Object> maps,PageModel pageModel) {
		maps.put("firstNum", pageModel.getFirstNum());
		maps.put("pageSize", pageModel.getPageSize());
		int totalCount = teamInfoMapper.loadAllTeamMsgCount(maps);
		List<Map<String,Object>> items = teamInfoMapper.loadAllTeamMsg(maps);
		pageModel.setTotalCount(totalCount);
		pageModel.setItems(items);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}
	
	@Override
	public int loadAllTeamMsgCount(Map<String, Object> maps) {
		int totalCount = teamInfoMapper.loadAllTeamMsgCount(maps);
		return totalCount;
	}
	
	@Override
	public ReturnJosnMsg wagePayrollSend(Map<String, String> maps)throws Exception{
		String srmsg_id = maps.get("salary_msg_id");
		String login_user_id = maps.get("login_user_id");
		SalaryMsg  salaryMsg= leagueService.getSalaryMsgByID(srmsg_id);
		if(salaryMsg.getStatus()!=0){
			new ReturnJosnMsg(-1,"Status Error.");
		}
		
		List<SalaryRecord> srmsgList = leagueService.getSalaryRecord(srmsg_id);

		List<TeamPlayer> pcList = new ArrayList<TeamPlayer>();
		int priceSum = 0;
		for(SalaryRecord sr:srmsgList){
			TeamPlayer pc = new TeamPlayer();
			pc.setSalary(sr.getReal_salary());
			pc.setUser_id(sr.getUser_id());
			pc.setTeaminfo_id(sr.getTeaminfo_id());
			pcList.add(pc);
			priceSum+=pc.getSalary().intValue();
		}

		int stuts = updateTeamAmount(login_user_id, priceSum,pcList);
		String errMsg = null;
		ReturnJosnMsg retmsg = ReturnJosnMsg.newError();
		if(stuts==0){
			retmsg =ReturnJosnMsg.newSuccess();
			salaryMsg.setStatus(1);
			leagueService.updateSalaryMsg(salaryMsg);
		}if(stuts==1){
			errMsg = messageResourceService.getMessage("user.amount.freeze");
			retmsg = new ReturnJosnMsg(-1,errMsg);
		}else if(stuts==2){
			errMsg =messageResourceService.getMessage("user.amount.not_enough");
			retmsg = new ReturnJosnMsg(-1,errMsg);
		}
		
		return retmsg;
	}

	@Override
	public List<Map<String, Object>> queryTeamPlayerByTid(String id) {
		return teamInfoMapper.queryTeamPlayerByTid(id);
	}

	@Override
	public AjaxMsg checkSimNameAgain(String sim_name, String id) {
		List<TeamInfo> teams = teamInfoMapper.checkSimNameAgain(sim_name,id);
		if(teams!=null&&teams.size()>0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.simname")); 
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg updateTeamName(TeamInfo team) {
		UserAmount amount = userAmountMapper.getUserAmountByTeaminfoID(team.getId());
		if(amount==null||amount.getStatus()==2){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("team.amount.freeze")); 
		}
		BigDecimal price = new BigDecimal(30000);
		if(amount.getReal_amount().compareTo(price)<0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("team.amount.not_enough")); 
		}
		//更新用户资金表
		amount.setAmount(amount.getAmount().subtract(price));
		amount.setReal_amount(amount.getReal_amount().subtract(price));
		userAmountMapper.update(amount);
		//创建消费记录
		String order_num = Common.createOrderOSN();
		PayCost pcPay = new PayCost();
		pcPay.setId(UUIDGenerator.getUUID());
		pcPay.setAmount(price);
		pcPay.setDescrible(messageResourceService.getMessage("team.info.changname"));
		pcPay.setNum_str(order_num);
		pcPay.setStatus(1);
		pcPay.setOrder_id(null);
		pcPay.setTeaminfo_id(team.getId());
		pcPay.setP_code("changetname");
		payCostMapper.save(pcPay);
		//修改俱乐部
		update(team);
		return AjaxMsg.newSuccess();
	}

	@Override
	public List<TeamActiveCode> getTeamActiveCodeByLeague(String teaminfo_id, String league_id) {
		return teamInfoMapper.getTeamActiveCodeByLeague(teaminfo_id,league_id);
	}

	@Override
	public int queryTeamRecords() {
		return teamInfoMapper.queryTeamRecords();
	}
}
