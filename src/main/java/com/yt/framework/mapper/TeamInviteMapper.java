package com.yt.framework.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.persistent.entity.TeamGameBaby;
import com.yt.framework.persistent.entity.TeamInvite;
import com.yt.framework.persistent.entity.TransferMsg;
import com.yt.framework.utils.AjaxMsg;

/**
 *俱乐部对战
 *@autor ylt
 *@date2015-8-3下午2:58:24
 */
public interface TeamInviteMapper extends BaseMapper<TeamInvite> {
	/** 俱乐部约战状态更新
	 *@param id约战比赛id status 约战状态
	 *@return void
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public void updateInvite(@Param(value="id")String id, @Param(value="status")Integer status);

	/** 俱乐部约战中列表
	 *@param
	 *@return List
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午3:18:41
	 */	
	public void updateInviteByProcedure(@Param(value="maps") Map maps);
	
	/** 俱乐部约战中列表
	 *@param teaminfo_id 俱乐部ID status 约战状态
	 *@return List
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午3:18:41
	 */	
	public List<TeamInvite> inviteList(@Param(value="teaminfo_id")String teaminfo_id);

	/** 俱乐部历史对战列表
	 *@param teaminfo_id 球队id
	 *@return List
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午3:18:41
	 */		
	public List<TeamGame> historyGameList(@Param(value="maps")Map<String, Object> maps);
	
	/** 俱乐部当前对战
	 *@param teaminfo_id 球队id
	 *@return TeamGame
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午3:18:41
	 */		
	public TeamGame currentGame(@Param(value="teaminfo_id")String teaminfo_id);
	
	/** 俱乐部所有待确认和确认中比赛
	 *@param map
	 *@return List
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午3:18:41
	 */	
	public List<Map<String, Object>> allMatchGame(@Param(value="maps")Map<String,Object> maps);

	/** 获取比赛记录
	 *@param id
	 *@return TeamGame
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-15下午3:18:41
	 */	
	public TeamGame getTeamGameById(@Param(value="id")String id);

	/** 更新比赛比分、状态
	 *@param TeamGame
	 *@return 
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-15下午3:18:41
	 */	
	public void updateTeamGame(TeamGame teamGame);
	
	/** 查询热门比赛
	 *@return 
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-15下午3:18:41
	 */	
	public List<Map<String, Object>> queryHotGame(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询热门比赛总数
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-22下午3:06:56
	 */
	public int queryHotGameCount(@Param(value="maps")Map<String,Object> maps);
	
	/** 查询双方比赛
	 *@return 
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-1下午3:18:41
	 */	
	public TeamInvite getInviteByTeam(@Param(value="teaminfo_id")String teaminfo_id, @Param(value="respond_teaminfo_id")String respond_teaminfo_id);

	/** 历史比赛总数
	 *@return 
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-1下午3:18:41
	 */		
	public int countHistory(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 查询该俱乐部比赛记录
	 *@param teaminfo_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-7下午5:22:18
	 */
	public List<TeamGame> loadTeamGameByTeamId(@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 查询该俱乐部比赛
	 *@param teaminfo_id
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-9下午5:22:18
	 */	
	public TeamGame loadTeamGameById(@Param(value="id")String id);
	
	/**
	 * 查询该俱乐部比赛和宝贝信息
	 *@param maps 
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-12下午5:22:18
	 */	
	public List<TeamGameBaby> historyGameMap(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 获取比赛记录
	 * @param date
	 * @return
	 */
	public List<TeamGame> getAllTeamGameByDate(@Param(value="date")Date date);
	
	/**
	 * 新增比赛记录
	 * @param teamGame
	 */
	public void saveTeamGame(TeamGame teamGame);
	
	/**
	 * 删除比赛记录
	 * @param teamGame
	 */
	public void delTeamGame(@Param(value="id")String id);

	/**
	 * 保存转会信息
	 * @param TransferMsg
	 */
	public void saveTransferMsg(TransferMsg transferMsg);
	/**
	 * 更新转会信息
	 * @param TransferMsg
	 */
	public void updateTransferMsg(TransferMsg transferMsg);
	
	/**
	 * 查询转会交易记录
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public int transferMarketCount(@Param(value="maps")Map<String, Object> maps);
	public List<Map<String, Object>> queryTransferMarket(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 获取转会纪录消息
	 * @param id
	 * @return
	 */
	public TransferMsg getTransferMsg(String id);


	/**
	 * 获取其他求购信息
	 * @param mid
	 * @param tid
	 * @param uid
	 * @return
	 */
	public List<TransferMsg> queryOtherTransferMsg(@Param(value="mid")String mid, @Param(value="tid")String tid, @Param(value="uid")String uid);

	/**
	 * 删除转会消息
	 * @param id
	 * @return
	 */
	public void deleteTransferMsg(@Param(value="id")String id);

	/**
	 * 查询关于该球员未处理转会请求
	 * @param user_id
	 * @return
	 */
	public List<TransferMsg> queryUntreatedTransferMsg(@Param(value="team_id")String team_id,@Param(value="user_id")String user_id);

}
