package com.yt.framework.service;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.persistent.entity.PPosition;
import com.yt.framework.persistent.entity.TeamActiveCode;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamNotice;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.TeamPlayerWage;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ReturnJosnMsg;

/**
 *俱乐部
 *@autor bo.xie
 *@date2015-8-3下午3:15:49
 */
public interface TeamInfoService extends BaseService<TeamInfo>{
	
	
	/**
	 * 创建俱乐部信息后增加俱乐部权限
	 * @param ti
	 * @return
	 */
	public AjaxMsg saveTeam(TeamInfo ti, HttpServletRequest request) throws Exception;
	
	/**
	 * 创建俱乐部信息后增加俱乐部权限 不创建资金账户
	 * @param ti
	 * @return
	 */
	public AjaxMsg saveTeamNoAmount(TeamInfo tinfo, HttpServletRequest request)throws Exception;
	
	/**
	 * 获取某用户俱乐部信息
	 *@param user_id 用户ID
	 *@return TeamInfo
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-3下午3:18:41
	 */
	public TeamInfo getTeamInfoByUserId(String user_id);
	
	/**
	 * 根据俱乐部成员用户ID获取俱乐部信息
	 * @param p_user_id 俱乐部成员用户ID
	 * @return
	 */
	public TeamInfo getTeamInfoByPUserID(String p_user_id);
	
	/**
	 * 加入俱乐部成员
	 *@param teaminfo_id 俱乐部ID
	 *@param player_id 球员ID
	 *@param type 球员类型 1:队长 2:副队长 3：普通球员
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午4:53:18
	 */
	public AjaxMsg saveTeamPlayer(String teaminfo_id,String player_id,int type);
	
	/**
	 * 退出球队
	 *@param teaminfo_id
	 *@param player_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午5:41:08
	 */
	public AjaxMsg outTeam(String teaminfo_id,String player_id)throws Exception;
	
	/**
	 * 踢出所有球队成员
	 * @autor gl
	 * @param teaminfo_id
	 * @return
	 */
	public AjaxMsg deleteAllPlayers(String teaminfo_id);
	
	/**
	 * 加入球队
	 *@param teaminfo_id
	 *@param player_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午5:41:19
	 */
	public AjaxMsg joinTeam(String teaminfo_id,String player_id)throws Exception;
	
	/**
	 * 俱乐部球员列表
	 * @param teaminfo_id
	 * @return
	 * @author ylt
	 * @date 2015-8-10 上午10:41:19
	 */
	public AjaxMsg getTeamPlayerList(Map<String, Object> maps,PageModel pageModel);
	
	/**
	 * 俱乐部球员拉黑
	 * @param teaminfo_id
	 * @param player_id
	 * @return
	 * @author ylt
	 * @date 2015-8-10 下午10:41:19
	 */
	public AjaxMsg defriendPlayer(String teaminfo_id, String player_id) throws Exception;
	
	/**
	 * 踢出拉黑列表
	 * @param teaminfo_id
	 * @param player_id
	 * @return
	 * @author ylt
	 * @date 2015-8-10 下午10:41:19
	 */
	public AjaxMsg kickfriendPlayer(String teaminfo_id, String player_id);

	/**
	 * 踢出球队
	 *@param teaminfo_id
	 *@param player_id
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-11 上午10:41:08
	 */
	public AjaxMsg kickTeam(String teaminfo_id, String player_id)throws Exception;
	
	/**
	 * 俱乐部黑名单列表
	 *@param teaminfo_id
	 *@param pageModel 
	 *@param player_id
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-11 上午10:41:08
	 */	
	public AjaxMsg blackList(String teaminfo_id, PageModel pageModel);

	/**
	 * 指认或者取消队长或者副队长
	 *@param player_id ,teaminfo_id ,type
	 *@param type
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-11 上午10:41:08
	 */	
	public AjaxMsg checkCaptain(String teaminfo_id,String player_id, int type,HttpServletRequest request)throws Exception;


	/**
	 * 俱乐部邀站搜索列表
	 *@param params , pageModel
	 *@param type
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-11 上午10:41:08
	 */	
	public AjaxMsg searchInviteTeam(Map<String, Object> params, PageModel pageModel);

	/**
	 * 俱乐部创始人
	 *@param Long
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-3 上午10:41:08
	 */	
	public AjaxMsg getCaption(String teaminfo_id);
	
	/**
	 * 关注用户
	 *@param focus f_type:0:非俱乐部，1 :俱乐部 ; f_teaminfo_id 关注ID  
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-12下午4:40:50
	 */
	public AjaxMsg saveFocus(Focus focus);
	
	/**
	 * 取消关注
	 *@param user_id 用户ID
	 *@param f_teaminfo_id 关注ID   
	 *@param type 0:非俱乐部 1：俱乐部 
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午6:06:43
	 */
	public AjaxMsg deleteFocus(String user_id,String f_teaminfo_id);
	
