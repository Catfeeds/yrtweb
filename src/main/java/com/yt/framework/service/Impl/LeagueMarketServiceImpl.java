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
import com.yt.framework.persistent.entity.Fee;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.MarketRecords;
import com.yt.framework.persistent.entity.Order;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.PriceSlave;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.TeamSale;
import com.yt.framework.persistent.entity.TransferRecord;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.UserFreezeAmount;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 * @Title: PlayerInfoServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年11月1日 下午3:58:34 
 */
@Service(value="leagueMarketService")
public class LeagueMarketServiceImpl extends BaseServiceImpl<LeagueMarket> implements LeagueMarketService{
	static Logger logger = LogManager.getLogger(LeagueMarketServiceImpl.class.getName());
	
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private UserService userService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private UserAmountService userAmountService;
	@Autowired
	private LeagueService leagueService;
	
	@Override
	public AjaxMsg saveMarketCfg(MarketCfg marketCfg) throws Exception {
		leagueMarketMapper.saveMarketCfg(marketCfg);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg updateMarketCfg(MarketCfg marketCfg) throws Exception {
		leagueMarketMapper.updateMarketCfg(marketCfg);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg queryCfgForMap(Map<String, Object> maps, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = cfgCount(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = leagueMarketMapper.queryCfgForMap(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	@Override
	public int cfgCount(Map<String, Object> maps) {
		return leagueMarketMapper.cfgCount(maps);
	}
	@Override
	public MarketCfg getCfgById(String id) {
		return leagueMarketMapper.getCfgById(id);
	}
	@Override
	public List<MarketCfg> getCfgByLeague(String s_id) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public MarketCfg queryCfg(String s_id, Integer turn_num) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public MarketCfg getCurrentMarket(String s_id) {
		return leagueMarketMapper.getCurrentMarket(s_id);
	}
	@Override
	public AjaxMsg saveMarketRecords(MarketRecords marketRecords) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public AjaxMsg deleteCfg(String id) throws Exception {
		leagueMarketMapper.deleteCfg(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg ifOpenMarket(String s_id) {
		MarketCfg marketCfg = leagueMarketMapper.getCurrentMarket(s_id);
		if(null != marketCfg){
			int if_open = marketCfg.getIf_open();
			if(if_open == 0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public LeagueMarket getMarketUser(String user_id, Integer status) {
		return leagueMarketMapper.getMarketUser(user_id, status);
	}
	@Override
	public AjaxMsg marketStatus(String s_id) {
		MarketCfg marketCfg = leagueMarketMapper.getCurrentMarket(s_id);
		if(marketCfg==null)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
		Date now = new Date();
		Date bg_time = marketCfg.getStart_time();//市场开启时间
		Date end_time = marketCfg.getEnd_time();
		if(marketCfg.getIf_open()==null){
			if(now.getTime()>bg_time.getTime()&&now.getTime()<end_time.getTime()){
				if(end_time.getTime()<now.getTime()){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
				}
				return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
			}
		}else{
			int if_open = marketCfg.getIf_open();
			if(if_open==1 && now.getTime()>bg_time.getTime()&&now.getTime()<end_time.getTime()){
				if(end_time.getTime()<now.getTime()){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
				}
				return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
			}
		}
	}
	
	@Override
	public AjaxMsg updateLock(LeagueMarket leagueMarket) throws Exception {
		int i = leagueMarketMapper.updateLock(leagueMarket);
		if(i == 0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.league.priceed"));
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg modifyLeagueMarket(MarketCfg cfg)throws Exception{
		//更新市场状态为关闭
		leagueMarketMapper.updateMarketCfg(cfg);
		//转会市场结算
		leagueMarketMapper.updateBatchMarket(cfg.getTurn_num(),cfg.getNext_num(),
				cfg.getUser_percent(),cfg.getTeam_percent(),cfg.getS_id());
		//清除固定消息
		leagueMarketMapper.clearMsg(cfg.getId());
		
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public void sendCalculateMsg(MarketCfg cfg) {
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("s_id", cfg.getS_id());
		maps.put("turn_num", cfg.getTurn_num());
		maps.put("status",1);
		List<Map<String, Object>> datas = leagueMarketMapper.queryForPageForMap(maps);
		for (Map<String, Object> market : datas) {
			String user_id = BeanUtils.nullToString(market.get("user_id"));
			String bidder_id = BeanUtils.nullToString(market.get("buyer"));
			if(!user_id.equals("")&&!bidder_id.equals("")){
				//发送给俱乐部管理者
				TeamInfo teamInfo = teamInfoMapper.getEntityById(bidder_id);
				if(null == teamInfo){
					continue;
				}
				TeamLeague teamLeague = leagueMapper.getTeamLeague(bidder_id);
				if(null == teamLeague){
					continue;
				}
				StringBuilder sb = new StringBuilder();
				String league_id = teamLeague.getLeague_id();
				League league = leagueMapper.getEntityById(league_id);
				String league_name = "";
				if(null!=league){
					league_name = league.getName();
				}else{
					continue;
				}
				User user =  userService.getEntityById(teamInfo.getUser_id());
				User p_user =  userService.getEntityById(user_id);
				sb.append("@1@=").append(user.getUsernick()).append(",@2@=").append(p_user.getUsernick())
				.append(",@3@=").append(league_name).append(",@4@=").append(p_user.getPhone());
				AjaxMsg msg = SendMsg.getInstance().sendSMS(user.getPhone(), sb.toString(), SMSTEMP.JSM405880033.toString());
				logger.info(user.getUsernick()+"("+user.getPhone()+")"+"购买球员短信通知发送失败！reson:"+msg.toJson());
				//发送给球员
				StringBuilder sb2 = new StringBuilder();
				sb2.append("@1@=").append(p_user.getUsernick()).append(",@2@=").append(league_name).append(",@3@=").append(teamInfo.getName())
				.append(",@4@=").append(league_name).append(",@5@=").append(user.getPhone());
				AjaxMsg re_msg = SendMsg.getInstance().sendSMS(p_user.getPhone(), sb2.toString(), SMSTEMP.JSM405880034.toString());
				logger.info(p_user.getUsernick()+"("+p_user.getPhone()+")"+"短信通知发送失败！reson:"+re_msg.toJson());
				
			}
		}
	}
	
	@Override
	public AjaxMsg queryLeagueMarket(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = leagueMarketMapper.leagueMarketCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = leagueMarketMapper.queryLeagueMarket(params);
			pageModel.setItems(datas);
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}
	@Override
	public AjaxMsg queryMarketHistorys(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = leagueMarketMapper.marketHistorysCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = leagueMarketMapper.queryMarketHistorys(params);
			pageModel.setItems(datas);
		}
		return AjaxMsg.newSuccess().addData("page", pageModel).addData("pageCount", pageModel.getPageCount());
	}

	@Override
	public Map<String, Object> getPlayerInfoForMarketById(String m_id) {
		return leagueMarketMapper.getPlayerInfoForMarketById(m_id);
	}
	@Override
	public AjaxMsg saveMarketData(Map<String, Object> params)throws Exception{
		String buyer = BeanUtils.nullToString(params.get("buyer")); //购买者用户id
		String id = BeanUtils.nullToString(params.get("id"));  //购买竞拍球员数据id
		String price = BeanUtils.nullToString(params.get("price")); //购买价格
		//String tm_user_id = BeanUtils.nullToString(params.get("tm_user_id"));//出售球员俱乐部管理者用户ID
		String p_user_id = BeanUtils.nullToString(params.get("p_user_id"));//出售球员用户ID
		//String s_id = BeanUtils.nullToString(params.get("s_id"));//当前联赛ID
		String cfg_id = BeanUtils.nullToString(params.get("cfg_id"));//当前转会竞拍配置
		try{
			//判断市场是否结束
				MarketCfg cfg = leagueMarketMapper.getCfgById(cfg_id);
				if(cfg == null){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.auction.noexist"));
				}else if(new Date().getTime() > cfg.getEnd_time().getTime()){//当前时间大于结束时间，市场已结束
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.auction.timeover"));
				}	
				LeagueMarket leagueMarket = leagueMarketMapper.getEntityById(id);
				MarketRecords records = leagueMarketMapper.getRecordsById(leagueMarket.getR_id());
				//获取俱乐部账户
				TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(buyer);
				UserAmount teamAmount = userAmountService.getUserAmountByTeamInfoID(teamInfo.getId());
				if(teamAmount == null){
					return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noaccount"));
				}else{
					BigDecimal current_amount = leagueMarket.getPrice();
					String lastBidder = leagueMarket.getBuyer(); //上一个竞拍者俱乐部id
					UserAmount lastTeamAmount = userAmountService.getUserAmountByTeamInfoID(lastBidder);
					
					BigDecimal real_amount = teamAmount.getReal_amount();//用户可用资金
					BigDecimal amount = teamAmount.getAmount();//用户总资金
					BigDecimal bid_price = new BigDecimal(price);//用户当前出价
					//BigDecimal addPrice = leagueAuctionCfg.getPer_price();//每次加价下限
					
						if(real_amount.compareTo(bid_price) == -1){//可用资金是否大于出价
							return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.accountless"));
						}else if(bid_price.compareTo(current_amount) == -1){//出价是否大于低价
							return AjaxMsg.newError().addMessage(messageResourceService.getMessage(new Object[]{current_amount.setScale(0,BigDecimal.ROUND_DOWN)},"system.error.user.addprice"));
						}else{
							//更新市场竞拍纪录表
							String r_id = UUIDGenerator.getUUID();
							leagueMarket.setPrice(bid_price);
							leagueMarket.setBuyer(teamInfo.getId());
							leagueMarket.setR_id(r_id);
							leagueMarket.setStatus(0);
							leagueMarket.setBuy_time(new Date());
							int i = leagueMarketMapper.updateLock(leagueMarket);
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
											lastTeamAmount.setReal_amount(lastTeamAmount.getReal_amount().add(userLastFreezeAmount.getAmount()));
											lastTeamAmount.setAmount(lastTeamAmount.getAmount().add(userLastFreezeAmount.getAmount()));
											userAmountService.update(lastTeamAmount);
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
								userFreezeAmount.setUser_id("");
								userAmountService.saveUserFreezeAmount(userFreezeAmount);
								
								//更新当前竞拍者的总资金账户
								teamAmount.setReal_amount(real_amount.subtract(bid_price).add(tempFreezeAmout));
								teamAmount.setAmount(amount.subtract(bid_price).add(tempFreezeAmout));
								userAmountService.update(teamAmount);
								
								//保存交易记录
								MarketRecords newRecords = new MarketRecords();
								newRecords.setId(r_id);
								newRecords.setManager_id(teamInfo.getId());
								newRecords.setM_id(leagueMarket.getId());
								newRecords.setBuy_price(bid_price);
								newRecords.setBuy_time(new Date());
								newRecords.setIf_bid(0);
								newRecords.setF_id(f_id);
								leagueMarketMapper.saveMarketRecords(newRecords);
								
								SendMsg sendMsg = SendMsg.getInstance();
								User p_user = userService.getEntityById(p_user_id);//被竞拍球员ID
								//String userName = userService.id2Name(leagueAuction.getUser_id());
								if(StringUtils.isNotBlank(lastBidder)){
									//发送短信 主 席大人，你对@1@的出价被@2@超过了，快去看看吧
									TeamInfo lastTeam = teamInfoService.getEntityById(lastBidder);
									User bidder = userService.getEntityById(lastTeam.getUser_id());
									StringBuilder sbb = new StringBuilder();
									sbb.append("@1@=").append(bidder.getUsername()).append(",@2@=").append(teamInfo.getName());
									sendMsg.sendSMS(bidder.getPhone(), sbb.toString(), SMSTEMP.JSM405880035.toString());
								}
								//added by bo.xie 2015年12月14日14:33:14	发送信息给竞拍球员	start
								if(p_user!=null && StringUtils.isNotBlank(p_user.getPhone())){
									String season_name = "宇任拓联赛" ;
									StringBuilder sb2 = new StringBuilder();
									sb2.append("@1@=").append(p_user.getUsername()).append(",@2@=").append(season_name).append(",@3@=").append(teamInfo.getName()).append(",@4@=").append(newRecords.getBuy_price());
									sendMsg.sendSMS(p_user.getPhone(), sb2.toString(), SMSTEMP.JSM405880036.toString());
								}else{
									logger.error(p_user.getUsername()+"竞拍球员成功后，给竞拍球员发送短信失败！");
								}
								//added by bo.xie 2015年12月14日14:33:14	发送信息给竞拍球员	end
							}
						}
					}
		}catch(Exception e){
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.error"));
		}
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg saveMarketDataOnePrice(Map<String, Object> params)throws Exception{
		String buyer = BeanUtils.nullToString(params.get("buyer"));//购买用户ID
		String id = BeanUtils.nullToString(params.get("id"));//球员跳蚤市场记录ID
		String price = BeanUtils.nullToString(params.get("price"));//购买价格
		String tm_user_id = BeanUtils.nullToString(params.get("tm_user_id"));//出售球员俱乐部管理者用户ID
		String p_user_id = BeanUtils.nullToString(params.get("p_user_id"));//出售球员用户ID
		String s_id = BeanUtils.nullToString(params.get("s_id"));//赛季ID
		
		//判断购买用户是否是俱乐部队长
		TeamInfo ti = teamInfoMapper.getTeamInfoByUserId(buyer);
		if(ti==null)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.noteam"));
		//出售球员俱乐部
		TeamInfo tm = teamInfoMapper.getTeamInfoByUserId(tm_user_id);
		//获取购买俱乐部资金账户，并判断可用资金是否足够
		UserAmount userAmount = userAmountMapper.getUserAmountByTeaminfoID(ti.getId());
		//update by bo.xie 购买球员账户由个人资金账户转到俱乐部资金账户 end
		//if(userAmount.getStatus()==2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.freeze"));
		if(userAmount.getReal_amount().compareTo(new BigDecimal(price))<0){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.not_enough"));
		}
		
		//更新俱乐部资金表
		userAmount.setAmount(userAmount.getAmount().subtract(new BigDecimal(price)));
		userAmount.setReal_amount(userAmount.getReal_amount().subtract(new BigDecimal(price)));
		userAmountMapper.update(userAmount);
		
		//更新球员市场表
		TeamLeague teamLeague = leagueService.getTeamSignByLeague(ti.getId(), s_id);
		LeagueMarket leagueMarket = playerInfoMapper.getLeagueMarketById(id);
		leagueMarket.setBuy_time(new Date());
		leagueMarket.setBuyer(ti.getId());
		leagueMarket.setStatus(1);
		leagueMarket.setLeague_id(teamLeague.getLeague_id());
		playerInfoMapper.updateLeagueMarker(leagueMarket);
		
		//保存球员购买记录
		MarketRecords mr = new MarketRecords();
		mr.setId(UUIDGenerator.getUUID());
		mr.setBuy_price(new BigDecimal(price));
		mr.setM_id(leagueMarket.getId());
		mr.setManager_id(ti.getId());
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
		
		//获取出售球员俱乐部账户资金
		UserAmount tm_userAmount = userAmountMapper.getUserAmountByTeaminfoID(tm.getId());
		//upadte by bo.xie 个人账户转为俱乐部资金账户end 
		if(tm_userAmount!=null){
			//获取市场分成比例参数
			MarketCfg marketCfg = this.getCurrentMarket(s_id);
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
			if(null != teamSale){
				teamSale.setStatus(1);
				playerInfoMapper.updateTeamSale(teamSale);
			}
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
			//String league_id = ls.getLeagues_id();
			League league = leagueMapper.getEntityById(teamLeague.getLeague_id());
			String league_name = BeanUtils.nullToString(league.getName());
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
	public List<Map<String, Object>> getMarketDetailData(String s_id, String turn_num) {
		return leagueMarketMapper.getMarketDetailData(s_id,turn_num);
	}
	
}
