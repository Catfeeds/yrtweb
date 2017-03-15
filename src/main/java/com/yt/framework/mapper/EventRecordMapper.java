package com.yt.framework.mapper;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.EventRecord;

public interface EventRecordMapper extends BaseMapper<EventRecord> {

	/**
	 * 查询某联赛最大轮次
	 * @param league_id
	 * @return
	 */
	public int getMaxRounds(@Param(value="league_id")String league_id);
}