	/**
	 * 获取用户关注俱乐部
	 *@param user_id 用户ID
	 *@param  f_teaminfo_id关注ID   当关注俱乐部时ID为俱乐部ID,非俱乐部时ID为用户ID
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-12下午5:53:36
	 */
	public int getFocusTeams(String user_id,String f_teaminfo_id);

	
	/**
	 * 获取俱乐部能力值,俱乐部人员数
	 *@param teaminfo_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-7下午2:23:15
	 */
	public Map<String,Object> getTeamAbilityScore(String teaminfo_id);
	
	/**
	 * 获取该用户在俱乐部成员中的信息
	 *@param user_id
	 *@param teaminfo_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-7下午4:23:33
	 */
	TeamPlayer getTeamPlayerInfoByIds(String user_id,String teaminfo_id);
	
	/**
	 *根据用户id,查询俱乐部球员表信息 
	 *@param user_id 用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-8下午4:57:52
	 */
	public TeamPlayer getTeamPlayerByUserId(String user_id);
	
	/**
	 * 获取俱乐部历史比赛记录(分页)
	 *@param teaminfo_id 俱乐部ID
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-11下午4:00:14
	 */
	public AjaxMsg loadHistoryTeamGame(String teaminfo_id,PageModel pageModel);
	
	/**
	 * 解散所有球员
	 *@param teaminfo_id 俱乐部ID
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-11下午4:00:14
	 */
	public AjaxMsg dissolvePlayers(String teaminfo_id)throws Exception;

	/**
	 * 解散俱乐部
	 *@param teaminfo_id 俱乐部ID
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-11下午4:00:14
	 */
	public AjaxMsg dissolveTeam(String user_id,String teaminfo_id,HttpServletRequest request)throws Exception;
	
	/**
	 * 更改俱乐部活跃度
	 * @param teamId 俱乐部ID
	 * @param type 加入球队(join) 踢出、拉黑、退出(out) 关注(focus) 取消关注(unfocus)
	 * @autor gl
	 * @return
	 */
	public AjaxMsg updateTeamScore(String teamId,String type) throws Exception;
	/**
	 * 更改俱乐部活跃度
	 * @param teamId 俱乐部ID
	 * @param type 加入球队(join) 踢出、拉黑、退出(out) 关注(focus) 取消关注(unfocus)
	 * @autor gl
	 * @return
	 */
	public AjaxMsg updateTeamScore(TeamInfo teamInfo, String type) throws Exception;

	public TeamInfo editTeamScore(TeamInfo teamInfo, String type) throws Exception;
	
	/**
	 * 判断是否黑名人员
	 * @param teamId 俱乐部ID
	 * @param type 加入球队(join) 踢出、拉黑、退出(out) 关注(focus) 取消关注(unfocus)
	 * @autor gl
	 * @return
	 */
	public int ifBlackPlayer(String teaminfo_id,String player_id);
	
	/**
	 * 获取俱乐部历史比赛记录总条数
	 *@param teaminfo_id
	 *@param maps
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-11下午4:05:54
	 */
	public AjaxMsg updateNotice(String teaminfo_id,String notice)throws Exception;
	
	/**
	 * 获取俱乐部球员总条数
	 *@param teaminfo_id
	 *@param maps
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-11下午4:05:54
	 */
	public int teamPlayerCount(String teaminfo_id);
	
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
	public List<TeamActiveCode> getTeamActiveCodeByTid(String teaminfo_id);
	
	/**
	 * 购买激活码
	 * @param price 单价
	 * @param user_id 当前登录用户
	 * @param teaminfo_id 俱乐部ID
	 * @return
	 */
	public AjaxMsg buyActiveCode(String price,String user_id,String teaminfo_id,Integer total,String league_id);
	
	/**
	 * 获取俱乐部所购买激活码
	 * @param code 俱乐部ID
	 * @return
	 */
	public TeamActiveCode getTeamActiveCode(String code_str);
	
	/**
	 * 加入联赛球队
	 *@param teaminfo_id
	 *@param player_id
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午5:41:19
	 */
	public AjaxMsg joinLeagueTeam(String teaminfo_id, String player_id) throws Exception;
	
	/**
	 * 判断该用户是否已加入俱乐部
	 * @param user_id
	 * @return
	 */
	public int isJoinTeamForPlayer(String user_id);
	

	/**
	 * 出售球员
	 * @param param
	 * @return
	 */
	public AjaxMsg salePlayer(Map<String,Object> param) throws Exception;
	
	/**
	 * 俱乐部宝贝
	 * @param teaminfo_id
	 * @return
	 */
	public int teamBabyCount(String teaminfo_id);
	
	/**
	 * 总身价
	 * @param teaminfo_id
	 * @return
	 */
	public int teamPlayerPrice(String teaminfo_id);
	
