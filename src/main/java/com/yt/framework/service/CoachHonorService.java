package com.yt.framework.service;

import java.util.List;

import com.yt.framework.persistent.entity.CoachHonor;

/**
 *教练荣誉
 *@autor bo.xie
 *@date2015-8-7下午3:26:55
 */
public interface CoachHonorService extends BaseService<CoachHonor>{

	/**
	 * 获取该教练的所有荣誉
	 *@param user_id 教练用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-7下午3:29:45
	 */
	public List<CoachHonor> getCoachHonorsByUserId(String user_id);
}
