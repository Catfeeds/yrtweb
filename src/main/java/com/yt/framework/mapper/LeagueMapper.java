package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.EventRecord;
import com.yt.framework.persistent.entity.InviteMsg;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.SuspendPlayer;
import com.yt.framework.persistent.entity.TeamIntegral;
import com.yt.framework.persistent.entity.TeamLeague;
/**
 * 联赛
 *@autor ylt
 *@date2015-10-16下午1:58:51
 */
public interface LeagueMapper extends BaseMapper<League>{
	/**
	 * 保存报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public void saveLeagueSign(LeagueSign leagueSign);
	
	/**
	 * 保存报名查询分页
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public List<Map<String, Object>> queryForPageSign(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 保存报名查询分页总数
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public int countSign(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取用户报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public LeagueSign getLeagueSign(@Param(value="user_id")String user_id,@Param(value="s_id")String s_id);
	
	/**
	 * 获取用户报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public LeagueSign getLeagueSignById(@Param(value="id")String id);
	
	/**
	 * 更新报名状态
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public void updateLeagueSign(LeagueSign leagueSign)throws Exception;
	
	/**
	 * 获取用户报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public Map<String, Object> getLeagueSignByIdMap(@Param(value="id")String id);
	
	
	/**
	 * 获取一场联赛信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public League getLeague();
	
	/**
	 * 获取一场联赛信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public List<League> getLeagues();
	
	/**
	 * 获取一场联赛俱乐部关系
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public TeamLeague getTeamLeague(@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 获取俱乐部联赛关系
	 * @autor gl
	 * @param league_id 联赛id
	 * @param teaminfo_id 俱乐部id
	 * @return TeamLeague
	 */
	public TeamLeague getTeamLeague(@Param(value="league_id")String league_id, @Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 激活联赛俱乐部
	 * @autor gl
	 * @param tleague 俱乐部联赛
	 * @return
	 */
	public int saveTeamLeague(TeamLeague tleague);

	/**
	 * 查询球员报名联赛后未失效数据
	 * @param userId
	 * @return
	 */
	public LeagueSign getLeagueSignInvalid(@Param(value="userId")String userId);
	
	/**
	 * 删除球员报名信息(取消报名)
	 * @param sign_id
	 * @param user_id
	 * @return
	 */
	public int deleteLeagueSign(@Param(value="sign_id")String sign_id, @Param(value="user_id")String user_id);
	
	/**
	 * 联赛俱乐部球员射手榜
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadScorerDatas(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 联赛俱乐部球员出场榜
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadHisDatas(@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 联赛俱乐部前场球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadFrontDatas(@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 联赛俱乐部中场球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadMidfieldDatas(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 联赛俱乐部后场球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadBackDatas(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 联赛俱乐部守门员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadGatekeeperDatas(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 联赛俱乐部宝贝
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadBabyDatas(@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 获取联赛赛程安排时间
	 * @param league_id
	 * @return
	 */
	public List<String> getLeagueEventTime(@Param(value="league_id")String league_id);
	
	/**
	 * 获取该联赛有多少个分组
	 * @param league_id
	 * @return
	 */
	public List<Map<String,Object>> loadLeagueGroup(@Param(value="league_id")String league_id);
	
	/**
	 * 查询联赛赛程
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadEventRecord(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 联赛积分榜
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadIntegral(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 联赛积分榜总条数
	 * @param maps
	 * @return
	 */
	public int loadIntegralCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 联赛射手榜
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadLeagueScorer(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 联赛射手榜数据总数条数
	 * @param maps
	 * @return
	 */
	public int loadLeagueScorerCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 联赛俱乐部
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> getTeamLeagueByLeague(@Param(value="league_id")String league_id);
	
	/**
	 * 获取魅力值信息
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> getFootBabyCharm(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取魅力值用户总数
	 * @param maps
	 * @return
	 */
	public int getFootBabyCharmCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * <p>Description:获取联赛分组列表 </p>
	 * @Author zhangwei
	 * @Date 2015年11月20日 上午11:43:59
	 * @return
	 */
	public List<LeagueGroup> loadLeagueGroups(@Param(value="league_id")String league_id);
	
	/**
	 * <p>Description: 查询联赛积分榜列表信息</p>
	 * @Author zhangwie
	 * @Date 2015年11月20日 下午2:01:28
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadLeagueIntegralRecord(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * <p>Description:获取球员射手榜列表信息 </p>
	 * @Author zhangwei
	 * @Date 2015年11月25日 下午1:19:30
	 * @param maps
	 * @return
	 */
	public int loadLeagueScorerRecordCount(@Param(value="maps")Map<String,Object> maps);
	public List<Map<String,Object>> loadLeagueScorerRecord(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取俱乐部联赛积分
	 * @param teaminfo_id 俱乐部ID
	 * @param league_id 联赛ID
	 * @return
	 */
	public TeamIntegral getTeamIntegralByID(@Param(value="teaminfo_id")String teaminfo_id,@Param(value="league_id")String league_id);
	
	/**
	 * 查询竞拍球员记录
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadBidRecords(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询竞拍球员记录数
	 * @param maps
	 * @return
	 */
	public int loadBidRecordCount(@Param(value="maps")Map<String,Object> maps);

	/**
	 * 
	 * 查询联赛预告
	 * @param league_id
	 * @return
	 */
	public List<Map<String, Object>> queryEventForecast(@Param(value="league_id")String league_id);

	public int queryEventRecordsCount(@Param(value="maps")Map<String, Object> params);

	/**
	 * 联赛赛程列表
	 * gl
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryEventRecords(@Param(value="maps")Map<String, Object> params);
	
	/**
	 * 查询赛事
	 * ylt
	 * @param params
	 * @return
	 */
	public EventRecord getEventRecordById(@Param(value="id")String id);
	
	/**
	 * 获取禁赛球员
	 * ylt
	 * @param params
	 * @return
	 */
	public SuspendPlayer getSuspendById(@Param(value="id")String id);
	
	/**
	 * 保存禁赛球员
	 * ylt
	 * @param params
	 * @return
	 */
	public void saveSuspend(SuspendPlayer suspendPlayer);
	
	/**
	 * 更新禁赛球员
	 * ylt
	 * @param params
	 * @return
	 */
	public void updateSuspend(SuspendPlayer suspendPlayer);
	
	/**
	 * 更新禁赛球员
	 * ylt
	 * @param params
	 * @return
	 */
	public void deleteSuspend(@Param(value="id")String id);
	
	/**
	 * 禁赛球员查询总数
	 * ylt
	 * @param params
	 * @return
	 */
	public int suspendCount(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 禁赛球员查询
	 * ylt
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryForPageSuspend(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 获取参加联赛所有的参赛队伍
	 * @param league_id
	 * @return
	 */
	public List<Map<String,Object>> loadAllLeagueTeam(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 获取参加联赛分类总数
	 * @param maps
	 * @return
	 */
	public int leagueCfgCount(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 更新联赛分类配置
	 * @param leagueCfg
	 * @return
	 */
	public void updateLeagueCfg(LeagueCfg leagueCfg);
	
	/**
	 * 保存联赛分类配置
	 * @param leagueCfg
	 * @return
	 */
	public void saveLeagueCfg(LeagueCfg leagueCfg);
	
	/**
	 * 获取联赛分类配置列表
	 * @param id
	 * @return
	 */
	public LeagueCfg getLeagueCfgById(@Param(value="id")String id);
	
	/**
	 * 获取联赛分类配置列表
	 * @param maps
	 * @return
	 */
	public List<Map<String, Object>> queryForPageLeagueCfgList(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 检测俱乐部是否已经报名
	 * @author gl
	 * @param teamId
	 * @param cfgId
	 * @return
	 */
	public TeamLeague getTeamSignByLeague(@Param(value="teamId")String teamId, @Param(value="cfgId")String cfgId);

	/**
	 * 检测球员是否已经报名
	 * @author gl
	 * @param teamId
	 * @param cfgId
	 * @return
	 */
	public LeagueSign getSignByLeague(@Param(value="userId")String userId, @Param(value="cfgId")String cfgId);
	
	/**
	 * 获取未结束联赛分类配置列表
	 * @param maps
	 * @return
	 */
	public List<LeagueCfg> getLeaugeCfgList();

	/**
	 * 查询联赛赛区
	 * @author gl
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryLeagueArea(@Param(value="maps")Map<String, Object> params);
	
	/**
	 * 获取联赛赛季信息
	 * @param q_match_id
	 * @return
	 */
	public List<Map<String, Object>> getLeagueCfgMap();
	
	
	/**
	 * 赛季俱乐部结算
	 * @param league_id
	 * @return
	 */
	public void balanceLeagueTeam(String league_id);
	

	/**
	 * 赛季球员结算
	 * @param s_id
	 * @return
	 */
	public void balanceSeasonPlayer(String s_id);

	/**
	 * 查询有效的俱乐部参赛确认信息
	 * @author gl
	 * @param tid
	 * @return
	 */
	public InviteMsg getBeGood4InviteMsg(@Param(value="tid")String tid);
	
	/**
	 * 保存联赛邀请信息记录
	 * @param inviteMsg
	 */
	public void saveLeagueInviteMsg(InviteMsg inviteMsg);
	
	/**
	 * 获取联赛邀请记录
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllInviteMsg(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取联赛邀请记录条数
	 * @param maps
	 * @return
	 */
	public int loadAllInviteMsgCount(@Param(value="maps")Map<String,Object> maps);

	/**
	 * 修改俱乐部参赛确认信息状态
	 * @author gl
	 * @param imsg
	 * @return
	 */
	public void updateInviteMsg(InviteMsg imsg);

	/**
	 * 修改联赛俱乐部status
	 * @author gl
	 * @param teaminfo_id
	 * @param i
	 */
	public void updateTeamLeagueStatus(@Param(value="teaminfo_id")String teaminfo_id, @Param(value="status")Integer status);
	
	/**
	 * 获取联赛信息列表
	 * @author params
	 * @param params
	 */
	public List<League> getLeaguesByCondition(@Param(value="maps")Map<String,Object> maps);

	/**
	 * 助攻排行榜
	 * @param params
	 * @return
	 */
	public int loadLeagueAssistsCount(@Param(value="maps")Map<String, Object> params);
	public List<Map<String, Object>> loadLeagueAssists(@Param(value="maps")Map<String, Object> params);

	/**
	 * 通过联赛ID和teamID查询俱乐部所用激活码
	 * @param league_id
	 * @param sellTeamId
	 * @return
	 */
	public ActiveCode getActiveCodeByLidAndTid(@Param(value="league_id")String league_id,@Param(value="team_id")String team_id);

	
	
}
