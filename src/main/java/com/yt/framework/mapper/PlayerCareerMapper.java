package com.yt.framework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.PlayerCareer;

/**
 * @Title: PlayerCareerMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月3日 下午5:42:48 
 */
public interface PlayerCareerMapper extends BaseMapper<PlayerCareer>{

	public List<PlayerCareer> queryByUserId(@Param(value="userId")String userId);
	
}
