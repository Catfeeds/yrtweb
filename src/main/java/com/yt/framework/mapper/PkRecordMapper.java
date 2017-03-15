package com.yt.framework.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.PkRecord;

/**
 *联赛比赛记录
 *@autor bo.xie
 *@date2015-8-3下午7:05:43
 */
public interface PkRecordMapper extends BaseMapper<PkRecord> {

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
}
