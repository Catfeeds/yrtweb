package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.persistent.entity.TeamActiveCode;
import com.yt.framework.persistent.entity.TeamApply;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamNotice;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.User;

/**
 *俱乐部
 *@autor bo.xie
 *@date2015-8-3下午2:58:24
 */
public interface TeamInfoMapper extends BaseMapper<TeamInfo> {
	
	/**
	 * 获取用户俱乐部
	 *@param user_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-3下午3:17:18
	 */
	public TeamInfo getTeamInfoByUserId(@Param(value="user_id")String user_id);
	
	/**
	 * 根据俱乐部成员用户ID获取俱乐部信息
	 * @param p_user_id 俱乐部成员用户ID
	 * @return
	 */
	public TeamInfo getTeamInfoByPUserID(@Param(value="p_user_id")String p_user_id);
	
	/**
	 * 删除俱乐部成员
	 *@param teaminfo_id
	 *@param player_id
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午3:13:03
	 */
	public void deleteTeamPlayer(@Param("teaminfo_id")String teaminfo_id,@Param(value="player_id")String player_id);
	
	/**
	 * 获取球员在俱乐部中的职位
	 *@param teaminfo_id
	 *@param player_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午3:16:33
	 */
	public Integer getTeamPlayerPosition(@Param("teaminfo_id")String teaminfo_id,@Param(value="player_id")String player_id);
	
	/**
	 * 加入俱乐部
	 *@param teamPlayer
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午5:08:55
	 */
	public void saveTeamPlayer(TeamPlayer teamPlayer);
	
	/**
	 * 判断球员是否已经加入到有俱乐部
	 *@param player_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午4:56:25
	 */
	public int isJoinTeamForPlayer(@Param(value="player_id")String player_id);
	
