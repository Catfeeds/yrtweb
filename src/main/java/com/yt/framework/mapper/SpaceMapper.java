package com.yt.framework.mapper;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Space;

/**
 *存储空间
 *@autor bo.xie
 *@date2015-9-2上午11:18:29
 */
public interface SpaceMapper extends BaseMapper<Space> {

	/**
	 * 获取俱乐部存储空间
	 *@param team_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-2上午11:24:59
	 */
	Space getSpaceByTeamId(@Param(value="team_id")String team_id);
}
