package com.yt.framework.service.admin;

import com.yt.framework.persistent.entity.AdminEventForecast;
import com.yt.framework.service.BaseService;

/**
 * 
 * @author YJH
 * 
 *         2015年11月10日
 */
public interface AdminEventForecastService extends
		BaseService<AdminEventForecast> {
	/**
	 * 后去预告信息
	 * @param league_id
	 * @param g_teaminfo_id
	 * @param m_teaminfo_id
	 * @return
	 */
	public AdminEventForecast getForecastByTeam(String league_id, String g_teaminfo_id, String m_teaminfo_id,int rounds);

}