	/**
	 * 查询俱乐部球员列表
	 * @param teaminfo_id
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-8下午4:56:25
	 */
	public List<Map<String, Object>> getTeamPlayerList(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 添加黑名单
	 * @param params
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-10下午4:56:25
	 */
	public void saveBlackPlayer(Map<String, Object> params);

	/**
	 * 查询黑名单
	 * @param params
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-10下午4:56:25
	 */
	public List<Map<String, Object>> getBlackPlayer(@Param(value="maps")Map<String, Object> maps);
	
	public int getBlackPlayerCount(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 踢出黑名单
	 * @param maps
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-10下午4:56:25
	 */
	public void kickfriendPlayer(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 指认队长或者副队长
	 *@param maps
	 *@param type
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-11 下午3:41:08
	 */	
	public void updateType(@Param(value="maps")Map<String, Object> maps);
	/**
	 * 俱乐部邀站搜索列表
	 *@param params , pageModel
	 *@param type
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-11 上午10:41:08
	 */	
	public List<TeamInfo> searchInviteTeam(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 俱乐部创始人
	 *@param String teaminfo_id
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-3 上午10:41:08
	 */
	public User getCaption(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 关注俱乐部
	 *@param focus   f_type:0:非俱乐部，1 :俱乐部 ; f_teaminfo_id关注ID   当关注俱乐部时存放俱乐部ID,非俱乐部时存放用户ID
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-12下午2:28:57
	 */
	public void saveFocus(Focus focus);
	
	/**
	 * 取消关注俱乐部
	 *@param user_id 用户ID
	 *@param  f_teaminfo_id关注ID   当关注俱乐部时ID为俱乐部ID,非俱乐部时ID为用户ID
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-12下午5:53:36
	 */
	public void deleteFocus(@Param(value="user_id")String user_id,@Param(value="f_teaminfo_id")String f_teaminfo_id);
	
	/**
	 * 获取用户关注俱乐部
	 *@param user_id 用户ID
	 *@param  f_teaminfo_id关注ID   当关注俱乐部时ID为俱乐部ID,非俱乐部时ID为用户ID
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-12下午5:53:36
	 */
	public int getFocusTeams(@Param(value="user_id")String user_id,@Param(value="f_teaminfo_id")String f_teaminfo_id);
	
	/**
	 * 获取俱乐部能力值,俱乐部人员数
	 *@param teamInfo_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-7下午2:19:18
	 */
	public Map<String,Object> getTeamAbilityScore(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 获取该用户在俱乐部成员中的信息
	 *@param user_id
	 *@param teaminfo_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-7下午4:23:33
	 */
	public TeamPlayer getTeamPlayerInfoByIds(@Param(value="user_id")String user_id,@Param("teaminfo_id")String teaminfo_id);
	
	/**
	 *根据用户id,查询俱乐部球员表信息 
	 *@param user_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-8下午4:57:52
	 */
	public TeamPlayer getTeamPlayerByUserId(@Param(value="user_id")String user_id);
	
	/**
	 * 获取俱乐部成员记录表信息
	 * @param id 俱乐部成员记录表ID
	 * @return
	 */
	public TeamPlayer getTeamPlayerByID(@Param(value="id")String id);
	
	/**
	 * 俱乐部邀站搜索列表总数
	 *@param params
	 *@param type
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-9 上午10:41:08
	 */	
	public int searchInviteTeamCount(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 获取该用户在俱乐部成员中的信息
	 *@param user_id
	 *@param teaminfo_id
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-7下午4:23:33
	 */	
	public List<TeamPlayer> getTeamPlayer(@Param(value="maps")Map<String, Object> params);

	
	/**
	 * 获取俱乐部历史比赛记录(分页)
	 *@param teaminfo_id
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-11下午4:00:14
	 */
	public List<Map<String,Object>> loadHistoryTeamGame(@Param(value="teaminfo_id")String teaminfo_id,@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取俱乐部历史比赛记录总条数
	 *@param teaminfo_id
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-11下午4:05:54
	 */
	public int loadHistoryTeamGameCount(@Param(value="teaminfo_id")String teaminfo_id,@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取俱乐部历史比赛记录总条数
	 *@param teaminfo_id
	 *@param maps
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-11下午4:05:54
	 */
	public void updateNotice(@Param(value="id")String id,@Param(value="notice")String notice);
	
	/**
	 * 获取俱乐部球员总条数
	 *@param teaminfo_id
	 *@param maps
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-11下午4:05:54
	 */
	public int teamPlayerCount(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 保存俱乐部购买激活码
	 * @param teamActiveCode
	 */
	public void saveTeamActiveCode(TeamActiveCode teamActiveCode);
	
	/**
	 * 更新俱乐部购买激活码状态
	 * @param teamActiveCode
	 */
	public void updateTeamActiveCode(TeamActiveCode teamActiveCode);
	
	/**
	 * 获取俱乐部所购买激活码
	 * @param teaminfo_id 俱乐部ID
	 * @return
	 */
	public List<TeamActiveCode> getTeamActiveCodeByTid(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 获取俱乐部所购买激活码
	 * @param code
	 * @return
	 */
	public TeamActiveCode getTeamActiveCode(@Param(value="code_str")String code_str);

	/**
	 * 踢出所有球队成员
	 * @autor gl
	 * @param teaminfo_id
	 * @return
	 */
	public int deleteAllPlayers(@Param(value="teaminfo_id")String teaminfo_id);
	/**
	 * 总身价
	 * @param teaminfo_id
	 * @return
	 */
	public int teamPlayerPrice(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 更新俱乐部成员状态
	 * @param teamPlayer
	 */
	public void updateTeamPlayer(TeamPlayer teamPlayer);
	
	/**
	 * 查询公告
	 * @param params
	 * @param pageModel
	 */
	public List<TeamNotice> queryNoticeForPage(@Param(value="maps")Map<String, Object> maps);
	/**
	 * 查询公告总数
	 * @param params
	 * @param pageModel
	 */
	public int countNotice(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 查询公告
	 * @param params
	 * @param pageModel
	 */
	public TeamNotice getNoticeById(@Param(value="id")String id);

	/**
	 * 保存公告
	 * @param teamNotice
	 * @return
	 */
	public void saveTeamNotice(TeamNotice teamNotice);
	
	/**
	 * 更新公告
	 * @param teamNotice
	 * @return
	 */
	public void updateTeamNotice(TeamNotice teamNotice);
	/**
	 * 删除公告
	 * @param teamNotice
	 * @return
	 */
	public void deleteTeamNotice(@Param(value="id")String id);
	
	/**
	 * 展示当前公告
	 * @param teamNotice
	 * @return
	 */
	public TeamNotice getCurrentNotice(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 俱乐部成员总数
	 * @param teamNotice
	 * @return
	 */
	public int countPlayer(Map<String, Object> maps);
	
	/**
	 * 获取俱乐部球队阵型成员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> getTeamPlayerByTeamInfoID(@Param(value="teaminfo_id")String teaminfo_id);
	
	public List<Map<String,Object>> getMyTeamPlayer(@Param(value="teaminfo_id")String teaminfo_id);

	
	/**
	 * 获取俱乐部内所有球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> getAllTPsTeamInfoID(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 更新俱乐部成员在球场上的位置
	 * @param maps
	 */
	public void updatePlayerPosition(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 更新俱乐部球员号码
	 * @param teaminfo_id
	 * @return
	 */
	public void updateNum(@Param(value="id")String id, @Param(value="num")int num);
	/**
	 * 获取俱乐部球员map信息
	 * @param teaminfo_id
	 * @return
	 */
	public Map<String, Object> getTeamPlayerMap(@Param(value="id")String id);
	
	/**
	 * 保存入队申请记录
	 * @param teamApply
	 */
	public void saveTeamApply(TeamApply teamApply);
	
	/**
	 * 更新入队申请记录状态
	 * @param teamApply
	 */
	public void updateTeamApply(TeamApply teamApply);
	
	/**
	 * 获取某条入队申请记录
	 * @param id
	 * @return
	 */
	public TeamApply getTeamApplyByID(@Param(value="id")String id);
	
	/**
	 * 获取所有入队申请记录
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllTeamApplys(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取所有入队申请记录总数
	 * @param maps
	 * @return
	 */
	public int loadAllTeamApplysCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取用户申请入队某俱乐部的申请记录信息
	 * @param teaminfo_id
	 * @param user_id
	 * @return
	 */
	public TeamApply getTeamApplyByUIDAndTID(@Param(value="teaminfo_id")String teaminfo_id,@Param(value="user_id")String user_id);
	
	/**
	 * YJH
	 * @param teaminfo_id
	 * @param user_id
	 * @return
	 */
	public TeamPlayer getTeamPlayerByUserID(@Param(value="teaminfo_id")String teaminfo_id,@Param(value="user_id")String user_id);
	
	/**
	 * YJH
	 * @param tp
	 * @return
	 */
	public void updTeamPlayer(TeamPlayer tp);

	public TeamInfo getTeamInfoById(@Param(value="id")String id);

	/**
	 * 判断该俱乐部名称是否已存在
	 * @param name 俱乐部名称
	 * @return
	 */
	public int teamExistByTeamName(@Param(value="name")String name);

	public List<Map<String, Object>> queryRecommends(@Param(value="maps")Map<String, Object> params);

	public int recommendsCount(@Param(value="maps")Map<String, Object> params);
	
	/**
	 * 根据名称查询俱乐部列表
	 * @param name 俱乐部名称
	 * @return
	 */
	public List<Map<String,Object>> queryTeamInfoByName(@Param(value="name")String name);
	
	/**
	 * 获取俱乐部工资信息列表
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllTeamMsg(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 获取俱乐部工资信息列表
	 * @param maps
	 * @return
	 */
	public int loadAllTeamMsgCount(@Param(value="maps")Map<String, Object> maps);

	/**
	 * \将t_team_info中的是否允许带人进入下届联赛p_status改为1
	 * @author gl
	 * @param teaminfo_id
	 * @param i
	 */
	public void updatePstatus(@Param(value="teaminfo_id")String teaminfo_id, @Param(value="p_status")Integer p_status);

	public List<Map<String, Object>> queryTeamPlayerByTid(@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 检测俱乐部简称是否重复
	 * @author gl
	 * @param sim_name
	 * @param id
	 * @return
	 */
	public List<TeamInfo> checkSimNameAgain(@Param(value="sim_name")String sim_name, @Param(value="id")String id);
	
	
	/**
	 * 检测俱乐部简称是否重复
	 * @author ylt
	 * @param teaminfo_id
	 * @param league_id
	 * @return
	 */
	public List<TeamActiveCode> getTeamActiveCodeByLeague(@Param(value="teaminfo_id")String teaminfo_id,
			@Param(value="league_id")String league_id);
	
}
