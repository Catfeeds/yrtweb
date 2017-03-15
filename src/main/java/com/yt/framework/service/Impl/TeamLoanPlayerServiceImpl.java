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

import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.Fee;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.Order;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamLoanMsg;
import com.yt.framework.persistent.entity.TeamLoanPlayer;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.TransferMsg;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.SystemEnum.SYSTYPE;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamLoanPlayerService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 俱乐部租借
 *@autor ylt
 *@date2015-8-3下午3:31:47
 */
@Transactional
@Service("teamLoanPlayerService")
public class TeamLoanPlayerServiceImpl extends BaseServiceImpl<TeamLoanPlayer> implements TeamLoanPlayerService {
	
	private static Logger logger = LogManager.getLogger(TeamLoanPlayerServiceImpl.class.getName());
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private LeagueMarketService leagueMarketService;

	
	@Override
	public AjaxMsg queryTeamLoanMsg(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				
				count = teamLoanPlayerMapper.teamLoanMsgCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = teamLoanPlayerMapper.queryTeamLoanMsg(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	
	@Override
	public int teamLoanMsgCount(Map<String, Object> params){
		return teamLoanPlayerMapper.teamLoanMsgCount(params);
	}

	@Override
	public AjaxMsg saveLoanMsg(TeamLoanMsg teamLoanMsg) throws Exception {
		teamLoanPlayerMapper.saveLoanMsg(teamLoanMsg);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg updateLoanMsg(TeamLoanMsg teamLoanMsg) throws Exception {
		teamLoanPlayerMapper.updateTeamLoanMsg(teamLoanMsg);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public TeamLoanMsg getTeamLoanMsgById(String id) {
		return teamLoanPlayerMapper.getTeamLoanMsgById(id);
	}

	@Override
	public AjaxMsg updateLoanManage(TeamLoanMsg loanMsg,String type) throws Exception{
		//检测市场是否开启
		MarketCfg marketCfg = leagueMarketService.getCfgById(loanMsg.getCfg_id());
		if(marketCfg != null){
			if(marketCfg.getIf_open() == 0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.market.ifopen"));
		}
		Integer if_ok = "1".equals(type) ? 1 : 0;
		if("3".equals(type)){
			//撤销请求信息
			teamLoanPlayerMapper.deleteTeamLoanMsg(loanMsg.getId());
			return AjaxMsg.newSuccess();
		}
		//租借方俱乐部
		TeamInfo buyTeam = teamInfoMapper.getEntityById(loanMsg.getBuy_teaminfo_id());
		//出租方俱乐部
		TeamInfo sellTeam = teamInfoMapper.getEntityById(loanMsg.getLoan_teaminfo_id());
		//被出租球员
		User player = userMapper.getEntityById(loanMsg.getUser_id());
		String username = StringUtils.isNotBlank(player.getUsername())?player.getUsername():player.getUsernick();
		if(buyTeam==null || sellTeam==null || player==null){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
		
		loanMsg.setIf_ok(if_ok);
		loanMsg.setStatus(2);
		loanMsg.setClosing_time(new Date());
		teamLoanPlayerMapper.updateTeamLoanMsg(loanMsg);
		if("1".equals(type)){
			//查询该球员所有未失效和未处理租借信息
			List<TeamLoanMsg> tls = teamLoanPlayerMapper.queryUntreatedTeamLoanMsg(loanMsg.getLoan_teaminfo_id(),loanMsg.getUser_id());
			if(tls!=null&&tls.size()>0){
				for (TeamLoanMsg teamLoanMsg : tls) {
					teamLoanMsg.setStatus(2);
					teamLoanPlayerMapper.updateTeamLoanMsg(teamLoanMsg);
					
					TeamInfo buy_team = teamInfoMapper.getEntityById(teamLoanMsg.getBuy_teaminfo_id());
					//发送站内信息
					messageResourceService.saveMessage(new Object[]{sellTeam.getName(),username}, SYSTYPE.LOANFALSE.toString(), "team.loan.reject", buy_team.getUser_id(), sellTeam.getUser_id(), teamLoanMsg.getId(), 1);
				}
			}
			//在定向转会中关于该球员的请求设置为已经处理
			List<TransferMsg> tms = teamInviteMapper.queryUntreatedTransferMsg(loanMsg.getLoan_teaminfo_id(),loanMsg.getUser_id());//查询关于该球员未处理转会请求
			if(tms!=null&&tms.size()>0){
				for (TransferMsg transferMsg : tms) {
					transferMsg.setStatus(2);
					teamInviteMapper.updateTransferMsg(transferMsg);
					//发送站内信息
					TeamInfo bteam = teamInfoMapper.getEntityById(transferMsg.getBuy_teaminfo_id());
					User bplayer = userMapper.getEntityById(transferMsg.getUser_id());
					if(bteam!=null&&bplayer!=null){
						String busername = StringUtils.isNotBlank(bplayer.getUsername())?bplayer.getUsername():bplayer.getUsernick();
						messageResourceService.saveMessage(new Object[]{sellTeam.getName(),busername}, SYSTYPE.BUYFALSE.toString(), "team.buyplayer.reject", bteam.getUser_id(), sellTeam.getUser_id(), transferMsg.getId(), 1);
					}
				}
			}
			//获得相应比例的租借金（和转会市场比例一致）
			
			BigDecimal price = loanMsg.getPrice();
			//获取购买俱乐部资金账户
			UserAmount buy_amount = userAmountMapper.getUserAmountByTeaminfoID(loanMsg.getBuy_teaminfo_id());
			//获取出售俱乐部资金账户
			UserAmount sell_amount = userAmountMapper.getUserAmountByTeaminfoID(loanMsg.getLoan_teaminfo_id());
			//买方俱乐部账户余额减少（扣除转会费）
			buy_amount.setAmount(buy_amount.getAmount().subtract(loanMsg.getPrice()));
			buy_amount.setReal_amount(buy_amount.getReal_amount().subtract(loanMsg.getPrice()));
			userAmountMapper.update(buy_amount);
			
			//保存用户订单信息
			Order order = new Order();
			order.setId(UUIDGenerator.getUUID());
			order.setMount(1);
			order.setNum_str(Common.createOrderOSN());
			order.setP_code("loanplay");
			order.setPrice(price);
			order.setSum_amount(price);
			//order.setUser_id(buyer);
			order.setTeaminfo_id(loanMsg.getBuy_teaminfo_id());
			orderMapper.save(order);
			
			//插入俱乐部消费记录
			PayCost pc = new PayCost();
			pc.setId(UUIDGenerator.getUUID());
			pc.setAmount(price);
			pc.setDescrible("租借球员");
			pc.setNum_str(Common.createOrderOSN());
			pc.setStatus(1);
			pc.setOrder_id(order.getId());
			//pc.setUser_id(buyer);
			pc.setTeaminfo_id(loanMsg.getBuy_teaminfo_id());
			pc.setP_code("loanplay");
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
			UserAmount playerAmount = userAmountMapper.getByUserId(loanMsg.getUser_id());
			playerAmount.setAmount(playerAmount.getAmount().add(player_money));
			playerAmount.setReal_amount(playerAmount.getReal_amount().add(player_money));
			userAmountMapper.update(playerAmount);
			
			//被租球员被添加已出租标签
			TeamPlayer tp = teamInfoMapper.getTeamPlayerByUserID(loanMsg.getLoan_teaminfo_id(), loanMsg.getUser_id());
			TeamLoanPlayer tlp = new TeamLoanPlayer();
			tlp.setId(UUIDGenerator.getUUID());
			tlp.setUser_id(loanMsg.getUser_id());
			tlp.setTeaminfo_id(loanMsg.getLoan_teaminfo_id());
			tlp.setNew_teaminfo_id(loanMsg.getBuy_teaminfo_id());
			tlp.setSalary(tp.getSalary());
			tlp.setPosition(tp.getPosition());
			tlp.setPlayer_num(tp.getPlayer_num());
			tlp.setEnd_time(loanMsg.getEnd_time());
			teamLoanPlayerMapper.save(tlp);
			
			
			//收到系统信息“租借成功，（出租方名称）同意了你租借（被租球员名称）的请求，租借金已从俱乐部账号中扣除。”
			messageResourceService.saveMessage(new Object[]{sellTeam.getName(),username}, SYSTYPE.LOANTRUE.toString(), "team.loan.agree", buyTeam.getUser_id(), sellTeam.getUser_id(), loanMsg.getId(), 1);
		}else{
			//拒绝后发送站内信息
			messageResourceService.saveMessage(new Object[]{sellTeam.getName(),username}, SYSTYPE.LOANFALSE.toString(), "team.loan.reject", buyTeam.getUser_id(), sellTeam.getUser_id(), loanMsg.getId(), 1);
		}
		
		return AjaxMsg.newSuccess();
	}

	@Override
	public String checkIfLoan(String sellTeamId, String buyTeamId) {
		//检测出租方是否联赛俱乐部
		TeamLeague sellTeamLeague = leagueMapper.getTeamLeague(null,sellTeamId);
		if(sellTeamLeague == null){
			return messageResourceService.getMessage("system.error.league.unleagueteam");
		}
		//出租方是否可以租借
		ActiveCode activeCode = leagueMapper.getActiveCodeByLidAndTid(sellTeamLeague.getLeague_id(),sellTeamId);
		if(activeCode==null || activeCode.getIf_loan()==0){
			return messageResourceService.getMessage("team.loan.unsupported");
		}
		
		//检测租借方是否联赛俱乐部
		TeamLeague buyTeamLeague = leagueMapper.getTeamLeague(null,buyTeamId);
		if(buyTeamLeague == null){
			return messageResourceService.getMessage("system.error.league.unleagueteam");
		}
		
		//租借方是否可以租借
		ActiveCode buy_activeCode = leagueMapper.getActiveCodeByLidAndTid(buyTeamLeague.getLeague_id(),buyTeamId);
		if(buy_activeCode==null || buy_activeCode.getIf_loan()==0){
			return messageResourceService.getMessage("team.loan.buyunsupported");
		}
		
		//检测是否在同一赛季
		if(!(sellTeamLeague.getS_id()).equals(buyTeamLeague.getS_id())){
			return messageResourceService.getMessage("team.loan.unsupported");
		}
		return null;
	}

	@Override
	public boolean checkIfLoanShow(String buyTeamId) {
		//检测租借方是否联赛俱乐部
		TeamLeague buyTeamLeague = leagueMapper.getTeamLeague(null,buyTeamId);
		if(buyTeamLeague == null){
			return false;
		}
		//租借方是否可以租借
		ActiveCode buy_activeCode = leagueMapper.getActiveCodeByLidAndTid(buyTeamLeague.getLeague_id(),buyTeamId);
		if(buy_activeCode==null || buy_activeCode.getIf_loan()==0){
			return false;
		}
		return true;
	}
	
	@Override
	public AjaxMsg deleteTeamLoanMsg(String id)throws Exception{
		teamLoanPlayerMapper.deleteTeamLoanMsg(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public List<TeamLoanPlayer> getTeamPlayersByTeamInfoId(String teaminfo_id) {
		return teamLoanPlayerMapper.getTeamPlayersByTeamInfoId(teaminfo_id);
	}

	@Override
	public AjaxMsg updateNum(String id, int num) throws Exception {
		 teamLoanPlayerMapper.updateNum(id,num);
		 return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public List<Map<String, Object>> getTeamLoanDetailData(String s_id, String turn_num) {
		return teamLoanPlayerMapper.getTeamLoanDetailData(s_id,turn_num);
	}
	
	
}
