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

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AuctionCondition;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueAuction;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.LeagueAuctionRecords;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.UserFreezeAmount;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 * @Title: PlayerInfoServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年11月1日 下午3:58:34 
 */
@Service(value="leagueAuctionService")
public class LeagueAuctionServiceImpl extends BaseServiceImpl<LeagueAuction> implements LeagueAuctionService{
	static Logger logger = LogManager.getLogger(LeagueAuctionServiceImpl.class.getName());
	
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private UserAmountService userAmountService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private LeagueService leagueService;
	
	@Override
	public AjaxMsg saveAuctionCfg(LeagueAuctionCfg leagueAuctionCfg)throws Exception{
		leagueAuctionMapper.saveAuctionCfg(leagueAuctionCfg);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg updateAuctionCfg(LeagueAuctionCfg leagueAuctionCfg)throws Exception{
		leagueAuctionMapper.updateAuctionCfg(leagueAuctionCfg);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg queryCfgForMap(Map<String, Object> maps,PageModel pageModel){
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = cfgCount(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = leagueAuctionMapper.queryCfgForMap(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@Override
	public int cfgCount(Map<String, Object> maps) {
		return leagueAuctionMapper.cfgCount(maps);
	}

	@Override
	public LeagueAuctionCfg getCfgById(String id) {
		return leagueAuctionMapper.getCfgById(id);
	}

	@Override
	public List<LeagueAuctionCfg> getCfgByLeague(String league_id) {
		return leagueAuctionMapper.getCfgByLeague(league_id);
	}

	@Override
	public LeagueAuctionCfg queryCfg(String s_id,Integer turn_num) {
		return leagueAuctionMapper.queryCfg(s_id,turn_num);
	}

	@Override
	public AjaxMsg queryAuctionForMap(AuctionCondition auctionCondition, PageModel pageModel) throws Exception {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		Map maps = BeanUtils.object2Map(auctionCondition);
		if(maps!=null){
			if(pageModel!=null){
				count = auctionCount(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = leagueAuctionMapper.queryAuctionForMap(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	
	@Override
	public int auctionCount(Map<String, Object> maps) {
		return leagueAuctionMapper.auctionCount(maps);
	}

	@Override
	public LeagueAuctionCfg getCurrentAuction(String s_id) {
		return leagueAuctionMapper.getCurrentAuction(s_id);
	}

	@Override
	public AjaxMsg getAuctionPlayerDetail(String id) {
		Map<String,Object>map = leagueAuctionMapper.getAuctionPlayerDetail(id);
		return AjaxMsg.newSuccess().addData("auctionMap", map);
	}

	@Override
	public AjaxMsg saveRecords(LeagueAuctionRecords records)throws Exception {
		leagueAuctionMapper.saveRecords(records);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public LeagueAuctionRecords getRecordsById(String r_id) {
		return leagueAuctionMapper.getRecordsById(r_id);
	}

	@Override
	public AjaxMsg saveAuction(String user_id, String id, String turn_id, String price)throws Exception{
		//判断市场是否结束
		LeagueAuctionCfg leagueAuctionCfg = leagueAuctionMapper.getCfgById(turn_id);
		if(leagueAuctionCfg == null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.auction.noexist"));
		}else if(new Date().getTime() > leagueAuctionCfg.getEnd_time().getTime()){//当前时间大于结束时间，市场已结束
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.auction.timeover"));
		}	
		LeagueAuction leagueAuction = leagueAuctionMapper.getEntityById(id);
		LeagueAuctionRecords records = leagueAuctionMapper.getRecordsById(leagueAuction.getR_id());
		//获取俱乐部账户
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		UserAmount teamAmount = userAmountService.getUserAmountByTeamInfoID(teamInfo.getId());
		//真实资金是否充足
		/*AjaxMsg msgUser = userAmountService.getByUserId(user_id);
		UserAmount userAmount = (UserAmount)msgUser.getData("data");*/
		if(teamAmount == null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noaccount"));
		}else{
			BigDecimal current_amount = null;//当前球员价格
			String lastBidder = "";
			UserAmount teamLastAmount = new UserAmount();
			/**                
			 * 1.当前如无出价则当前价格为初始价
			 * 2.当前如有出价则为当前竞拍价
			 */
			if(null == leagueAuction.getBid_price() || leagueAuction.getBid_price().compareTo(new BigDecimal(0)) == 0){
				current_amount = leagueAuction.getInit_price();
			}else{
				current_amount = leagueAuction.getBid_price();
				lastBidder = leagueAuction.getBidder();
				//AjaxMsg lastMsgUser = userAmountService.getByUserId(lastBidder);
				teamLastAmount = userAmountService.getUserAmountByTeamInfoID(lastBidder);
				//teamLastAmount = (UserAmount)lastMsgUser.getData("data");
			}
			BigDecimal real_amount = teamAmount.getReal_amount();//用户可用资金
			BigDecimal amount = teamAmount.getAmount();//用户总资金
			BigDecimal bid_price = new BigDecimal(price);//用户当前出价
			BigDecimal addPrice = leagueAuctionCfg.getPer_price();//每次加价下限
			
			if(real_amount.compareTo(bid_price) == -1){//可用资金是否大于出价
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.accountless"));
			}else if(bid_price.subtract(current_amount).compareTo(addPrice) == -1){//出价是否大于10000宇拓币
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage(new Object[]{addPrice.setScale(0,BigDecimal.ROUND_DOWN)},"system.error.user.priceless"));
			}else{
				//更新市场竞拍纪录表
				String r_id = UUIDGenerator.getUUID();
				leagueAuction.setBid_price(bid_price);
				leagueAuction.setBidder(teamInfo.getId());
				leagueAuction.setR_id(r_id);
				leagueAuction.setStatus(0);
				int i = leagueAuctionMapper.updateLock(leagueAuction);
				if(i == 0){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.league.priceed"));
				}else{
					//解冻上一个出价者资金	
					BigDecimal tempFreezeAmout = new BigDecimal(0);//同一竞拍者冻结临时资金
						if(records != null){
							UserFreezeAmount userLastFreezeAmount = userAmountService.getFreezeAmountById(records.getF_id());
							userLastFreezeAmount.setStatus(3);
							userAmountService.updateFreezeAmount(userLastFreezeAmount);
							//退还上一个出价者账户冻结资金
							if(!lastBidder.equals(teamInfo.getId())){
								teamLastAmount.setReal_amount(teamLastAmount.getReal_amount().add(userLastFreezeAmount.getAmount()));
								teamLastAmount.setAmount(teamLastAmount.getAmount().add(userLastFreezeAmount.getAmount()));
								userAmountService.update(teamLastAmount);
							}else{
								tempFreezeAmout = userLastFreezeAmount.getAmount();
							}
						}
					//生成当前竞拍者的冻结资金
					UserFreezeAmount userFreezeAmount = new UserFreezeAmount();
					String f_id = UUIDGenerator.getUUID();
					userFreezeAmount.setId(f_id);
					userFreezeAmount.setAmount(bid_price);
					userFreezeAmount.setDescrible(messageResourceService.getMessage("system.info.league.sfreeze"));
					userFreezeAmount.setStatus(1);
					userFreezeAmount.setU_amount_id(teamAmount.getId());
					userFreezeAmount.setTeaminfo_id(teamInfo.getId());
					userAmountService.saveUserFreezeAmount(userFreezeAmount);
					
					//更新当前竞拍者的总资金账户
					teamAmount.setReal_amount(real_amount.subtract(bid_price).add(tempFreezeAmout));
					teamAmount.setAmount(amount.subtract(bid_price).add(tempFreezeAmout));
					userAmountService.update(teamAmount);
					
					//保存交易记录	
					LeagueAuctionRecords newRecords = new LeagueAuctionRecords();
					newRecords.setId(r_id);
					newRecords.setManager_id(teamInfo.getId());
					newRecords.setAuc_id(leagueAuction.getId());
					newRecords.setBid_price(bid_price);
					newRecords.setBid_time(new Date());
					newRecords.setIf_bid(0);
					newRecords.setTeam_id(teamInfo.getId());
					newRecords.setF_id(f_id);
					leagueAuctionMapper.saveRecords(newRecords);
					
					SendMsg sendMsg = SendMsg.getInstance();
					String p_user_id = leagueAuction.getUser_id();//球员用户ID
					User p_user = userService.getEntityById(p_user_id);//被竞拍球员ID
					//String userName = userService.id2Name(leagueAuction.getUser_id());
					if(StringUtils.isNotBlank(lastBidder)){
						//发送短信 主 席大人，你对@1@的出价被@2@超过了，快去看看吧
						TeamInfo leaderTeamInfo = teamInfoService.getEntityById(lastBidder);
						User bidder = userService.getEntityById(leaderTeamInfo.getUser_id());
						StringBuilder sbb = new StringBuilder();
						sbb.append("@1@=").append(p_user.getUsername()).append(",@2@=").append(teamInfo.getName());
						sendMsg.sendSMS(bidder.getPhone(), sbb.toString(), SMSTEMP.JSM405880035.toString());
					}
					//added by bo.xie 2015年12月14日14:33:14	发送信息给竞拍球员	start
					if(p_user!=null && StringUtils.isNotBlank(p_user.getPhone())){
						String league_id = leagueAuctionCfg.getLeague_id();
						League league = leagueMapper.getEntityById(league_id);
						String league_name = "";
						if(null!=league)league_name = league.getName();
						StringBuilder sb2 = new StringBuilder();
						sb2.append("@1@=").append(p_user.getUsername()).append(",@2@=").append(league_name).append(",@3@=").append(teamInfo.getName()).append(",@4@=").append(newRecords.getBid_price());
						sendMsg.sendSMS(p_user.getPhone(), sb2.toString(), SMSTEMP.JSM405880036.toString());
					}else{
						logger.error(p_user.getUsername()+"竞拍球员成功后，给竞拍球员发送短信失败！");
					}
					//added by bo.xie 2015年12月14日14:33:14	发送信息给竞拍球员	end
				}
			}
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg updateLock(LeagueAuction leagueAuction) throws Exception {
		int i = leagueAuctionMapper.updateLock(leagueAuction);
		if(i == 0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.league.priceed"));
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg queryMyAuctionForMap(AuctionCondition auctionCondition, PageModel pageModel)throws Exception {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		Map maps = BeanUtils.object2Map(auctionCondition);
		if(maps!=null){
			if(pageModel!=null){
				count = myAuctionCount(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = leagueAuctionMapper.queryMyAuctionForMap(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	
	@Override
	public int myAuctionCount(Map<String, Object> maps) {
		return leagueAuctionMapper.myAuctionCount(maps);
	}

	@Override
	public AjaxMsg modifyLeagueAuction(LeagueAuctionCfg leagueAuctionCfg) throws Exception {
		//更新市场状态为关闭
		leagueAuctionMapper.updateAuctionCfg(leagueAuctionCfg);
		//竞拍市场结算
		leagueAuctionMapper.updateBatchAuction(leagueAuctionCfg.getNext_num(),leagueAuctionCfg.getTurn_num(),
					leagueAuctionCfg.getUser_percent(),leagueAuctionCfg.getS_id());
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg deleteCfg(String id)throws Exception {
		leagueAuctionMapper.deleteCfg(id);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg sendCalculateMsg(LeagueAuctionCfg leagueAuctionCfg) throws Exception {
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("s_id", leagueAuctionCfg.getS_id());
		maps.put("turn_num", leagueAuctionCfg.getTurn_num());
		maps.put("status",1);
		List<Map<String, Object>> datas = leagueAuctionMapper.queryForPageForMap(maps);
		for(Map<String, Object> auction : datas) {
			String user_id = BeanUtils.nullToString(auction.get("user_id"));
			String bidder_id = BeanUtils.nullToString(auction.get("bidder"));
			if(!user_id.equals("")&&!bidder_id.equals("")){
				//获取球员
				User user = userService.getEntityById(user_id);
				LeagueSign leagueSign = leagueService.getSignByLeague(user_id, leagueAuctionCfg.getS_id());
				//User bidder = userService.getEntityById(bidder_id);
				//TeamInfo team = teamInfoService.getTeamInfoByUserId(bidder_id);
				TeamInfo team = teamInfoService.getEntityById(bidder_id);
				User bidder = userService.getEntityById(team.getUser_id());
				if(null !=team && null !=bidder){
					League league = leagueMapper.getEntityById(leagueSign.getLeagues_id());
					String league_name = "";
					if(null!=league)league_name = BeanUtils.nullToString(league.getName());
					//尊敬的@1@主 席：球员@2@已成功被招至麾下听候差遣。宇超联赛战火已点燃，祝您带领球队踢出精彩。球员电话：@3@。
					StringBuilder sbb = new StringBuilder();
					sbb.append("@1@=").append(BeanUtils.nullToString(team.getName())).append(",@2@=").append(BeanUtils.nullToString(user.getUsernick()))
					.append(",@3@=").append(league_name).append(",@4@=").append(BeanUtils.nullToString(leagueSign.getMobile()));
					SendMsg.getInstance().sendSMS(BeanUtils.nullToString(bidder.getPhone()), sbb.toString(), SMSTEMP.JSM405880033.toString());
					//尊敬的@1@：您已正式加入宇超新贵@2@。祝您在宇超联赛开启您的球星之路。球队主 席电话：@3@
					StringBuilder sbu = new StringBuilder();
					sbu.append("@1@=").append(BeanUtils.nullToString(user.getUsername())).append(",@2@=").append(league_name)
					.append(",@3@=").append(BeanUtils.nullToString(team.getName())).append(",@4@=").append(league_name).append(",@5@=").append(BeanUtils.nullToString(bidder.getPhone()));
					SendMsg.getInstance().sendSMS(BeanUtils.nullToString(leagueSign.getMobile()), sbu.toString(), SMSTEMP.JSM405880034.toString());
				}
			}
		}
		

		return AjaxMsg.newSuccess();
	}

	@Override
	public LeagueAuction getAuctionPlayer(String user_id, String s_id) {
		return leagueAuctionMapper.getAuctionPlayer(user_id,s_id);
	}
	@Override
	public LeagueAuction getAucPlayer(String s_id,String user_id) {
		return leagueAuctionMapper.getAuctionCheckedPlayer(s_id,user_id);
	}
	
	@Override
	public List<LeagueAuction> getAuctionPlayers(String user_id) {
		return leagueAuctionMapper.getAuctionNoCheckedPlayer(user_id);
	}

	@Override
	public List<LeagueAuctionCfg> getCfgByLeagueCfg(String s_id) {
		return leagueAuctionMapper.getCfgByLeagueCfg(s_id);
	}

	@Override
	public List<Map<String, Object>> getAuctionDetailData(String s_id, String turn_num) {
		return leagueAuctionMapper.getAuctionDetailData(s_id, turn_num);
	}
}
