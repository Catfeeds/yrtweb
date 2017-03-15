package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.AuctionCondition;
import com.yt.framework.persistent.entity.LeagueAuction;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.LeagueAuctionRecords;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: PlayerOtherService.java 
 * @Package com.yt.framework.service
 * @author ylt
 * @date 2015年10月15日 下午4:05:37 
 */
public interface LeagueAuctionService extends BaseService<LeagueAuction> {
	/**
	 * 竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg saveAuctionCfg(LeagueAuctionCfg leagueAuctionCfg) throws Exception;
	
	/**
	 * 更新竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg updateAuctionCfg(LeagueAuctionCfg leagueAuctionCfg)throws Exception;
	
	/**
	 * 查询市场配置列表
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg queryCfgForMap(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 查询市场配置总数
	 * @param leagueAuctionCfg
	 */
	public int cfgCount(Map<String,Object> maps);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public LeagueAuctionCfg getCfgById(String id);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public List<LeagueAuctionCfg> getCfgByLeague(String league_id);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public LeagueAuctionCfg queryCfg(String s_id,Integer turn_num);
	
	/**
	 * 查询市场球员列表
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg queryAuctionForMap(AuctionCondition auctionCondition, PageModel pageModel)throws Exception;
	
	/**
	 * 查询市场球员列表汇总
	 * @param leagueAuctionCfg
	 */
	public int auctionCount(Map<String, Object> maps);
	
	/**
	 * 查询当前开放市场
	 * @param leagueAuctionCfg
	 */
	public LeagueAuctionCfg getCurrentAuction(String s_id);
	
	/**
	 * 查询球员详情
	 * @param id
	 */
	public AjaxMsg getAuctionPlayerDetail(String id);
	
	/**
	 * 保存市场竞拍纪录
	 * @param id
	 */
	public AjaxMsg saveRecords(LeagueAuctionRecords records)throws Exception;
	
	/**
	 * 获取竞拍纪录数据
	 * @param id
	 */
	public LeagueAuctionRecords getRecordsById(String r_id);
		
	/**
	 * 竞拍球员
	 * @param id
	 */
	public AjaxMsg saveAuction(String user_id, String id, String turn_id ,String price)throws Exception;
	
	/**
	 * 更新球员竞拍数据（乐观锁方法）
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg updateLock(LeagueAuction leagueAuction)throws Exception;
	
	/**
	 * 查询我竞拍的市场球员列表
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg queryMyAuctionForMap(AuctionCondition auctionCondition, PageModel pageModel)throws Exception;
	
	/**
	 * 查询我的市场球员列表汇总
	 * @param leagueAuctionCfg
	 */
	public int myAuctionCount(Map<String, Object> maps);
	
	/**
	 * 联赛拍卖市场结算
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg modifyLeagueAuction(LeagueAuctionCfg leagueAuctionCfg) throws Exception;
	
	/**
	 * 删除配置
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg deleteCfg(String id)throws Exception;
	
	/**
	 * 结算短信通知
	 */
	public AjaxMsg sendCalculateMsg(LeagueAuctionCfg leagueAuctionCfg)throws Exception;

	/**
	 * 查询竞拍市场中的球员
	 * @author gl
	 * @param user_id
	 * @param s_id
	 * @return
	 */
	public LeagueAuction getAuctionPlayer(String user_id, String s_id);
	public LeagueAuction getAucPlayer(String s_id,String user_id);
	public List<LeagueAuction> getAuctionPlayers(String user_id);
	
	/**
	 * 获取赛季下的市场
	 */
	public List<LeagueAuctionCfg> getCfgByLeagueCfg(String s_id);
	
	/**
	 * 获取竞拍球员数据
	 */
	public List<Map<String,Object>> getAuctionDetailData(String s_id, String turn_num);
}
