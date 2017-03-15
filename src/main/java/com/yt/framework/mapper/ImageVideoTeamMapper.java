package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ImageVideoTeam;

/**
 *俱乐部图片、视频保存
 *@autor gl
 *@date2015-8-14下午2:18:49
 */
public interface ImageVideoTeamMapper extends BaseMapper<ImageVideoTeam> {

	public List<Map<String, Object>> searchImageVideos(@Param(value="maps")Map<String, Object> params);

	public int searchImageVideosCount(@Param(value="maps")Map<String, Object> params);

	
}
