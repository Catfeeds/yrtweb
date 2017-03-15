package com.yt.framework.service;

import com.yt.framework.persistent.entity.PlayerHonor;
import com.yt.framework.utils.AjaxMsg;

/**
 * @Title: PlayerHonorService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月3日 下午4:05:37 
 */
public interface PlayerHonorService extends BaseService<PlayerHonor> {

	/**
	 * 根据用户ID查询荣誉
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg queryByUserId(String uid);
	

}
