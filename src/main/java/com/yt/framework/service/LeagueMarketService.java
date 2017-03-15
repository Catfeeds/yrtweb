package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.MarketRecords;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: PlayerOtherService.java 
 * @Package com.yt.framework.service
 * @author ylt
 * @date 2015年10月15日 下午4:05:37 
 */
public interface LeagueMarketService extends BaseService<LeagueMarket> {
	/**
	 * 竞拍市场配置
	 * @param leagueMarketCfg
	 */
	public AjaxMsg saveMarketCfg(MarketCfg marketCfg) throws Exception;
	
	/**
	 * 更新竞拍市场配置
	 * @param leagueMarketCfg
	 */
	public AjaxMsg updateMarketCfg(MarketCfg marketCfg)throws Exception;
	
	/**
	 * 查询市场配置列表
	 * @param leagueMarketCfg
	 */
	public AjaxMsg queryCfgForMap(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 查询市场配置总数
	 * @param leagueMarketCfg
	 */
	public int cfgCount(Map<String,Object> maps);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueMarketCfg
	 */
	public MarketCfg getCfgById(String id);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueMarketCfg
	 */
	public List<MarketCfg> getCfgByLeague(String s_id);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueMarketCfg
	 */
	public MarketCfg queryCfg(String s_id,Integer turn_num);
	
	/**
	 * 查询当前开放市场
	 * @param leagueMarketCfg
	 */
	public MarketCfg getCurrentMarket(String s_id);
	
	/**
	 * 保存市场竞拍纪录
	 * @param id
	 */
	public AjaxMsg saveMarketRecords(MarketRecords marketRecords)throws Exception;
	
	/**
	 * 删除配置
	 * @param leagueMarketCfg
	 */
	public AjaxMsg deleteCfg(String id)throws Exception;
	
	/**
	 * 判断交易市场是否关闭
	 * @param leagueMarketCfg
	 */
	public AjaxMsg ifOpenMarket(String s_id);
	
	/**
	 * 获取市场球员信息
	 * @param user_id
	 */
	public LeagueMarket getMarketUser(String user_id,Integer status);
	
	/**
	 * 判断某联赛球员交易市场状态
	 * @param league_id
	 * @return
	 */
	public AjaxMsg marketStatus(String s_id);
	
	/**
	 * 更新球员竞拍数据（乐观锁方法）
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg updateLock(LeagueMarket leagueMarket)throws Exception;
	
	/**
	 * 更新市场结算
	 * @param leagueAuctionCfg
	 */
	public AjaxMsg modifyLeagueMarket(MarketCfg cfg)throws Exception;
	
	/**
	 * 批量发送短信
	 * @param leagueAuctionCfg
	 */
	public void sendCalculateMsg(MarketCfg cfg);

	/**
	 *  转会公告
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryLeagueMarket(Map<String, Object> params,PageModel pageModel);
	
	/**
	 *  获取市场球员数据
	 * @param params
	 * @param m_id 转会球员数据id
	 * @return
	 */
	public Map<String, Object> getPlayerInfoForMarketById(String m_id);
	
	/**
	 *  保存竞拍纪录
	 * @param params
	 * @return
	 */
	public AjaxMsg saveMarketData(Map<String, Object> params)throws Exception;

	/**
	 * 转会竞拍历史记录
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryMarketHistorys(Map<String, Object> maps,PageModel pageModel);
	
	/**
	 * 一口价购买
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg saveMarketDataOnePrice(Map<String, Object> params)throws Exception;
	
	/**
	 * 每轮转会数据详情
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public List<Map<String, Object>> getMarketDetailData(String s_id, String turn_num);
}
