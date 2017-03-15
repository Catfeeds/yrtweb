package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueGroup;
import com.yt.framework.persistent.entity.SalaryMsg;
import com.yt.framework.persistent.entity.SalaryRecord;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @author gl
 *
 */
public interface AdminLeagueGroupService extends BaseService<LeagueGroup>{ 
	
	public List<League> getLeagues();

	public List<LeagueGroup> getGroupsByLid(String league_id);
	/**
	 * 保存分组信息
	 * @param teaminfo_id
	 * @param group_id
	 * @param league_id
	 */
	public AjaxMsg saveOrUpdateGroup(String teaminfo_id, String group_id, String league_id)throws Exception;
	
	
	public AjaxMsg deleteGroup(String group_id)throws Exception;
	
	/**
	 * 保存联赛工资信息发送记录
	 * @param salarys
	 * @return
	 * @throws Exception
	 */
	public AjaxMsg saveSalaryMsg(SalaryMsg salarys)throws Exception;
	
	/**
	 * 保存俱乐部工资清单
	 * @param salaryRecords
	 * @return
	 * @throws Exception
	 */
	public AjaxMsg saveSalaryRecord(SalaryRecord salaryRecords)throws Exception;
	
	/**
	 * 生成工资清单
	 * @param teaminfo_ids
	 * @param league_id
	 * @param rounds
	 * @param event_id
	 * @return
	 * @throws Exception
	 */
	public AjaxMsg saveLeagueSalaryInfoByParams(List<String> teaminfo_ids,String league_id,String rounds)throws Exception;
	
	/**
	 * 获取所有联赛工资发送信息记录
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadAllSalaryMsgList(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 联赛发送工资单总览列表
	 * @param params
	 * @return
	 */
	public AjaxMsg loadAllSalaryTable(Map<String,Object> params,PageModel pageModel);
	
	/**
	 * 删除某联赛某轮次下所有俱乐部球员工资预览信息
	 * @param maps
	 */
	public AjaxMsg deleteSalaryTableByParasm(Map<String,Object>maps)throws Exception;
	
	/**
	 * 获取联赛某轮次俱乐部工资发送详情列表
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadLeagueTurnDetail(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 更新发送状态为已发送
	 * @param maps
	 */
	public AjaxMsg updateSalarySend(Map<String,Object>maps);
}
