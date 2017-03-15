package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.LeagueGroupEvent;
import com.yt.framework.persistent.entity.SalaryMsg;
import com.yt.framework.persistent.entity.SalaryRecord;

/**
 *@autor gl
 *@date2015-9-23下午5:59:46
 */
public interface AdminLeagueGroupMapper extends BaseMapper<LeagueGroup> {

	public List<League> getLeagues();
	
	public List<LeagueGroup> getGroupsByLid(@Param(value="league_id")String league_id);
	
	/**
	 * 获取联赛俱乐部分组信息
	 * @param league_id
	 * @param teaminfo_id
	 * @return
	 */
	public LeagueGroupEvent getGroupEvent(@Param(value="league_id")String league_id, @Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 获取联赛俱乐部分组信息
	 * @param league_id
	 * @param teaminfo_id
	 * @return
	 */
	public Map<String,Object> getGroupName(@Param(value="league_id")String league_id, @Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 保存联赛分组信息
	 * @param leagueGroupEvent
	 */
	public void saveGroupEvent(LeagueGroupEvent leagueGroupEvent);
	
	/**
	 * 更新联赛分组信息
	 * @param leagueGroupEvent
	 */
	public void updateGroupEvent(LeagueGroupEvent leagueGroupEvent);
	
	/**
	 * 查询分组列表
	 * @param leagueGroupEvent
	 */
	public List<LeagueGroupEvent> getGroupEventByGroupId(@Param(value="group_id")String group_id);
	
	/**
	 * 删除分组
	 * @param leagueGroupEvent
	 */
	public void deleteGroupEvent(@Param(value="id")String id);
	
	/**
	 * 保存联赛工资发送信息
	 * @param salaryMsg
	 */
	public void saveSalaryMsg(SalaryMsg salaryMsg);
	
	/**
	 * 保存联赛俱乐部工资清单
	 * @param salaryRecord
	 */
	public void saveSalaryRecord(SalaryRecord salaryRecord);
	
	/**
	 * 获取所有联赛工资发送信息记录
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllSalaryMsgList(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取所有联赛工资发送信息记录总数
	 * @param maps
	 * @return
	 */
	public int loadAllSalaryMsgListCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取联赛工资总览列表
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllSalaryTable(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 获取联赛某轮次俱乐部工资发送详情列表
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadLeagueTurnDetail(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 获取联赛某轮次俱乐部工资发送详情列表总数
	 * @param maps
	 * @return
	 */
	public int loadLeagueTurnDetailCount(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 更新发送状态为已发送
	 * @param maps
	 */
	public void updateSalarySend(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 获取联赛工资总览列表数量
	 * @param maps
	 * @return
	 */
	public int loadAllSalaryTableCount(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 删除某联赛某轮次下所有俱乐部球员工资预览信息
	 * @param maps
	 */
	public void deleteSalaryMsgRecord(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 删除某联赛某轮次下所有俱乐部球员工资预览信息
	 * @param maps
	 */
	public void deleteSalaryTableByParasm(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 获取工资信息记录
	 * @param maps
	 * @return
	 */
	public SalaryMsg getSalaryMsgByParams(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 获取工资详情单
	 * @param maps
	 * @return
	 */
	public SalaryRecord getSalaryRecordByParams(@Param(value="maps")Map<String,Object>maps);
}
