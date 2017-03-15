package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.ImageVideoLeague;

/**
 *@autor gl
 *@date2015-9-23下午5:59:46
 */
public interface AdminImageVideoLeagueMapper extends BaseMapper<ImageVideoLeague> {

	public List<Map<String, Object>> queryTeamInfoByIvid(@Param(value="ivid")String ivid);
	public List<String> queryIvTids(@Param(value="ivid")String ivid);

	public int deleteIvTeam(@Param(value="ivid")String ivid);
	public int deleteSImage(@Param(value="ivid")String ivid,@Param(value="tid")String tid);
	public int deleteSVideo(@Param(value="ivid")String ivid,@Param(value="tid")String tid);

	public int saveIvTeam(Map<String, Object> map);


}
