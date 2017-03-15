package com.yt.framework.service.Impl.adminImpl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.LeagueStatistics;
import com.yt.framework.service.admin.AdminLeagueStatisticsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.UUIDGenerator;

@Service(value="adminLeagueStatisticsService")
public class AdminLeagueStatisticsServiceImpl extends BaseAdminServiceImpl<LeagueStatistics> implements AdminLeagueStatisticsService {

	@Override
	public AjaxMsg updateStatistics(String league_id) throws Exception {
		//查询该联赛下球员数据
		List<LeagueStatistics> users = leagueStatisticsMapper.queryQUserData(league_id);
		if(users!=null&&users.size()>0){
			for (LeagueStatistics user : users) {
				LeagueStatistics ls = leagueStatisticsMapper.getLeagueStatistics(league_id,user.getUser_id());
				user.setZg_sort(0);
				user.setHop_sort(0);
				user.setHup_sort(0);
				user.setShup_sort(0);
				if(ls!=null){
					user.setId(ls.getId());
					update(user);
				}else{
					user.setId(UUIDGenerator.getUUID());
					save(user);
				}
			}
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public List<Map<String, Object>> getAuctionStatisticsData(String s_id) {
		return leagueStatisticsMapper.getAuctionStatisticsData(s_id);
	}
	
	
	@Override
	public List<Map<String, Object>> getMarketStatisticsData(String s_id) {
		return leagueStatisticsMapper.getMarketStatisticsData(s_id);
	}

	@Override
	public List<Map<String, Object>> getTeamLoanStatisticsData(String s_id) {
		return leagueStatisticsMapper.getTeamLoanStatisticsData(s_id);
	}
}
