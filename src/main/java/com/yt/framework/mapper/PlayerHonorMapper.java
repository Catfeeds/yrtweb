package com.yt.framework.mapper;

import java.util.List;

import com.yt.framework.persistent.entity.PlayerHonor;

/**
 * @Title: PlayerHonorMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月3日 下午5:42:56 
 */
public interface PlayerHonorMapper extends BaseMapper<PlayerHonor>{

	/**
	 * 根据用户ID查询荣誉
	 * @param userId
	 * @return AjaxMsg
	 */
	public List<PlayerHonor> queryByUserId(String userId);
}
