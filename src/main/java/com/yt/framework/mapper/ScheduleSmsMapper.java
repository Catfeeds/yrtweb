package com.yt.framework.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ScheduleSms;

/**
 *
 *@autor bo.xie
 *@date2015-9-19下午4:37:47
 */
public interface ScheduleSmsMapper extends BaseMapper<ScheduleSms>{

	public void saveScheduleSMS(Map<String,Object>maps);
	
	/**
	 * 按日期查询需要发送的信息
	 *@param search_date 日期
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-21上午11:36:22
	 */
	public List<ScheduleSms> loadScheduleSmsdatas(@Param("search_date")Date search_date);
	
	/**
	 * 删除某场比赛短信计划任务信息
	 * @param teamgame_id
	 */
	public void deleteScheduleSms(@Param(value="teamgame_id")String teamgame_id);
}
