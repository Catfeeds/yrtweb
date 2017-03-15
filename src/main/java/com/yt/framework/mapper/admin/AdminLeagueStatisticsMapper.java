package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.LeagueStatistics;

public interface AdminLeagueStatisticsMapper extends BaseMapper<LeagueStatistics> {

	public List<LeagueStatistics> queryQUserData(@Param(value="league_id")String league_id);

	public LeagueStatistics getLeagueStatistics(@Param(value="league_id")String league_id, @Param(value="user_id")String user_id);

	public List<Map<String, Object>> getAuctionStatisticsData(@Param(value="s_id")String s_id);

	public List<Map<String, Object>> getMarketStatisticsData(@Param(value="s_id")String s_id);

	public List<Map<String, Object>> getTeamLoanStatisticsData(@Param(value="s_id")String s_id);

}
