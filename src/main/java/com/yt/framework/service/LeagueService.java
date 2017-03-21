package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.EventRecord;
import com.yt.framework.persistent.entity.InviteMsg;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueAuction;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.persistent.entity.LeagueCfg;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QUserData;
import com.yt.framework.persistent.entity.SalaryMsg;
import com.yt.framework.persistent.entity.SalaryRecord;
import com.yt.framework.persistent.entity.SuspendPlayer;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamIntegral;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: PlayerOtherService.java 
 * @Package com.yt.framework.service
 * @author ylt
 * @date 2015年10月15日 下午4:05:37 
 */
public interface LeagueService extends BaseService<League> {
	
	/**
	 * 保存报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public AjaxMsg saveLeagueSign(LeagueSign leagueSign)throws Exception;
	/**
	 * 查询报名列表分页
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public AjaxMsg queryForPageSign(Map<String, Object> map, PageModel pageModel);
	/**
	 * 查询报名列表总数
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public int countSign(Map<String, Object> params);
	
	/**
	 * 获取用户报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public LeagueSign getLeagueSign(String user_id,String s_id);
	
	/**
	 * 后台更新报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public AjaxMsg updateLeagueSign(LeagueSign leagueSign)throws Exception;
	/**
	 * 前台更新报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public AjaxMsg updateQLeagueSign(LeagueSign leagueSign) throws Exception;
	
	/**
	 * 获取用户报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public LeagueSign getLeagueSignById(String id);
	
	/**
	 * 获取用户报名信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public Map<String, Object> getLeagueSignByIdMap(String id);
	
	/**
	 * 获取一场联赛信息
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public League getLeague();
	
	/**
	 * 获取联赛信息结合
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public List<League> getLeagues();
	
	/**
	 *
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public List<League> getLeaguesByCondition(Map params);
	
	
	/**
	 * 获取一场联赛俱乐部关系
	 *@param mr
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public TeamLeague getTeamLeague(String teaminfo_id);
	
	/**
	 * 获取俱乐部联赛关系
	 * @autor gl
	 * @param league_id 联赛id
	 * @param teaminfo_id 俱乐部id
	 * @return
	 */
	public TeamLeague getTeamLeague(String league_id,String teaminfo_id);
	
	/**
	 * 激活球员认证码
	 *@param mr
	 *@autor gl
	 *@parameter *
	 *@date2015-10-16下午1:58:51
	 */
	public AjaxMsg updatePlayerCode(String login_user_id,String cfg_id, String code_str)throws Exception;
	
	/**
	 * 从个人中心输入球员激活码
	 * @autor gl
	 * @param login_user_id
	 * @param code_str
	 * @return
	 * @throws Exception
	 */
	public AjaxMsg updatePlayerCode(String login_user_id, String code_str)throws Exception; 
	/**
	 * 取消使用邀请码
	 * @autor gl
	 * @param userId
	 * @param league_id
	 * @param active_code
	 * @return
	 * @throws Exception
	 */
	public AjaxMsg updateActiveCode(LeagueSign sign)throws Exception;
	/**
	 * 激活联赛俱乐部
	 * @autor gl
	 * @param tleague 俱乐部联赛
	 * @return
	 */
	public AjaxMsg saveTeamLeague(TeamLeague tleague, TeamInfo tinfo,
			ActiveCode code,HttpServletRequest request) throws Exception;
	/**
	 * 查询球员报名联赛后未失效数据
	 * @param userId
	 * @return
	 */
	public LeagueSign getLeagueSignInvalid(String userId);
	/**
	 * 单飞球员加入联赛(前台球员添加如市场表)
	 * @param request
	 * @return
	 */
	public AjaxMsg saveLeagueAuction(LeagueAuction la) throws Exception;
	
	/**
	 * 删除球员报名信息(取消报名)
	 * @param sign_id
	 * @param user_id
	 * @return
	 */
	public AjaxMsg deleteLeagueSign(LeagueSign sign) throws Exception;
	
