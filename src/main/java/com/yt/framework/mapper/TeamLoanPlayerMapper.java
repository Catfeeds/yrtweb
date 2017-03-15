package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.TeamLoanMsg;
import com.yt.framework.persistent.entity.TeamLoanPlayer;

/**
 * 俱乐部租借
 *@autor ylt
 *@date2016-6-3下午2:58:24
 */
public interface TeamLoanPlayerMapper extends BaseMapper<TeamLoanPlayer> {
	
	/**
	 * 查询租借申请信息
	 * @autor gl
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public List<Map<String, Object>> queryTeamLoanMsg(@Param(value="maps")Map<String, Object> params);
	
	public int teamLoanMsgCount(@Param(value="maps")Map<String, Object> params);

	/**
	 * 保存租借消息
	 * @autor ylt
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public void saveLoanMsg(TeamLoanMsg teamLoanMsg);
	
	
	/**
	 * 根据ID查询租借信息
	 * @autor gl
	 * @param id
	 * @return
	 */
	public TeamLoanMsg getTeamLoanMsgById(@Param(value="id")String id);
	/**
	 * 根据ID删除租借信息
	 * @autor gl
	 * @param id
	 * @return
	 */
	public void deleteTeamLoanMsg(@Param(value="id")String id);
	
	/**
	 * 修改租借信息状态
	 * @autor gl
	 * @param id
	 * @return
	 */
	public void updateTeamLoanMsg(TeamLoanMsg loanMsg);
	/**
	 * 查询该球员所有未处理租借信息
	 * @autor gl
	 * @param id
	 * @return
	 */
	public List<TeamLoanMsg> queryUntreatedTeamLoanMsg(@Param(value="loan_teaminfo_id")String loan_teaminfo_id,
			@Param(value="user_id")String user_id);
	
	/**
	 * 查询俱乐部租借球员
	 * @autor ylt
	 * @param teaminfo_id
	 * @return
	 */
	public List<TeamLoanPlayer> getTeamPlayersByTeamInfoId(@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 更新俱乐部租借球员号码
	 * @param num id
	 * @return
	 */
	public void updateNum(@Param(value="id")String id, @Param(value="num")int num);
	
	/**
	 * 租借球员详情
	 * @param s_id turn_num
	 * @return
	 */
	public List<Map<String, Object>> getTeamLoanDetailData( @Param(value="s_id")String s_id, @Param(value="turn_num") String turn_num);
	
}
