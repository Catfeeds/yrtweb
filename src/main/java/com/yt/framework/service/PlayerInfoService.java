package com.yt.framework.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.yt.framework.persistent.entity.AuctionCondition;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.PlayerTag;
import com.yt.framework.persistent.entity.PlayerTerm;
import com.yt.framework.persistent.entity.SuspendPlayer;
import com.yt.framework.persistent.entity.Trial;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: PlayerInfoService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月3日 下午4:05:37 
 */
public interface PlayerInfoService extends BaseService<PlayerInfo> {
	
	
	public AjaxMsg savePlayerInfo(PlayerInfo info,HttpServletRequest request) throws Exception;
	public AjaxMsg updatePlayerInfo(PlayerInfo info) throws Exception;
	
	/**
	 * 根据用户ID获取用户属性和能力
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg getPlayerInfoByUserId(String userId,boolean flag);

	/**
	 * 获取球员经纪人
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg getAgentByUserId(String userId);

	/**
	 * 获取球员所在俱乐部
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg getTeamByUserId(String userId);

	/**
	 * 申请解约经纪人
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg terminated(String userId);

	/**
	 * 退出俱乐部
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg quitTeam(String userId);

	/**
	 * 经纪人向球员申请签约  该按钮在球员信息页
	 * @param userId 经纪人ID
	 * @param playerId 球员的userID
	 * @return AjaxMsg
	 */
	/*public AjaxMsg signByPlayer(String userId, String playerId);*/

	/**
	 * 球员向经纪人申请签约  该按钮在经纪人信息页
	 * @param userId 球员的userID
	 * @param agentId 经纪人ID
	 * @return AjaxMsg
	 */
	public AjaxMsg signByAgent(String userId, String agentId);
	/**
	 * 队长邀请球员加入球队
	 * @param request
	 * @return
	 */
	public AjaxMsg saveTeamByPlayer(String userId, String playerId)throws Exception; 
	
	
	/**
	 * 保存邀请试训人员记录
	 * @param trial
	 * @return
	 */
	public AjaxMsg saveTrial(Trial trial)throws Exception;
	
	/**
	 * 试训次数
	 * @param userId
	 * @return int
	 */
	public int trialCount(String userId);
	
	/**
	 * @Title: 球员筛选查询 
	 * @param    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @author ylt
	 * @date  2015年8月25日上午9:57:18
	 */
	public AjaxMsg searchPlayerInfo(PlayerTerm playerTerm, PageModel pageModel)throws Exception;
	
	/**
	 * 查询是否球员  如果是球员返回收到邀请数量,粉丝数量,综合分数
	 * @param userId
	 * @author gl
	 * @return AjaxMsg
	 */
	public AjaxMsg queryHasPlayer(String userId);
	
	/**
	 * 更新试训状态
	 * @param userId
	 * @author gl
	 * @return AjaxMsg
	 */
	public AjaxMsg updateTrial(String trail_id, Integer status);
	/**
	 * @param othUserId 接受人ID
	 * @param uid 发送人ID;
	 * @return
	 */
	public AjaxMsg queryTrialByUserId(String othUserId, String uid);
	/**
	 * @param user_id 用户id
	 * @return
	 */
	public PlayerInfo getPlayerInfoByUserId(String user_id);
	
	/**
	 * 球员解约经纪人
	 * @param agent_id
	 * @param player_id
	 * @param status 状态 0:无 1：同意 2：拒绝
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-09-21下午2:34:33
	 */
	public AjaxMsg breakAgent(String agent_id, String player_id, Integer status)throws Exception;
	
	/**
	 * 球员签约经纪人
	 * 
	 * @param agent_id
	 * @param player_id
	 * @param status 状态 0:无 1：同意 2：拒绝
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-09-21下午2:34:33
	 */
	public AjaxMsg signAgent(String agent_id, String player_id, Integer status)throws Exception;
	
	
	public List<Map<String, Object>> queryPraise(Map<String, Object> params);
	
	/**
	 * 用户给球员点赞或点踩
	 * @param params
	 * @return
	 */
	public AjaxMsg updatePraise(Map<String, Object> params) throws Exception;

	/**
	 * 购买球员
	 * @param maps
	 * @return
	 */
	public AjaxMsg buyPalyer(Map<String,Object> maps)throws Exception ;
	
	
	/**
	 * 查询用户所购买球员
	 * @param user_id
	 * @return
	 */
	public AjaxMsg loadMarketRecord(Map params,PageModel pageModel);
	
	/**
	 * 查询球员列表
	 * @param condition
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadPlayers(AuctionCondition condition,PageModel pageModel);
	
	/**
	 * 根据球员用户ID查询球员相关信息
	 * @param user_id
	 * @param status
	 * @return
	 */
	public Map<String,Object> getPlayerInfoForMarketByUserId(String user_id,String status);
	/**
	 * 更新球员当前身价
	 * @param user_id
	 * @return
	 */
	public AjaxMsg updatePrice(String user_id,BigDecimal current_price)throws Exception;
	
	/**
	 * 查询用户出售球员
	 * @param condition
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadSaleRecord(AuctionCondition condition,PageModel pageModel);
	
	/**
	 * 查询用户评价信息
	 * @param maps
	 * @return
	 */
	public AjaxMsg queryPlayerTag(String user_id);
	
	/**
	 * 保存用户评价
	 * @param maps
	 * @return
	 */
	public AjaxMsg savePlayerTag(PlayerTag playerTag)throws Exception;
	
	/**
	 * 查询用户评价信息
	 * @param maps
	 * @return
	 */
	public AjaxMsg deletePlayerTag(String id)throws Exception;
	
	/**
	 * @Title: 推荐球员查询 
	 * @param   
	 * @return AjaxMsg    返回类型 
	 * @author ylt
	 * @date  2015年8月25日上午9:57:18
	 */
	public AjaxMsg searchPlayerInfoByAdmin(Map maps,PageModel pageModel);
	/**
	 * @Title: 推荐球员查询汇总
	 * @param   
	 * @return AjaxMsg    返回类型 
	 * @author ylt
	 * @date  2015年8月25日上午9:57:18
	 */
	public int countAdmin(Map maps);
	
	public AjaxMsg savePlayerRecommendation(String userIds)throws Exception;
	
	public AjaxMsg updatePlayerRecommendation(Map<String, Object> maps)throws Exception;
	
	public AjaxMsg deletePlayerRecommendation(String id)throws Exception;
	
	/**
	 * <!-- 判断该球员是否在转会市场 -->
	 * @param userId
	 * @return
	 */
	public LeagueMarket getPlayerInLeagueMarket(String userId);
	
	/**
	 * 获取该用户是否禁赛
	 * @param user_id
	 * @return
	 */
	public SuspendPlayer getSuspendPlayerByUserId(String user_id);
	/**
	 * 总球员人数
	 * @return
	 */
	public int queryPlayerRecords();
	/**
	 * 首页球员list
	 * @return
	 */
	public List<PlayerInfo> queryIndexPlayer();
}