	/**
	 * 查询公告信息
	 * @param teaminfo_id
	 * @return
	 */
	public AjaxMsg queryNoticeForPage(Map<String, Object> maps, PageModel pageModel);
	
	/**
	 * 查询公告信息总数
	 * @param teaminfo_id
	 * @return
	 */
	public int countNotice(Map<String, Object> maps);
	
	/**
	 * 查询公告
	 * @param teaminfo_id
	 * @return
	 */
	public TeamNotice getNoticeById(String id);
	
	/**
	 * 保存公告
	 * @param teamNotice
	 * @return
	 */
	public AjaxMsg saveTeamNotice(TeamNotice teamNotice)throws Exception;
	
	/**
	 * 更新公告
	 * @param teamNotice
	 * @return
	 */
	public AjaxMsg updateTeamNotice(TeamNotice teamNotice)throws Exception;

	/**
	 * 获取俱乐部阵型球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> getTeamPlayerByTeamInfoID(String teaminfo_id);
	
	public List<TeamPlayerWage> getTeamPlayer(String teaminfo_id);

	public ReturnJosnMsg wageSave(Map<String, String> maps);
	public ReturnJosnMsg wagePayrollSave(Map<String, String> maps);
	

	
	/**
	 * 获取俱乐部所有球员
	 * @param teaminfo_id
	 * @return
	 */
	public List<Map<String,Object>> getAllTPsTeamInfoID(String teaminfo_id);
	
	/**
	 * 更新俱乐部成员在球场上的位置
	 * @param maps
	 */
	public void updatePlayerPosition(List<PPosition> pp);
	
	/**
	 * 更新俱乐部球员号码
	 * @param teaminfo_id
	 * @return
	 */
	public AjaxMsg updateNum(String id,int num)throws Exception;
	
	/**
	 * 获取俱乐部球员map信息
	 * @param teaminfo_id
	 * @return
	 */
	public Map<String, Object> getTeamPlayerMap(String id);
	
	/**
	 * 取消球员挂牌
	 * @param param
	 * @return
	 */
	public AjaxMsg cancelSalePlayer(Map<String,Object> param);
	
	/**
	 * 获取所有入队申请记录
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadAllTeamApplys(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 是否同意入队申请
	 * @param teaminfo_id 申请入队俱乐部ID
	 * @param user_id 申请人ID
	 * @param type 1:同意申请 2：不同意申请
	 * @return
	 */
	public AjaxMsg agreeTeamApply(String teaminfo_id,String user_id,String type)throws Exception;
	
	/**
	 * 判断该俱乐部名称是否已存在
	 * @param name 俱乐部名称
	 * @return
	 */
	public int teamExistByTeamName(String name);

	/**
	 * 删除俱乐部公告
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteNotice(String id);

	/**
	 * 俱乐部列表 推荐俱乐部
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryRecommends(Map<String, Object> params,PageModel pageModel);
	
	
	/**
	 * 根据名称查询俱乐部列表
	 * @param name 俱乐部名称
	 * @return
	 */
	public List<Map<String,Object>> queryTeamInfoByName(String name);
	
	/**
	 * <p>Description:根据俱乐部id查询俱乐部球员列表 </p>
	 * @Author zhangwei
	 * @Date 2015年12月24日 下午1:23:53
	 * @param teamInfoId
	 * @return
	 */
	public List<TeamPlayer> getTeamPlayersByTeamInfoId(String teamInfoId);
	
	/**
	 * 平台用户为俱乐部账户充值
	 * @param maps
	 * @return
	 */
	public AjaxMsg payForTeam(Map<String,Object> maps)throws Exception;
	
	/**
	 * 获取俱乐部工资信息列表
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadAllTeamMsg(Map<String, Object> maps,PageModel pageModel);
	
	/**
	 * 获取俱乐部工资信息列表
	 * @param maps
	 * @return
	 */
	public int loadAllTeamMsgCount(Map<String, Object> maps);
	
	public ReturnJosnMsg wagePayrollSend(Map<String, String> map)throws Exception;

	/**
	 * 更具俱乐部ID查询所有球员
	 * @author gl
	 * @param id
	 * @return
	 */
	public List<Map<String, Object>> queryTeamPlayerByTid(String id);

	/**
	 * 检测俱乐部简称是否重复
	 * @author gl
	 * @param sim_name
	 * @param id
	 * @return
	 */
	public AjaxMsg checkSimNameAgain(String sim_name, String id);

	/**
	 * 修改俱乐部名称
	 * @param team
	 * @return
	 */
	public AjaxMsg updateTeamName(TeamInfo team);
	
	/**
	 * 获取联赛球员激活码
	 * @param team
	 * @return
	 */
	public List<TeamActiveCode> getTeamActiveCodeByLeague(String teaminfo_id, String league_id);
	/**
	 * 总比赛场数
	 * @return
	 */
	public int queryTeamRecords();

}
