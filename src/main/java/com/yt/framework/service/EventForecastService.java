package com.yt.framework.service;

import java.util.Map;

import com.yt.framework.persistent.entity.EventForecast;

public interface EventForecastService extends BaseService<EventForecast>{

	/**
	 * 获取用户最近一场联赛预告
	 * @param user_id 登录用户ID
	 * @param league_id 联赛ID
	 * @return
	 */
	public Map<String,Object> getEventForecastLastByUserId(String teaminfo_id,String league_id);
}