	/**
	 * 联赛俱乐部球员射手榜
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadScorerDatas(String teaminfo_id);
	
	/**
	 * 联赛俱乐部球员出场榜
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadHisDatas(String teaminfo_id);

	/**
	 * 联赛俱乐部前场球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadFrontDatas(String teaminfo_id);

	/**
	 * 联赛俱乐部中场球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadMidfieldDatas(String teaminfo_id);
	
	/**
	 * 联赛俱乐部后场球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadBackDatas(String teaminfo_id);
	
	/**
	 * 联赛俱乐部守门员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadGatekeeperDatas(String teaminfo_id);
	
	/**
	 * 联赛俱乐部宝贝
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> loadBabyDatas(String teaminfo_id);
	
	/**
	 * 获取联赛赛程安排时间
	 * @param league_id
	 * @return
	 */
	public List<String> getLeagueEventTime(String league_id);
	
	/**
	 * 获取该联赛有多少个分组
	 * @param league_id
	 * @return
	 */
	public List<Map<String,Object>> loadLeagueGroup(String league_id);

	/**
	 * 查询联赛赛程
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadEventRecord(Map<String,Object> maps);
	
	/**
	 * 联赛积分榜
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadIntegral(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 联赛射手榜
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadLeagueScorer(Map<String,Object>maps,PageModel pageModel);
	
	/**
	 * <p>Description:获取联赛分组列表  </p>
	 * @Author zhangwei
	 * @Date 2015年11月20日 上午11:54:45
	 * @return
	 */
	public List<LeagueGroup> loadLeagueGroups(String league_id);
	/**
	 * <p>Description:获取联赛积分榜列表 </p>
	 * @Author zhangwei
	 * @Date 2015年11月20日 下午2:17:42
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadLeagueIntegralRecord(Map<String,Object> maps);
	
	/**
	 * 联赛俱乐部
	 * @param maps
	 * @return
	 */
	public List<Map<String, Object>> getTeamLeagueByLeague(String league_id);
	
