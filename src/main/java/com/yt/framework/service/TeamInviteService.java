package com.yt.framework.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamInvite;
import com.yt.framework.persistent.entity.TransferMsg;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
/**
 *俱乐部对战
 *@autor ylt
 *@date2015-8-13下午3:15:49
 */
public interface TeamInviteService extends BaseService<TeamInvite>{
	
	/**
	 * 俱乐部约战列表
	 *@param id 约战id status 约战状态 teaminfo_id 俱乐部id
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public AjaxMsg inviteList(String teaminfo_id);
	
	/**
	 * 俱乐部约战状态更新
	 *@param id 约战id status 约战状态 teaminfo_id 俱乐部id
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public AjaxMsg updateInvite(String id, Integer status,String teaminfo_id,String respond_teaminfo_id) throws Exception;
	
	/**
	 * 俱乐部历史对战记录
	 * @param pageModel 
	 *@param id 约战id status 约战状态 teaminfo_id 俱乐部id
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public AjaxMsg historyGameList(String teaminfo_id, PageModel pageModel);

	/**
	 * 俱乐部当前对战信息
	 *@param  teaminfo_id 俱乐部id
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public AjaxMsg currentGame(String teaminfo_id);
	
	/**
	 * 俱乐部待确认对战信息
	 *@param teaminfo_id 俱乐部id
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public AjaxMsg allMatchGame(String teaminfo_id);

	/**
	 * 上传比赛记录
	 *@param teaminfo_id 俱乐部id
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public AjaxMsg uploadResult(TeamGame tg,String teaminfo_id)throws Exception;

	/**
	 * 确认比赛结果
	 * @param teaminfo_id 
	 *@param teaminfo_id 俱乐部id
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public AjaxMsg checkResult(String id, String teaminfo_id, Integer status)throws Exception;

	/**
	 * 热门比赛
	 *@param teaminfo_id 
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public List<Map<String, Object>> queryHotGameList(Map<String,Object> maps);
	
	/**
	 * 查询热门比赛总数
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-22下午3:06:56
	 */
	public int queryHotGameCount(Map<String,Object> maps);
	
	/**
	 * 俱乐部约战状态更新
	 *@param user_id 消息接收用户 s_user_id 消息发送用户
	 *@return AjaxMsg
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-1 下午3:18:41
	 */
	public AjaxMsg updateInviteByMsg(String invite_id,Integer status)throws Exception;
	
	
	/**
	 * 查询该俱乐部比赛记录
	 *@param team_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-7下午5:39:18
	 */
	public List<TeamGame> loadTeamGameByTeamId(String team_id);
	/** 查询双方比赛
	 *@return 
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-1下午3:18:41
	 */	
	public TeamInvite getInviteByTeam(String teaminfo_id,String respond_teaminfo_id);

	/** 查询双方比赛
	 *@return 
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-1下午3:18:41
	 */		
	public TeamGame loadTeamGameById(String id);
	
	
	/**
	 * 查询该俱乐部比赛和宝贝信息
	 *@param maps 
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-12下午5:22:18
	 */	
	public AjaxMsg historyGameMap(String teaminfo_id,Integer status,PageModel pageModel);
	
	/**
	 * 获取比赛记录
	 * @param date
	 * @return
	 */
	public List<TeamGame> getAllTeamGameByDate(Date date);
	
	/**
	 * 更新比赛记录状态
	 * @param teamGame
	 */
	public void updateTeamGame(TeamGame teamGame);
	
	/**
	 * 新增比赛记录
	 * @param teamGame
	 */
	public void saveTeamGame(TeamGame teamGame);
	
	/**
	 * 删除比赛记录
	 * @param teamGame
	 */
	public void delTeamGame(String id);
	
	/**
	 * 保存转会信息
	 * @param TransferMsg
	 */
	public AjaxMsg saveTransferMsg(TransferMsg transferMsg)throws Exception;
	/**
	 * 更新转会信息
	 * @param TransferMsg
	 */
	public AjaxMsg updateTransferMsg(TransferMsg transferMsg)throws Exception;

	/**
	 * 查询转会交易记录
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryTransferMarket(Map<String, Object> maps,PageModel pageModel);
	
	public int transferMarketCount(Map<String, Object> maps);
	

	/**
	 * 处理售出记录
	 * @param id
	 * @param type
	 * @param team
	 * @return
	 */
	public AjaxMsg updateTransferMsg(String id, String type, TeamInfo team) throws Exception;
		
	/**
	 * 获取转会消息
	 * @param id
	 * @return
	 */
	public TransferMsg getTransferMsg(String id);
	
	/**
	 * 删除转会消息
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteTransferMsg(String id)throws Exception;
	
	/**
	 * 删除转会消息
	 * @param id
	 * @return
	 */
	public boolean checkIfTransferShow(String buyTeamId);
	
	/**
	 * 检测出租方和租借方是否可以定向转会
	 * @param sellTeamId
	 * @param buyTeamId
	 * @return
	 */
	public String checkIfTransfer(String sellTeamId, String buyTeamId);

}
