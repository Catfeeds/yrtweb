package com.yt.framework.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.EventForecast;

public interface EventForecastMapper extends BaseMapper<EventForecast>{

	/**
	 * 获取用户最近一场联赛预告
	 * @param user_id
	 * @param league_id
	 * @return
	 */
	public Map<String,Object> getEventForecastLastByUserId(@Param(value="teaminfo_id")String teaminfo_id,@Param(value="league_id")String league_id);
}
