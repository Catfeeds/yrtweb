package com.yt.framework.service;

import java.util.Date;
import java.util.List;

import com.yt.framework.persistent.entity.ScheduleSms;

/**
 *
 *@autor bo.xie
 *@date2015-9-21上午11:39:02
 */
public interface ScheduleSmsService extends BaseService<ScheduleSms>{

	public List<ScheduleSms> loadScheduleDatas(Date date);
	
	/**
	 * 删除比赛短信计划任务表信息
	 * @param teamGame_id
	 */
	public void deleteScheduleSmsByTeamGameId(String teamGame_id);
}
