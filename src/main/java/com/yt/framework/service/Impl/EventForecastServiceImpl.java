package com.yt.framework.service.Impl;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.EventForecast;
import com.yt.framework.service.EventForecastService;

@Service("eventForecastService")
public class EventForecastServiceImpl extends BaseServiceImpl<EventForecast> implements EventForecastService {
	
	protected static Logger logger = LogManager.getLogger(EventForecastServiceImpl.class);

	@Override
	public Map<String, Object> getEventForecastLastByUserId(String teaminfo_id, String league_id) {
		return eventForecastMapper.getEventForecastLastByUserId(teaminfo_id, league_id);
	}

}
