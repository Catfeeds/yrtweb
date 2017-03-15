package com.yt.framework.service;

import java.util.List;

import com.yt.framework.persistent.entity.CoachCareer;

/**
 *
 *@autor bo.xie
 *@date2015-8-7下午5:06:10
 */
public interface CoachCareerService extends BaseService<CoachCareer> {

	/**
	 *获取该教练的所有任职记录
	 *@param user_id 教练用户ID 
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-7下午5:09:36
	 */
	public List<CoachCareer> getCoachCareerListByUserId(String user_id);
}
