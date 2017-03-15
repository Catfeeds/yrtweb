package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.LeagueStatistics;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;

public interface AdminLeagueStatisticsService extends BaseService<LeagueStatistics>{

	public AjaxMsg updateStatistics(String league_id) throws Exception; 
	
	/**
	 * 竞拍市场统计
	 * @param s_id
	 * @return
	 */
	public List<Map<String, Object>> getAuctionStatisticsData(String s_id);
	
	/**
	 * 转会市场统计
	 * @param s_id
	 * @return
	 */
	public List<Map<String, Object>> getMarketStatisticsData(String s_id);
	
	/**
	 * 租借统计
	 * @param s_id
	 * @return
	 */
	public List<Map<String, Object>> getTeamLoanStatisticsData(String s_id);
}
