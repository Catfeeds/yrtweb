package com.yt.framework.mapper.admin;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.AdminPkRecord;
import com.yt.framework.persistent.entity.PkRecord;

/**
 *联赛比赛记录
 *@autor bo.xie
 *@date2015-8-3下午7:05:43
 */
public interface AdminPkRecordMapper extends BaseMapper<AdminPkRecord> {

	/**
	 * 获取联赛俱乐部获胜场数
	 * @param maps
	 * key num <br>
	 * 若num=teaminfo_id 查询获胜场数<br>
	 * 若num=-1 查询平局场数
	 * 若num为null 查询为开始比赛
	 * @return
	 */
	public int teamLeagueWinCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 联赛比赛总场数
	 * @param maps
	 * @return
	 */
	public int teamLeagueCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取联赛纪录数据，一场联赛的两支队伍只能有一场比赛记录
	 * @param league_id
	 * @param g_teaminfo_id
	 * @param m_teaminfo_id
	 * @return
	 */
	public AdminPkRecord getPkRecordByTeam(@Param(value="league_id")String league_id,
			@Param(value="g_teaminfo_id")String g_teaminfo_id,@Param(value="m_teaminfo_id")String m_teaminfo_id);
}
