package com.yt.framework.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.AgentPlayer;
import com.yt.framework.persistent.entity.AuctionCondition;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.MarketRecords;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.PlayerTag;
import com.yt.framework.persistent.entity.SuspendPlayer;
import com.yt.framework.persistent.entity.TeamSale;
import com.yt.framework.persistent.entity.TransferRecord;
import com.yt.framework.persistent.entity.Trial;

/**
 * @Title: PlayerInfoMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月3日 下午5:43:00 
 */
public interface PlayerInfoMapper extends BaseMapper<PlayerInfo>{
	
	/**
	 * 根据用户ID获取用户属性和能力
	 * @param userId
	 */
	public Map<String, Object> getPlayerInfoByUserId(@Param(value="userId")String userId);

	public Map<String, Object> getAgentByUserId(@Param(value="userId")String userId);

	public Map<String, Object> getTeamByUserId(@Param(value="userId")String userId);

	public int terminated(@Param(value="userId")String userId);

	public int quitTeam(@Param(value="userId")String userId);

	public int signByPlayer(AgentPlayer ap);

	public int saveTrial(Trial trial);

	public int trialCount(@Param(value="userId")String userId);

	/**
	 * @Title: 球员筛选查询 
	 * @param    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @author ylt
	 * @date  2015年8月25日上午9:57:18
	 */
	public List<Map<String, Object>> searchPlayerInfo(@Param(value="maps")Map<String,Object> maps);

	/**
	 * 查询球员收到的邀请数量,粉丝数量
	 * @param user_id
	 * @return List<String>
	 */
	public List<String> queryPlayerCount(@Param(value="userId")String userId);

	/**
	 * 更新试训状态
	 * @param userId
	 * @author gl
	 * @return AjaxMsg
	 */
	public void updateTrial(@Param(value="trail_id")String trail_id, @Param(value="status")Integer status);

	/**
	 * @param othUserId 接受人ID
	 * @param uid 发送人ID;
	 * @return
	 */
	public List<Trial> queryTrialByUserId(@Param(value="user_id")String user_id, @Param(value="s_user_id")String s_user_id);
	
	
	/**
	 * 踩或赞的的数量
	 * @param userId
	 * @return
	 */
	public List<String> praiseCount(@Param(value="p_user_id")String p_user_id);
	
	/**
	 * 查询是否已经给球员点过赞或踩
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryPraise(Map<String, Object> params);
	
	/**
	 * 球员点赞
	 * @param params
	 * @return
	 */
	public int savePraise(Map<String, Object> params);
	/**
	 * 用户取消球员点赞
	 * @param params
	 * @return
	 */
	public int deletePraise(Map<String, Object> params);
	
	/**
	 * 更新球员能力属性
	 * @param playerInfo
	 */
	public void updateByUserId(PlayerInfo playerInfo);
	
	/**
	 * 获取市场球员信息
	 * @param id
	 * @return
	 */
	public LeagueMarket getLeagueMarketById(@Param(value="id")String id);
	
	/**
	 * 更新市场球员信息
	 * @param leagueMarket
	 */
	public void updateLeagueMarker(LeagueMarket leagueMarket);
	
	/**
	 * 保存球员购买记录
	 * @param records
	 */
	public void saveMarketRecord(MarketRecords records);
	
	/**
	 * 查询用户所购买球员
	 * @param user_id
	 * @return
	 */
	public List<Map<String,Object>> loadMarketRecord(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询用户所购买球员总数
	 * @param maps
	 * @return
	 */
	public int loadMarketRecordCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询用户出售球员
	 * @param condition
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>>loadSaleRecord(@Param(value="condition")AuctionCondition condition,@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 查询用户出售球员总数
	 * @param maps
	 * @return
	 */
	public int loadSaleRecordCount(@Param(value="condition")AuctionCondition condition);
	
	/**
	 * 保存出售记录
	 * @param teamSale
	 */
	public void saveTeamSale(TeamSale teamSale);
	
	/**
	 * 删除出售记录
	 * @param id
	 */
	public void deleteTeamSale(@Param(value="id")String id);
	/**
	 * 获取某个用户的出售记录
	 * @param user_id 用户ID
	 * @param status 是否出售
	 * @return
	 */
	public TeamSale getTeamSaleByUserID(@Param(value="user_id")String user_id,@Param(value="status")String status);
	/**
	 * 更新出售记录
	 * @param teamSale
	 */
	public void updateTeamSale(TeamSale teamSale);
	
	/**
	 * 查询球员列表
	 * @param condition
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadPlayers(@Param(value="condition")AuctionCondition condition,@Param(value="maps")Map<String,Object> maps);

	/**
	 * 查询球员列表数量
	 * @param condition
	 * @return
	 */
	public int loadPlayersCount(@Param(value="condition")AuctionCondition condition);
	
	/**
	 * 根据球员用户ID查询球员相关信息
	 * @param user_id
	 * @return
	 */
	public Map<String,Object> getPlayerInfoForMarketByUserId(@Param(value="user_id")String user_id,@Param(value="status")String status);
	
	/**
	 * 更新球员当前身价
	 * @param user_id
	 * @return
	 */
	public void updatePrice(@Param(value="user_id")String user_id, @Param(value="current_price")BigDecimal current_price);
	
	/**
	 * 更新球员当前身价
	 * @param user_id
	 * @return
	 */
	public void updateLeagueStatus(@Param(value="user_id")String user_id, @Param(value="if_league")Integer if_league);
	
	/**
	 * 保存球员转会记录
	 * @param transferRecord
	 */
	public void saveTransferRecord(TransferRecord transferRecord);
	
	/**
	 * 查询用户评价信息
	 * @param maps
	 * @return
	 */
	public List<PlayerTag> queryPlayerTag(@Param(value="user_id")String user_id);
	
	/**
	 * 保存用户评价
	 * @param maps
	 * @return
	 */
	public void savePlayerTag(PlayerTag playerTag);
	
	/**
	 * 查询用户评价信息
	 * @param maps
	 * @return
	 */
	public void deletePlayerTag(@Param(value="id")String id);
	
	/**
	 * @Title: 推荐球员查询 
	 * @param   
	 * @return AjaxMsg    返回类型 
	 * @author ylt
	 * @date  2015年8月25日上午9:57:18
	 */
	public List<Map<String, Object>> searchPlayerInfoByAdmin(@Param(value="maps")Map<String,Object> maps);

	public int countAdmin(@Param(value="maps")Map<String,Object> maps);
	
	public int savePlayerRecommendation(Map<String, Object> maps);
	
	public int updatePlayerRecommendation(Map<String, Object> maps);
	
	public int deletePlayerRecommendation(@Param(value="id")String id);

	/**
	 * <!-- 判断该球员是否在转会市场 -->
	 * @param userId
	 * @return
	 */
	public LeagueMarket getPlayerInLeagueMarket(@Param(value="userId")String userId);
	
	/**
	 * 获取该用户是否禁赛
	 * @param user_id
	 * @return
	 */
	public SuspendPlayer getSuspendPlayerByUserId(@Param(value="user_id")String user_id);
	/**
	 * 总球员人数
	 * @return
	 */
	public int queryPlayerRecords();
	
}