	/**
	 * 获取魅力值信息
	 * @param maps
	 * @return
	 */
	public AjaxMsg getFootBabyCharm(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * <p>Description: 获取球员射手榜列表信息</p>
	 * @Author lenovo
	 * @Date 2015年11月25日 下午1:23:18
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadLeagueScorerRecord(Map<String,Object> params,PageModel pageModel);
	
	/**
	 * 获取俱乐部联赛积分
	 * @param teaminfo_id 俱乐部ID
	 * @param league_id 联赛ID
	 * @return
	 */
	public TeamIntegral getTeamIntegralByID(String teaminfo_id,String league_id);
	
	
	/**
	 * 查询竞拍球员记录
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadBidRecords(Map<String,Object> maps,PageModel pageModel);
	/**
	 * 
	 * 查询联赛预告
	 * @param league_id
	 * @return
	 */
	public Map<String, Object> queryEventForecast(String league_id);
	
	/**
	 * 联赛赛程列表
	 * gl
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryEventRecords(Map<String, Object> params,PageModel pageModel);
	
	/**
	 * 联赛赛程列表
	 * ylt
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public EventRecord getEventRecordById(String id);
	
	/**
	 * 获取禁赛球员
	 * ylt
	 * @param id
	 * @return
	 */
	public SuspendPlayer getSuspendById(String id);
	
	/**
	 * 获取禁赛球员
	 * ylt
	 * @param suspendPlayer
	 * @return
	 */
	public AjaxMsg saveOrUpdateSuspend(SuspendPlayer suspendPlayer)throws Exception;
	
	/**
	 * 删除禁赛球员
	 * ylt
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteSuspend(String id)throws Exception;

	/**
	 * 查询禁赛球员
	 * ylt
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryForPageSuspend(Map<String, Object> params, PageModel pageModel);
	
	/**
	 * 查询某联赛最大轮次
	 * @param league_id
	 * @return
	 */
	public int getMaxRounds(String league_id);
	
	/**
	 * 获取当前联赛所有参赛队伍
	 * @param league_id
	 * @return
	 */
	public List<Map<String,Object>> loadAllLeagueTeam(Map<String,Object> params);
	
	/**
	 * 获取联赛分类配置
	 * @param league_id
	 * @return
	 */
	public LeagueCfg getLeagueCfgById(String id);
	
	/**
	 * 保存或者更新联赛分类配置
	 * @param league_id
	 * @return
	 */
	public AjaxMsg saveOrUpdateLeagueCfg(LeagueCfg leagueCfg)throws Exception;
	/**
	 * 获取联赛分类配置列表
	 * @param league_id
	 * @return
	 */
	public AjaxMsg queryLeagueCfgList(Map<String, Object> maps,PageModel pageModel);
	/**
	 * 检测俱乐部是否已经报名
	 * @author gl
	 * @param teamId
	 * @param cfgId
	 * @return
	 */
	public TeamLeague getTeamSignByLeague(String teamId, String cfgId);
	/**
	 * 检测球员是否已经报名
	 * @author gl
	 * @param teamId
	 * @param cfgId
	 * @return
	 */
	public LeagueSign getSignByLeague(String userId, String cfgId);
	/**
	 * 获取联赛分类配置列表
	 * @param league_id
	 * @return
	 */
	public List<LeagueCfg> getLeaugeCfgList();
	
	/**
	 * 查询联赛赛区
	 * @author gl
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryLeagueArea(Map<String, Object> params);
	
	/**
	 * 俱乐部薪资发送信息记录
	 * @param event_id
	 * @param teaminfo_id
	 * @return
	 */
	public List<SalaryMsg> getSalaryMsg(String event_id, String teaminfo_id);
	
	public SalaryMsg getSalaryMsgByID(String id);
	
	public void updateSalaryMsg(SalaryMsg o);
	
	/**
	 * 工资表明细
	 * @param srmsg_id
	 * @param teaminfo_id
	 * @return
	 */
	public List<SalaryRecord> getSalaryRecord(String srmsg_id);
	
	public void updateSalaryRecord(SalaryRecord sr);
	
	
	/**
	 * 参赛信息主表
	 * @param event_id
	 * @return
	 */
	public List<QMatchInfo> getMatchInfo(String event_id);
	
	/**
	 * 参赛球员详细数据
	 * @param q_match_id
	 * @return
	 */
	public List<QUserData> getQuserData(String event_id);
	
	/**
	 * 获取联赛赛季信息
	 * @param q_match_id
	 * @return
	 */
	public List<Map<String, Object>> getLeagueCfgMap();
	
	/**
	 * 赛季球员结算
	 * @param s_id
	 * @return
	 */
	public AjaxMsg balanceSeason(String s_id)throws Exception;
	/**
	 * 查询有效的俱乐部参赛确认信息
	 * @author gl
	 * @param tid
	 * @return
	 */
	public InviteMsg getBeGood4InviteMsg(String tid);
	
	/**
	 * 联赛球队结算
	 * @param league_id
	 * @return
	 */
	public AjaxMsg balanceLeagueMsg(String league_id)throws Exception;
	
	/**
	 * 发送联赛邀请信息
	 */
	public AjaxMsg saveLeagueInviteMsg(String league_id,String end_time_str)throws Exception;
	
	/**
	 * 获取联赛邀请记录
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadAllInviteMsg(Map<String,Object> maps,PageModel pageModel);
	/**
	 * 修改俱乐部参赛确认信息状态
	 * @author gl
	 * @param imsg
	 * @return
	 */
	public AjaxMsg updateInviteMsg(InviteMsg imsg,String flag)throws Exception;
	
	/**
	 * 助攻排行榜
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg loadLeagueAssists(Map<String, Object> params,PageModel pageModel);
	
	public int queryLeagueRecords();
	/**
	 * 最近10场比赛结果
	 * @return
	 */
	public List<EventRecord> queryEventRecord();
	
}
