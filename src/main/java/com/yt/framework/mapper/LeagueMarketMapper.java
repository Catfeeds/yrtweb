package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.LeagueAuction;
import com.yt.framework.persistent.entity.LeagueAuctionRecords;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.MarketCfg;
import com.yt.framework.persistent.entity.MarketRecords;
import com.yt.framework.utils.AjaxMsg;
/**
 * 交易市场
 *@autor ylt
 *@date2015-10-16下午1:58:51
 */
public interface LeagueMarketMapper extends BaseMapper<LeagueMarket>{
	
	public LeagueMarket getLeagueMarketByUserIDAndStatus(@Param(value="user_id")String user_id,@Param(value="status")String status);
	
	/**
	 * 交易市场配置
	 * @param leagueMarketCfg
	 */
	public void saveMarketCfg(MarketCfg marketCfg);
	
	/**
	 * 更新交易市场配置
	 * @param leagueMarketCfg
	 */
	public void updateMarketCfg(MarketCfg marketCfg);
	
	/**
	 * 查询市场配置列表
	 * @param leagueMarketCfg
	 */
	public List<Map<String,Object>> queryCfgForMap(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询市场配置总数
	 * @param leagueMarketCfg
	 */
	public int cfgCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询交易市场配置
	 * @param leagueMarketCfg
	 */
	public MarketCfg getCfgById(@Param(value="id")String id);
	
	/**
	 * 查询交易市场配置
	 * @param leagueMarketCfg
	 */
	public MarketCfg getCurrentMarket(@Param(value="s_id")String s_id);
	
	/**
	 * 保存市场交易纪录
	 * @param id
	 */
	public void saveMarketRecords(MarketRecords marketRecords);
	
	/**
	 * 删除配置
	 * @param leagueMarketCfg
	 */
	public void deleteCfg(@Param(value="id")String id);
	
	/**
	 * 获取市场球员信息
	 * @param user_id
	 */
	public LeagueMarket getMarketUser(@Param(value="user_id")String user_id,@Param(value="status")Integer status);
	
	/**
	 * 转会数据更新
	 * @param leagueMarket
	 */
	public int updateLock(LeagueMarket leagueMarket);

	/**
	 * 转会公告
	 * @param params
	 * @return
	 */
	public int leagueMarketCount(@Param(value="maps")Map<String, Object> params);
	public List<Map<String, Object>> queryLeagueMarket(@Param(value="maps")Map<String, Object> params);

	
	/**
	 * 批量结算转会数据
	 * @param leagueMarket
	 */
	public void updateBatchMarket(@Param(value="turn_num")Integer turn_num, @Param(value="next_num")Integer next_num, 
			@Param(value="user_percent")float user_percent,@Param(value="team_percent")float team_percent, @Param(value="s_id")String s_id);

	/**
	 * 转会竞拍历史记录
	 * @param params
	 * @return
	 */
	public int marketHistorysCount(@Param(value="maps")Map<String, Object> params);
	public List<Map<String, Object>> queryMarketHistorys(@Param(value="maps")Map<String, Object> params);
	

	/**
	 *  获取市场球员数据
	 * @param params
	 * @param m_id 转会球员数据id
	 * @return
	 */
	public Map<String, Object> getPlayerInfoForMarketById(@Param(value="m_id")String m_id);

	/**
	 * 获取竞拍纪录数据
	 * @param MarketRecords
	 */
	public MarketRecords getRecordsById(@Param(value="id")String id);
	
	/**
	 * 清除转会相关消息(租借等)
	 * @param MarketRecords
	 */
	public void clearMsg(@Param(value="id")String id);
	
	/**
	 * 转会相关
	 * @param MarketRecords
	 */
	public List<Map<String, Object>> getMarketDetailData(@Param(value="s_id")String s_id,@Param(value="turn_num")String turn_num);
}
