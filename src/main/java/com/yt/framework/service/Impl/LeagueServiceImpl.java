package com.yt.framework.service.Impl;
import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
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

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.EventRecord;
import com.yt.framework.persistent.entity.InviteMsg;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueAuction;
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QUserData;
import com.yt.framework.persistent.entity.SalaryMsg;
import com.yt.framework.persistent.entity.SalaryRecord;
import com.yt.framework.persistent.entity.SuspendPlayer;
import com.yt.framework.persistent.entity.TeamActiveCode;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamIntegral;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.ActiveCodeService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 * @Title: LeagueServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年8月3日 下午3:58:34 
 */
@Service(value="leagueService")
public class LeagueServiceImpl extends BaseServiceImpl<League> implements LeagueService{
	static Logger logger = LogManager.getLogger(LeagueServiceImpl.class.getName());
	
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private CertificaService certificaService;
	@Autowired
	private UserService userService;
	@Autowired
	ActiveCodeService activeCodeService;
	@Autowired
	private LeagueAuctionService leagueAuctionService;
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;

	@Override
	public AjaxMsg saveLeagueSign(LeagueSign leagueSign)throws Exception {
		if(StringUtils.isBlank(leagueSign.getId())){
			leagueSign.setId(UUIDGenerator.getUUID());
		}	
		leagueMapper.saveLeagueSign(leagueSign);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg queryForPageSign(Map<String, Object> map, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(map!=null){
			if(pageModel!=null){
				count = countSign(map);
				pageModel.setTotalCount(count);
				map.put("start",pageModel.getFirstNum());
				map.put("rows",pageModel.getPageSize());
			}
			datas = leagueMapper.queryForPageSign(map);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	
	@Override
	public int countSign(Map<String, Object> params) {
		return leagueMapper.countSign(params);
	}
	
	public LeagueSign getLeagueSign(String user_id,String s_id){
		return leagueMapper.getLeagueSign(user_id,s_id);
	}

	@Override
	public AjaxMsg updateLeagueSign(LeagueSign leagueSign)throws Exception{
		AjaxMsg msg = AjaxMsg.newSuccess();
		//判断是否已经实名认证
		Certification certification =  certificaService.getCertificationByUserId(leagueSign.getUser_id(), "idcard");
		
		if(certification.getStatus() != 1){
			if(leagueSign.getStatus() == 1){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.player.idcardnopass"));
			}
		}
		//审核通过
		if(leagueSign.getStatus()==1){
			//是否使用邀请码
			String active_code = leagueSign.getActive_code();
			if(StringUtils.isNotBlank(active_code)){
				TeamActiveCode teamActiveCode = teamInfoService.getTeamActiveCode(active_code);
				if(null == teamActiveCode || StringUtils.isBlank(teamActiveCode.getId()) || teamActiveCode.getStatus() == 2) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codenoexist"));
				msg = teamInfoService.joinLeagueTeam(teamActiveCode.getTeaminfo_id(), leagueSign.getUser_id());
				playerInfoMapper.updateLeagueStatus(leagueSign.getUser_id(), 1);//将球员设为联赛球员
				leagueSign.setEntry_mode(2);
			}else{
				LeagueAuction la = new LeagueAuction();
				la.setUser_id(leagueSign.getUser_id());
				//la.setLeague_id(leagueSign.getLeagues_id());
				la.setS_id(leagueSign.getS_id());
				la.setStatus(0);
				la.setIf_up(0);
				la.setIf_sold(0);
				msg = this.saveLeagueAuction(la);
				leagueSign.setEntry_mode(1);
			}
		}
		leagueMapper.updateLeagueSign(leagueSign);
		
		User user = userService.getEntityById(leagueSign.getUser_id());
		user.setBorndate(leagueSign.getBirth_date());
		userService.update(user);
		if(user.getReceive_sms()==1){
			String sms = "";
			if(leagueSign.getStatus() == 1){
				sms = SMSTEMP.JSM405880031.toString();
			}else if(leagueSign.getStatus() == 3){
				sms = SMSTEMP.JSM405880030.toString();
			}
			if(StringUtils.isNotBlank(sms)){
				AjaxMsg re_msg = SendMsg.getInstance().sendSMS(user.getPhone(), "", sms);
				if(re_msg.isError()) logger.error("error!user_id="+user.getId()+",reson:"+re_msg.getErrorMessages());
			}
		}
		return msg;
	}
	
	@Override
	public AjaxMsg updateQLeagueSign(LeagueSign leagueSign)throws Exception{
		leagueMapper.updateLeagueSign(leagueSign);
		return AjaxMsg.newSuccess();
	}

	@Override
	public LeagueSign getLeagueSignById(String id){
		return leagueMapper.getLeagueSignById(id);
	}
	
	@Override
	public Map<String,Object> getLeagueSignByIdMap(String id){
		return leagueMapper.getLeagueSignByIdMap(id);
	}
	
	@Override
	public League getLeague(){
		return leagueMapper.getLeague();
	}
	
	public TeamLeague getTeamLeague(String teaminfo_id){
		return leagueMapper.getTeamLeague(null,teaminfo_id);
	}
	
	@Override
	public TeamLeague getTeamLeague(String league_id,String teaminfo_id){
		return leagueMapper.getTeamLeague(league_id,teaminfo_id);
	}

	@Override
	public AjaxMsg updatePlayerCode(String login_user_id,String cfg_id, String code_str)throws Exception {
		TeamActiveCode teamActiveCode = teamInfoService.getTeamActiveCode(code_str);
		if(null == teamActiveCode || StringUtils.isBlank(teamActiveCode.getId()) || teamActiveCode.getStatus()==2) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codenoexist"));
		if(teamActiveCode.getIf_use() == 2) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codeused")); 
		if(teamActiveCode.getEnd_time().getTime() < new Date().getTime()){
			teamActiveCode.setStatus(2);
			teamInfoService.updateTeamActiveCode(teamActiveCode);
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codetimeout")); 
		}else{
			teamActiveCode.setStatus(2);
			teamActiveCode.setIf_use(2);
			teamActiveCode.setUse_time(new Date());
			teamActiveCode.setUser_id(login_user_id);
			teamInfoMapper.updateTeamActiveCode(teamActiveCode);
		}
		//更新激活码状态
		//从市场中删除球员
		leagueAuctionMapper.deleteByUser(teamActiveCode.getUser_id(),cfg_id);
		//加入俱乐部
		//AjaxMsg msg = teamInfoService.joinLeagueTeam(teamActiveCode.getTeaminfo_id(), login_user_id);
		//add by gl 添加报名人的参赛方式
		/*if(msg.isSuccess()){
			LeagueSign sign = getLeagueSign(login_user_id, teamActiveCode.getLeague_id());
			sign.setEntry_mode(2);
			updateQLeagueSign(sign);
		}else{
			throw new RuntimeException();
		}*/
		//add by gl
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg updatePlayerCode(String login_user_id, String code_str)throws Exception {
		//检测用户是否实名认证
		Certification certification =  certificaService.getCertificationByUserId(login_user_id, "idcard");
		if(certification == null || certification.getStatus()!= 1){
			return AjaxMsg.newError().addData("user_cert", "1");
		}
		//检查是否激活球员
		Map<String, Object> player = playerInfoMapper.getPlayerInfoByUserId(login_user_id);
		if(player==null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.noplayer")); 
		}
		
		TeamActiveCode teamActiveCode = teamInfoService.getTeamActiveCode(code_str);
		if(null == teamActiveCode || StringUtils.isBlank(teamActiveCode.getId()) || teamActiveCode.getStatus()==2) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codenoexist"));
		if(teamActiveCode.getIf_use() == 2) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codeused")); 
		
		//获取邀请码所属俱乐部的报名信息
		String teamId = teamActiveCode.getTeaminfo_id();
		TeamLeague teamLeague = getTeamSignByLeague(teamId,null);
		
		//检测球员是否在竞拍市场中选中
		LeagueAuction auction = leagueAuctionService.getAucPlayer(teamLeague.getS_id(),login_user_id);
		if(auction!=null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.auctionchecked"));
		}
		
		if(teamActiveCode.getEnd_time().getTime() < new Date().getTime()){
			teamActiveCode.setStatus(2);
			teamInfoService.updateTeamActiveCode(teamActiveCode);
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codetimeout")); 
		}else{
			teamActiveCode.setStatus(2);
			teamActiveCode.setIf_use(2);
			teamActiveCode.setUse_time(new Date());
			teamActiveCode.setUser_id(login_user_id);
			teamInfoMapper.updateTeamActiveCode(teamActiveCode);
		}
		
		//检测是否报名
		LeagueSign leagueSign = getSignByLeague(login_user_id,null);
		if(leagueSign!=null){
			leagueSign.setStatus(1);
			leagueSign.setEntry_mode(2);
			leagueSign.setActive_code(code_str);
			leagueSign.setS_id(teamLeague.getS_id());//将报名的赛区改成俱乐部报名的赛区
			updateQLeagueSign(leagueSign);
		}else{
			leagueSign = new LeagueSign();
			leagueSign.setStatus(1);
			leagueSign.setUser_id(login_user_id);
			leagueSign.setImage_src(player.get("head_icon")!=null?player.get("head_icon").toString():null);
			leagueSign.setLove_num(player.get("love_num")!=null?player.get("love_num").toString():null);
			leagueSign.setMobile(player.get("phone")!=null?player.get("phone").toString():null);
			if(Boolean.parseBoolean(player.get("sex").toString())){
				leagueSign.setSex(1);
			}else{
				leagueSign.setSex(0);
			}
			leagueSign.setHeight(player.get("height")!=null?Double.parseDouble(player.get("height").toString()):null);
			leagueSign.setWeight(player.get("weight")!=null?Double.parseDouble(player.get("weight").toString()):null);
			leagueSign.setPosition(player.get("position")!=null?player.get("position").toString():null);
			leagueSign.setCfoot(player.get("cfoot")!=null?player.get("cfoot").toString():null);
			leagueSign.setInvalid(1);
			leagueSign.setEntry_mode(2);
			String bdate = player.get("borndate")!=null?player.get("borndate").toString():null;
			if(StringUtils.isNotBlank(bdate)){
				leagueSign.setBirth_date(Common.parseStringDate(bdate, "yyyy-MM-dd"));
			}
			leagueSign.setActive_code(code_str);
			leagueSign.setS_id(teamLeague.getS_id());
			leagueSign.setIdCard(certification.getId_card());
			saveLeagueSign(leagueSign);
		}
		
		//从市场中删除球员
		leagueAuctionMapper.deleteByUserId(teamActiveCode.getUser_id());
		//加入俱乐部
		AjaxMsg msg = teamInfoService.joinLeagueTeam(teamActiveCode.getTeaminfo_id(), login_user_id);
		playerInfoMapper.updateLeagueStatus(leagueSign.getUser_id(), 1);//将球员设为联赛球员
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg updateActiveCode(LeagueSign sign)throws Exception {
		TeamActiveCode teamActiveCode = teamInfoService.getTeamActiveCode(sign.getActive_code());
		if(null == teamActiveCode || StringUtils.isBlank(teamActiveCode.getId())) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.codenoexist"));
		teamActiveCode.setStatus(1);
		teamActiveCode.setIf_use(1);
		teamActiveCode.setUse_time(null);
		teamActiveCode.setUser_id(null);
		teamInfoMapper.updateTeamActiveCode(teamActiveCode);
		sign.setActive_code(null);
		AjaxMsg msg = updateQLeagueSign(sign);
		return msg;
	}

	@Override
	public AjaxMsg saveTeamLeague(TeamLeague tleague, TeamInfo tinfo,
			ActiveCode code,HttpServletRequest request) throws Exception{
		if(StringUtils.isBlank(tinfo.getId())){
			String team_id = UUIDGenerator.getUUID();
			tinfo.setId(team_id);
			code.setTeaminfo_id(team_id);
			tleague.setTeaminfo_id(team_id);
			AjaxMsg msg = teamInfoService.saveTeamNoAmount(tinfo, request);
			if(msg.isError()){
				throw new RuntimeException();
			}
		}else{
			//TeamInfo teaminfo = teamInfoService.getEntityById(tleague.getTeaminfo_id());
			tinfo.setIs_pk(0);
			tinfo.setAllow(0);
			/*if(tinfo.getP_status()!=null&&tinfo.getP_status()==1){*/
			//update by ylt 
			if(code.getP_status()!=null&&code.getP_status()==1){
				tinfo.setP_status(1);
				//查询俱乐部所有球员
				List<Map<String, Object>> teamPlayerList = teamInfoService.queryTeamPlayerByTid(tinfo.getId());
				if(teamPlayerList!=null&&teamPlayerList.size()>0){
					for (Map<String, Object> map : teamPlayerList) {
						String type = map.get("tp_type").toString();
						if(!"1".equals(type)){
							LeagueSign leagueSign = parseLeagueSignPlayer(map);
							leagueSign.setS_id(tleague.getS_id());
							saveLeagueSign(leagueSign);
						}
						playerInfoMapper.updateLeagueStatus(map.get("user_id").toString(), 1);//将球员设为联赛球员
					}
				}
			}
			teamInfoService.update(tinfo);
		}
		tleague.setId(UUIDGenerator.getUUID());
		code.setStatus(2);
		activeCodeService.updateCode(code);
		tleague.setLeague_id(code.getLeague_id());
		int num = leagueMapper.saveTeamLeague(tleague);
		if(num>0){
			BigDecimal init_capital = code.getInit_capital();//邀请码中的初始资金
			if(init_capital == null){
				init_capital = new BigDecimal(0);
			}
			//给用户资金账户添加100w
			UserAmount amount = userAmountMapper.getUserAmountByTeaminfoID(code.getTeaminfo_id());
			//UserAmount amount = userAmountMapper.getByUserId(code.getUser_id());
			if(amount==null){
				//创建俱乐部资金账户
				amount = new UserAmount();
				amount.setAmount(init_capital);
				amount.setId(UUIDGenerator.getUUID());
				amount.setReal_amount(init_capital);
				amount.setSend_amount(init_capital);
				amount.setTeaminfo_id(code.getTeaminfo_id());
				amount.setStatus(1);
				amount.setType(2);//俱乐部账户
				userAmountMapper.save(amount);
			}else{
				amount.setAmount(amount.getAmount().add(init_capital));
				amount.setReal_amount(amount.getReal_amount().add(init_capital));
				amount.setSend_amount(amount.getSend_amount().add(init_capital));
				userAmountMapper.update(amount);
			}
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		}else{
			throw new RuntimeException();
		}
	}
	
	
	private LeagueSign parseLeagueSignPlayer(Map<String, Object> player) {
		LeagueSign leagueSign = new LeagueSign();
		leagueSign.setStatus(1);
		leagueSign.setUser_id(player.get("user_id")!=null?player.get("user_id").toString():null);
		leagueSign.setImage_src(player.get("head_icon")!=null?player.get("head_icon").toString():null);
		leagueSign.setLove_num(player.get("love_num")!=null?player.get("love_num").toString():null);
		leagueSign.setMobile(player.get("phone")!=null?player.get("phone").toString():null);
		if(Boolean.parseBoolean(player.get("sex").toString())){
			leagueSign.setSex(1);
		}else{
			leagueSign.setSex(0);
		}
		leagueSign.setHeight(player.get("height")!=null?Double.parseDouble(player.get("height").toString()):null);
		leagueSign.setWeight(player.get("weight")!=null?Double.parseDouble(player.get("weight").toString()):null);
		leagueSign.setPosition(player.get("position")!=null?player.get("position").toString():null);
		leagueSign.setCfoot(player.get("cfoot")!=null?player.get("cfoot").toString():null);
		leagueSign.setInvalid(1);
		leagueSign.setEntry_mode(2);
		String bdate = player.get("borndate")!=null?player.get("borndate").toString():null;
		if(StringUtils.isNotBlank(bdate)){
			leagueSign.setBirth_date(Common.parseStringDate(bdate, "yyyy-MM-dd"));
		}
		//leagueSign.setActive_code(code_str);
		//leagueSign.setS_id(teamLeague.getS_id());
		leagueSign.setIdCard(player.get("id_card")!=null?player.get("id_card").toString():null);
		return leagueSign;
	}

	@Override
	public List<League> getLeagues() {
		List<League> listData = leagueMapper.getLeagues();
		return listData;
	}

	@Override
	public LeagueSign getLeagueSignInvalid(String userId) {
		return leagueMapper.getLeagueSignInvalid(userId);
	}

	@Override
	public AjaxMsg saveLeagueAuction(LeagueAuction la) throws Exception{
		la.setId(UUIDGenerator.getUUID());
		leagueAuctionMapper.save(la);
		playerInfoMapper.updateLeagueStatus(la.getUser_id(), 1);
		LeagueSign sign = this.getLeagueSign(la.getUser_id(), la.getS_id());
		sign.setEntry_mode(1);
		AjaxMsg msg = updateQLeagueSign(sign);
		
		if(msg.isError()){
			throw new RuntimeException();
		}
		return msg;
	}

	@Override
	public AjaxMsg deleteLeagueSign(LeagueSign sign) throws Exception{
		//如果用户使用了邀请码则还原邀请码
		if(StringUtils.isNotBlank(sign.getActive_code())){
			updateActiveCode(sign);
		}
		//从市场中删除球员
		leagueAuctionMapper.deleteByUser(sign.getUser_id(),sign.getS_id());
		//将球员改成非联赛球员
		playerInfoMapper.updateLeagueStatus(sign.getUser_id(), null);
		//删除报名信息
		int num = leagueMapper.deleteLeagueSign(sign.getId(),sign.getUser_id());
		if(num>0){
			return AjaxMsg.newSuccess(); 
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<Map<String, Object>> loadScorerDatas(String teaminfo_id) {
		return leagueMapper.loadScorerDatas(teaminfo_id);
	}

	@Override
	public List<Map<String, Object>> loadHisDatas(String teaminfo_id) {
		return leagueMapper.loadHisDatas(teaminfo_id);
	}

	@Override
	public List<Map<String, Object>> loadFrontDatas(String teaminfo_id) {
		return leagueMapper.loadFrontDatas(teaminfo_id);
	}

	@Override
	public List<Map<String, Object>> loadMidfieldDatas(String teaminfo_id) {
		return leagueMapper.loadMidfieldDatas(teaminfo_id);
	}

	@Override
	public List<Map<String, Object>> loadBackDatas(String teaminfo_id) {
		return leagueMapper.loadBackDatas(teaminfo_id);
	}

	@Override
	public List<Map<String, Object>> loadGatekeeperDatas(String teaminfo_id) {
		return leagueMapper.loadGatekeeperDatas(teaminfo_id);
	}

	@Override
	public List<Map<String, Object>> loadBabyDatas(String teaminfo_id) {
		return leagueMapper.loadBabyDatas(teaminfo_id);
	}

	@Override
	public List<Map<String, Object>> loadEventRecord(Map<String, Object> maps) {
		return leagueMapper.loadEventRecord(maps);
	}

	@Override
	public List<Map<String, Object>> loadLeagueGroup(String league_id) {
		return leagueMapper.loadLeagueGroup(league_id);
	}

	@Override
	public List<String> getLeagueEventTime(String league_id) {
		return leagueMapper.getLeagueEventTime(league_id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public AjaxMsg loadIntegral(Map<String, Object> maps, PageModel pageModel) {
		int totalCount = leagueMapper.loadIntegralCount(maps);
		pageModel.setTotalCount(totalCount);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> inters = leagueMapper.loadIntegral(maps);
		pageModel.setItems(inters);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg loadLeagueScorer(Map<String, Object> maps, PageModel pageModel) {
		int totalCount = leagueMapper.loadLeagueScorerCount(maps);
		pageModel.setTotalCount(totalCount);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> scorers = leagueMapper.loadLeagueScorer(maps);
		pageModel.setItems(scorers);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public List<LeagueGroup> loadLeagueGroups(String league_id) {
		return leagueMapper.loadLeagueGroups(league_id);
	}

	@Override
	public List<Map<String, Object>> loadLeagueIntegralRecord(Map<String, Object> maps) {
		return leagueMapper.loadLeagueIntegralRecord(maps);
	}

	@Override
	public List<Map<String, Object>> getTeamLeagueByLeague(String league_id) {
		List<Map<String, Object>> mapList = leagueMapper.getTeamLeagueByLeague(league_id);
		for (Map<String, Object> mapObj : mapList) {
			String t_id = BeanUtils.nullToString(mapObj.get("teaminfo_id"));
			Map<String,Object> map = adminLeagueGroupMapper.getGroupName(league_id, t_id);
			if(null != map){
				mapObj.put("group_name", BeanUtils.nullToString(map.get("name")));
				mapObj.put("group_id", BeanUtils.nullToString(map.get("group_id")));
			}
		}
		return mapList;
	}

	@Override
	public AjaxMsg getFootBabyCharm(Map<String, Object> maps,PageModel pageModel) {
		int totalCount = leagueMapper.getFootBabyCharmCount(maps);
		pageModel.setTotalCount(totalCount);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> babys = leagueMapper.getFootBabyCharm(maps);
		pageModel.setItems(babys);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg loadLeagueScorerRecord(Map<String,Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = leagueMapper.loadLeagueScorerRecordCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = leagueMapper.loadLeagueScorerRecord(params);
			pageModel.setItems(datas);
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}
	
	@Override
	@CacheEvict(value = "objCache",key = "'lId'+#league.id")
	public AjaxMsg update(League league) {
		try {
			leagueMapper.update(league);
			return  AjaxMsg.newSuccess().addData("data", league);
		} catch (Exception e) {
			return AjaxMsg.newError();
		}
	}
	
	@Override
	@Cacheable(value = "objCache",key = "'lId'+#id")
	public String id2Name(String id){
		return leagueMapper.id2Name(id);
	}

	@Override
	public TeamIntegral getTeamIntegralByID(String teaminfo_id, String league_id) {
		return leagueMapper.getTeamIntegralByID(teaminfo_id, league_id);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg loadBidRecords(Map<String, Object> maps, PageModel pageModel) {
		int totalCount = leagueMapper.loadBidRecordCount(maps);
		pageModel.setTotalCount(totalCount);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		List<Map<String,Object>> bids = leagueMapper.loadBidRecords(maps);
		pageModel.setItems(bids);
		return AjaxMsg.newSuccess().addData("page", pageModel).addData("pageCount", pageModel.getPageCount());
	}

	@Override
	public Map<String, Object> queryEventForecast(String league_id) {
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(league_id)){
			List<Map<String, Object>> forecasts = leagueMapper.queryEventForecast(league_id);
			if(forecasts!=null&&forecasts.size()>0){
				//取日期
				List<String> play_dates = new ArrayList<String>();
				for (Map<String, Object> map : forecasts) {
					String pdate = map.get("play_date").toString();
					boolean flag = true;
					if(play_dates!=null&&play_dates.size()>0){
						for (String date : play_dates) {
							if(pdate.equals(date)){
								flag = false;
								break;
							}
						}
					}
					if(!flag) continue;
					play_dates.add(pdate);
				}
				//取日期下时间
				List<Map<String, Object>> date_list= new ArrayList<Map<String, Object>>();
				for (String play_date : play_dates) {
					Map<String, Object> param = new HashMap<String,Object>();
					param.put("pdate", play_date);
					List<String> ptimes = new ArrayList<String>();
					for (Map<String, Object> fors2time : forecasts) {
						String pdate = fors2time.get("play_date").toString();
						if(play_date.equals(pdate)){
							String ptime = fors2time.get("play_time").toString();
							boolean tflag = true;
							if(ptimes!=null&&ptimes.size()>0){
								for (String tt : ptimes) {
									if(ptime.equals(tt)){
										tflag = false;
										break;
									}
								}
							}
							if(!tflag) continue;
							ptimes.add(ptime);
						}
					}
					param.put("ptimes", ptimes);
					date_list.add(param);
				}
				params.put("date_list", date_list);
				//取时间下比赛
				Map<String, Object> bisais = new HashMap<String,Object>();
				for (Map<String, Object> map : date_list) {
					String pdate = map.get("pdate").toString();
					List<String> ptimes = (List<String>) map.get("ptimes");
					for (String ptime : ptimes) {
						List<Map<String, Object>> bisai = new ArrayList<Map<String,Object>>();
						String key = pdate+"_"+ptime;
						for (Map<String, Object> fors : forecasts) {
							String fdate = fors.get("play_date").toString();
							String ftime = fors.get("play_time").toString();
							if(pdate.equals(fdate)&&ptime.equals(ftime)){
								bisai.add(fors);
							}
						}
						bisais.put(key, bisai);
					}
				}
				params.put("forecasts", bisais);
				return params;
			}
		}
		return null;
	}

	@Override
	public AjaxMsg queryEventRecords(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = leagueMapper.queryEventRecordsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = leagueMapper.queryEventRecords(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@Override
	public EventRecord getEventRecordById(String id) {
		return leagueMapper.getEventRecordById(id);
	}

	@Override
	public SuspendPlayer getSuspendById(String id) {
		return leagueMapper.getSuspendById(id);
	}

	@Override
	public AjaxMsg saveOrUpdateSuspend(SuspendPlayer suspendPlayer) throws Exception {
		if(StringUtils.isBlank(suspendPlayer.getId())){
			suspendPlayer.setId(UUIDGenerator.getUUID());	
			leagueMapper.saveSuspend(suspendPlayer);
		}else{
			leagueMapper.updateSuspend(suspendPlayer);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg deleteSuspend(String id)throws Exception{
		leagueMapper.deleteSuspend(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg queryForPageSuspend(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = leagueMapper.suspendCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = leagueMapper.queryForPageSuspend(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@Override
	public int getMaxRounds(String league_id) {
		return eventRecordMapper.getMaxRounds(league_id);
	}

	@Override
	public List<Map<String, Object>> loadAllLeagueTeam(Map<String,Object> params) {
		return leagueMapper.loadAllLeagueTeam(params);
	}

	@Override
	public LeagueCfg getLeagueCfgById(String id) {
		return leagueMapper.getLeagueCfgById(id);
	}

	@Override
	public AjaxMsg saveOrUpdateLeagueCfg(LeagueCfg leagueCfg)throws Exception{
		if(StringUtils.isBlank(leagueCfg.getId())){
			leagueCfg.setId(UUIDGenerator.getUUID());
			int result = OSSClientFactory.uploadFile(leagueCfg.getImage_src(), new File(fileRepository.getRealPath(leagueCfg.getImage_src())));
			if(result == Global.SUCCESS){
				ImageKit.delFile(fileRepository.getRealPath(leagueCfg.getImage_src()));
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
			}
			leagueMapper.saveLeagueCfg(leagueCfg);
		}else{
			LeagueCfg old_cfg = getLeagueCfgById(leagueCfg.getId());
			String old_img = old_cfg.getImage_src();
			String new_img = leagueCfg.getImage_src();
			if(!old_img.equals(new_img)){
				int result = OSSClientFactory.uploadFile(new_img, new File(fileRepository.getRealPath(new_img)));
				if(result == Global.SUCCESS){
					ImageKit.delFile(fileRepository.getRealPath(new_img));
				}else{
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
				}
				OSSClientFactory.deleteFile(old_img);
			}
			leagueMapper.updateLeagueCfg(leagueCfg);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg queryLeagueCfgList(Map<String, Object> maps, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = leagueMapper.leagueCfgCount(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = leagueMapper.queryForPageLeagueCfgList(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@Override
	public TeamLeague getTeamSignByLeague(String teamId, String cfgId) {
		return leagueMapper.getTeamSignByLeague(teamId,cfgId);
	}

	@Override
	public LeagueSign getSignByLeague(String userId, String cfgId) {
		return leagueMapper.getSignByLeague(userId,cfgId);
	}

	@Override
	public List<LeagueCfg> getLeaugeCfgList() {
		return leagueMapper.getLeaugeCfgList();
	}

	@Override
	public List<Map<String, Object>> queryLeagueArea(Map<String, Object> params) {
		return leagueMapper.queryLeagueArea(params);
	}

	@Override
	public List<SalaryMsg> getSalaryMsg(String event_id, String teaminfo_id) {
		return salaryRecordMapper.getSalaryMsg(event_id,teaminfo_id);
	}

	@Override
	public List<SalaryRecord> getSalaryRecord(String srmsg_id) {
		return salaryRecordMapper.getSalaryRecord(srmsg_id);
	}

	@Override
	public List<QMatchInfo> getMatchInfo(String event_id) {
		return salaryRecordMapper.getMatchInfo(event_id);
	}

	@Override
	public List<QUserData> getQuserData(String event_id) {
		List<QMatchInfo>  qMatchInfoList = salaryRecordMapper.getMatchInfo(event_id);
		String q_match_id = null;
		if(qMatchInfoList.size()>0){
			q_match_id = qMatchInfoList.get(0).getId();
			return salaryRecordMapper.getQuserData(q_match_id);
		}else{
			return new ArrayList<QUserData>();
		}
	}

	@Override
	public void updateSalaryRecord(SalaryRecord sr) {
		 salaryRecordMapper.updateSalaryRecord(sr);
	}

	@Override
	public SalaryMsg getSalaryMsgByID(String id) {
		return salaryRecordMapper.getSalaryMsgByID(id);
	}

	@Override
	public void updateSalaryMsg(SalaryMsg o) {
		salaryRecordMapper.updateSalaryMsg(o);
	}

	@Override
	public List<Map<String, Object>> getLeagueCfgMap() {
		return leagueMapper.getLeagueCfgMap();
	}

	@Override
	public AjaxMsg balanceSeason(String s_id)throws Exception{
		/**
		 * 结算俱乐部
		 * 1.将俱乐部报名联赛报名信息TeamLeague数据状态status为2
		 */
		/*leagueMapper.balanceSeasonTeam(s_id);	*/
		
		/**
		 * 结算球员
		 * 1.将球员报名联赛报名信息LeagueSign数据状态invalid为0
		 * 2.将球员信息PlayerInfo中的联赛状态if_league为0
		 */
		leagueMapper.balanceSeasonPlayer(s_id);
		
		LeagueCfg leagueCfg = leagueMapper.getLeagueCfgById(s_id);
		leagueCfg.setIf_balance(1);
		leagueMapper.updateLeagueCfg(leagueCfg);
		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")); 
	}

	@Override
	public InviteMsg getBeGood4InviteMsg(String tid) {
		return leagueMapper.getBeGood4InviteMsg(tid);
	}

	@Override
	public AjaxMsg balanceLeagueMsg(String league_id) throws Exception{
		/**
		 * 结算俱乐部消息
		 * 1.将俱乐部报名上一届联赛报名信息TeamLeague数据状态status为2
		 * 2.查询上届联赛的俱乐部是否已报名下届联赛
		 * 3.若球队不参赛则将该球队球员所有状态改为非联赛球员。
		 */
		leagueMapper.balanceLeagueTeam(league_id);	
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")); 
	}

	@Override
	public AjaxMsg saveLeagueInviteMsg(String league_id,String end_time_str) throws Exception {
		if(StringUtils.isBlank(league_id) || StringUtils.isBlank(end_time_str))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		Map<String,Object>maps = Maps.newHashMap();
		maps.put("league_id", league_id);
		int count = leagueMapper.loadAllInviteMsgCount(maps);
		if(count>0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.invite"));
		
		Date end_time = Common.parseStringDate(end_time_str, "yyyy-MM-dd HH:mm:ss");//到期时间
		List<Map<String,Object>> re = leagueMapper.getTeamLeagueByLeague(league_id);
		if(null!=re && re.size()>0){
			for (Map<String, Object> map : re) {
				String teaminfo_id = String.valueOf(map.get("teaminfo_id"));
				if(StringUtils.isNotBlank(teaminfo_id)){
					InviteMsg im = new InviteMsg();
						im.setId(UUIDGenerator.getUUID());
						im.setEnd_time(end_time);
						im.setLeague_id(league_id);
						im.setTeaminfo_id(teaminfo_id);
					leagueMapper.saveLeagueInviteMsg(im);
				}
			}
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg loadAllInviteMsg(Map<String, Object> maps, PageModel pageModel) {
		maps.put("firstNum", pageModel.getFirstNum());
		maps.put("pageSize", pageModel.getPageSize());
		List<Map<String,Object>> ims = leagueMapper.loadAllInviteMsg(maps);
		int totalCount = leagueMapper.loadAllInviteMsgCount(maps);
		pageModel.setItems(ims);
		pageModel.setTotalCount(totalCount);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public AjaxMsg updateInviteMsg(InviteMsg imsg,String flag) throws Exception{
		imsg.setStatus(0);
		leagueMapper.updateInviteMsg(imsg);
		leagueMapper.updateTeamLeagueStatus(imsg.getTeaminfo_id(),2);//修改联赛俱乐部status
		if(StringUtils.isNotBlank(flag)&&"1".equals(flag)){
			//将t_team_info中的是否允许带人进入下届联赛p_status改为1
			teamInfoMapper.updatePstatus(imsg.getTeaminfo_id(),1);
		}else{
			//点否 将所有球员改成非联赛球员
			List<Map<String, Object>> teamPlayerList = teamInfoService.queryTeamPlayerByTid(imsg.getTeaminfo_id());
			if(teamPlayerList!=null&&teamPlayerList.size()>0){
				for (Map<String, Object> map : teamPlayerList) {
					playerInfoMapper.updateLeagueStatus(map.get("user_id").toString(), 0);//将球员设为非联赛球员
				}
			}
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public List<League> getLeaguesByCondition(Map params) {
		return leagueMapper.getLeaguesByCondition(params);
	}

	@Override
	public AjaxMsg loadLeagueAssists(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = leagueMapper.loadLeagueAssistsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = leagueMapper.loadLeagueAssists(params);
			pageModel.setItems(datas);
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public int queryLeagueRecords() {
		return leagueMapper.queryLeagueRecords();
	}

}
