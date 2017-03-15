package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.News;

/**
 *@autor gl
 *@date2015-9-23下午5:59:46
 */
public interface AdminNewsMapper extends BaseMapper<News> {

	public List<Map<String, Object>> queryTeamInfoByNid(@Param(value="newsId")String newsId);

	public int deleteNewsTeam(@Param(value="newsId")String newsId);

	public int saveNewsTeam(Map<String, Object> map);

}
