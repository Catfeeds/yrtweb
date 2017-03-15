package com.yt.framework.service;

import com.yt.framework.persistent.entity.PlayerCareer;
import com.yt.framework.utils.AjaxMsg;

/**
 * @Title: PlayerCareerService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月3日 下午4:05:37 
 */
public interface PlayerCareerService extends BaseService<PlayerCareer> {
	
	/**
	 * 根据用户ID查询职业生涯
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg queryByUserId(String userId);
}
