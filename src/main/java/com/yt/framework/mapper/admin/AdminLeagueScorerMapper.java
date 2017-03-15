package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.EventRecord;
import com.yt.framework.persistent.entity.LeagueScorer;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QUserData;

/**
 * @author gl
 *
 */
public interface AdminLeagueScorerMapper extends BaseMapper<LeagueScorer> {

	/**
	 * 查询进球参赛球员
	 * @param q_match_id
	 * @return
	 */
	public List<Map<String, Object>> queryQUserData(@Param(value="league_id")String league_id);

	/**
	 * 检测射手表中有无该球员记录
	 * @param league_id
	 * @param group_id
	 * @param rel_palyer_id
	 * @return
	 */
	public LeagueScorer getLeagueScorer(@Param(value="league_id")String league_id, @Param(value="group_id")String group_id,
			@Param(value="user_id")String user_id);

}
