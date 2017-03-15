package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.LeagueAuction;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.LeagueAuctionRecords;
import com.yt.framework.utils.AjaxMsg;
/**
 * 联赛
 *@autor ylt
 *@date2015-10-16下午1:58:51
 */
public interface LeagueAuctionMapper extends BaseMapper<LeagueAuction>{
	
	/**
	 * 删除联赛竞拍用户
	 * @param user_id
	 * @param league_id
	 */
	public void deleteByUser(@Param(value="user_id")String user_id, @Param(value="cfg_id")String cfg_id);
	public void deleteByUserId(@Param(value="user_id")String user_id);
	
	/**
	 * 保存竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public void saveAuctionCfg(LeagueAuctionCfg leagueAuctionCfg);
	
	/**
	 * 更新竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public void updateAuctionCfg(LeagueAuctionCfg leagueAuctionCfg);
	
	/**
	 * 查询市场配置列表
	 * @param leagueAuctionCfg
	 */
	public List<Map<String,Object>> queryCfgForMap(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询市场配置总数
	 * @param leagueAuctionCfg
	 */
	public int cfgCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public LeagueAuctionCfg getCfgById(@Param(value="id")String id);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public List<LeagueAuctionCfg> getCfgByLeague(@Param(value="league_id")String league_id);
	
	/**
	 * 查询竞拍市场配置
	 * @param leagueAuctionCfg
	 */
	public LeagueAuctionCfg queryCfg(@Param(value="s_id")String s_id,@Param(value="turn_num")Integer turn_num);
	
	/**
	 * 查询竞拍市场球员汇总
	 * @param leagueAuctionCfg
	 */
	public int auctionCount(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 查询竞拍市场球员
	 * @param leagueAuctionCfg
	 */
	public List<Map<String, Object>> queryAuctionForMap(@Param(value="maps")Map maps);
	
	/**
	 * 查询当前开发市场
	 * @param leagueAuctionCfg
	 */
	public LeagueAuctionCfg getCurrentAuction(@Param(value="s_id")String s_id);
	
	/**
	 * 查询竞拍球员详情
	 * @param leagueAuctionCfg
	 */
	public Map<String,Object> getAuctionPlayerDetail(@Param(value="id")String id);
	
	/**
	 * 保存市场球员竞拍纪录
	 * @param leagueAuctionCfg
	 */
	public void saveRecords(LeagueAuctionRecords records);
	
	/**
	 * 获取竞拍纪录数据
	 * @param leagueAuctionCfg
	 */
	public LeagueAuctionRecords getRecordsById(@Param(value="id")String id);
	
	/**
	 * 获取竞拍纪录数据
	 * @param leagueAuctionCfg
	 */
	public int updateLock(LeagueAuction leagueAuction)throws Exception;
	
	/**
	 * 查询我的竞拍市场球员
	 * @param leagueAuctionCfg
	 */
	public List<Map<String, Object>> queryMyAuctionForMap(@Param(value="maps")Map maps);
	
	/**
	 * 查询我的竞拍市场球员汇总
	 * @param leagueAuctionCfg
	 */
	public int myAuctionCount(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 竞拍市场结算（储存过程）
	 * @param leagueAuctionCfg
	 */
	public void updateBatchAuction(@Param(value="next_num")Integer next_num, @Param(value="turn_num")Integer turn_num, 
			@Param(value="user_percent")float user_percent,@Param(value="s_id")String s_id);
	
	/**
	 * 竞拍市场结算（储存过程）
	 * @param leagueAuctionCfg
	 */
	public void updateBatchAuctionCd(@Param(value="next_num")Integer next_num, @Param(value="turn_num")Integer turn_num, @Param(value="s_id")String s_id);
	
	
	/**
	 * 删除竞拍市场
	 * @param leagueAuctionCfg
	 */
	public void deleteCfg(String id);

	/**
	 * 查询竞拍市场中的球员
	 * @author gl
	 * @param user_id
	 * @param s_id
	 * @return
	 */
	public LeagueAuction getAuctionPlayer(@Param(value="user_id")String user_id, @Param(value="s_id")String s_id);
	public LeagueAuction getAuctionCheckedPlayer(@Param(value="s_id")String s_id,@Param(value="user_id")String user_id);
	public List<LeagueAuction> getAuctionNoCheckedPlayer(@Param(value="user_id")String user_id);
	
	/**
	 * 获取赛季下市场配置
	 * @param leagueAuctionCfg
	 */
	public List<LeagueAuctionCfg> getCfgByLeagueCfg(String s_id);
	/**
	 * 获取竞拍数据
	 * @param turn_num s_id
	 */
	public List<Map<String, Object>> getAuctionDetailData(@Param(value="s_id")String s_id, @Param(value="turn_num")String turn_num);

}
