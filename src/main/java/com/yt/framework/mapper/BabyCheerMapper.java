package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.yt.framework.persistent.entity.BabyCheer;

public interface BabyCheerMapper extends BaseMapper<BabyCheer> {

	public List<Map<String, Object>> getByBabyByGame(@Param(value="game_id")String game_id,@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 查询俱乐部某场比赛已有助威宝贝数量
	 * @param teaminfo_id 俱乐部ID
	 * @param teamgame_id 比赛ID
	 * @return
	 */
	public int babyCheerCount(@Param(value="teaminfo_id")String teaminfo_id,@Param("teamgame_id")String teamgame_id);
}
