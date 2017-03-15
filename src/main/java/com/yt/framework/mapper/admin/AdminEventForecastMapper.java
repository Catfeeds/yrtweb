package com.yt.framework.mapper.admin;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.AdminEventForecast;

/**
 * 
 * @author YJH
 * 
 *         2015年11月10日
 */
public interface AdminEventForecastMapper extends
		BaseMapper<AdminEventForecast> {
	/**
	 * 后去预告信息
	 * @param league_id
	 * @param g_teaminfo_id
	 * @param m_teaminfo_id
	 * @return
	 */
	public AdminEventForecast getForecastByTeam(@Param(value="league_id")String league_id,
			@Param(value="g_teaminfo_id")String g_teaminfo_id, 
			@Param(value="m_teaminfo_id")String m_teaminfo_id,
			@Param(value="rounds")int rounds);

}
