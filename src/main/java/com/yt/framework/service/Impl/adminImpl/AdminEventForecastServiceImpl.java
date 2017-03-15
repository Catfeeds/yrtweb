package com.yt.framework.service.Impl.adminImpl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.AdminEventForecast;
import com.yt.framework.service.Impl.BaseServiceImpl;
import com.yt.framework.service.admin.AdminEventForecastService;

/**
 * 
 * @author YJH
 * 
 *         2015年11月10日
 */
@Service(value = "adminEventForecastService")
public class AdminEventForecastServiceImpl extends
		BaseServiceImpl<AdminEventForecast> implements
		AdminEventForecastService {
	
	protected static Logger logger = LogManager.getLogger(AdminEventForecastServiceImpl.class);

	@Override
	public AdminEventForecast getForecastByTeam(String league_id, String g_teaminfo_id, String m_teaminfo_id,int rounds) {
		return adminEventForecastMapper.getForecastByTeam(league_id, g_teaminfo_id, m_teaminfo_id,rounds);
	}

}
