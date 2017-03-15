package com.yt.framework.service.admin;

import java.util.Map;
import com.yt.framework.persistent.entity.AdminPkRecord;
import com.yt.framework.service.BaseService;

/**
 * 联赛比赛记录
 * @author bo.xie
 * @Date 2015年11月10日11:48:18
 */
public interface AdminPkRecordService extends BaseService<AdminPkRecord>{

	/**
	 * 获取联赛俱乐部相关信息
	 * @param maps
	 * key num <br>
	 * 若num=teaminfo_id 查询获胜场数<br>
	 * 若num=-1 查询平局场数
	 * 若num为null 查询未开始比赛
	 * @return
	 */
	public Map<String,Object> teamInfoLeague(Map<String,Object> maps);
	
	/**
	 * 获取联赛纪录数据，一场联赛的两支队伍只能有一场比赛记录
	 * @param league_id
	 * @param g_teaminfo_id
	 * @param m_teaminfo_id
	 * @return
	 */
	public AdminPkRecord getPkRecordByTeam(String league_id, String g_teaminfo_id, String m_teaminfo_id);
}
