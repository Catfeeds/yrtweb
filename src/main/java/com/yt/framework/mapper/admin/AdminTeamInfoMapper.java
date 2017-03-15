package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.TeamInfo;

/**
 * @author gl
 *
 */
public interface AdminTeamInfoMapper  extends BaseMapper<TeamInfo> {

	public List<Map<String, Object>> queryTeamLeagueForMap(@Param(value="maps")Map<String, Object> maps);

	public int teamLeagueCount(@Param(value="maps")Map<String, Object> maps);
	
	public int saveRecommendation(Map<String, Object> maps);
	
	public int updateRecommendation(Map<String, Object> maps);
	
	public int deleteRecommendation(@Param(value="id")String id);

	public int recommendationCount(@Param(value="maps")Map<String, Object> params);

	public List<Map<String, Object>> queryRecommendation(@Param(value="maps")Map<String, Object> params);

}
